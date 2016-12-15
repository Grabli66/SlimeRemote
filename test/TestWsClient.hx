package;

class TestWsClient {
    private static function TestClientWs () {        
       SlimePacketParser.GetInstance ().Register (TestPacket.TYPE, TestPacket.FromData);

       var client = new ClientWebSocket ("localhost");
       client.OnOpen = function () {
           client.Send (new TestPacket ());
       }

       client.OnPacket = function (packet : SlimePacket) {
           var d = cast (packet, TestPacket);
           trace (d.);
       }

       client.Open ();       
    }

    public static function main () : Void {        
        TestClientWs ();
    }
}