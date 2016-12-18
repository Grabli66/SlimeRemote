/**
    Process bytes and SlimeData
**/
class SlimeProtocol {
    /**
        Default port for protocol
    **/
    public static inline var DEFAULT_PORT : Int = 65200;


    /**
        Data buffer
    **/  
    private var _buffer : BinaryData;


    /**
        Length of packet
    **/
    private var _packetLength : Int;

    /*
    *   On packet recieved
    */
    public var OnPacket : SlimePacket -> Void;      

    /*
    *   Process data and get packet
    */
    private function ProcessPacket (data : Array<SlimeData>) : Void {
        try {
           /* var pack = _packetParser.FromData (data);
            OnPacket (pack);*/
        } catch (e : Dynamic) {
            trace (e);
        }
    }  

    /*
    * Process buffer data
    */
    private function ProcessData () : Void {        
       /* var slimeData = _dataParser.FromBinaryData (_buffer);
        ProcessPacket (slimeData);        */
    }

    /**
        Constructor
    **/
    public function new () {        
        _buffer = new BinaryData ();
    }

    /**
        Parse packet to binary data with length
    **/
    public function PacketToBinaryData (packet : SlimePacket) : BinaryData {
        
        //return bd;
        return new BinaryData ();
    }

    /**
        Add bytes to buffer
    **/
    public function AddBytes (data : BinaryData) : Void {        
        _buffer.AddBinaryData (data);                
        ProcessData ();        
    }
}