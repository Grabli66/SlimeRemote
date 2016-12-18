#if !cpp
    abstract UInt16 (Int) to Int {
        public inline function new (v : Int) {            
            this = v & 0xFFFF;
        }

        @:from static inline function FromInt (v : Int) : UInt16 {            
            return new UInt16 (v);
        }

        @:op(A > B) static function gt( a : UInt16, b : UInt16 ) : Bool;
        @:op(A < B) static function gt( a : UInt16, b : UInt16 ) : Bool;
    }
#end

#if cpp
    typedef UInt16 = cpp.UInt16;
#end