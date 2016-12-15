/**
    Uint8 data
**/
class SlimeArray extends SlimeData {
    /**
        Type tag
    **/
    public static inline var TYPE : Int = 1;

    /**
        Data
    **/
    public var Data : Array<SlimeData>;

    /**
        Parse binary data to SlimeData
    **/
    public static function FromBinaryData (pos : Int, data : BinaryData) : SlimeData {
        var arr = new Array<SlimeData> ();
        var parser = SlimeDataParser.GetInstance ();
        var len = data.GetUint8 (pos + 1);
        var ps = pos + 2;
        for (i in 0...len) {            
            var dat = parser.ReadData (ps, data);            
            arr.push (dat);            
            ps += dat.GetSize ();
        }
        return new SlimeArray (arr);
    }

    /**
        Constructor
    **/
    public function new (?data : Array<SlimeData>) {
        Data = data == null ? [] : data;
    }

    /**
        For array iterate
    **/
    public function iterator() {
        return Data.iterator();
    }

    /**
        Return data size        
    **/
    public override function GetSize () : Int {
        var res : Int = 2;
        for (it in Data) {
            res += it.GetSize ();
        }        
        return res;
    }

    /**
        Serialize slime data to binary data       
    **/
    public override function ToBinaryData () : BinaryData {
        var res = new BinaryData ();
        var parser = SlimeDataParser.GetInstance ();
        res.AddUint8 (Data.length);
        res.AddBinaryData (parser.ToBinaryData (Data));
        return res;
    }

    /**
        Return data tag     
    **/
    public override function GetTag () : Int {
        return TYPE;
    }

    /**
        Add SlimeUint8 to array
    **/
    public function AddUint8 (d : UInt8) : SlimeArray {
        Data.push (new SlimeUint8 (d));
        return this;
    }
}