import sys.net.Socket;

/**
    Handle events from client
**/
@:final
class ClientHandler {
    /**
        Owner
    **/
    private var _owner : InternalHandler;

    /**
        Info about client
    **/
    public var ClientInfo (default, null) : ClientInfo;

    /**
        Emits on websocket ready to transmit data
    **/
    public var OnReady : Void -> Void;

    /**
        Emits when client sent data        
    **/
    public var OnPacket : SlimePacket -> Void;

    /**
        Emits on some error
    **/
    public var OnError : Dynamic -> Void;

    /**
        Emits on disconnect
    **/
    public var OnClose : Void -> Void;    

    /**
        Constructor
    **/
    public function new (owner : InternalHandler) {
        _owner = owner;
        //this.ClientInfo = new ClientInfo (client);
    }

    /**
        Send slime packet
    **/
    public function Send (packet : SlimePacket) : Void {
        _owner.Send (packet);
    }
}