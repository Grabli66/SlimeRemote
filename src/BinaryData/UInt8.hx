#if !cpp
    abstract UInt8 (Int) to Int {
        public inline function new (v : Int) {
            this = v & 0xFF;
        }

        @:from static inline function FromInt (v : Int) : UInt8 {
            return new UInt8 (v);
        }

        @:op(A > B) static function gt( a : UInt8, b : UInt8 ) : Bool;
        @:op(A < B) static function gt( a : UInt8, b : UInt8 ) : Bool;
    }
#end

#if cpp
    typedef UInt8 = cpp.UInt8;
#end