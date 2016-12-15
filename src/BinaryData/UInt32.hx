#if !cpp
    abstract UInt32 (Int) to Int {
        public inline function new (v : Int) {
            this = v & 0xFFFFFFFF;
        }

        @:from static inline function FromInt (v : Int) : UInt32 {
            return new UInt32 (v);
        }

        @:op(A > B) static function gt( a : UInt32, b : UInt32 ) : Bool;
        @:op(A < B) static function gt( a : UInt32, b : UInt32 ) : Bool;
    }
#end

#if cpp
    typedef UInt32 = cpp.UInt32;
#end