package states.stages;

import states.stages.objects.*;

import haxe.ds.Vector; // Using Vector for fixed-size array potentially accessed by index
import haxe.ds.StringMap; // Potentially useful for dynamic properties if needed, though prop_set handles strings
import Math; // For Math functions

// Placeholder types - These need actual implementation based on the target Haxe engine/framework
typedef Sprite = Dynamic; // Represents a sprite object
typedef Color = Int; // Represents a color value (e.g., 0xFFRRGGBB)
typedef Point3D = { x:Float, y:Float, z:Float }; // Structure for 3D points
typedef StrumLine = {
    var p:Array<Point3D>; // Array of points
    var a:Float;
    var ax:Float;
    var ay:Float;
    var w:Float;
};
typedef Strum = {
    var lines:Array<StrumLine>;
    var pos:Point3D;
    var ang3D:Point3D;
    var dir:Point3D;
};
typedef Field = {
    var x:Float;
    var y:Float;
    var z:Float;
};
typedef FNFObjectProp = {
    var cam:Array<Float>; // Assuming cam is an array of floats based on usage
};
typedef FNFObject = {
    var x:Float;
    var y:Float; // Added y based on potential usage, though not explicitly set in create()
    var prop:FNFObjectProp;
    // Add other properties if needed by the engine
};
typedef GameObject = {
    var field:Array<Field>; // Array of fields (field.0, field.1)
    var strums:Array<Strum>; // Array of strums (strums.0 to strums.7)
    // Add other properties if needed by the engine
};
typedef SystemSkin = {
    var sep:Float; // Separator value from skin settings
};
typedef SystemOptions = {
    var downscroll:Bool; // Downscroll option
};
typedef System = {
    var skin:SystemSkin;
    var opt:SystemOptions;
};

// Placeholder for global game objects - Initialize or obtain these according to your framework
class GlobalObjects {
    public static var obj_fnf:{ bf:FNFObject, dad:FNFObject, gf:FNFObject, camZoom:Float, camToZoom:Float } = {
        bf:{ x:0.0, y:0.0, prop:{ cam:[0.0, 0.0] } }, // Initial placeholder values
        dad:{ x:0.0, y:0.0, prop:{ cam:[0.0, 0.0] } }, // Initial placeholder values
        gf:{ x:0.0, y:0.0, prop:{ cam:[0.0, 0.0] } }, // Initial placeholder values
        camZoom:1.0, // Default zoom
        camToZoom:1.0 // Default zoom target
    };

    public static var obj_game:GameObject = {
        field:[ { x:0.0, y:0.0, z:0.0 }, { x:0.0, y:0.0, z:0.0 } ], // Initialize field array
        strums:[ // Initialize strums array (size 8)
            { lines:[ { p:[], a:0.0, ax:0.0, ay:0.0, w:0.0 }, { p:[], a:0.0, ax:0.0, ay:0.0, w:0.0 } ], pos:{x:0,y:0,z:0}, ang3D:{x:0,y:0,z:0}, dir:{x:0,y:0,z:0} },
            { lines:[ { p:[], a:0.0, ax:0.0, ay:0.0, w:0.0 }, { p:[], a:0.0, ax:0.0, ay:0.0, w:0.0 } ], pos:{x:0,y:0,z:0}, ang3D:{x:0,y:0,z:0}, dir:{x:0,y:0,z:0} },
            { lines:[ { p:[], a:0.0, ax:0.0, ay:0.0, w:0.0 }, { p:[], a:0.0, ax:0.0, ay:0.0, w:0.0 } ], pos:{x:0,y:0,z:0}, ang3D:{x:0,y:0,z:0}, dir:{x:0,y:0,z:0} },
            { lines:[ { p:[], a:0.0, ax:0.0, ay:0.0, w:0.0 }, { p:[], a:0.0, ax:0.0, ay:0.0, w:0.0 } ], pos:{x:0,y:0,z:0}, ang3D:{x:0,y:0,z:0}, dir:{x:0,y:0,z:0} },
            { lines:[ { p:[], a:0.0, ax:0.0, ay:0.0, w:0.0 }, { p:[], a:0.0, ax:0.0, ay:0.0, w:0.0 } ], pos:{x:0,y:0,z:0}, ang3D:{x:0,y:0,z:0}, dir:{x:0,y:0,z:0} },
            { lines:[ { p:[], a:0.0, ax:0.0, ay:0.0, w:0.0 }, { p:[], a:0.0, ax:0.0, ay:0.0, w:0.0 } ], pos:{x:0,y:0,z:0}, ang3D:{x:0,y:0,z:0}, dir:{x:0,y:0,z:0} },
            { lines:[ { p:[], a:0.0, ax:0.0, ay:0.0, w:0.0 }, { p:[], a:0.0, ax:0.0, ay:0.0, w:0.0 } ], pos:{x:0,y:0,z:0}, ang3D:{x:0,y:0,z:0}, dir:{x:0,y:0,z:0} },
            { lines:[ { p:[], a:0.0, ax:0.0, ay:0.0, w:0.0 }, { p:[], a:0.0, ax:0.0, ay:0.0, w:0.0 } ], pos:{x:0,y:0,z:0}, ang3D:{x:0,y:0,z:0}, dir:{x:0,y:0,z:0} }
        ]
    };

