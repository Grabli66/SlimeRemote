import haxe.macro.Context;
import haxe.macro.Expr;

/**
    Macros to build SlimePacket
**/
class PacketMacro {
    /**
        Return super type
    **/
    private static function GetSuperType (type : String) : String {
        try {
            var fieldType = Context.getType (type);

            switch (fieldType) {
                case TInst (tp, pr): {
                    return tp.get ().superClass.t.get ().name;
                }
                default: {}
            }            
        } catch (e : Dynamic) {}
        return null;
    }

   // private static function ResolveArray 

    /**
        Resolve type to type info
    **/
    private static function ResolveType (type : TypePath) : TypeInfo {        
        var ktype:KnownType;        
        try {
            ktype = type.name;            
        } catch (e : Dynamic) {
            try {                
                ktype = GetSuperType (type.name);
            } catch (e2 : Dynamic) {

            }
        }

        if (ktype == null) return null;
        var res : TypeInfo = { Id : ktype };

        if (ktype == KnownType.ARRAY) {            
            for (par in type.params) {
                switch (par) {
                    case TPType (t): {
                        switch (t) {
                            case TPath(p): {
                                res.Param = ResolveType (p);
                            }
                            default: {}
                        }                        
                    }
                    default : {}
                }
            }            
        }

        return res;
    }

    /**
        Return field type
    **/
    private static function GetFieldType (field : Field) : TypeInfo {        
        switch (field.kind) {
            case FVar(t,_): {
                var found = false;
                for (m in field.meta) {
                    if (m.name == 'Serialize') {
                        found = true;
                        break;
                    }
                }

                if (!found) return null; 

                switch (t) {
                    case TPath (e) : {                        
                        return ResolveType (e);
                    }
                    default: {}
                }
            }
            default: {}
        }

        return null;
    }

    /**
        Return fields with serialize meta
    **/
    private static function GetSelializeFields (fields : Array<Field>) : Array<VarInfo> {    
        var res = new Array<VarInfo> ();

        for (f in fields) {
            var fieldType = GetFieldType (f);            
            if (fieldType == null) continue;            
            res.push ({ Name : f.name, TypeInfo : fieldType });          
        }        
        
        return res;
    }

    /**
        Add constructor to fields
    **/
    private static function AddConstructor (fields : Array<Field>) {
        var pos = Context.currentPos();        

        var constructorFunc:Function = {
            expr: macro {
                super ();
            },
            ret: (macro:Void),
            args:[]
        }

        var constructorField:Field = {
            name: 'new',
            access: [Access.APublic],
            kind: FieldType.FFun(constructorFunc),
            pos: pos
        };   

        fields.push(constructorField);
    }

    /**
        Add class name to fields
    **/
    private static function AddGetName (fields : Array<Field>) {
        var classMeta = Context.getLocalClass ().get ();        
        var pos = Context.currentPos();
        var name = classMeta.name;

        var getNameFunc:Function = {
            expr: macro {
                var nm = $v{name};
                return nm;
            },
            ret: (macro:String),
            args:[]
        }

        var getNameField:Field = {
            name: 'GetName',
            access: [Access.APublic, Access.AOverride],
            kind: FieldType.FFun(getNameFunc),
            pos: pos
        };   

        fields.push(getNameField);

        var noCompletion = [{ name : ":noCompletion", pos : pos }];
        var registerField:Field = {
            name: '_register',
            meta : noCompletion,
            access: [Access.APrivate, Access.AStatic],
            kind: FVar(macro : Int, macro @:privateAccess SlimePacketParser.Register($v{name})),
            pos: pos
        };

        fields.push(registerField);

    }

    /**
        Add GetNames, GetValues function
    **/
    private static function AddGetValues (fields : Array<Field>) {
        var flds = GetSelializeFields (fields);
        var pos = Context.currentPos();
        trace (flds);

        var getNamesFunc:Function = {
            expr: macro {
                return $v{flds};
            },
            ret: (macro:Array<VarInfo>),
            args:[]
        }

        var getNamesField:Field = {
            name: 'GetNames',
            access: [Access.APublic, Access.AOverride],
            kind: FieldType.FFun(getNamesFunc),
            pos: pos
        }; 

        fields.push(getNamesField);

        var getValuesFunc:Function = {
            expr: macro {                
                var data = GetNames ();
                var fl = new Array<ValueInfo> ();
                for (d in data) {
                    var info : ValueInfo = { VarInfo : d, Value :  Reflect.field(this, d.Name) };                    
                    fl.push (info);
                }
                return fl;
            },
            ret: (macro:Array<ValueInfo>),
            args:[]
        }

        var getValuesField:Field = {
            name: 'GetValues',
            access: [Access.APublic, Access.AOverride],
            kind: FieldType.FFun(getValuesFunc),
            pos: pos
        }; 

        fields.push(getValuesField);
    }

    /**
        Add ToData function
    **/
    private static function AddToData (fields : Array<Field>) {
        var pos = Context.currentPos();

        var toDataFunc:Function = {
            expr: macro {
                return SlimePacketParser.ToBinary (this);
            },
            ret: (macro:BinaryData),
            args:[]
        }

        var toDataField:Field = {
            name: 'ToData',
            access: [Access.APublic],
            kind: FieldType.FFun(toDataFunc),
            pos: pos
        };   

        fields.push(toDataField);
    }


    /**
        Build type
    **/
    public static function build () : Array<Field> {        
        var fields = Context.getBuildFields();
        AddGetName (fields);
        AddGetValues (fields);
        AddToData (fields);
        AddConstructor (fields);
        return fields;
    }    
}