/**
    Bool data
**/
class SlimeBool extends SlimeData implements ISlimeNumber {
    /**
        Type tag
    **/
    public static inline var TYPE : Int = 0x10;

    /**
        Data
    **/
    public var Data : Bool;

    /**
        Parse binary data to SlimeData
    **/
    public static function FromBinaryData (pos : Int, data : BinaryData) : SlimeData {
        return new SlimeBool (data.GetUint8 (pos + 1) > 1);
    }

    /**
        Constructor
    **/
    public function new (d : Bool) {
        Data = d;
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
        return 2;
    }

    /**
        Serialize slime data to binary data       
    **/
    public override function ToBinaryData () : BinaryData {
        return new BinaryData ([AsInt ()]);
    }

    /**
        Return data as Int
    **/
    public function AsInt () : Int {
        return Data ? 1 : 0;
    }
}