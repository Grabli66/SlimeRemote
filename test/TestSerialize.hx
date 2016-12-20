package;

import haxe.io.Bytes;

class TestSerialize {
    public static function main () : Void {        
        /*var items = new Array<SlimePacket> ();
        var tm = Date.now ().getTime ();
        for (i in 0...1) {
            var pack = new TestPacket ();
            pack.x = 125;
            pack.x = 125;            
            //trace (pack.ToData ().ToArray ());
            items.push (SlimePacketParser.FromBinary (pack.ToData ()));
        }
        tm = Date.now ().getTime () - tm;
        trace (tm);*/

        //var tp:TestPacket = cast items[0];
        //trace (tp.x);
        //trace (tp.Arr);

        /*var items1 = new Array<TestBitsPacket> ();
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
        trace (tm);*/

        var ser = new hxbit.Serializer();  
        var ser2 = new hxbit.Serializer ();
        var items1 = new Array<TestBitsPacket> ();

        var tm = Date.now ().getTime ();
        for (i in 0...1) {
            var pack = new TestBitsPacket ();
            pack.Arr.push (330);
            pack.Arr.push (54);
            pack.Arr.push (25);
            pack.Arr.push (55);
            //pack.Pack.Name = "Распиздосный расколбас";

            ser.begin();
            ser.addAnyRef (pack);
            var bytes = ser.end ();
            trace (bytes.getData ());
            ser2.setInput (bytes, 0);
            var pac:TestBitsPacket = cast ser2.getAnyRef();
            items1.push (pac);
        }                        
        tm = Date.now ().getTime () - tm;
        trace (tm);

        trace (items1[0].Arr);
    }
}