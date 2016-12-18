package;

import haxe.io.Bytes;

class TestSerialize {
    public static function main () : Void {        
        var items = new Array<SlimePacket> ();
        var tm = Date.now ().getTime ();
        for (i in 0...100000) {
            var pack = new TestPacket ();
            pack.x = 125;
            pack.x = 125;
            pack.Arr.push (22);
            pack.Arr.push (24);
            pack.Arr.push (26);
            //trace (pack.ToData ().ToArray ());
            items.push (SlimePacketParser.FromBinary (pack.ToData ()));
        }
        tm = Date.now ().getTime () - tm;
        trace (tm);

        //var tp:TestPacket = cast items[0];
        //trace (tp.x);
        //trace (tp.Arr);

        var items1 = new Array<TestBitsPacket> ();
        var ser = new hxbit.Serializer();                     
        
        var tm = Date.now ().getTime ();
        for (i in 0...100000) {
            var pack = new TestBitsPacket ();
            pack.x = 125;
            pack.y = 125;
            pack.Arr.push (22);
            pack.Arr.push (24);
            pack.Arr.push (26);
            items1.push (ser.unserialize (ser.serialize(pack), TestBitsPacket));
        }
        tm = Date.now ().getTime () - tm;
        trace (tm);

        //trace (items1.length);
        //trace (BinaryData.FromArrayBuffer (items1[0].getData ()).ToArray ());

        //var pack3:TestPacket = cast SlimePacketParser.FromBinary (data);        
        //trace (pack3.x);
    }
}