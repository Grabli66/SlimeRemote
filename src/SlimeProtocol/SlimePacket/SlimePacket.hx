/**
    Abstract packet
**/
class SlimePacket {
    /**
        Return data tag
        For override     
    **/
    public function GetTag () : Int {
        throw "Not implemented";
    }

    /**
        Parse SlimePacket to SlimeData
        For override
    **/
    public function ToData () : Array<SlimeData> {
        throw "Not implemented";
    }
}   