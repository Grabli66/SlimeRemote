import haxe.io.Bytes;
import haxe.Utf8;

/*
*   Class for working with binary data
*/
class BinaryData {
    /**
        Buffer to store data
    **/
    private var _buffer = new Array<UInt8> ();

    /**
        Create binary data from array of byte
    **/
    public static function FromArray (data : Array<UInt8>) : BinaryData 
    {
        var res = new BinaryData (data);        
        return res;
    }
    
    /**
        Convert array buffer to Array UInt8
    **/
    private static inline function ConvertToArrayUInt8 (data : Bytes) : Array<UInt8> {
        #if js

        var dat = cast (data.getData (), js.html.Uint8Array);
        var arr = new Array<UInt8> ();
        for (b in dat) {
            arr.push (b);
        }

        return arr;

        #end

        #if !js
        return data.getData ();
        #end
    }

    /**
        Convert array data to Array UInt8
    **/
    private static inline function ConvertToArrayBuffer (data : Array<UInt8>) : Bytes {
        #if js
        
        var arr = new js.html.Uint8Array (data);
        var dat = cast (arr, js.html.ArrayBuffer);
        return Bytes.ofData (dat);

        #end

        #if !js
        return Bytes.ofData (data);
        #end
    }    

    /**
        Return random bytes
    **/
    public static function RandomBytes (len : Int) : Array<UInt8> {
        var res = new Array<UInt8> ();
        for (i in 0...len) {
            var r:UInt8 = Math.round (Math.random () * 0xFF);
            res.push (r);
        }

        return res;
    }

    /**
        Create binary data from Bytes
    **/
    public static function FromBytes (data : Bytes) : BinaryData 
    {        
        var res = new BinaryData (ConvertToArrayUInt8 (data));
        return res;    
    }

    #if js

    /**
        Create binary data from Array Buffer
    **/
    public static function FromArrayBuffer (data : js.html.ArrayBuffer) : BinaryData {
        var dat = new js.html.Uint8Array (data);
        var arr = new Array<UInt8> ();
        for (b in dat) {
            arr.push (b);
        }
        return new BinaryData (arr);
    }

    #end

    /**
        Constructor
    **/    
    public function new (?data: Array<UInt8>) {
        if (data != null) _buffer = data;
    }

    /**
        For array iterate
    **/
    public function iterator() {
        return _buffer.iterator();
    }

    /**
        Add binary data to buffer
    **/
    public function AddBinaryData (data : BinaryData) {        
        for (b in data) {
            _buffer.push (b);
        }
    }

    /**
        Add array of byte to buffer
    **/
    public function AddArray (data : Array<UInt8>) {        
        for (b in data) {
            _buffer.push (b);
        }
    }

    /**
        Add Bytes to buffer
    **/
    public function AddBytes (data : Bytes) {
        AddArray (ConvertToArrayUInt8 (data));
    }

    /*
    *   Add uint8 to buffer
    */
    public function AddUint8 (b : UInt8) : Void {
        _buffer.push (b);
    }    

    /**
       Add uint16 to buffer
    **/
    public function AddUint16 (b : UInt16) : Void {        
        _buffer.push ((b & 0xFF00) >> 8);
        _buffer.push (b & 0xFF);
    }  

    /**
       Add uint32 to buffer
    **/
    public function AddUint32 (b : UInt32) : Void {
        _buffer.push ((b & 0xFF000000) >> 24);
        _buffer.push ((b & 0xFF0000) >> 16);
        _buffer.push ((b & 0xFF00) >> 8);
        _buffer.push (b & 0xFF);
    }

    /**
        Add Utf-8 string
    **/
    public function AddString (s : String) : Void {
        var us = Utf8.encode (s);
        Utf8.iter (us, function (b : Int) {
            _buffer.push (b);
        });
        // Add null terminator
        _buffer.push (0);
    }

    /**
        Read byte from buffer
    **/
    public function GetUint8 (pos : Int) : UInt8 {
        return _buffer[pos];
    }

    /**
        Read uint16 from buffer
    **/
    public function GetUint16 (pos : Int) : UInt16 {
        return (_buffer[pos] << 8) + _buffer[pos + 1];
    }

    /**
        Read uint32 from buffer
    **/
    public function GetUint32 (pos : Int) : UInt32 {
        return (_buffer[pos] << 24) + (_buffer[pos + 1] << 16) + (_buffer[pos + 2] << 8) + (_buffer[pos + 3]);
    }

    /**
        Read uint64 from buffer
    **/
    /*public function GetUint64 (pos : Int) : UInt64 {
        return (_buffer[pos] << 56) + (_buffer[pos + 1] << 48) + (_buffer[pos + 2] << 40) + (_buffer[pos + 3] << 32) +
                (_buffer[pos + 4] << 24) + (_buffer[pos + 5] << 16) + (_buffer[pos + 6] << 8) + (_buffer[pos + 7]);
    }*/

    /**
        Read null terminated string from buffer
    **/
    public function GetString (pos : Int) : String {
        var utf = new Utf8 ();
        for (i in pos..._buffer.length) {
            var b = _buffer[i];            
            if (b == 0) break;            
            utf.addChar (b);
        }        
        return Utf8.decode (utf.toString ());
    }

    /**
        Read array from buffer
    **/
    public function GetArray (pos : Int, len : Int) : Array<UInt8> {
        var res = new Array<UInt8> ();
        for (i in pos...pos + len) {
            res.push (_buffer[i]);            
        }
        return res;
    }
    
    /**
        Return length of buffer
    **/
    public function Length () : UInt32 {
        return _buffer.length;
    }

    /**
        Extract binary data
    **/
    public function Cut (pos : Int, len : Int) : BinaryData {
        return new BinaryData (_buffer.splice (pos, len));
    }

    /**
        Return buffer
    **/
    public function ToArray () : Array<UInt8> {
        return _buffer;
    }

    /**
        Return buffer as bytes
    **/
    public function ToBytes () : Bytes {
        return ConvertToArrayBuffer (_buffer);
    }

    #if js

    /**
        Return js array buffer
    **/
    public function ToArrayBufferView () : js.html.ArrayBufferView {
        return new js.html.Uint8Array (_buffer);        
    }

    #end
}