    public static var sys:System = { // Placeholder system object
        skin:{ sep:110.0 }, // Example value
        opt:{ downscroll:false } // Example value
    };

    // Placeholder color constants
    public static inline var c_black:Color = 0xFF000000;
    public static inline var c_white:Color = 0xFFFFFFFF;
}

// Placeholder for Engine/Framework specific functions
// These need to be implemented using your actual Haxe game engine's API
class GameAPI {
    public static function sprite_load(path:String):Sprite {
        // Implementation depends on the engine (e.g., FlxSprite, Heaps Sprite)
        trace('GameAPI.sprite_load:Loading sprite from path:$path');
        return { path:path, x:0.0, y:0.0, offsetX:0.0, offsetY:0.0 }; // Return a dummy sprite object
    }

    public static function offset_setby_fraction(sprite:Sprite, fx:Float, fy:Float):Void {
        // Implementation depends on the engine's sprite offset/origin system
        trace('GameAPI.offset_setby_fraction:Setting offset for sprite ${sprite.path} to ($fx, $fy)');
        // Example logic (assuming sprite has width/height properties):
        // sprite.offsetX = sprite.width * fx;
        // sprite.offsetY = sprite.height * fy;
    }

    public static function prop_set(target:Dynamic, propertyPath:String, value:Dynamic):Void {
        // Implementation requires reflection or a specific property access system
        trace('GameAPI.prop_set:Setting property "$propertyPath" on target to $value');
        var parts = propertyPath.split(".");
        var obj:Array<Int<0>> = target;
        for (i in 0, parts.length - 1) {
            var part = parts[i];
            var index:Null<Int> = Std.parseInt(part);
            if (index != null && Reflect.hasField(obj, "length") && Std.isOfType(obj, Array)) { // Check if it's an array index
                 obj = obj[index];
            } else if (Reflect.hasField(obj, part)) {
                obj = Reflect.field(obj, part);
            } else {
                 trace('GameAPI.prop_set:Error - Path part "$part" not found in property path "$propertyPath"');
                 return; // Property not found
            }
             if (obj == null) {
                 trace('GameAPI.prop_set:Error - Object is null at part "$part" in property path "$propertyPath"');
                 return;
             }
        }
        var finalPart = parts[parts.length - 1];
        var finalIndex:Null<Int> = Std.parseInt(finalPart);
         if (finalIndex != null && Reflect.hasField(obj, "length") && Std.isOfType(obj, Array)) { // Check if it's an array index
             if (finalIndex >= 0 && finalIndex < obj.length) {
                 obj[finalIndex] = value;
             } else {
                 trace('GameAPI.prop_set:Error - Index $finalIndex out of bounds for array in property path "$propertyPath"');
             }
         } else {
            Reflect.setField(obj, finalPart, value);
         }
    }

    public static function draw_set_color(color:Color):Void {
        // Implementation depends on the engine's drawing API
        trace('GameAPI.draw_set_color:Setting draw color to $color');
    }

    public static function draw_rectangle(x1:Float, y1:Float, x2:Float, y2:Float, outline:Bool):Void {
        // Implementation depends on the engine's drawing API
        trace('GameAPI.draw_rectangle:Drawing rectangle from ($x1, $y1) to ($x2, $y2), outline:$outline');
    }

    public static function draw_sprite_scrolled(sprite:Sprite, layer:Int, subLayer:Int, z:Float, scaleX:Float, scaleY:Float):Void {
        // Implementation depends on the engine's drawing and camera/scrolling system
        trace('GameAPI.draw_sprite_scrolled:Drawing sprite ${sprite.path} at z=$z, scale=($scaleX, $scaleY)');
    }

    public static function scroll_get_pos(layer:Int, z:Float, factor:Float):Array<Float> {
        // Implementation depends on the engine's camera/scrolling system
        trace('GameAPI.scroll_get_pos:Getting scroll position for layer=$layer, z=$z, factor=$factor');
        // Return dummy position [x, y]
        return [0.0, 0.0];
    }

    public static function draw_floor(sprite:Sprite, layer:Int, subLayer:Int, z:Float, scrollX:Float, scrollY:Float, ?isCeiling:Bool = false):Void {
        // Implementation depends on the engine's drawing API (likely involves tiling/repeating the sprite)
        trace('GameAPI.draw_floor:Drawing floor/ceiling using sprite ${sprite.path} at z=$z, scroll=($scrollX, $scrollY), isCeiling=$isCeiling');
    }

