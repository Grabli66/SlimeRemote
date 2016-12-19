import sys.net.Socket;
import cpp.vm.Thread;
import haxe.io.Bytes;
import haxe.crypto.Base64;
import haxe.crypto.Sha1;
import haxe.crypto.BaseCode;

/**
    State of handler
**/
enum HandlerState {
    HANDSHAKE;
    WORK;
}

/**
    State of work
**/
enum WorkState {
    /**
        Get frame type
    **/
    FRAME_TYPE;
    /**
        Get length
    **/
    LENGTH;
    /**
        Get data
    **/
    DATA;
}

/**
    Internal client handler
**/
class InternalHandler {
    /**
        Message mask size
    **/
    private static inline var MASK_SIZE = 4;

    /**
        One byte max body size
    **/
    private static inline var ONE_BYTE_MAX_BODY_SIZE = 125;

    /**
        Two byte body size
    **/
    private static inline var TWO_BYTE_BODY_SIZE = 126;

    /**
        Eight byte body size
    **/
    private static inline var EIGHT_BYTE_BODY_SIZE = 127;

    /**
        Sec-WebSocket-Key header name
    **/
    private static inline var SecWebSocketKey = "Sec-WebSocket-Key";

    /**
        Web socket GUID
    **/
    private static inline var WS_GUID = "258EAFA5-E914-47DA-95CA-C5AB0DC85B11";

    /**
        Client socket
    **/
    private var _socket : Socket;

    /**
        State of handler
    **/
    private var _state : HandlerState;    

    /**
        State of handler
    **/
    private var _workState : WorkState;

    /**
        Packet length
    **/
    private var _packLen : Int;

    /**
        Handshake headers
    **/
    private var _headers : Map<String, String>;

    /**
        Handle data from client
    **/
    private var _clientHandler : ClientHandler;

    /**
        Frame type
    **/
    private var _frameType : Int;

    /**
        When client send close frame
    **/
    public var OnClose : Socket -> Void;

    /**
        Decode hex string to Bytes
    **/
    private function decode (str : String) {
        var base = Bytes.ofString("0123456789abcdef");
        return new BaseCode(base).decodeBytes(Bytes.ofString(str.toLowerCase()));
    }

    /**
        Process handshake from client
    **/
    private function ProcessHandshake () : Void {
        var s = _socket.input.readLine ();
        var head = s.split (": ");
        if (head.length == 2) {
            _headers[head[0]] = head[1];
        } 

        if (s.length == 0) {
            var key = _headers[SecWebSocketKey] + WS_GUID;                                   
            var sha = Sha1.encode (key);
            var shaKey = Base64.encode (decode (sha));
            var stringBuffer = new StringBuf ();
            stringBuffer.add ("HTTP/1.1 101 Switching Protocols\r\n");
            stringBuffer.add ("Upgrade: websocket\r\n");
            stringBuffer.add ("Connection: Upgrade\r\n");                        
            stringBuffer.add ('Sec-WebSocket-Accept: ${shaKey}\r\n');                        
            stringBuffer.add ("\r\n");
            _socket.output.writeString (stringBuffer.toString ());
            _state = HandlerState.WORK;
            _clientHandler.OnReady ();
        }
    }

    /**
        Process frame type, opcode, mask, len part
    **/
    private function ProcessFrame () : Void {
        var binaryData = BinaryData.FromBytes (_socket.input.read (2));         
        var frame = binaryData.GetUint8 (0);

        // Close frame
        if ((frame & 0x08) > 0) {
            _frameType = FrameType.CLOSE;
        } else if ((frame & 0x02) > 0) {
            _frameType = FrameType.BINARY;
        } else {
            trace (binaryData.ToArray ());
            throw "Only binary frame allowed";
        }

        var len = binaryData.GetUint8 (1);        
        _packLen = 0;
        if ((len & 0x80) < 1) throw "Only masked message allowed";                
        _packLen += len ^ 0x80;        

        if (_packLen > ONE_BYTE_MAX_BODY_SIZE) {
            _workState = WorkState.LENGTH;
        } else {
            _workState = WorkState.DATA;
        }
    }

    /**
        Process length
    **/
    private function ProcessLength () : Void {
        var binaryData : BinaryData;        
        if (_packLen == TWO_BYTE_BODY_SIZE) {
            binaryData = BinaryData.FromBytes (_socket.input.read (2));
            _packLen += binaryData.GetUint16 (0);
        } else if (_packLen == EIGHT_BYTE_BODY_SIZE) {
            binaryData = BinaryData.FromBytes (_socket.input.read (8));
            //_packLen += binaryData.GetUint64 (0);
        } else {
            throw "Wrong length type";
        }

        _workState = WorkState.DATA;                
    }

    /**
        Process data
    **/
    private function ProcessData () : Void {
        var binaryData = BinaryData.FromBytes (_socket.input.read (_packLen + MASK_SIZE));

        switch (_frameType) {
            case FrameType.CLOSE: {
                if (_clientHandler.OnClose != null) _clientHandler.OnClose ();       
                OnClose (_socket);         
            }
            case FrameType.BINARY: {                
                var mask = binaryData.Cut (0, MASK_SIZE);
                var res = new BinaryData ();
                for (i in 0...binaryData.Length ()) {
                    var j = i % 4;
                    var b = binaryData.GetUint8 (i);
                    var d = b ^ mask.GetUint8 (j);
                    res.AddUint8 (d);
                }

                try {                    
                    var pack = SlimePacketParser.FromBinary (res);                    
                    _clientHandler.OnPacket (pack);
                } catch (e : Dynamic) {
                    trace (e);
                }
            }
        }      
        
        _workState = WorkState.FRAME_TYPE;
    }

    /**
        Process work data from client
    **/
    private function ProcessWork () : Void {        
        switch (_workState) {
            case WorkState.FRAME_TYPE: ProcessFrame ();
            case WorkState.LENGTH: ProcessLength ();
            case WorkState.DATA: ProcessData ();            
        }        
    }

    /*
    *   Process client data
    */
    public function ProcessClientData () : Void {                           
        switch (_state) {
            case HandlerState.HANDSHAKE: ProcessHandshake ();
            case HandlerState.WORK: ProcessWork ();
        }        
    }

    /*
    *   Constructor
    */
    public function new (c : Socket) {
        _socket = c;
        _clientHandler = new ClientHandler (this);
        _state = HandlerState.HANDSHAKE; 
        _workState = WorkState.FRAME_TYPE;     
        _headers = new Map<String, String> ();        
    }

    /**
        Return client handler
    **/
    public function GetClientHandler () : ClientHandler {
        return _clientHandler;
    }

    /**
        Send slime packet
    **/
    public function Send (packet : SlimePacket) : Void {
        try {
            var data = SlimePacketParser.ToBinary (packet);
            var frame = new BinaryData ();
            frame.AddUint8 (0x82);  // FIN, BINARY
            frame.AddUint8 (data.Length ());             
            frame.AddBinaryData (data);        
            _socket.output.write (frame.ToBytes ());
        } catch (e : Dynamic) {
            trace (e);
        }
    }
}