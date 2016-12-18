class TestPacket extends SlimePacket {
    @Serialize
    public var x : UInt8;

    @Serialize
    public var y : UInt16;

   /* @Serialize
    public var Pack : TestPacket2;*/

    @Serialize
    public var Arr : Array<UInt16> = new Array<UInt16> ();
}