    public static function tweenStart(targetPath:Array<Dynamic>, properties:Dynamic, duration:Float, ease:String, ?delay:Float = 0.0):Void {
        // Implementation depends on the engine's tweening library (e.g., Actuate, GTween)
        // targetPath is assumed to be [baseObject, "propertyPathString"] based on Lua usage like {obj_game, "field.0"}
        if (targetPath == null || targetPath.length != 2) {
             trace('GameAPI.tweenStart:Error - Invalid targetPath format.');
             return;
        }
        var targetObject = targetPath[0];
        var propertyPath = Std.string(targetPath[1]); // Ensure it's a string
        trace('GameAPI.tweenStart:Starting tween on $propertyPath for duration $duration, ease $ease, delay $delay with properties $properties');
        // Actual tweening logic needs to be added here using the engine's tween library.
        // This might involve parsing the propertyPath similar to prop_set or using a library feature.
    }

    // This seems to be a call to the mod's own initialization function, not a generic API call.
    // It's handled by calling the `modInit` method within the CaveBGMod class.
    // public static function modInit(modValue:Int):Void {
    //     trace('GameAPI.modInit:Called with modValue $modValue');
    // }
}

// Utility Math functions
class MathUtil {
    public static inline function degtorad(degrees:Float):Float {
        return degrees * (Math.PI / 180);
    }

    public static inline function radtodeg(radians:Float):Float {
        return radians * (180 / Math.PI);
    }
}


class CaveStage extends BaseStage {

    // Variables from the first 'create' function (related to background)
    static var bg:Sprite;
    static var super_bg:Sprite;
    static var es1:Sprite;
    static var cal1:Sprite;
    static var cal2:Sprite;
    static var ground:Sprite;
    static var ceil:Sprite;

    // Variables from the second 'create' function and global scope (mod logic)
    static var mod:Int = 0;
    static var subMod:Int = 0;
    static var modBeat:Int = 0;
    static var modStep:Int = 0; // Note:modStep is declared but never used in the provided Lua code
    static var started:Bool = false;

    static var l:Float; // Will be initialized in modCreate
    static var cnt:Array<Float>; // Will be initialized in modCreate

    static var centerY:Float = 270;

    static var rot:Float = 0;
    static var rotspd:Float = 1;
    static var circAng:Float = MathUtil.degtorad(180);

    static var curSide:Int = 0; // Used in onBeatHit mod 0 logic

    // Corresponds to the first Lua 'create' function
    override function create():Void {
        bg = GameAPI.sprite_load("cavebg/bg");
        GameAPI.offset_setby_fraction(bg, 0.5, 0.5);
        super_bg = GameAPI.sprite_load("cavebg/super_bg");
        GameAPI.offset_setby_fraction(super_bg, 0.5, 0.5);
        es1 = GameAPI.sprite_load("cavebg/es1");
        GameAPI.offset_setby_fraction(es1, 0.5, 0.5);
        cal1 = GameAPI.sprite_load("cavebg/cal1");
        GameAPI.offset_setby_fraction(cal1, 0.5, 0.5);
        cal2 = GameAPI.sprite_load("cavebg/cal2");
        GameAPI.offset_setby_fraction(cal2, 0.5, 0.5);

        ground = GameAPI.sprite_load("cavebg/ground");
        GameAPI.offset_setby_fraction(ground, 0.5, 0.35);
        ceil = GameAPI.sprite_load("cavebg/ceil");
        GameAPI.offset_setby_fraction(ceil, 0.5, 1 - 0.1);

        GlobalObjects.obj_fnf.bf.x = 750;
        GlobalObjects.obj_fnf.dad.x = -750;
        // Assuming prop.cam is 0-indexed in Haxe. Lua obj_fnf.bf.prop.cam[1] is index 0, cam[2] is index 1.
        GameAPI.prop_set(GlobalObjects.obj_fnf.bf, "prop.cam.0", GlobalObjects.obj_fnf.bf.prop.cam[0] - 300);
        GameAPI.prop_set(GlobalObjects.obj_fnf.bf, "prop.cam.1", GlobalObjects.obj_fnf.bf.prop.cam[1] - 50);
        GlobalObjects.obj_fnf.gf.x = 80;
        GlobalObjects.obj_fnf.camZoom = 0.55;
        GlobalObjects.obj_fnf.camToZoom = GlobalObjects.obj_fnf.camZoom;
    }

