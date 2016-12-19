package;

class TestWsClient {
    private static function TestClientWs () {               
       var client = new ClientWebSocket ("localhost");
       client.OnOpen = function () {
           client.Send (new TestPacket ());
           client.Send (new TestPacket ());
       }

       client.OnPacket = function (packet : SlimePacket) {
           var d = cast (packet, TestPacket);
           trace (d.x);           
       }

       client.Open ();       
    }

    public static function main () : Void {        
        TestClientWs ();
    }
}