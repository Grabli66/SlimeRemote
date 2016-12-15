class TestPacket extends SlimePacket {
    public static inline var TYPE = 0;

    public var x : UInt8;

    public function new () {
        x = 22;
    }

    public override function GetTag () : Int {
        return TYPE;
    }

    public override function ToData () : Array<SlimeData> {
        return [ new SlimeUint8 (x) ];
    }

    public static function FromData (data : Array<SlimeData>) : SlimePacket {
        var d = cast (data[0], ISlimeNumber);        
        var p = new TestPacket ();
        p.x = d.AsInt ();
        return p;
    }
}