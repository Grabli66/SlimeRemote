import sys.net.Socket;

/**
    Pool of workers
**/
class WorkerPool {
    /**
        Max worker count
    **/
    public inline static var MAX_WORKERS = 10;

    /**
        Max client per worker
    **/
    public inline static var MAX_CLIENT_PER_WORKER = 100;

    /**
        Instance
    **/
    private static var _instance : WorkerPool = new WorkerPool();    
    
    /**
        Array of workers
    **/
    private var _workers : Array<PollWorker>;

    /**
        Return pool instance
    **/
    public inline static function GetInstance () {
        return _instance;
    }

    /**
        Constructor
    **/
    private function new () {
        _workers = new Array<PollWorker> ();
        for (i in 0...MAX_WORKERS) {
            var worker = new PollWorker (MAX_CLIENT_PER_WORKER);            
            _workers.push (worker); 
            worker.Start ();           
        }
    }

    /**
        Add client to worker
    **/
    public function AddClient (c : Socket) {
        var found = false;

        for (w in _workers) {
            if (w.IsReady) {
                w.AddClient (c);
                found = true;
                break;
            }
        }

        if (!found) throw "Poll Workers ended";
    }
}