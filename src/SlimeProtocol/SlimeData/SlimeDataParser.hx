/**
    Handler delegate for parse binary data
**/
typedef ParseDataHandler = Int -> BinaryData -> SlimeData;

/**
    Parse bytes to SlimeData and back
**/
class SlimeDataParser {
    /**
        Instance
    **/
    private static var _instance : SlimeDataParser;

    /**
        Handlers for parse binary data
    **/
    private var _dataTypes : Map<Int, ParseDataHandler>;

    /**
        Return instance of parser
    **/
    public static function GetInstance () : SlimeDataParser {
        if (_instance == null) _instance = new SlimeDataParser ();
        return _instance;
    }

    /**
        Constructor
    **/
    private function new () {
        _dataTypes = new Map<Int, ParseDataHandler> ();
        _dataTypes[SlimeArray.TYPE] = SlimeArray.FromBinaryData;
        _dataTypes[SlimeString.TYPE] = SlimeString.FromBinaryData;
        _dataTypes[SlimeUint8.TYPE] = SlimeUint8.FromBinaryData;
    }

    /**
        Read one type from buffer
    **/
    public function ReadData (pos : Int, data : BinaryData) : SlimeData {
        var b = data.GetUint8 (pos);
        var delegate = _dataTypes[b];
        return delegate (pos, data);
    }

    /**
        Parse bytes to array of slimedata
    **/
    public function FromBinaryData (data : BinaryData, pos : Int = 0) : Array<SlimeData> {        
        var i = pos;
        var res = new Array<SlimeData> ();
        while (i < data.Length()) {
            var dat = ReadData (i, data);
            res.push (dat);
            i += dat.GetSize ();
        }

        return res;
    }

    /**
        Parse SlimeData to BinaryData
    **/
    public function ToBinaryData (data : Array<SlimeData>) : BinaryData {
        var res = new BinaryData ();
        for (d in data) {
            res.AddUint8 (d.GetTag ());
            res.AddBinaryData (d.ToBinaryData ());
        }
        return res;
    }    
}