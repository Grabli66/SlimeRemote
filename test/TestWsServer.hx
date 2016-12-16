package;

class TestWsServer {
    private static function TestServerWs () {
        SlimePacketParser.GetInstance ().Register (TestPacket.TYPE, TestPacket.FromData);
        var wss = new ServerWebSocket (function (c : ClientHandler) {
            var protocol = new SlimeProtocol ();
            protocol.OnPacket = function (packet : SlimePacket) {
                trace (packet);
            }

            c.OnReady = function () {
                
            }

            c.OnData = function (data : BinaryData) {                
                protocol.AddBytes (data);
                c.Send (new TestPacket ());
            }
            c.OnClose = function () {
                trace ("CLOSED");
            }            
        });
        wss.Start ();
    }

    public static function main () : Void {        
        TestServerWs ();
    }
}