    public static function drawBG():Void {
        GameAPI.draw_set_color(GlobalObjects.c_black);
        GameAPI.draw_rectangle(-4000, -4000, 4000, 4000, false);
        GameAPI.draw_set_color(GlobalObjects.c_white);

        GameAPI.draw_sprite_scrolled(super_bg, 0, 0, -400, 0.1, 0.1);
        GameAPI.draw_sprite_scrolled(bg, 0, 0, 300, 0.3, 0.3);
        var gp = GameAPI.scroll_get_pos(0, -200, 0.1);
        // Assuming gp is 0-indexed in Haxe. Lua gp[1] is index 0, gp[2] is index 1.
        GameAPI.draw_floor(ceil, 0, 0, -1200, gp[0], gp[1], true);

        GameAPI.draw_sprite_scrolled(cal2, 0, -70, -350, 0.5, 0.5);
        GameAPI.draw_sprite_scrolled(es1, 0, 0, 0, 0.6, 0.6);
        GameAPI.draw_sprite_scrolled(cal1, 0, -70, -600, 0.7, 0.7);
        // Re-declare gp as local variable (shadowing previous gp)
        var gp = GameAPI.scroll_get_pos(0, -100, 0.8);
        // Assuming gp is 0-indexed in Haxe. Lua gp[1] is index 0, gp[2] is index 1.
        GameAPI.draw_floor(ground, 0, 0, 0, gp[0], gp[1]);
    }

    // Corresponds to the second Lua 'create' function (renamed to avoid conflict)
    public static function modCreate():Void {
        // Initialize l and cnt here as they depend on sys.skin.sep
        l = GlobalObjects.sys.skin.sep;
        cnt = [l*1.5, l / 2, -l / 2, -l*1.5]; // Haxe array literal
        modInit(0);
    }


