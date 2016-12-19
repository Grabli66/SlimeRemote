/**
    Handler delegate for parse slime data
**/
typedef ParsePacketHandler = BinaryData -> SlimePacket;

/**
    Parse packet to data and back
**/
class SlimePacketParser {
    public static inline var NULL:UInt8 = 0xFF;
    public static inline var ARRAY:UInt8 = 1;
    public static inline var STRUCTURE:UInt8 = 2;
    public static inline var UINT8:UInt8 = 3;
    public static inline var UINT16:UInt8 = 4;
    public static inline var UINT32:UInt8 = 5;

    /**
        Packet id counter
    **/
    private static var _counter = 0;

    /**
        Known packets. Name -> Id
    **/
    private static var _knownPackets = new Map<String, UInt8> ();

    /**
        Known packets. Id -> Type
    **/
    private static var _knownPacketsResolved = new Map<UInt8, Class<Dynamic>> ();

    /**
        Add SlimePacket to BinaryData
    **/
    private static function AddPacket (data : SlimePacket, out : BinaryData) : Void  {
        if (data == null) {
            // Add type
            out.AddUint8 (NULL);
            return;
        }

        // Add type
        out.AddUint8 (STRUCTURE);
        // Add slime packet type
        var name = data.GetName ();
        out.AddUint8 (_knownPackets[name]);
        var vals = data.GetValues ();
        out.AddUint8 (vals.length);
        for (v in vals) {
            AddData (v, out);
        }
    }

    /**
        Add UInt8 to BinaryData
    **/
    private static function AddUInt8 (data : ValueInfo, out : BinaryData) : Void  {
        out.AddUint8 (UINT8);
        out.AddUint8 (data.Value);
    }

    /**
        Add UInt16 to BinaryData
    **/
    private static function AddUInt16 (data : ValueInfo, out : BinaryData) : Void  {        
        out.AddUint8 (UINT16);
        out.AddUint16 (data.Value);
    }

    /**
        Add UInt32 to BinaryData
    **/
    private static function AddUInt32 (data : ValueInfo, out : BinaryData) : Void  {
        out.AddUint8 (UINT32);
        out.AddUint32 (data.Value);
    }

    /**
        Add Array to BinaryData
    **/
    private static function AddArray (data : ValueInfo, out : BinaryData) : Void  {        
        var typeInfo = data.VarInfo.TypeInfo.Param;
        if (data.VarInfo.TypeInfo.Param == null) throw "Wrong array";
        var value:Array<Dynamic> = data.Value;
        out.AddUint8 (ARRAY);
        out.AddUint8 (value.length);
        
        for (v in value) {
            var varInfo:VarInfo = { Name : '', TypeInfo : typeInfo };
            var valInfo:ValueInfo = { VarInfo : varInfo, Value : v };
            AddData (valInfo, out);
        }
    }

    /**
        Add data to BinaryData
    **/
    private static function AddData (data : ValueInfo, out : BinaryData) : Void {
        var typeId = data.VarInfo.TypeInfo.Id;

        if (typeId == KnownType.SLIME_PACKET) {
            AddPacket (data.Value, out);
        } else if (typeId == KnownType.UINT8) {
            AddUInt8 (data, out);            
        } else if (typeId == KnownType.UINT16) {
            AddUInt16 (data, out);            
        } else if (typeId == KnownType.UINT32) {
            AddUInt32 (data, out);
        } else if (typeId == KnownType.INT) {
            AddUInt32 (data, out);
        } else if (typeId == KnownType.ARRAY) {
            AddArray (data, out);
        }
        else {
            throw "Unsupported data";
        }
    }

    /**
        Get packet from binary
    **/
    private static function GetPacket (data : BinaryData, pos : Int) : { Packet : SlimePacket, Pos : Int } {        
        var packType = data.GetUint8 (pos);
        pos += 1;
        var pack:SlimePacket = Type.createInstance (_knownPacketsResolved[packType], []);
        if (pack == null) throw "Unknown packet";
        var count = data.GetUint8 (pos);
        pos += 1;

        var names = pack.GetNames ();
        if (count != names.length) throw "Wrong data";

        for (i in 0...count) {            
            var dat = GetType (data, pos);            
            pos = dat.Pos;
            Reflect.setField (pack, names[i].Name, dat.Data);
        }        

        return { Packet : pack, Pos : pos };
    }

    /**
        Get array from binary
    **/
    private static function GetArray (data : BinaryData, pos : Int) : { Data : Dynamic, Pos : Int } {
        var count = data.GetUint8 (pos);
        pos += 1;
        var res = new Array<Dynamic> ();
        for (i in 0...count) {
            var tp = GetType(data, pos);
            pos = tp.Pos;
            res.push (tp.Data);
        }

        return { Data : res, Pos : pos };
    }

    /**
        Get some type from BinaryData
    **/
    private static function GetType (data : BinaryData, pos : Int) : { Data : Dynamic, Pos : Int } {
        var type = data.GetUint8 (pos);

        pos += 1;
        var dat : Dynamic;
        switch (type) {            
            case STRUCTURE: {
                var stru = GetPacket (data, pos);                
                dat = stru.Packet;
                pos = stru.Pos;
            }
            case ARRAY: {
                var arr = GetArray (data, pos);                
                dat = arr.Data;
                pos = arr.Pos;
            }
            case UINT8: {
                dat = data.GetUint8 (pos);
                pos += 1;
            }
            case UINT16: {
                dat = data.GetUint16 (pos);
                pos += 2;
            }
            case UINT32: {
                dat = data.GetUint32 (pos);
                pos += 4;
            }
            case NULL: {
                dat = null;                
            }
            default: throw 'Unknown type: ${type}';
        }
        
        return { Data : dat, Pos : pos };
    }

    /**
        Register handler for packet
    **/
    public static function Register (name : String) : Int {  
        trace (name);      
        _knownPackets[name] = _counter;
        _knownPacketsResolved[_counter] = Type.resolveClass (name);            
        _counter++;
        return 0;
    }    

    /**
        Parse packet fields to BinaryData
    **/
    public static function ToBinary (data : SlimePacket) : BinaryData {
        var res = new BinaryData ();
        AddPacket (data, res);
        return res;
    }

    /**
        Parse packet fields to BinaryData
    **/
    public static function FromBinary (data : BinaryData) : SlimePacket {
        var res = GetType (data, 0).Data;
        return res;
    }
}