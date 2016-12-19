/**
    Class for macro build
**/
@:rtti
@:autoBuild(PacketMacro.build ())
class SlimePacket {    
    /**
        Get name of packet
        To override by macros
    **/
    public function GetName () : String {
        return "SlimePacket";
    }

    /**
        Array of values with type info
        To override by macros
    **/
    public function GetValues () : Array<ValueInfo> {
        return null;
    }

    /**
        Array of field names
        To override by macros
    **/
    public function GetNames () : Array<VarInfo> {
        return null;
    }

    /**
        Constructor
    **/
    public function new () {       
    }
}