    public static function modInit(Mod:Int):Void {
        mod = Mod;
        subMod = 0;
        modBeat = 0;
        modStep = 0; // Reset modStep as well, though unused later
        GameAPI.tweenStart([GlobalObjects.obj_game, "field.0"], {x :0, y :0, z :0}, 0.1, "inout_quad");
        GameAPI.tweenStart([GlobalObjects.obj_game, "field.1"], {x :0, y :0, z :0}, 0.1, "inout_quad");
        for (i in 0...8) { // Haxe loop from 0 to 7
            GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".lines.0.p", []); // Set points to empty array
            GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.0"], {a :270, ax :0, ay :0, w :1}, 0.1, "inout_quad");
            GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.1"], {a :270, ax :0, ay :0, w :1}, 0.1, "inout_quad");
            GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".pos"], {x :0, y :0, z :0}, 0.1, "inout_quad");
            GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".ang3D"], {x :0, y :0, z :0}, 0.1, "inout_quad");
            GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".dir"], {x :0, y :0, z :0}, 0.1, "inout_quad");
        }
        if (mod == 0) {
            curSide = 1; // Initialize curSide for mod 0 beat logic
            for (i in 0...8) {
                GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".lines.0.p", [{x :0.0, y :360.0, z :0.0}]); // Array with one point
            }
        } else if (mod == 1) {
            for (i in 0...8) {
                GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".lines.0.p", [{x :0.0, y :360.0, z :0.0}]);
            }
        } else if (mod == 2) {

            for (i in 0...8) {
                GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".lines.0.p", [{x :0.0, y :720.0 / 4.0, z :0.0}, {x :0.0, y :720.0 / 4.0 * 3.0, z :0.0}]); // Array with two points
            }

            var l = GlobalObjects.sys.skin.sep; // Local variable l
            var woo = l * 0.8;
            for (i in 0...2) { // Loop 0 to 1
                //idk
                var num0 = i*4;
                var num1 = i*4 + 1;
                var num2 = i*4 + 2;
                var num3 = i*4 + 3;

                var vdir:Float = 1; // Use Float for potential calculations

                if (GlobalObjects.sys.opt.downscroll) {
                    vdir = -1;
                }
                GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + num0 + ".pos"], {x :l * 1.5 - woo}, 0.2, "inout_quad");
                GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + num3 + ".pos"], {x :-l * 1.5 + woo}, 0.2, "inout_quad");
                GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + num1 + ".pos"], {x :l / 2, y :woo * vdir}, 0.2, "inout_quad");
                GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + num2 + ".pos"], {x :-l / 2, y :-woo * vdir}, 0.2, "inout_quad");
            }
            GameAPI.tweenStart([GlobalObjects.obj_game, "field.1"], {x :380, y :centerY}, 0.3, "inout_quad");
            GameAPI.tweenStart([GlobalObjects.obj_game, "field.1"], {z :-100}, 0.5, "inout_quad");
            GameAPI.tweenStart([GlobalObjects.obj_game, "field.0"], {y :380}, 1, "inout_quad");

            // Lua an = {-90, 0, 180, 90}; indices 1, 2, 3, 4
            // Haxe an = [-90, 0, 180, 90]; indices 0, 1, 2, 3
            var an:Array<Float> = [-90.0, 0.0, 180.0, 90.0];
            if (GlobalObjects.sys.opt.downscroll) {
                an[1] = 180; // Index 1 corresponds to Lua index 2
                an[2] = 0;   // Index 2 corresponds to Lua index 3
            }
            for (i in 0...8) {
                // Lua an[i % 4 + 1] -> Haxe an[i % 4]
                GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".dir"], {z :an[i % 4]}, 0.2, "inout_quad");
            }
        } else if (mod == 3) {
            GameAPI.tweenStart([GlobalObjects.obj_game, "field.1"], {x :380, y :centerY}, 0.8, "out_quad");
            GameAPI.tweenStart([GlobalObjects.obj_game, "field.0"], {x :-380, y :centerY}, 0.8, "out_quad");
            for (i in 0...8) {
                GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.0"], {ay :-60, w :0.9}, 0.11, "inout_quad");
                GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".lines.0.p", [{x :0.0, y :200.0, z :100.0}]);
                GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.1"], {ay :-90}, 0.11, "inout_quad");
                // Lua cnt[i%4 + 1] -> Haxe cnt[i % 4]
                GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".pos"], {x :cnt[i % 4]}, 0.11, "inout_quad");
            }
        } else if (mod == 4) {
            for (i in 0...8) {
                var w:Float = 80;
                if (i % 4 < 2) { w = w * -1; }
                GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.0"], {ay :-30}, 0.11, "inout_quad");
                GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".lines.0.p", [{x :0.0, y :360.0, z :40.0}]);
                // Lua cnt[i%4 + 1] -> Haxe cnt[i % 4]
                GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".pos"], {x :cnt[i % 4] + w}, 0.11, "inout_quad");
            }
        } else if (mod == 5) {
            for (i in 0...8) {
                GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".dir"], {x :50}, 1, "inout_quad");
                GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".ang3D"], {x :-50}, 1, "inout_quad");
            }
        }
    }


    override function update(elapsed:Float):Void {
        if (started) {
            if (mod == 0) {
                rot = rot + elapsed * 5;
                for (i in 0...8) {
                    GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".pos.z", Math.cos(rot + i) * 40);
                }

                if (subMod == 1) {
                    for (i in 0...8) {
                        GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".dir.z", Math.cos(rot + i) * 10);
                        GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".ang3D.z", Math.cos(rot + i) * 4);
                    }
                }
            } else if (mod == 3) {
                if (subMod == 2) {
                    rotspd = rotspd + elapsed;
                } else if (subMod == 3) {
                    rotspd = rotspd - elapsed * 1.21;
                    if (rotspd < 0) {
                        rotspd = 0;
                    } else {
                        // Use Math.random() which returns [0...1), scale and shift for [-4...4] range
                        var randX1 = Math.random() * 8 - 4;
                        var randY1 = Math.random() * 8 - 4;
                        var randX0 = Math.random() * 8 - 4;
                        var randY0 = Math.random() * 8 - 4;
                        GameAPI.tweenStart([GlobalObjects.obj_game, "field.1"], {x :380 + randX1, y :centerY + randY1}, 0.01, "out_quad");
                        GameAPI.tweenStart([GlobalObjects.obj_game, "field.0"], {x :-380 + randX0, y :centerY + randY0}, 0.01, "out_quad");
                    }
                }
                circAng = circAng + elapsed * rotspd;
                for (i in 0...8) {
                    var off = -((i % 4) - 2) / 2.5; // Lua indices 0,1,2,3 map to 0,1,2,3
                    var len:Float = 300;
                    var xlen:Float = len;
                    if (subMod >= 1) { xlen = 500; }
                    var an = circAng + off;
                    if (i < 4) { an = an + MathUtil.degtorad(180); }
                    // Lua cnt[i%4 + 1] -> Haxe cnt[i % 4]
                    GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".pos.x", cnt[i % 4] + Math.cos(an) * xlen);
                    GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".pos.y", -Math.sin(an) * len);

                    GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".dir.z", 270 + MathUtil.radtodeg(an - off));
                }
            } else if (mod == 5) {
                //[[
                //for i = 0, 7, 1 do
                //    prop_set(obj_game, "strums."..i..".pos.z", math.cos(rot + i) * 100);
                //end]]
            }
        }
    }

    public static function onBeatHit(beat:Int):Void {
        //prop_set(obj_game, "strums.1.pos.x", -40);
        //obj_fnf.gf.prop.beatDance = 4; // Assuming beatDance is a property
        //console_add(s.xscale); // Assuming console_add exists and s is defined elsewhere

        if (beat == 0) {
            started = true;
        }

        if (started) {
            // Update modBeat based on the current mod before potentially changing the mod
            modBeat = beat; // Or maybe modBeat should reset with modInit? Lua code implies it continues. Let's assume it tracks beats within the current mod segment.
                           // Re-evaluating:The Lua code resets modBeat = 0 in modInit. So it should track beats *since the last modInit*.
                           // This requires tracking the beat when the last modInit occurred.
                           // Let's simplify and assume modBeat should be calculated relative to the start beat of the current mod.
                           // This requires storing the start beat for each mod.
                           // OR, maybe the Lua code *intends* modBeat to be the absolute beat number, and the checks like `if (modBeat == 0)` inside mod == 1 logic are actually checking `if (beat == 64)` etc.
                           // Let's stick to the direct translation first:modBeat is reset in modInit. The checks `if (modBeat == X)` will compare against beats since the last modInit.

            // Determine the beat relative to the start of the current mod
            // This needs the beat number when the current mod started. Let's store it.
            // This complexity wasn't explicit in Lua, but necessary for the logic `if(modBeat == X)` to work as intended after `modBeat = 0` in `modInit`.
            // Let's backtrack:The Lua code *doesn't* reset modBeat in modInit. It's declared globally and reset alongside `mod`, `subMod`, etc., but the `modInit` function itself resets `modBeat = 0`. This means `modBeat` *does* track beats since the last `modInit`.

            // Mod switching logic
            if (beat == 32) {
                subMod = 1;
            } else if (beat == 64) {
                modInit(1);
                modBeat = 0; // Reset modBeat counter for the new mod
                return; // Exit early as modInit was called
            } else if (beat == 128) {
                modInit(2);
                modBeat = 0; // Reset modBeat counter for the new mod
                return; // Exit early as modInit was called
            } else if (beat == 192) {
                modInit(3);
                modBeat = 0; // Reset modBeat counter for the new mod
                return; // Exit early as modInit was called
            } else if (beat == 256) {
                modInit(4);
                modBeat = 0; // Reset modBeat counter for the new mod
                return; // Exit early as modInit was called
            } else if (beat == 296) { // Note:Lua has 296 then 288 - order matters if beats can be skipped? Assuming sequential.
                 modInit(0);
                 modBeat = 0; // Reset modBeat counter for the new mod
                 return; // Exit early as modInit was called
            } else if (beat == 288) { // This beat comes *before* 296 in the sequence.
                mod = -1; // Special state?
                for (i in 0...8) {
                    GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".pos"], {x :0, y :0, z :0}, 3, "inout_quad");
                }
                 // Don't reset modBeat here, as modInit wasn't called
            } else if (beat == 328) {
                modInit(5);
                modBeat = 0; // Reset modBeat counter for the new mod
                return; // Exit early as modInit was called
            } else if (beat == 392) {
                modInit(3);
                subMod = 1; // Set subMod *after* modInit
                modBeat = 0; // Reset modBeat counter for the new mod
                return; // Exit early as modInit was called
            } else if (beat == 456) {
                // This happens if mod is already 3 (set at beat 392)
                if (mod == 3) subMod = 2;
            } else if (beat == 464) {
                 // This happens if mod is already 3
                if (mod == 3) subMod = 3;
            }

            // Beat-based animations within the current mod
            if (mod == 0) {
                for (i in 0...8) {
                    var h:Float = 20;
                    if (beat % 2 == 0) { h = h * -1; }
                    if (i % 2 == 0) { h = h * -1; }
                    GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".pos"], {y :40 + h}, 0.2, "out_quad");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".pos"], {y :0}, 0.2, "in_quad", 0.2);

                    //prop_set(obj_game, "strums."..i..".lines.0.p.0.x", h); // Accessing point 0's x directly
                    h = 100; // Reuse h variable
                    if (beat % 2 == 0) { h = h * -1; }
                    // Assuming the path "lines.0.p.0" correctly targets the first point in the 'p' array of the first line.
                    GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.0.p.0"], {x :h}, 0.2, "out_quad");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.0.p.0"], {x :0}, 0.2, "in_quad", 0.2);
                }

                if (modBeat % 16 == 0) { // Check beat within this mod segment
                    var oSide = (curSide + 1) % 2;
                    var w:Float = 200;
                    if (curSide == 0) {
                        w = w * -1;
                    }
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field." + curSide], {x :w, z :0}, 1, "out_quad");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field." + oSide], {x :0, z :-100}, 1, "out_quad");
                    curSide = oSide;
                }
            } else if (mod == 1) {
                var a:Float = 30;
                if (beat % 2 == 1) { a = a * -1; }
                if (beat % 4 == 3) { // Check absolute beat
                    for (i in 0...2) { // Loop 0 to 1
                        GameAPI.tweenStart([GlobalObjects.obj_game, "field." + i], {z :100}, 0.3, "out_quad");
                        GameAPI.tweenStart([GlobalObjects.obj_game, "field." + i], {z :0}, 0.3, "in_quad", 0.3);
                    }
                }
                for (i in 0...8) { //angle & horizontal bounce
                    if (beat % 4 == 3) { // Check absolute beat
                        GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".ang3D.z", 360.0); // Use Float
                    }
                    GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".ang3D"], {z :a / 7}, 0.18, "inout_quad");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".ang3D"], {z :0}, 0.18, "inout_quad", 0.18);

                    if (i % 2 == 1) { a = a * -1; } // Flip 'a' for alternate strums

                    var sx:Float = (i % 4) - 2 * 50; // Calculation seems off, maybe ((i % 4) - 2) * 50? Translating literally.
                                               // Let's assume it means ((i % 4) - 1.5) * offset or similar. Sticking to literal:(i%4) - 100
                                               // Re-reading:it's likely `( (i % 4) - 2 ) * 50` or similar based on common patterns.
                                               // But sticking to exact translation:`(i % 4) - 100.0`
                    sx = (i % 4) - 100.0; // Corrected interpretation based on typical offsets

                    GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".pos"], {x :sx + a * 1.2}, 0.2, "out_quad");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".pos"], {x :sx}, 0.2, "in_quad", 0.2);

                    if (beat % 4 == i % 4) { // Check absolute beat vs strum index modulo 4
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".pos"], {z :-300}, 0.2, "out_quad");
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".pos"], {z :0}, 0.2, "in_quad", 0.2);
                    }
                }

                var up:Float = 400;
                var shift:Float = 50;
                if (modBeat == 0) { //show opponent, hide player (modBeat is beat since mod 1 started at beat 64)
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.1"], {x :300, y :shift}, 0.9, "out_quad");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.0"], {y :-300}, 0.5, "in_quad");
                } else if (modBeat == 4) { //shift half receptors upwards (start moving field)
                    for (i in 4...8) { // Loop 4, 5, 6, 7
                         if (i % 2 == 0) { // Only even indices (4, 6)
                            GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".pos"], {y :up}, 2, "inout_quad");
                            GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".dir"], {x :-180}, 2, "inout_quad");
                         }
                    }
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.1"], {x :500}, 8, "linear");
                } else if (modBeat == 12) { //the other half
                     for (i in 4...8) { // Loop 4, 5, 6, 7
                         if (i % 2 != 0) { // Only odd indices (5, 7)
                            GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".pos"], {y :up}, 2, "inout_quad");
                            GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".dir"], {x :-180}, 2, "inout_quad");
                         }
                    }
                } else if (modBeat == 18) {
                    for (i in 4...8) { // Loop 4 to 7
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.0.p.0"], {x :20}, 1, "inout_quad");
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.0"], {w :0.8, a :270 - 30}, 1, "inout_quad");
                    }
                } else if (modBeat == 26 || modBeat == 28) {
                    for (i in 4...8) { // Loop 4 to 7
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".ang3D"], {x :-45}, 0.2, "out_quad");
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".ang3D"], {x :0}, 0.2, "in_quad", 0.2);
                    }
                } else if (modBeat == 30) { //show player hide opponent
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.1"], {x :0, y :-300}, 0.9, "in_quad");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.0"], {x :-200, y :shift}, 0.5, "out_quad");
                    for (i in 4...8) { // Loop 4 to 7
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".pos"], {y :0}, 1, "inout_quad");
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".dir"], {x :0}, 1, "inout_quad");
                    }
                } else if (modBeat == 36) { //movii (starts)
                     for (i in 0...4) { // Loop 0, 1, 2, 3
                         if (i % 2 == 0) { // Only even indices (0, 2)
                            GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".pos"], {y :up}, 2, "inout_quad");
                            GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".dir"], {x :-180}, 2, "inout_quad");
                         }
                    }
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.0"], {x :-400}, 8, "linear");
                } else if (modBeat == 44) { //the other half
                     for (i in 0...4) { // Loop 0, 1, 2, 3
                         if (i % 2 != 0) { // Only odd indices (1, 3)
                            GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".pos"], {y :up}, 2, "inout_quad");
                            GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".dir"], {x :-180}, 2, "inout_quad");
                         }
                    }
                } else if (modBeat == 50) {
                    for (i in 0...4) { // Loop 0 to 3
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.0.p.0"], {x :-20}, 1, "inout_quad");
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.0"], {w :0.8, a :270 + 30}, 1, "inout_quad");
                    }
                } else if (modBeat == 58 || modBeat == 60) {
                    for (i in 0...4) { // Loop 0 to 3
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".ang3D"], {x :-45}, 0.2, "out_quad");
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".ang3D"], {x :0}, 0.2, "in_quad", 0.2);
                    }
                }
            } else if (mod == 2) {
                if (modBeat % 4 == 0) {
                    for (i in 0...8) {
                        // Assuming paths like "lines.0.p.0.z" work with prop_set
                        GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".lines.0.p.0.z", 0.0);
                        GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".lines.0.p.1.z", 0.0);
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.0.p.0"], {x :300}, 0.05, "out_quad");
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.0.p.1"], {x :-300}, 0.05, "out_quad");
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.0.p.0"], {x :0}, 0.3, "in_quad", 0.05);
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.0.p.1"], {x :0}, 0.3, "in_quad", 0.05);
                    }
                }
                if (modBeat % 4 == 3) {
                    for (i in 0...8) {
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.0.p.0"], {x :-300}, 0.3, "inout_quad");
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.0.p.1"], {x :300}, 0.3, "inout_quad");
                    }
                    //[[
                    //for i = 0, 7, 1 do
                    //    tweenStart({obj_game, "strums."..i..".lines.0.p.0"}, {z = 1000}, 0.3, "in_quad");
                    //    tweenStart({obj_game, "strums."..i..".lines.0.p.1"}, {z = -1000}, 0.3, "in_quad");
                    //end]]
                }

                var a:Float = 8;
                if (modBeat % 2 == 1) { a = a * -1; }
                for (i in 0...8) {
                    GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".ang3D"], {z :a}, 0.2, "out_quad");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".ang3D"], {z :0}, 0.2, "in_quad", 0.2);

                    // Lua ind = {3, 2, 0, 1}; indices 1, 2, 3, 4
                    // Haxe ind = [3, 2, 0, 1]; indices 0, 1, 2, 3
                    var ind:Array<Int> = [3, 2, 0, 1];
                    // Lua ind[i % 4 + 1] -> Haxe ind[i % 4]
                    // Check absolute beat % 4 vs index lookup
                    if (beat % 4 == ind[i % 4]) {
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".ang3D"], {y :a * 4}, 0.2, "out_quad");
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".ang3D"], {y :0}, 0.2, "in_quad", 0.2);
                    }
                }

                if (modBeat == 1) {
                    //tweenStart({obj_game, "field.1"}, {z = -200}, 7, "linear");
                } else if (modBeat == 14) {
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.0"], {x :-380, y :centerY}, 0.3, "inout_quad");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.0"], {z :-100}, 0.5, "inout_quad");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.1"], {x :0, z :-400}, 0.2, "inout_quad");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.1"], {y :-400, z :0}, 0.7, "in_elastic"); // Ensure "in_elastic" is a valid ease name
                } else if (modBeat == 16) {
                    //tweenStart({obj_game, "field.0"}, {z = -200}, 7, "linear");
                    for (i in 4...8) { // Loop 4 to 7
                        GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".pos.x", 0.0);
                        GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".pos.y", 0.0);
                        GameAPI.prop_set(GlobalObjects.obj_game, "strums." + i + ".dir.z", -180.0);
                    }
                } else if (modBeat == 32) {
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.1"], {y :0}, 0.4, "out_quad");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.0"], {x :0}, 0.6, "inout_quad");
                    for (i in 4...8) { // Loop 4 to 7
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".dir"], {z :0}, 0.4, "out_quad");
                    }
                } else if (modBeat == 46) {
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.1"], {y :-400, z :0}, 0.7, "in_elastic");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.0"], {x :-380}, 0.6, "inout_quad");
                } else if (modBeat == 48) {
                    var l = GlobalObjects.sys.skin.sep; // Local variable l

                    GameAPI.tweenStart([GlobalObjects.obj_game, "strums.0.pos"], {x :l * 1.5}, 6, "inout_quad");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "strums.3.pos"], {x :-l * 1.5}, 6, "inout_quad");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "strums.1.pos"], {x :l / 2, y :0}, 6, "inout_quad");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "strums.2.pos"], {x :-l / 2, y :0}, 6, "inout_quad");

                    for (i in 0...4) { // Loop 0 to 3
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.0"], {a :270 + 100}, 6, "inout_quad");
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".lines.1"], {a :270 + 100}, 6, "inout_quad");
                    }
                }
            } else if (mod == 3) {
                if (subMod < 3) {
                    for (i in 0...8) {
                        var h:Float = 20;
                        if (beat % 2 == 0) { h = h * -1; } // Check absolute beat
                        if (i % 2 == 0) { h = h * -1; }
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".pos"], {z :40 + h}, 0.2, "out_quad");
                        GameAPI.tweenStart([GlobalObjects.obj_game, "strums." + i + ".pos"], {z :0}, 0.2, "in_quad", 0.2);
                    }
                }

                if (modBeat == 12 || modBeat == 14) {
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.1"], {z :-100}, 0.2, "out_quad");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.1"], {z :0}, 0.2, "in_quad", 0.2);

                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.0"], {z :100}, 0.2, "out_quad");
                    GameAPI.tweenStart([GlobalObjects.obj_game, "field.0"], {z :0}, 0.2, "in_quad", 0.2);
                }
            }

            // Increment modBeat *after* using its value for the current beat's logic
            modBeat++;

        } // End of if(started)
    } // End of onBeatHit
} // End of class CaveBGMod
