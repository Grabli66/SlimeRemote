/**
    Abstract data
**/
class SlimeData {
    /**
        Return data tag
        For override
    **/
    public function GetTag () : Int {
        throw "Not implemented";
    }

    /**
        Return data size
        For override
    **/
    public function GetSize () : Int {
        throw "Not implemented";
    }

    /**
        Serialize slime data to binary data
        For override
    **/
    public function ToBinaryData () : BinaryData {
        throw "Not implemented";
    }
}