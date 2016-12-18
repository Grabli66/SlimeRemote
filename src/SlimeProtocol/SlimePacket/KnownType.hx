/**
    Information about type
**/
abstract KnownType(Int) to Int {
    public static inline var UINT8 = 0;
    public static inline var UINT16 = 1;
    public static inline var UINT32 = 2;
    public static inline var INT = 3;
    public static inline var STRING = 4;
    public static inline var ARRAY = 5;
    public static inline var SLIME_PACKET = 6;

    public static inline var UINT8_STR = 'UInt8';
    public static inline var UINT16_STR = 'UInt16';
    public static inline var UINT32_STR = 'UInt32';
    public static inline var INT_STR = 'Int';
    public static inline var STRING_STR = 'String';
    public static inline var ARRAY_STR = 'Array';
    public static inline var SLIME_PACKET_STR = 'SlimePacket';

    public inline function new (v : Int) {
        if ([INT, STRING, UINT8, UINT16, UINT32, SLIME_PACKET, ARRAY].indexOf (v) < 0) throw "Wrong value";
        this = v;
    }

    @:from public static inline function FromInt (v : Int) : KnownType {
        return new KnownType (v);
    }

    @:from public static inline function FromString (v : String) : KnownType {
        switch (v) {
            case UINT8_STR: return new KnownType (UINT8);
            case UINT16_STR: return new KnownType (UINT16);
            case UINT32_STR: return new KnownType (UINT32);
            case INT_STR: return new KnownType (INT);
            case STRING_STR: return new KnownType (STRING);
            case SLIME_PACKET_STR: return new KnownType (SLIME_PACKET);
            case ARRAY_STR: return new KnownType (ARRAY);
            default: throw "Wrong type";
        }        
    }
}