import haxe.Utf8;

/**
    String data
**/
class SlimeString extends SlimeData {
    /**
        Type tag
    **/
    public static inline var TYPE : Int = 0x09;

    /**
        Data
    **/
    public var Data : String;

    /**
        Parse binary data to SlimeData
    **/
    public static function FromBinaryData (pos : Int, data : BinaryData) : SlimeData {
        return new SlimeString (data.GetString (pos + 1));
    }

    /**
        Constructor
    **/
    public function new (s : String) {
        Data = s;
    }    

    /**
        Return data tag     
    **/
    public override function GetTag () : Int {
        return TYPE;
    }

    /**
        Return data size        
    **/
    public override function GetSize () : Int {
        return Utf8.length (Data) + 2; // 2 - data type and null terminator
    }

    /**
        Serialize slime data to binary data       
    **/
    public override function ToBinaryData () : BinaryData {
        var res = new BinaryData ();        
        res.AddString (Data);
        return res;
    }    
}