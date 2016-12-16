import sys.net.Socket;
import sys.net.Host;
import cpp.net.Poll;

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
    public static inline var DEFAULT_CONNECTIONS : Int = 1000;

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
        // TODO: bind to some IP
        _socket.bind (new Host("localhost"), SlimeProtocol.DEFAULT_PORT);                
        _socket.setBlocking (false);
        _socket.listen (DEFAULT_CONNECTIONS);

        var poll = new Poll(1);
        var serverList = new Array<Socket> ();
        serverList.push (_socket);
        poll.prepare (serverList, []);
        
        while (true) {
            var readyServer = poll.poll (serverList, 0.5);
            if (readyServer.length > 0) {
                var client = readyServer[0].accept ();                
                var internal = new InternalHandler (client);
                client.custom = internal;
                _onAccept (internal.GetClientHandler ());
                WorkerPool.GetInstance ().AddClient (client);
            }
        }
    }
}