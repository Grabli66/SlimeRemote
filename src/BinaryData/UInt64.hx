#if !cpp
    /*abstract UInt64 (Int) to Int {
        public inline function new (v : Int) {
            this = v & 0xFFFFFFFFFFFFFFFF;
        }

        @:from static inline function FromInt (v : Int) : UInt64 {
            return new UInt64 (v);
        }

        @:op(A > B) static function gt( a : UInt64, b : UInt64 ) : Bool;
        @:op(A < B) static function gt( a : UInt64, b : UInt64 ) : Bool;
    }*/
#end

#if cpp
    typedef UInt64 = cpp.UInt64;
#end