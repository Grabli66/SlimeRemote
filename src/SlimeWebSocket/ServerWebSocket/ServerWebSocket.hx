import sys.net.Socket;
import sys.net.Host;

/**
    Handler for accept
**/
typedef AcceptHandler = ClientHandler -> Void;

/**
    Web socket server: cpp
**/
class ServerWebSocket {
    /**
        Max Connections to listen
    **/
    public static inline var DEFAULT_CONNECTIONS : Int = 10;

    /**
        Server socket
    **/
    private var _socket : Socket; 

    /**
        Handle data from client
    **/
    private var _onAccept : AcceptHandler;

    /**
        Constructor
    **/
    public function new (onAccept : AcceptHandler) 
    {
        _socket = new Socket ();
        _onAccept = onAccept;
    }

    /**
        Start socket
    **/
    public function Start () {
        _socket.bind (new Host("localhost"), SlimeProtocol.DEFAULT_PORT);
        _socket.listen (DEFAULT_CONNECTIONS);

        while (true) {
            var client = _socket.accept ();
            var internalHandler = new InternalHandler (client);
            _onAccept (internalHandler.GetClientHandler ());
            internalHandler.Start ();
        }
    }
}