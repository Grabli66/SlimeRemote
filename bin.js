// Generated by Haxe 3.4.0
(function ($global) { "use strict";
var $hxClasses = {};
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var BinaryData = function(data) {
	this._buffer = [];
	if(data != null) {
		this._buffer = data;
	}
};
$hxClasses["BinaryData"] = BinaryData;
BinaryData.__name__ = true;
BinaryData.FromArray = function(data) {
	return new BinaryData(data);
};
BinaryData.ConvertToArrayUInt8 = function(data) {
	var dat = js_Boot.__cast(data.b.bufferValue , Uint8Array);
	var arr = [];
	var _g = 0;
	while(_g < dat.length) {
		var b = dat[_g];
		++_g;
		arr.push(b & 255);
	}
	return arr;
};
BinaryData.ConvertToArrayBuffer = function(data) {
	return haxe_io_Bytes.ofData(js_Boot.__cast(new Uint8Array(data) , ArrayBuffer));
};
BinaryData.RandomBytes = function(len) {
	var res = [];
	var _g1 = 0;
	while(_g1 < len) {
		++_g1;
		res.push(Math.round(Math.random() * 255) & 255);
	}
	return res;
};
BinaryData.FromBytes = function(data) {
	var dat = js_Boot.__cast(data.b.bufferValue , Uint8Array);
	var arr = [];
	var _g = 0;
	while(_g < dat.length) {
		var b = dat[_g];
		++_g;
		arr.push(b & 255);
	}
	return new BinaryData(arr);
};
BinaryData.FromArrayBuffer = function(data) {
	var dat = new Uint8Array(data);
	var arr = [];
	var _g = 0;
	while(_g < dat.length) {
		var b = dat[_g];
		++_g;
		arr.push(b & 255);
	}
	return new BinaryData(arr);
};
BinaryData.prototype = {
	iterator: function() {
		return HxOverrides.iter(this._buffer);
	}
	,AddBinaryData: function(data) {
		var b = data.iterator();
		while(b.hasNext()) {
			var b1 = b.next();
			this._buffer.push(b1);
		}
	}
	,AddArray: function(data) {
		var _g = 0;
		while(_g < data.length) {
			var b = data[_g];
			++_g;
			this._buffer.push(b);
		}
	}
	,AddBytes: function(data) {
		var dat = js_Boot.__cast(data.b.bufferValue , Uint8Array);
		var arr = [];
		var _g = 0;
		while(_g < dat.length) {
			var b = dat[_g];
			++_g;
			arr.push(b & 255);
		}
		this.AddArray(arr);
	}
	,AddUint8: function(b) {
		this._buffer.push(b);
	}
	,AddUint16: function(b) {
		this._buffer.push((b & 65280) >> 8 & 255);
		this._buffer.push(b & 255 & 255);
	}
	,AddUint32: function(b) {
		this._buffer.push((b & -16777216) >> 24 & 255);
		this._buffer.push((b & 16711680) >> 16 & 255);
		this._buffer.push((b & 65280) >> 8 & 255);
		this._buffer.push(b & 255 & 255);
	}
	,AddString: function(s) {
		var _gthis = this;
		haxe_Utf8.iter(haxe_Utf8.encode(s),function(b) {
			_gthis._buffer.push(b & 255);
		});
		this._buffer.push(0);
	}
	,GetUint8: function(pos) {
		return this._buffer[pos];
	}
	,GetUint16: function(pos) {
		return (this._buffer[pos] << 8) + this._buffer[pos + 1] & 65535;
	}
	,GetUint32: function(pos) {
		return (this._buffer[pos] << 24) + (this._buffer[pos + 1] << 16) + (this._buffer[pos + 2] << 8) + this._buffer[pos + 3] & -1;
	}
	,GetString: function(pos) {
		var utf = new haxe_Utf8();
		var _g1 = pos;
		var _g = this._buffer.length;
		while(_g1 < _g) {
			var b = this._buffer[_g1++];
			if(b == 0) {
				break;
			}
			utf.__b += String.fromCharCode(b);
		}
		return haxe_Utf8.decode(utf.__b);
	}
	,GetArray: function(pos,len) {
		var res = [];
		var _g1 = pos;
		var _g = pos + len;
		while(_g1 < _g) res.push(this._buffer[_g1++]);
		return res;
	}
	,Length: function() {
		return this._buffer.length & -1;
	}
	,Cut: function(pos,len) {
		return new BinaryData(this._buffer.splice(pos,len));
	}
	,ToArray: function() {
		return this._buffer;
	}
	,ToBytes: function() {
		return haxe_io_Bytes.ofData(js_Boot.__cast(new Uint8Array(this._buffer) , ArrayBuffer));
	}
	,ToArrayBufferView: function() {
		return new Uint8Array(this._buffer);
	}
	,__class__: BinaryData
};
var HxOverrides = function() { };
$hxClasses["HxOverrides"] = HxOverrides;
HxOverrides.__name__ = true;
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) {
		return undefined;
	}
	return x;
};
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var _$KnownType_KnownType_$Impl_$ = {};
$hxClasses["_KnownType.KnownType_Impl_"] = _$KnownType_KnownType_$Impl_$;
_$KnownType_KnownType_$Impl_$.__name__ = true;
_$KnownType_KnownType_$Impl_$._new = function(v) {
	if([3,4,0,1,2,6,5].indexOf(v) < 0) {
		throw new js__$Boot_HaxeError("Wrong value");
	}
	return v;
};
_$KnownType_KnownType_$Impl_$.FromInt = function(v) {
	if([3,4,0,1,2,6,5].indexOf(v) < 0) {
		throw new js__$Boot_HaxeError("Wrong value");
	}
	return v;
};
_$KnownType_KnownType_$Impl_$.FromString = function(v) {
	switch(v) {
	case "Array":
		if([3,4,0,1,2,6,5].indexOf(5) < 0) {
			throw new js__$Boot_HaxeError("Wrong value");
		}
		return 5;
	case "Int":
		if([3,4,0,1,2,6,5].indexOf(3) < 0) {
			throw new js__$Boot_HaxeError("Wrong value");
		}
		return 3;
	case "SlimePacket":
		if([3,4,0,1,2,6,5].indexOf(6) < 0) {
			throw new js__$Boot_HaxeError("Wrong value");
		}
		return 6;
	case "String":
		if([3,4,0,1,2,6,5].indexOf(4) < 0) {
			throw new js__$Boot_HaxeError("Wrong value");
		}
		return 4;
	case "UInt16":
		if([3,4,0,1,2,6,5].indexOf(1) < 0) {
			throw new js__$Boot_HaxeError("Wrong value");
		}
		return 1;
	case "UInt32":
		if([3,4,0,1,2,6,5].indexOf(2) < 0) {
			throw new js__$Boot_HaxeError("Wrong value");
		}
		return 2;
	case "UInt8":
		if([3,4,0,1,2,6,5].indexOf(0) < 0) {
			throw new js__$Boot_HaxeError("Wrong value");
		}
		return 0;
	default:
		throw new js__$Boot_HaxeError("Wrong type");
	}
};
Math.__name__ = true;
var Reflect = function() { };
$hxClasses["Reflect"] = Reflect;
Reflect.__name__ = true;
Reflect.field = function(o,field) {
	try {
		return o[field];
	} catch( e ) {
		return null;
	}
};
var SlimePacket = function() {
};
$hxClasses["SlimePacket"] = SlimePacket;
SlimePacket.__name__ = true;
SlimePacket.prototype = {
	GetName: function() {
		return "SlimePacket";
	}
	,GetValues: function() {
		return null;
	}
	,GetNames: function() {
		return null;
	}
	,__class__: SlimePacket
};
var SlimePacketParser = function() { };
$hxClasses["SlimePacketParser"] = SlimePacketParser;
SlimePacketParser.__name__ = true;
SlimePacketParser.AddPacket = function(data,out) {
	if(data == null) {
		out.AddUint8(255);
		return;
	}
	out.AddUint8(2);
	var name = data.GetName();
	var _this = SlimePacketParser._knownPackets;
	out.AddUint8(__map_reserved[name] != null?_this.getReserved(name):_this.h[name]);
	var vals = data.GetValues();
	out.AddUint8(vals.length & 255);
	var _g = 0;
	while(_g < vals.length) {
		var v = vals[_g];
		++_g;
		SlimePacketParser.AddData(v,out);
	}
};
SlimePacketParser.AddUInt8 = function(data,out) {
	out.AddUint8(3);
	out.AddUint8(data.Value);
};
SlimePacketParser.AddUInt16 = function(data,out) {
	out.AddUint8(4);
	out.AddUint16(data.Value);
};
SlimePacketParser.AddUInt32 = function(data,out) {
	out.AddUint8(5);
	out.AddUint32(data.Value);
};
SlimePacketParser.AddArray = function(data,out) {
	var typeInfo = data.VarInfo.TypeInfo.Param;
	if(data.VarInfo.TypeInfo.Param == null) {
		throw new js__$Boot_HaxeError("Wrong array");
	}
	var value = data.Value;
	out.AddUint8(1);
	out.AddUint8(value.length & 255);
	var _g = 0;
	while(_g < value.length) {
		var v = value[_g];
		++_g;
		SlimePacketParser.AddData({ VarInfo : { Name : "", TypeInfo : typeInfo}, Value : v},out);
	}
};
SlimePacketParser.AddData = function(data,out) {
	var typeId = data.VarInfo.TypeInfo.Id;
	if(typeId == 6) {
		SlimePacketParser.AddPacket(data.Value,out);
	} else if(typeId == 0) {
		SlimePacketParser.AddUInt8(data,out);
	} else if(typeId == 1) {
		SlimePacketParser.AddUInt16(data,out);
	} else if(typeId == 2) {
		SlimePacketParser.AddUInt32(data,out);
	} else if(typeId == 3) {
		SlimePacketParser.AddUInt32(data,out);
	} else if(typeId == 5) {
		SlimePacketParser.AddArray(data,out);
	} else {
		throw new js__$Boot_HaxeError("Unsupported data");
	}
};
SlimePacketParser.GetPacket = function(data,pos) {
	var packType = data.GetUint8(pos);
	++pos;
	var pack = Type.createInstance(SlimePacketParser._knownPacketsResolved.h[packType],[]);
	if(pack == null) {
		throw new js__$Boot_HaxeError("Unknown packet");
	}
	var count = data.GetUint8(pos);
	++pos;
	var names = pack.GetNames();
	if(count != names.length) {
		throw new js__$Boot_HaxeError("Wrong data");
	}
	var _g1 = 0;
	var _g = count;
	while(_g1 < _g) {
		var dat = SlimePacketParser.GetType(data,pos);
		pos = dat.Pos;
		pack[names[_g1++].Name] = dat.Data;
	}
	return { Packet : pack, Pos : pos};
};
SlimePacketParser.GetArray = function(data,pos) {
	var count = data.GetUint8(pos);
	++pos;
	var res = [];
	var _g1 = 0;
	var _g = count;
	while(_g1 < _g) {
		++_g1;
		var tp = SlimePacketParser.GetType(data,pos);
		pos = tp.Pos;
		res.push(tp.Data);
	}
	return { Data : res, Pos : pos};
};
SlimePacketParser.GetType = function(data,pos) {
	var type = data.GetUint8(pos);
	++pos;
	var dat;
	switch(type) {
	case 1:
		var arr = SlimePacketParser.GetArray(data,pos);
		dat = arr.Data;
		pos = arr.Pos;
		break;
	case 2:
		var stru = SlimePacketParser.GetPacket(data,pos);
		dat = stru.Packet;
		pos = stru.Pos;
		break;
	case 3:
		dat = data.GetUint8(pos);
		++pos;
		break;
	case 4:
		dat = data.GetUint16(pos);
		pos += 2;
		break;
	case 5:
		dat = data.GetUint32(pos);
		pos += 4;
		break;
	case 255:
		dat = null;
		break;
	default:
		throw new js__$Boot_HaxeError("Unknown type: " + type);
	}
	return { Data : dat, Pos : pos};
};
SlimePacketParser.Register = function(name) {
	console.log(name);
	var v = SlimePacketParser._counter & 255;
	var _this = SlimePacketParser._knownPackets;
	if(__map_reserved[name] != null) {
		_this.setReserved(name,v);
	} else {
		_this.h[name] = v;
	}
	var this1 = SlimePacketParser._knownPacketsResolved;
	var this2 = SlimePacketParser._counter & 255;
	var v1 = Type.resolveClass(name);
	this1.h[this2] = v1;
	SlimePacketParser._counter++;
	return 0;
};
SlimePacketParser.ToBinary = function(data) {
	var res = new BinaryData();
	SlimePacketParser.AddPacket(data,res);
	return res;
};
SlimePacketParser.FromBinary = function(data) {
	return SlimePacketParser.GetType(data,0).Data;
};
var Std = function() { };
$hxClasses["Std"] = Std;
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
var Type = function() { };
$hxClasses["Type"] = Type;
Type.__name__ = true;
Type.resolveClass = function(name) {
	var cl = $hxClasses[name];
	if(cl == null || !cl.__name__) {
		return null;
	}
	return cl;
};
Type.createInstance = function(cl,args) {
	var _g = args.length;
	switch(_g) {
	case 0:
		return new cl();
	case 1:
		return new cl(args[0]);
	case 2:
		return new cl(args[0],args[1]);
	case 3:
		return new cl(args[0],args[1],args[2]);
	case 4:
		return new cl(args[0],args[1],args[2],args[3]);
	case 5:
		return new cl(args[0],args[1],args[2],args[3],args[4]);
	case 6:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5]);
	case 7:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6]);
	case 8:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7]);
	case 9:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8]);
	case 10:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9]);
	case 11:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10]);
	case 12:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11]);
	case 13:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12]);
	case 14:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11],args[12],args[13]);
	default:
		throw new js__$Boot_HaxeError("Too many arguments");
	}
};
var TestPacket = function() {
	SlimePacket.call(this);
};
$hxClasses["TestPacket"] = TestPacket;
TestPacket.__name__ = true;
TestPacket.__super__ = SlimePacket;
TestPacket.prototype = $extend(SlimePacket.prototype,{
	GetName: function() {
		return "TestPacket";
	}
	,GetNames: function() {
		if([3,4,0,1,2,6,5].indexOf(0) < 0) {
			throw new js__$Boot_HaxeError("Wrong value");
		}
		if([3,4,0,1,2,6,5].indexOf(1) < 0) {
			throw new js__$Boot_HaxeError("Wrong value");
		}
		return [{ Name : "x", TypeInfo : { Id : 0}},{ Name : "y", TypeInfo : { Id : 1}}];
	}
	,GetValues: function() {
		var data = this.GetNames();
		var fl = [];
		var _g = 0;
		while(_g < data.length) {
			var d = data[_g];
			++_g;
			fl.push({ VarInfo : d, Value : Reflect.field(this,d.Name)});
		}
		return fl;
	}
	,ToData: function() {
		return SlimePacketParser.ToBinary(this);
	}
	,__class__: TestPacket
});
var TestSerialize = function() { };
$hxClasses["TestSerialize"] = TestSerialize;
TestSerialize.__name__ = true;
TestSerialize.main = function() {
	var items = [];
	var tm = new Date().getTime();
	var _g = 0;
	while(_g < 1) {
		_g++;
		var pack = new TestPacket();
		pack.x = 125;
		pack.x = 125;
		items.push(SlimePacketParser.FromBinary(pack.ToData()));
	}
	tm = new Date().getTime() - tm;
	console.log(tm);
};
var _$UInt16_UInt16_$Impl_$ = {};
$hxClasses["_UInt16.UInt16_Impl_"] = _$UInt16_UInt16_$Impl_$;
_$UInt16_UInt16_$Impl_$.__name__ = true;
_$UInt16_UInt16_$Impl_$._new = function(v) {
	return v & 65535;
};
_$UInt16_UInt16_$Impl_$.FromInt = function(v) {
	return v & 65535;
};
var _$UInt32_UInt32_$Impl_$ = {};
$hxClasses["_UInt32.UInt32_Impl_"] = _$UInt32_UInt32_$Impl_$;
_$UInt32_UInt32_$Impl_$.__name__ = true;
_$UInt32_UInt32_$Impl_$._new = function(v) {
	return v & -1;
};
_$UInt32_UInt32_$Impl_$.FromInt = function(v) {
	return v & -1;
};
var _$UInt8_UInt8_$Impl_$ = {};
$hxClasses["_UInt8.UInt8_Impl_"] = _$UInt8_UInt8_$Impl_$;
_$UInt8_UInt8_$Impl_$.__name__ = true;
_$UInt8_UInt8_$Impl_$._new = function(v) {
	return v & 255;
};
_$UInt8_UInt8_$Impl_$.FromInt = function(v) {
	return v & 255;
};
var haxe_IMap = function() { };
$hxClasses["haxe.IMap"] = haxe_IMap;
haxe_IMap.__name__ = true;
var haxe_Utf8 = function(size) {
	this.__b = "";
};
$hxClasses["haxe.Utf8"] = haxe_Utf8;
haxe_Utf8.__name__ = true;
haxe_Utf8.iter = function(s,chars) {
	var _g1 = 0;
	var _g = s.length;
	while(_g1 < _g) chars(HxOverrides.cca(s,_g1++));
};
haxe_Utf8.encode = function(s) {
	throw new js__$Boot_HaxeError("Not implemented");
};
haxe_Utf8.decode = function(s) {
	throw new js__$Boot_HaxeError("Not implemented");
};
haxe_Utf8.prototype = {
	__class__: haxe_Utf8
};
var haxe_ds_IntMap = function() {
	this.h = { };
};
$hxClasses["haxe.ds.IntMap"] = haxe_ds_IntMap;
haxe_ds_IntMap.__name__ = true;
haxe_ds_IntMap.__interfaces__ = [haxe_IMap];
haxe_ds_IntMap.prototype = {
	__class__: haxe_ds_IntMap
};
var haxe_ds_StringMap = function() {
	this.h = { };
};
$hxClasses["haxe.ds.StringMap"] = haxe_ds_StringMap;
haxe_ds_StringMap.__name__ = true;
haxe_ds_StringMap.__interfaces__ = [haxe_IMap];
haxe_ds_StringMap.prototype = {
	setReserved: function(key,value) {
		if(this.rh == null) {
			this.rh = { };
		}
		this.rh["$" + key] = value;
	}
	,getReserved: function(key) {
		if(this.rh == null) {
			return null;
		} else {
			return this.rh["$" + key];
		}
	}
	,__class__: haxe_ds_StringMap
};
var haxe_io_Bytes = function(data) {
	this.length = data.byteLength;
	this.b = new Uint8Array(data);
	this.b.bufferValue = data;
	data.hxBytes = this;
	data.bytes = this.b;
};
$hxClasses["haxe.io.Bytes"] = haxe_io_Bytes;
haxe_io_Bytes.__name__ = true;
haxe_io_Bytes.ofData = function(b) {
	var hb = b.hxBytes;
	if(hb != null) {
		return hb;
	}
	return new haxe_io_Bytes(b);
};
haxe_io_Bytes.prototype = {
	__class__: haxe_io_Bytes
};
var js__$Boot_HaxeError = function(val) {
	Error.call(this);
	this.val = val;
	this.message = String(val);
	if(Error.captureStackTrace) {
		Error.captureStackTrace(this,js__$Boot_HaxeError);
	}
};
$hxClasses["js._Boot.HaxeError"] = js__$Boot_HaxeError;
js__$Boot_HaxeError.__name__ = true;
js__$Boot_HaxeError.wrap = function(val) {
	if((val instanceof Error)) {
		return val;
	} else {
		return new js__$Boot_HaxeError(val);
	}
};
js__$Boot_HaxeError.__super__ = Error;
js__$Boot_HaxeError.prototype = $extend(Error.prototype,{
	__class__: js__$Boot_HaxeError
});
var js_Boot = function() { };
$hxClasses["js.Boot"] = js_Boot;
js_Boot.__name__ = true;
js_Boot.getClass = function(o) {
	if((o instanceof Array) && o.__enum__ == null) {
		return Array;
	} else {
		var cl = o.__class__;
		if(cl != null) {
			return cl;
		}
		var name = js_Boot.__nativeClassName(o);
		if(name != null) {
			return js_Boot.__resolveNativeClass(name);
		}
		return null;
	}
};
js_Boot.__string_rec = function(o,s) {
	if(o == null) {
		return "null";
	}
	if(s.length >= 5) {
		return "<...>";
	}
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) {
		t = "object";
	}
	switch(t) {
	case "function":
		return "<function>";
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) {
					return o[0];
				}
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) {
						str += "," + js_Boot.__string_rec(o[i],s);
					} else {
						str += js_Boot.__string_rec(o[i],s);
					}
				}
				return str + ")";
			}
			var l = o.length;
			var i1;
			var str1 = "[";
			s += "\t";
			var _g11 = 0;
			var _g2 = l;
			while(_g11 < _g2) {
				var i2 = _g11++;
				str1 += (i2 > 0?",":"") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") {
				return s2;
			}
		}
		var k = null;
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) {
			str2 += ", \n";
		}
		str2 += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
	case "string":
		return o;
	default:
		return String(o);
	}
};
js_Boot.__interfLoop = function(cc,cl) {
	if(cc == null) {
		return false;
	}
	if(cc == cl) {
		return true;
	}
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0;
		var _g = intf.length;
		while(_g1 < _g) {
			var i = intf[_g1++];
			if(i == cl || js_Boot.__interfLoop(i,cl)) {
				return true;
			}
		}
	}
	return js_Boot.__interfLoop(cc.__super__,cl);
};
js_Boot.__instanceof = function(o,cl) {
	if(cl == null) {
		return false;
	}
	switch(cl) {
	case Array:
		if((o instanceof Array)) {
			return o.__enum__ == null;
		} else {
			return false;
		}
		break;
	case Bool:
		return typeof(o) == "boolean";
	case Dynamic:
		return true;
	case Float:
		return typeof(o) == "number";
	case Int:
		if(typeof(o) == "number") {
			return (o|0) === o;
		} else {
			return false;
		}
		break;
	case String:
		return typeof(o) == "string";
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) {
					return true;
				}
				if(js_Boot.__interfLoop(js_Boot.getClass(o),cl)) {
					return true;
				}
			} else if(typeof(cl) == "object" && js_Boot.__isNativeObj(cl)) {
				if(o instanceof cl) {
					return true;
				}
			}
		} else {
			return false;
		}
		if(cl == Class?o.__name__ != null:false) {
			return true;
		}
		if(cl == Enum?o.__ename__ != null:false) {
			return true;
		}
		return o.__enum__ == cl;
	}
};
js_Boot.__cast = function(o,t) {
	if(js_Boot.__instanceof(o,t)) {
		return o;
	} else {
		throw new js__$Boot_HaxeError("Cannot cast " + Std.string(o) + " to " + Std.string(t));
	}
};
js_Boot.__nativeClassName = function(o) {
	var name = js_Boot.__toStr.call(o).slice(8,-1);
	if(name == "Object" || name == "Function" || name == "Math" || name == "JSON") {
		return null;
	}
	return name;
};
js_Boot.__isNativeObj = function(o) {
	return js_Boot.__nativeClassName(o) != null;
};
js_Boot.__resolveNativeClass = function(name) {
	return $global[name];
};
var js_html_compat_ArrayBuffer = function(a) {
	if((a instanceof Array) && a.__enum__ == null) {
		this.a = a;
		this.byteLength = a.length;
	} else {
		var len = a;
		this.a = [];
		var _g1 = 0;
		var _g = len;
		while(_g1 < _g) this.a[_g1++] = 0;
		this.byteLength = len;
	}
};
$hxClasses["js.html.compat.ArrayBuffer"] = js_html_compat_ArrayBuffer;
js_html_compat_ArrayBuffer.__name__ = true;
js_html_compat_ArrayBuffer.sliceImpl = function(begin,end) {
	var u = new Uint8Array(this,begin,end == null?null:end - begin);
	var result = new ArrayBuffer(u.byteLength);
	new Uint8Array(result).set(u);
	return result;
};
js_html_compat_ArrayBuffer.prototype = {
	slice: function(begin,end) {
		return new js_html_compat_ArrayBuffer(this.a.slice(begin,end));
	}
	,__class__: js_html_compat_ArrayBuffer
};
var js_html_compat_Uint8Array = function() { };
$hxClasses["js.html.compat.Uint8Array"] = js_html_compat_Uint8Array;
js_html_compat_Uint8Array.__name__ = true;
js_html_compat_Uint8Array._new = function(arg1,offset,length) {
	var arr;
	if(typeof(arg1) == "number") {
		arr = [];
		var _g1 = 0;
		var _g = arg1;
		while(_g1 < _g) {
			var i = _g1++;
			arr[i] = 0;
		}
		arr.byteLength = arr.length;
		arr.byteOffset = 0;
		arr.buffer = new js_html_compat_ArrayBuffer(arr);
	} else if(js_Boot.__instanceof(arg1,js_html_compat_ArrayBuffer)) {
		var buffer = arg1;
		if(offset == null) {
			offset = 0;
		}
		if(length == null) {
			length = buffer.byteLength - offset;
		}
		if(offset == 0) {
			arr = buffer.a;
		} else {
			arr = buffer.a.slice(offset,offset + length);
		}
		arr.byteLength = arr.length;
		arr.byteOffset = offset;
		arr.buffer = buffer;
	} else if((arg1 instanceof Array) && arg1.__enum__ == null) {
		arr = arg1.slice();
		arr.byteLength = arr.length;
		arr.byteOffset = 0;
		arr.buffer = new js_html_compat_ArrayBuffer(arr);
	} else {
		throw new js__$Boot_HaxeError("TODO " + Std.string(arg1));
	}
	arr.subarray = js_html_compat_Uint8Array._subarray;
	arr.set = js_html_compat_Uint8Array._set;
	return arr;
};
js_html_compat_Uint8Array._set = function(arg,offset) {
	if(js_Boot.__instanceof(arg.buffer,js_html_compat_ArrayBuffer)) {
		var a = arg;
		if(arg.byteLength + offset > this.byteLength) {
			throw new js__$Boot_HaxeError("set() outside of range");
		}
		var _g1 = 0;
		var _g = arg.byteLength;
		while(_g1 < _g) {
			var i = _g1++;
			this[i + offset] = a[i];
		}
	} else if((arg instanceof Array) && arg.__enum__ == null) {
		var a1 = arg;
		if(a1.length + offset > this.byteLength) {
			throw new js__$Boot_HaxeError("set() outside of range");
		}
		var _g11 = 0;
		var _g2 = a1.length;
		while(_g11 < _g2) {
			var i1 = _g11++;
			this[i1 + offset] = a1[i1];
		}
	} else {
		throw new js__$Boot_HaxeError("TODO");
	}
};
js_html_compat_Uint8Array._subarray = function(start,end) {
	var a = js_html_compat_Uint8Array._new(this.slice(start,end));
	a.byteOffset = start;
	return a;
};
$hxClasses["Math"] = Math;
String.prototype.__class__ = $hxClasses["String"] = String;
String.__name__ = true;
$hxClasses["Array"] = Array;
Array.__name__ = true;
Date.prototype.__class__ = $hxClasses["Date"] = Date;
Date.__name__ = ["Date"];
var Int = $hxClasses["Int"] = { __name__ : ["Int"]};
var Dynamic = $hxClasses["Dynamic"] = { __name__ : ["Dynamic"]};
var Float = $hxClasses["Float"] = Number;
Float.__name__ = ["Float"];
var Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = $hxClasses["Class"] = { __name__ : ["Class"]};
var Enum = { };
var __map_reserved = {}
var ArrayBuffer = $global.ArrayBuffer || js_html_compat_ArrayBuffer;
if(ArrayBuffer.prototype.slice == null) {
	ArrayBuffer.prototype.slice = js_html_compat_ArrayBuffer.sliceImpl;
}
var Uint8Array = $global.Uint8Array || js_html_compat_Uint8Array._new;
_$KnownType_KnownType_$Impl_$.UINT8 = 0;
_$KnownType_KnownType_$Impl_$.UINT16 = 1;
_$KnownType_KnownType_$Impl_$.UINT32 = 2;
_$KnownType_KnownType_$Impl_$.INT = 3;
_$KnownType_KnownType_$Impl_$.STRING = 4;
_$KnownType_KnownType_$Impl_$.ARRAY = 5;
_$KnownType_KnownType_$Impl_$.SLIME_PACKET = 6;
_$KnownType_KnownType_$Impl_$.UINT8_STR = "UInt8";
_$KnownType_KnownType_$Impl_$.UINT16_STR = "UInt16";
_$KnownType_KnownType_$Impl_$.UINT32_STR = "UInt32";
_$KnownType_KnownType_$Impl_$.INT_STR = "Int";
_$KnownType_KnownType_$Impl_$.STRING_STR = "String";
_$KnownType_KnownType_$Impl_$.ARRAY_STR = "Array";
_$KnownType_KnownType_$Impl_$.SLIME_PACKET_STR = "SlimePacket";
SlimePacketParser.NULL = 255;
SlimePacketParser.ARRAY = 1;
SlimePacketParser.STRUCTURE = 2;
SlimePacketParser.UINT8 = 3;
SlimePacketParser.UINT16 = 4;
SlimePacketParser.UINT32 = 5;
SlimePacketParser._counter = 0;
SlimePacketParser._knownPackets = new haxe_ds_StringMap();
SlimePacketParser._knownPacketsResolved = new haxe_ds_IntMap();
TestPacket.__meta__ = { fields : { x : { Serialize : null}, y : { Serialize : null}}};
TestPacket._register = SlimePacketParser.Register("TestPacket");
js_Boot.__toStr = ({ }).toString;
js_html_compat_Uint8Array.BYTES_PER_ELEMENT = 1;
TestSerialize.main();
})(typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
