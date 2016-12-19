#if js
    import js.html.WebSocket;
    import js.html.BinaryType;
#end

/**
    Web socket client: cpp, js
**/
class ClientWebSocket {
    /**
        Js WebSocket
    **/
    private var _socketWs : WebSocket;

    /**
        Server host
    **/
    private var _host : String;

    /**
        On open callback
    **/
    public var OnOpen : Void -> Void;

    /**
        On packet recieved
    **/
    public var OnPacket : SlimePacket -> Void;

    /**
        Constructor
    **/
    public function new (host : String) {
        _host = host;        
    }

    /**
        Open connection
    **/
    public function Open () : Void {
        _socketWs = new WebSocket ('ws://${_host}:${Global.DEFAULT_PORT}');
        _socketWs.binaryType = BinaryType.ARRAYBUFFER;
        _socketWs.onopen = function () {
            OnOpen ();
        }

        _socketWs.onclose = function () {
            trace ("CLOSE");
        }

        _socketWs.onmessage = function (e) {
            try {
                var binaryData = BinaryData.FromArrayBuffer(e.data);
                var pack = SlimePacketParser.FromBinary (binaryData);
                OnPacket (pack);
            } catch (e : Dynamic) {
                trace (e);
            }
        }

        _socketWs.onerror = function (e) {
            trace (e);
        }
    }

    /**
        Send packet
    **/
    public function Send (packet : SlimePacket) : Void {
        var binaryData = SlimePacketParser.ToBinary (packet);
        _socketWs.send (binaryData.ToArrayBufferView ());
    } 
}