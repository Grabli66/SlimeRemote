package;

import cpp.net.ThreadServer;
import sys.net.Socket;
import haxe.io.Bytes;

typedef Client = {
    Socket : Socket
}

typedef Message = {
    Data : Bytes
}

class Server extends ThreadServer<Client, Message> {
    override function clientConnected( s : Socket ) : Client
    {
        var num = Std.random(100);
        trace("client " + num + " is " + s.peer());
        return { Socket : s };
    }

    override function clientDisconnected( c : Client )
    {
        trace ("Disconnected");
    }

    override function readClientMessage( c : Client, buf : haxe.io.Bytes, pos : Int, len : Int ) : { msg : Message, bytes : Int }
    {
        var binary = BinaryData.FromBytes (buf);
        var line = binary.GetLine ();
        while (line != null) {
            trace (line);
            line = binary.GetLine ();
        }
        return {msg: {Data: buf}, bytes: len};
    }

    override function clientMessage( c : Client, msg : Message )
    {
        //trace (msg.Data.getData ());
    }
}


class TestThreadServer {
    public static function main () : Void {        
        var server = new Server ();
        server.run("localhost", 65200);
    }
}