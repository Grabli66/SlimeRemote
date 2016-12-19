package;

class TestWsServer {
    private static function TestServerWs () {
        var wss = new ServerWebSocket (function (c : ClientHandler) {
            c.OnReady = function () {
                
            }
            c.OnPacket = function (packet : SlimePacket) { 
                trace (packet);
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