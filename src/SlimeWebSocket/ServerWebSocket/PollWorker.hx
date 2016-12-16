import sys.net.Socket;
import cpp.net.Poll;
import cpp.vm.Thread;

/**
    Process client with poll
**/
class PollWorker {
    /**
        Clients
    **/
    private var _clients : Array<Socket>;

    /**
        Poll sockets
    **/
    private var _poll : Poll;

    /**
        Max clients count
    **/
    private var _max : Int;

    /**
        Is read to add new client
    **/
    public var IsReady (get_IsReady, null) : Bool;

    /**
        Calc IsReady
    **/
    public function get_IsReady () : Bool {        
        if (_clients.length >= _max) return false;
        return true;
    }

    /**
        Close socket
    **/
    private function CloseSocket (s : Socket) {
        try {
            trace ("CLOSE SOCKET");
            s.close ();
            _clients.remove (s); 
            trace ('CLIENTS: ${_clients.length}');           
        } catch (e : Dynamic) {
            trace (e);
        }
    }

    /**
        Thread work
    **/
    private function Work () : Void {
        while (true) {
            var readyClients = _poll.poll (_clients, 0.01);

            for (s in readyClients) {
                try {            
                    var handler:InternalHandler = s.custom;
                    handler.ProcessClientData ();
                } catch (e: Dynamic) {
                    trace (e);
                    CloseSocket (s);           
                }                  
            }
        }
    }

    /**
        Constructor
    **/
    public function new (max : Int) {
        _max = max;
        _clients = new Array<Socket> ();
        _poll = new Poll(_max);
        _poll.prepare ([], []);
    }

    /**
        Start thread
    **/
    public function Start () : Void {
        var thread = Thread.create (Work);
        thread.sendMessage ('');
    }

    /**
        Add new client
    **/
    public function AddClient (sock : Socket) : Void {                
        if (IsReady) {
            var handler:InternalHandler = sock.custom;
            handler.OnClose = CloseSocket;
            _clients.push (sock);
            trace ('CLIENTS: ${_clients.length}');
        }
    }
}