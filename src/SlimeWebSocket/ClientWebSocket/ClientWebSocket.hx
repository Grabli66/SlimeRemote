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
        Protocol to parse data
    **/
    private var _protocol : SlimeProtocol;

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
        _protocol = new SlimeProtocol ();
        _protocol.OnPacket = function (packet : SlimePacket) {            
            OnPacket (packet);
        }
    }

    /**
        Open connection
    **/
    public function Open () : Void {
        _socketWs = new WebSocket ('ws://${_host}:${SlimeProtocol.DEFAULT_PORT}');
        _socketWs.binaryType = BinaryType.ARRAYBUFFER;
        _socketWs.onopen = function () {
            OnOpen ();
        }

        _socketWs.onclose = function () {
            trace ("CLOSE");
        }

        _socketWs.onmessage = function (e) {
            var binaryData = BinaryData.FromArrayBuffer(e.data);
            _protocol.AddBytes (binaryData);
        }

        _socketWs.onerror = function (e) {
            trace (e);
        }
    }

    /**
        Send packet
    **/
    public function Send (packet : SlimePacket) : Void {
        var binaryData = _protocol.PacketToBinaryData (packet);
        _socketWs.send (binaryData.ToArrayBufferView ());
    } 
}