/**
    Handler delegate for parse slime data
**/
typedef ParsePacketHandler = Array<SlimeData> -> SlimePacket;

/**
    Parse SlimeData to Packet and Back
**/
class SlimePacketParser {
    /**
        Instance
    **/
    private static var _instance : SlimePacketParser;    

    /**
        Handlers for parse binary data
    **/
    private var _dataTypes : Map<Int, ParsePacketHandler>;

    /**
        Return Instance
    **/
    public static function GetInstance () : SlimePacketParser {
        if (_instance == null) _instance = new SlimePacketParser ();
        return _instance;
    }

    /**
        Constructor
    **/
    private function new () {
        _dataTypes = new Map<Int, ParsePacketHandler> ();                
    }

    /**
        Register parse handler
    **/
    public function Register (code : Int, handler : ParsePacketHandler) {
        _dataTypes[code] = handler;
    }

    /**
        Parse slime data to packet
    **/
    public function FromData (data : Array<SlimeData>) : SlimePacket {
        // Remove packet type
        var packData = cast (data[0], ISlimeNumber);        
        var packType = packData.AsInt ();
        var delegate = _dataTypes[packType];        
        var ndata = data.splice (1, data.length - 1);
        return delegate (ndata);
    }

    /**
        Parse SlimePacket to SlimeData with packet type
    **/
    public function ToData (packet : SlimePacket) : Array<SlimeData> {
        var res = new Array<SlimeData> ();
        var dat = packet.ToData ();
        res.push (new SlimeUint8 (packet.GetTag ()));
        for (d in dat) {
            res.push (d);
        }
        return res;
    }
}