/**
    Uint8 data
**/
class SlimeUint8 extends SlimeData implements ISlimeNumber {
    /**
        Type tag
    **/
    public static inline var TYPE : Int = 0x0F;

    /**
        Data
    **/
    public var Data : UInt8;

    /**
        Parse binary data to SlimeData
    **/
    public static function FromBinaryData (pos : Int, data : BinaryData) : SlimeData {
        return new SlimeUint8 (data.GetUint8 (pos + 1));
    }

    /**
        Constructor
    **/
    public function new (d : UInt8) {
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
        return new BinaryData ([Data]);
    }

    /**
        Return data as Int
    **/
    public function AsInt () : Int {
        return Data;
    }
}