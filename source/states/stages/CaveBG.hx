package states.stages;

// Required Dependencies/Imports (Assuming a HaxeFlixel or similar context)
// Note: These imports are assumptions based on common Haxe game frameworks.
// The actual imports might differ based on the specific framework used.
import haxe.ds.Vector; // Or Array<Float> depending on scroll_get_pos return type
import flixel.FlxG; // Assuming FlxG for global access if needed
import flixel.FlxSprite; // Assuming sprite_load returns FlxSprite or similar
import flixel.util.FlxColor; // Assuming c_black/c_white map to FlxColor

import Math;

// Assuming existence of external functions/objects like:
// sprite_load(path:String):Dynamic // Or specific sprite type
// offset_setby_fraction(sprite:Dynamic, x:Float, y:Float):Void
// prop_set(object:Dynamic, propertyPath:String, value:Dynamic):Void
// draw_set_color(color:Int):Void // Or specific color type
// draw_rectangle(x1:Float, y1:Float, x2:Float, y2:Float, outline:Bool):Void
// draw_sprite_scrolled(sprite:Dynamic, x:Float, y:Float, z:Float, scrollX:Float, scrollY:Float):Void
// scroll_get_pos(x:Float, y:Float, factor:Float):Array<Float> // Or Vector<Float>
// draw_floor(sprite:Dynamic, x:Float, y:Float, z:Float, scrollX:Float, scrollY:Float, isCeiling:Bool = false):Void
// obj_fnf:Dynamic // Global or static object
// c_black:Int // Color constant
// c_white:Int // Color constant

class CaveBG extends BaseStage {
    // Static variables to hold sprite references, mimicking Lua's global scope
    static var bg:Dynamic;
    static var super_bg:Dynamic;
    static var es1:Dynamic;
    static var cal1:Dynamic;
    static var cal2:Dynamic;
    static var ground:Dynamic;
    static var ceil:Dynamic;

    // --- Assumed external functions (replace with actual framework calls) ---
    // These are placeholders demonstrating the expected function calls.
    // The actual implementation depends on the target Haxe framework.

    static function sprite_load(path:String):Dynamic {
        // Example: return new FlxSprite().loadGraphic(AssetPaths.image(path));
        trace("Warning: sprite_load not implemented. Called with path: " + path);
        return null; // Placeholder
    }

    static function offset_setby_fraction(sprite:Dynamic, x:Float, y:Float):Void {
        // Example: if (sprite != null) { sprite.offset.set(sprite.width * (x - 0.5), sprite.height * (y - 0.5)); } // Approximation
        trace("Warning: offset_setby_fraction not implemented.");
        // Placeholder implementation detail: Assumes sprite has width/height and offset properties
        if (sprite != null && Reflect.hasField(sprite, "width") && Reflect.hasField(sprite, "height") && Reflect.hasField(sprite, "offset") && Reflect.hasField(sprite.offset, "set")) {
             // This is a guess based on common frameworks like HaxeFlixel
             // sprite.offset.set(sprite.width * x - sprite.frameWidth * 0.5, sprite.height * y - sprite.frameHeight * 0.5); // More accurate offset calc?
             // The original Lua function name suggests setting the origin/pivot point as a fraction of size.
             // Let's assume it sets the origin:
             if (Reflect.hasField(sprite, "origin") && Reflect.hasField(sprite.origin, "set")) {
                // sprite.origin.set(sprite.width * x, sprite.height * y); // This might be closer
             }
        }
    }

    static function prop_set(object:Dynamic, propertyPath:String, value:Dynamic):Void {
        trace("Warning: prop_set not implemented. Called with path: " + propertyPath + ", value: " + value);
        // Example using Reflection (careful with nested paths):
        var parts = propertyPath.split(".");
        var current:Dynamic = object;
        for (i in 0...parts.length - 1) {
            var part = parts[i];
            if (current == null || !Reflect.hasField(current, part)) {
                 trace('Error: prop_set failed, invalid path part: ${part} in ${propertyPath}');
                 return;
            }
             // Handle potential array access like "cam.0"
             var numIndex = Std.parseInt(part);
             if (numIndex != null && Std.string(numIndex) == part) {
                 current = current[numIndex];
             } else {
                current = Reflect.field(current, part);
             }
        }
        var finalPart = parts[parts.length - 1];
        var numIndex = Std.parseInt(finalPart);
         if (current != null) {
             if (numIndex != null && Std.string(numIndex) == finalPart) {
                 current[numIndex] = value;
             } else {
                Reflect.setProperty(current, finalPart, value);
             }
         } else {
             trace('Error: prop_set failed, final object in path is null for ${propertyPath}');
         }
    }

    static function draw_set_color(color:Int):Void {
        // Example: FlxG.camera.bgColor = color; or specific drawing context color
        trace("Warning: draw_set_color not implemented. Called with color: " + color);
        // Placeholder
    }

    static function draw_rectangle(x1:Float, y1:Float, x2:Float, y2:Float, outline:Bool):Void {
        // Example: FlxG.camera.buffer.drawRect(x1, y1, x2 - x1, y2 - y1, FlxColor.TRANSPARENT, { thickness: 1, color: currentColor }); // Complex example
        trace("Warning: draw_rectangle not implemented.");
        // Placeholder
    }

    static function draw_sprite_scrolled(sprite:Dynamic, x:Float, y:Float, z:Float, scrollX:Float, scrollY:Float):Void {
        // Example: Needs custom implementation or framework equivalent (e.g., FlxSprite with scrollFactor)
        trace("Warning: draw_sprite_scrolled not implemented.");
        // Placeholder - This likely requires setting sprite position based on camera scroll
        // if (sprite != null) {
        //    sprite.x = x - FlxG.camera.scroll.x * scrollX;
        //    sprite.y = y - FlxG.camera.scroll.y * scrollY;
        //    // Z-ordering would depend on the drawing system (e.g., adding to a FlxGroup)
        //    // sprite.draw(); // Or add to a render group
        // }
    }

    static function scroll_get_pos(x:Float, y:Float, factor:Float):Array<Float> {
        // Example: return [x - FlxG.camera.scroll.x * factor, y - FlxG.camera.scroll.y * factor];
        trace("Warning: scroll_get_pos not implemented.");
        // Placeholder
        // Assuming FlxG.camera exists and has a scroll property
        // if (Reflect.hasField(FlxG, "camera") && Reflect.hasField(FlxG.camera, "scroll")) {
        //    return [x - FlxG.camera.scroll.x * factor, y - FlxG.camera.scroll.y * factor];
        // }
        return [x, y]; // Default fallback
    }

    static function draw_floor(sprite:Dynamic, x:Float, y:Float, z:Float, scrollX:Float, scrollY:Float, isCeiling:Bool = false):Void {
        // Example: Needs custom implementation (likely tiling a sprite based on scroll)
        trace("Warning: draw_floor not implemented.");
        // Placeholder
    }

    // --- Assumed global constants/objects ---
    // Replace with actual framework constants/objects
    static var c_black:Int = 0xFF000000; // Example using FlxColor format (ARGB)
    static var c_white:Int = 0xFFFFFFFF; // Example using FlxColor format (ARGB)
    public static var obj_fnf:Dynamic = { // Placeholder structure based on usage
        bf: { x: 0.0, prop: { cam: [0.0, 0.0] } }, // Assuming cam is an array/vector
        dad: { x: 0.0 },
        gf: { x: 0.0 },
        camZoom: 1.0,
        camToZoom: 1.0
    };


    // --- Translated Lua Functions ---

    override function create():Void {
        bg = sprite_load("cavebg/bg");
        offset_setby_fraction(bg, 0.5, 0.5);
        super_bg = sprite_load("cavebg/super_bg");
        offset_setby_fraction(super_bg, 0.5, 0.5);
        es1 = sprite_load("cavebg/es1");
        offset_setby_fraction(es1, 0.5, 0.5);
        cal1 = sprite_load("cavebg/cal1");
        offset_setby_fraction(cal1, 0.5, 0.5);
        cal2 = sprite_load("cavebg/cal2");
        offset_setby_fraction(cal2, 0.5, 0.5);

        ground = sprite_load("cavebg/ground");
        offset_setby_fraction(ground, 0.5, 0.35);
        ceil = sprite_load("cavebg/ceil");
        offset_setby_fraction(ceil, 0.5, 1 - 0.1); // Haxe calculation is the same

        obj_fnf.bf.x = 750;
        obj_fnf.dad.x = -750;
        // Assuming prop_set exists and handles the path string "prop.cam.0" / "prop.cam.1"
        // Reading Lua's 1-based index obj_fnf.bf.prop.cam[1] -> Haxe's 0-based index obj_fnf.bf.prop.cam[0]
        // Reading Lua's 1-based index obj_fnf.bf.prop.cam[2] -> Haxe's 0-based index obj_fnf.bf.prop.cam[1]
        prop_set(obj_fnf.bf, "prop.cam.0", obj_fnf.bf.prop.cam[0] - 300);
        prop_set(obj_fnf.bf, "prop.cam.1", obj_fnf.bf.prop.cam[1] - 50);
        obj_fnf.gf.x = 80;
        obj_fnf.camZoom = 0.55;
        obj_fnf.camToZoom = obj_fnf.camZoom;
    }

    public static function drawBG():Void {
        draw_set_color(c_black);
        draw_rectangle(-4000, -4000, 4000, 4000, false);
        draw_set_color(c_white);

        draw_sprite_scrolled(super_bg, 0, 0, -400, 0.1, 0.1);
        draw_sprite_scrolled(bg, 0, 0, 300, 0.3, 0.3);
        var gp:Array<Float> = scroll_get_pos(0, -200, 0.1); // Declare gp as local variable, assuming Array<Float> return type
        // Accessing Lua's gp[1] -> Haxe's gp[0]
        // Accessing Lua's gp[2] -> Haxe's gp[1]
        draw_floor(ceil, 0, 0, -1200, gp[0], gp[1], true);

        draw_sprite_scrolled(cal2, 0, -70, -350, 0.5, 0.5);
        draw_sprite_scrolled(es1, 0, 0, 0, 0.6, 0.6);
        draw_sprite_scrolled(cal1, 0, -70, -600, 0.7, 0.7);
        // Re-declare gp locally (shadowing is allowed, matches Lua behavior)
        gp = scroll_get_pos(0, -100, 0.8);
        // Accessing Lua's gp[1] -> Haxe's gp[0]
        // Accessing Lua's gp[2] -> Haxe's gp[1]
        draw_floor(ground, 0, 0, 0, gp[0], gp[1]); // Default isCeiling is false
    }
}

// Placeholder for external dependencies - Replace with actual implementations
typedef Vector3 = { x: Float, y: Float, z: Float };
typedef PointData = { x: Float, y: Float, z: Float }; // Assuming structure for points in prop_set

class Sys {
    public static var skin = { sep: 100.0 }; // Example value, replace with actual
    public static var opt = { downscroll: false }; // Example value, replace with actual
}

class TweenEase {
    public static inline var INOUT_QUAD = "inout_quad";
    public static inline var OUT_QUAD = "out_quad";
    public static inline var IN_QUAD = "in_quad";
    public static inline var LINEAR = "linear";
    public static inline var IN_ELASTIC = "in_elastic";
    public static inline var OUT_ELASTIC = "out_elastic";
}

// Placeholder for tweening function - Replace with actual implementation
function tweenStart(target:Dynamic, properties:Dynamic, duration:Float, ease:String, ?delay:Float = 0.0):Void {
    // Example: trace('tweenStart: Target: ${target}, Props: ${properties}, Duration: ${duration}, Ease: ${ease}, Delay: ${delay}');
    // Replace with actual tweening library call, e.g., FlxTween.tween(...) or Actuate.tween(...)
    ExternalAPI.tweenStart(target, properties, duration, ease, delay);
}

// Placeholder for property setting function - Replace with actual implementation
function prop_set(target:Dynamic, propertyPath:String, value:Dynamic):Void {
    // Example: trace('prop_set: Target: ${target}, Path: ${propertyPath}, Value: ${value}');
    // Replace with actual property setting logic, potentially using reflection or specific object accessors
    ExternalAPI.prop_set(target, propertyPath, value);
}

// Placeholder for random integer function
function randomInt(min:Int, max:Int):Int {
     return min + Math.floor(Math.random() * (max - min + 1));
}

// Placeholder for math utilities
class MathUtil {
    public static inline function degToRad(deg:Float):Float {
        return deg * Math.PI / 180;
    }
    public static inline function radToDeg(rad:Float):Float {
        return rad * 180 / Math.PI;
    }
}

// Placeholder for the main game object - Replace with actual type if known
var obj_game:Dynamic = {
    // Mock structure based on usage
    field: [{x:0.0, y:0.0, z:0.0}, {x:0.0, y:0.0, z:0.0}],
    strums: [
        // Example for one strum, repeat 8 times
        {
            lines: [
                { p: [], a: 0.0, ax: 0.0, ay: 0.0, w: 0.0 },
                { a: 0.0, ax: 0.0, ay: 0.0, w: 0.0 }
            ],
            pos: {x:0.0, y:0.0, z:0.0},
            ang3D: {x:0.0, y:0.0, z:0.0},
            dir: {x:0.0, y:0.0, z:0.0}
        },
        // ... (repeat 7 more times)
    ]
}; // Replace with actual game object reference

// Placeholder for external API calls if needed
class ExternalAPI {
    public static function tweenStart(target:Dynamic, properties:Dynamic, duration:Float, ease:String, ?delay:Float = 0.0):Void { /* Actual implementation needed */ }
    public static function prop_set(target:Dynamic, propertyPath:String, value:Dynamic):Void { /* Actual implementation needed */ }
}


class ModScript {

    public static var mod:Int = 0;
    public static var subMod:Int = 0;
    public static var modBeat:Int = 0;
    public static var modStep:Int = 0; // Note: modStep is declared but never used in the Lua code
    public static var started:Bool = false;

    // Translated from Lua global scope
    public static var l:Float;
    public static var cnt:Array<Float>;
    public static var centerY:Float = 270;

    public static var rot:Float = 0;
    public static var rotspd:Float = 1;
    public static var circAng:Float = MathUtil.degToRad(180);

    // Added static init block to initialize variables dependent on others
    static function __init__() {
        l = Sys.skin.sep;
        cnt = [l*1.5, l / 2, -l / 2, -l*1.5];

        // Initialize obj_game structure if it's managed here (adjust if obj_game is external)
        obj_game = {
            field: [{x:0.0, y:0.0, z:0.0}, {x:0.0, y:0.0, z:0.0}],
            strums: []
        };
        for (i in 0...8) {
            obj_game.strums.push({
                lines: [
                    { p: [], a: 0.0, ax: 0.0, ay: 0.0, w: 0.0 },
                    { a: 0.0, ax: 0.0, ay: 0.0, w: 0.0 }
                ],
                pos: {x:0.0, y:0.0, z:0.0},
                ang3D: {x:0.0, y:0.0, z:0.0},
                dir: {x:0.0, y:0.0, z:0.0}
            });
        }
    }


    public static function create():Void
    {
        modInit(0);
    }


    public static function modInit(Mod:Int):Void
    {
        mod = Mod;
        subMod = 0;
        modBeat = 0;
        modStep = 0; // Resetting modStep although unused
        tweenStart({obj_game: obj_game, prop: "field.0"}, {x : 0, y : 0, z : 0}, 0.1, TweenEase.INOUT_QUAD);
        tweenStart({obj_game: obj_game, prop: "field.1"}, {x : 0, y : 0, z : 0}, 0.1, TweenEase.INOUT_QUAD);
        for (i in 0...8) {
            prop_set(obj_game, "strums." + i + ".lines.0.p", []);
            tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0"}, {a : 270, ax : 0, ay : 0, w : 1}, 0.1, TweenEase.INOUT_QUAD);
            tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.1"}, {a : 270, ax : 0, ay : 0, w : 1}, 0.1, TweenEase.INOUT_QUAD);
            tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {x : 0, y : 0, z : 0}, 0.1, TweenEase.INOUT_QUAD);
            tweenStart({obj_game: obj_game, prop: "strums." + i + ".ang3D"}, {x : 0, y : 0, z : 0}, 0.1, TweenEase.INOUT_QUAD);
            tweenStart({obj_game: obj_game, prop: "strums." + i + ".dir"}, {x : 0, y : 0, z : 0}, 0.1, TweenEase.INOUT_QUAD);
        }
        if (mod == 0) {
            // curSide is used later in onBeatHit, initialize it here or ensure it's initialized elsewhere
            // Assuming curSide should be initialized here for mod 0 based on onBeatHit logic
            curSide = 1;
            for (i in 0...8) {
                prop_set(obj_game, "strums." + i + ".lines.0.p", [{x : 0.0, y : 360.0, z : 0.0}]);
            }
        }
        else if (mod == 1) {
            for (i in 0...8) {
                prop_set(obj_game, "strums." + i + ".lines.0.p", [{x : 0.0, y : 360.0, z : 0.0}]);
            }
        }
        else if (mod == 2) {

            for (i in 0...8) {
                prop_set(obj_game, "strums." + i + ".lines.0.p", [{x : 0.0, y : 720.0 / 4.0, z : 0.0}, {x : 0.0, y : 720.0 / 4.0 * 3.0, z : 0.0}]);
            }

            var l:Float = Sys.skin.sep;
            var woo:Float = l * 0.8;
            for (i in 0...2) {
                //idk
                var num0:Int = i*4;
                var num1:Int = i*4 + 1;
                var num2:Int = i*4 + 2;
                var num3:Int = i*4 + 3;

                var vdir:Float = 1;

                if (Sys.opt.downscroll) {
                    vdir = -1;
                }
                tweenStart({obj_game: obj_game, prop: "strums." + num0 + ".pos"}, {x : l * 1.5 - woo}, 0.2, TweenEase.INOUT_QUAD);
                tweenStart({obj_game: obj_game, prop: "strums." + num3 + ".pos"}, {x : -l * 1.5 + woo}, 0.2, TweenEase.INOUT_QUAD);
                tweenStart({obj_game: obj_game, prop: "strums." + num1 + ".pos"}, {x : l / 2, y : woo * vdir}, 0.2, TweenEase.INOUT_QUAD);
                tweenStart({obj_game: obj_game, prop: "strums." + num2 + ".pos"}, {x : -l / 2, y : -woo * vdir}, 0.2, TweenEase.INOUT_QUAD);
            }
            tweenStart({obj_game: obj_game, prop: "field.1"}, {x : 380, y : centerY}, 0.3, TweenEase.INOUT_QUAD);
            tweenStart({obj_game: obj_game, prop: "field.1"}, {z : -100}, 0.5, TweenEase.INOUT_QUAD);
            tweenStart({obj_game: obj_game, prop: "field.0"}, {y : 380}, 1, TweenEase.INOUT_QUAD);

            var an:Array<Float> = [-90.0, 0.0, 180.0, 90.0];
            if (Sys.opt.downscroll) {
                an[1] = 180; // Index 1 corresponds to Lua index 2
                an[2] = 0;   // Index 2 corresponds to Lua index 3
            }
            for (i in 0...8) {
                // Lua: an[i % 4 + 1] -> Haxe: an[i % 4]
                tweenStart({obj_game: obj_game, prop: "strums." + i + ".dir"}, {z : an[i % 4]}, 0.2, TweenEase.INOUT_QUAD);
            }
        }
        else if (mod == 3) {
            tweenStart({obj_game: obj_game, prop: "field.1"}, {x : 380, y : centerY}, 0.8, TweenEase.OUT_QUAD);
            tweenStart({obj_game: obj_game, prop: "field.0"}, {x : -380, y : centerY}, 0.8, TweenEase.OUT_QUAD);
            for (i in 0...8) {
                tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0"}, {ay : -60, w : 0.9}, 0.11, TweenEase.INOUT_QUAD);
                prop_set(obj_game, "strums." + i + ".lines.0.p", [{x : 0.0, y : 200.0, z : 100.0}]);
                tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.1"}, {ay : -90}, 0.11, TweenEase.INOUT_QUAD);
                // Lua: cnt[i%4 + 1] -> Haxe: cnt[i%4]
                tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {x : cnt[i%4]}, 0.11, TweenEase.INOUT_QUAD);
            }
        }
        else if (mod == 4) {
            for (i in 0...8) {
                var w:Float = 80;
                if (i % 4 < 2) { w = w*-1; }
                tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0"}, {ay : -30}, 0.11, TweenEase.INOUT_QUAD);
                prop_set(obj_game, "strums." + i + ".lines.0.p", [{x : 0.0, y : 360.0, z : 40.0}]);
                // Lua: cnt[i%4 + 1] -> Haxe: cnt[i%4]
                tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {x : cnt[i%4] + w}, 0.11, TweenEase.INOUT_QUAD);
            }
        }
        else if (mod == 5) {
            for (i in 0...8) {
                tweenStart({obj_game: obj_game, prop: "strums." + i + ".dir"}, {x : 50}, 1, TweenEase.INOUT_QUAD);
                tweenStart({obj_game: obj_game, prop: "strums." + i + ".ang3D"}, {x : -50}, 1, TweenEase.INOUT_QUAD);
            }
        }
    }

    public static function update(elapsed:Float):Void
    {
        if (started) {
            if (mod == 0) {
                rot = rot + elapsed * 5;
                for (i in 0...8) {
                    prop_set(obj_game, "strums." + i + ".pos.z", Math.cos(rot + i) * 40);
                }

                if (subMod == 1) {
                    for (i in 0...8) {
                        prop_set(obj_game, "strums." + i + ".dir.z", Math.cos(rot + i) * 10);
                        prop_set(obj_game, "strums." + i + ".ang3D.z", Math.cos(rot + i) * 4);
                    }
                }
            }
            else if (mod == 3) {
                if (subMod == 2) {
                    rotspd = rotspd + elapsed;
                }
                else if (subMod == 3) {
                    rotspd = rotspd - elapsed * 1.21;
                    if (rotspd < 0) {
                        rotspd = 0;
                    }
                    else {
                        tweenStart({obj_game: obj_game, prop: "field.1"}, {x : 380 + randomInt(-4, 4), y : centerY + randomInt(-4, 4)}, 0.01, TweenEase.OUT_QUAD);
                        tweenStart({obj_game: obj_game, prop: "field.0"}, {x : -380 + randomInt(-4, 4), y : centerY + randomInt(-4, 4)}, 0.01, TweenEase.OUT_QUAD);
                    }
                }
                circAng = circAng + elapsed * rotspd;
                for (i in 0...8) {
                    var off:Float = -((i%4) - 2) / 2.5;
                    var len:Float = 300;
                    var xlen:Float = len;
                    if (subMod >= 1) { xlen = 500; }
                    var an:Float = circAng + off;
                    if (i < 4) { an = an + MathUtil.degToRad(180); }
                    // Lua: cnt[i%4 + 1] -> Haxe: cnt[i%4]
                    prop_set(obj_game, "strums." + i + ".pos.x", cnt[i%4] + Math.cos(an) * xlen);
                    prop_set(obj_game, "strums." + i + ".pos.y", -Math.sin(an) * len);

                    prop_set(obj_game, "strums." + i + ".dir.z", 270 + MathUtil.radToDeg(an - off));
                }
            }
            else if (mod == 5) {
                //[[
                //for i = 0, 7, 1 do
                //    prop_set(obj_game, "strums."..i..".pos.z", math.cos(rot + i) * 100);
                //end]]
                // Lua comment block translated
                /*
                for (i in 0...8) {
                    prop_set(obj_game, "strums." + i + ".pos.z", Math.cos(rot + i) * 100);
                }
                */
            }
        }
    }

    // Need to declare curSide, likely intended as a static variable based on usage
    static var curSide:Int = 1; // Initialized based on modInit(0) logic

    public static function onBeatHit(beat:Int):Void
    {
        //prop_set(obj_game, "strums.1.pos.x", -40);
        //obj_fnf.gf.prop.beatDance = 4; // Assuming obj_fnf is another external object
        //console_add(s.xscale); // Assuming console_add and s are external

        if (beat == 0) {
            started = true;
        }

        if (started) {
            // Update modBeat before using it in conditions
            modBeat = beat; // Assuming modBeat should track the current beat within the mod

            if (beat == 32) {
                subMod = 1;
            }
            else if (beat == 64) {
                modInit(1);
                modBeat = 0; // Reset modBeat when mod changes
            }
            else if (beat == 128) {
                modInit(2);
                modBeat = 0; // Reset modBeat when mod changes
            }
            else if (beat == 192) {
                modInit(3);
                modBeat = 0; // Reset modBeat when mod changes
            }
            else if (beat == 256) {
                modInit(4);
                modBeat = 0; // Reset modBeat when mod changes
            }
            else if (beat == 296) { // Note: Lua code has 296, but later uses 288 to set mod = -1. Check logic.
                modInit(0);
                modBeat = 0; // Reset modBeat when mod changes
            }
            else if (beat == 288) { // This comes *before* 296 in the sequence, might be intended order?
                mod = -1; // Setting mod to -1, but no logic handles mod == -1 later
                for (i in 0...8) {
                    tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {x : 0, y : 0, z : 0}, 3, TweenEase.INOUT_QUAD);
                }
                // Note: modBeat is not reset here, might be intentional or an oversight
            }
            else if (beat == 328) {
                modInit(5);
                modBeat = 0; // Reset modBeat when mod changes
            }
            else if (beat == 392) {
                modInit(3); // Re-init mod 3
                subMod = 1; // Set subMod immediately
                modBeat = 0; // Reset modBeat when mod changes
            }
            else if (beat == 456) {
                subMod = 2;
            }
            else if (beat == 464) {
                subMod = 3;
            }

            // Mod-specific beat logic (using the current mod value)
            if (mod == 0) {
                for (i in 0...8) {
                    var h:Float = 20;
                    if (beat % 2 == 0) { h = h * -1; }
                    if (i % 2 == 0) { h = h * -1; }
                    tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {y : 40 + h}, 0.2, TweenEase.OUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {y : 0}, 0.2, TweenEase.IN_QUAD, 0.2);

                    //prop_set(obj_game, "strums."..i..".lines.0.p.0.x", h); // Lua comment or old code?
                    h = 100;
                    if (beat % 2 == 0) { h = h * -1; }
                    // Assuming p is an array, accessing index 0
                    tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0.p.0"}, {x : h}, 0.2, TweenEase.OUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0.p.0"}, {x : 0}, 0.2, TweenEase.IN_QUAD, 0.2);
                }

                if (modBeat % 16 == 0) { // Using modBeat here, ensure it's updated correctly
                    var oSide:Int = (curSide + 1) % 2;
                    var w:Float = 200;
                    if (curSide == 0) {
                        w = w * -1;
                    }
                    tweenStart({obj_game: obj_game, prop: "field." + curSide}, {x : w, z : 0}, 1, TweenEase.OUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "field." + oSide}, {x : 0, z : -100}, 1, TweenEase.OUT_QUAD);
                    curSide = oSide;
                }
            }
            else if (mod == 1) {
                var a:Float = 30;
                if (beat % 2 == 1) { a = a * -1; }
                if (beat % 4 == 3) {
                    for (i in 0...2) {
                        tweenStart({obj_game: obj_game, prop: "field." + i}, {z : 100}, 0.3, TweenEase.OUT_QUAD);
                        tweenStart({obj_game: obj_game, prop: "field." + i}, {z : 0}, 0.3, TweenEase.IN_QUAD, 0.3);
                    }
                }
                for (i in 0...8) { //angle & horizontal bounce
                    if (beat % 4 == 3) {
                        prop_set(obj_game, "strums." + i + ".ang3D.z", 360.0); // Use Float
                    }
                    tweenStart({obj_game: obj_game, prop: "strums." + i + ".ang3D"}, {z : a / 7}, 0.18, TweenEase.INOUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "strums." + i + ".ang3D"}, {z : 0}, 0.18, TweenEase.INOUT_QUAD, 0.18);

                    if (i % 2 == 1) { a = a * -1; }

                    var sx:Float = (i % 4) - 2 * 50; // Calculation seems off, check original intent. (i%4) is 0..3, result is -100..-97? Maybe (i % 4 - 2) * 50? Assuming original Lua is correct.
                    tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {x : sx + a * 1.2}, 0.2, TweenEase.OUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {x : sx}, 0.2, TweenEase.IN_QUAD, 0.2);

                    if (beat % 4 == i % 4) {
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {z : -300}, 0.2, TweenEase.OUT_QUAD);
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {z : 0}, 0.2, TweenEase.IN_QUAD, 0.2);
                    }
                }

                var up:Float = 400;
                var shift:Float = 50;
                if (modBeat == 0) { //show opponent, hide player
                    tweenStart({obj_game: obj_game, prop: "field.1"}, {x : 300, y : shift}, 0.9, TweenEase.OUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "field.0"}, {y : -300}, 0.5, TweenEase.IN_QUAD);
                }
                else if (modBeat == 4) { //shift half receptors upwards (start moving field)
                    for (i in 4...8) { // Haxe range 4...8 means 4, 5, 6, 7
                       if (i % 2 == 0) { // Equivalent to Lua step 2 (4, 6)
                            tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {y : up}, 2, TweenEase.INOUT_QUAD);
                            tweenStart({obj_game: obj_game, prop: "strums." + i + ".dir"}, {x : -180}, 2, TweenEase.INOUT_QUAD);
                       }
                    }
                    tweenStart({obj_game: obj_game, prop: "field.1"}, {x : 500}, 8, TweenEase.LINEAR);
                }
                else if (modBeat == 12) { //the other half
                     for (i in 5...8) { // Haxe range 5...8 means 5, 6, 7
                       if (i % 2 != 0) { // Equivalent to Lua step 2 (5, 7)
                            tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {y : up}, 2, TweenEase.INOUT_QUAD);
                            tweenStart({obj_game: obj_game, prop: "strums." + i + ".dir"}, {x : -180}, 2, TweenEase.INOUT_QUAD);
                       }
                    }
                }
                else if (modBeat == 18) {
                    for (i in 4...8) {
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0.p.0"}, {x : 20}, 1, TweenEase.INOUT_QUAD);
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0"}, {w : 0.8, a : 270.0 - 30.0}, 1, TweenEase.INOUT_QUAD);
                    }
                }
                else if (modBeat == 26 || modBeat == 28) {
                    for (i in 4...8) {
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".ang3D"}, {x : -45}, 0.2, TweenEase.OUT_QUAD);
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".ang3D"}, {x : 0}, 0.2, TweenEase.IN_QUAD, 0.2);
                    }
                }
                else if (modBeat == 30) { //show player hide opponent
                    tweenStart({obj_game: obj_game, prop: "field.1"}, {x : 0, y : -300}, 0.9, TweenEase.IN_QUAD);
                    tweenStart({obj_game: obj_game, prop: "field.0"}, {x : -200, y : shift}, 0.5, TweenEase.OUT_QUAD);
                    for (i in 4...8) {
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {y : 0}, 1, TweenEase.INOUT_QUAD);
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".dir"}, {x : 0}, 1, TweenEase.INOUT_QUAD);
                    }
                }
                else if (modBeat == 36) { //movii (starts)
                    for (i in 0...4) { // Haxe range 0...4 means 0, 1, 2, 3
                       if (i % 2 == 0) { // Equivalent to Lua step 2 (0, 2)
                            tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {y : up}, 2, TweenEase.INOUT_QUAD);
                            tweenStart({obj_game: obj_game, prop: "strums." + i + ".dir"}, {x : -180}, 2, TweenEase.INOUT_QUAD);
                       }
                    }
                    tweenStart({obj_game: obj_game, prop: "field.0"}, {x : -400}, 8, TweenEase.LINEAR);
                }
                else if (modBeat == 44) { //the other half
                    for (i in 1...4) { // Haxe range 1...4 means 1, 2, 3
                       if (i % 2 != 0) { // Equivalent to Lua step 2 (1, 3)
                            tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {y : up}, 2, TweenEase.INOUT_QUAD);
                            tweenStart({obj_game: obj_game, prop: "strums." + i + ".dir"}, {x : -180}, 2, TweenEase.INOUT_QUAD);
                       }
                    }
                }
                else if (modBeat == 50) {
                    for (i in 0...4) {
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0.p.0"}, {x : -20}, 1, TweenEase.INOUT_QUAD);
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0"}, {w : 0.8, a : 270.0 + 30.0}, 1, TweenEase.INOUT_QUAD);
                    }
                }
                else if (modBeat == 58 || modBeat == 60) {
                    for (i in 0...4) {
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".ang3D"}, {x : -45}, 0.2, TweenEase.OUT_QUAD);
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".ang3D"}, {x : 0}, 0.2, TweenEase.IN_QUAD, 0.2);
                    }
                }
            }
            else if (mod == 2) {
                if (modBeat % 4 == 0) {
                    for (i in 0...8) {
                        // Assuming p is an array with at least 2 elements
                        prop_set(obj_game, "strums." + i + ".lines.0.p.0.z", 0.0);
                        prop_set(obj_game, "strums." + i + ".lines.0.p.1.z", 0.0);
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0.p.0"}, {x : 300}, 0.05, TweenEase.OUT_QUAD);
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0.p.1"}, {x : -300}, 0.05, TweenEase.OUT_QUAD);
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0.p.0"}, {x : 0}, 0.3, TweenEase.IN_QUAD, 0.05);
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0.p.1"}, {x : 0}, 0.3, TweenEase.IN_QUAD, 0.05);
                    }
                }
                if (modBeat % 4 == 3) {
                    for (i in 0...8) {
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0.p.0"}, {x : -300}, 0.3, TweenEase.INOUT_QUAD);
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0.p.1"}, {x : 300}, 0.3, TweenEase.INOUT_QUAD);
                    }
                    //[[
                    //for i = 0, 7, 1 do
                    //    tweenStart({obj_game, "strums."..i..".lines.0.p.0"}, {z = 1000}, 0.3, "in_quad");
                    //    tweenStart({obj_game, "strums."..i..".lines.0.p.1"}, {z = -1000}, 0.3, "in_quad");
                    //end]]
                    /*
                    for (i in 0...8) {
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0.p.0"}, {z : 1000}, 0.3, TweenEase.IN_QUAD);
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0.p.1"}, {z : -1000}, 0.3, TweenEase.IN_QUAD);
                    }
                    */
                }

                var a:Float = 8;
                if (modBeat % 2 == 1) { a = a*-1; }
                for (i in 0...8) {
                    tweenStart({obj_game: obj_game, prop: "strums." + i + ".ang3D"}, {z : a}, 0.2, TweenEase.OUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "strums." + i + ".ang3D"}, {z : 0}, 0.2, TweenEase.IN_QUAD, 0.2);
                    var ind:Array<Int> = [3, 2, 0, 1]; // Lua: {3, 2, 0, 1}
                    // Lua: ind[i % 4 + 1] -> Haxe: ind[i % 4]
                    if (beat % 4 == ind[i % 4]) {
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".ang3D"}, {y : a * 4}, 0.2, TweenEase.OUT_QUAD);
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".ang3D"}, {y : 0}, 0.2, TweenEase.IN_QUAD, 0.2);
                    }
                }

                if (modBeat == 1) {
                    //tweenStart({obj_game, "field.1"}, {z = -200}, 7, "linear");
                }
                else if (modBeat == 14) {
                    tweenStart({obj_game: obj_game, prop: "field.0"}, {x : -380, y : centerY}, 0.3, TweenEase.INOUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "field.0"}, {z : -100}, 0.5, TweenEase.INOUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "field.1"}, {x : 0, z : -400}, 0.2, TweenEase.INOUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "field.1"}, {y : -400, z : 0}, 0.7, TweenEase.IN_ELASTIC);
                }
                else if (modBeat == 16) {
                    //tweenStart({obj_game, "field.0"}, {z = -200}, 7, "linear");
                    for (i in 4...8) {
                        prop_set(obj_game, "strums." + i + ".pos.x", 0.0);
                        prop_set(obj_game, "strums." + i + ".pos.y", 0.0);
                        prop_set(obj_game, "strums." + i + ".dir.z", -180.0);
                    }
                }
                else if (modBeat == 32) {
                    tweenStart({obj_game: obj_game, prop: "field.1"}, {y : 0}, 0.4, TweenEase.OUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "field.0"}, {x : 0}, 0.6, TweenEase.INOUT_QUAD);
                    for (i in 4...8) {
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".dir"}, {z : 0}, 0.4, TweenEase.OUT_QUAD);
                    }
                }
                else if (modBeat == 46) {
                    tweenStart({obj_game: obj_game, prop: "field.1"}, {y : -400, z : 0}, 0.7, TweenEase.IN_ELASTIC);
                    tweenStart({obj_game: obj_game, prop: "field.0"}, {x : -380}, 0.6, TweenEase.INOUT_QUAD);
                }
                else if (modBeat == 48) {
                    var l:Float = Sys.skin.sep;

                    tweenStart({obj_game: obj_game, prop: "strums.0.pos"}, {x : l * 1.5}, 6, TweenEase.INOUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "strums.3.pos"}, {x : -l * 1.5}, 6, TweenEase.INOUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "strums.1.pos"}, {x : l / 2, y : 0}, 6, TweenEase.INOUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "strums.2.pos"}, {x : -l / 2, y : 0}, 6, TweenEase.INOUT_QUAD);

                    for (i in 0...4) {
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.0"}, {a : 270.0 + 100.0}, 6, TweenEase.INOUT_QUAD);
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".lines.1"}, {a : 270.0 + 100.0}, 6, TweenEase.INOUT_QUAD);
                    }
                }
            }
            else if (mod == 3) {
                if (subMod < 3) {
                    for (i in 0...8) {
                        var h:Float = 20;
                        if (beat % 2 == 0) { h = h * -1; }
                        if (i % 2 == 0) { h = h * -1; }
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {z : 40 + h}, 0.2, TweenEase.OUT_QUAD);
                        tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {z : 0}, 0.2, TweenEase.IN_QUAD, 0.2);
                    }
                }

                if (modBeat == 12 || modBeat == 14) {
                    tweenStart({obj_game: obj_game, prop: "field.1"}, {z : -100}, 0.2, TweenEase.OUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "field.1"}, {z : 0}, 0.2, TweenEase.IN_QUAD, 0.2);

                    tweenStart({obj_game: obj_game, prop: "field.0"}, {z : 100}, 0.2, TweenEase.OUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "field.0"}, {z : 0}, 0.2, TweenEase.IN_QUAD, 0.2);
                }
                else if (modBeat == 44 || modBeat == 46) {
                    tweenStart({obj_game: obj_game, prop: "field.0"}, {z : -100}, 0.2, TweenEase.OUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "field.0"}, {z : 0}, 0.2, TweenEase.IN_QUAD, 0.2);

                    tweenStart({obj_game: obj_game, prop: "field.1"}, {z : 100}, 0.2, TweenEase.OUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "field.1"}, {z : 0}, 0.2, TweenEase.IN_QUAD, 0.2);
                }
            }
            else if (mod == 4) {
                for (i in 0...8) {
                    var h:Float = 20;
                    if (beat % 2 == 0) { h = h * -1; }
                    if (i % 4 >= 2) { h = h * -1; }
                    tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {y : h, z : -h}, 0.1, TweenEase.OUT_QUAD);
                    tweenStart({obj_game: obj_game, prop: "strums." + i + ".pos"}, {y : 0, z : 0}, 0.3, TweenEase.IN_QUAD, 0.1);
                }
            }
            else if (mod == 5) {
                var dumb:Int = (curSide + 1) % 2; // Assuming curSide is accessible and updated
                if (modBeat % 4 == 0) {
                    tweenStart({obj_game: obj_game, prop: "field." + dumb}, {y : 0}, 0.4, TweenEase.OUT_ELASTIC);
                }
                if (modBeat % 4 == 3) {
                    tweenStart({obj_game: obj_game, prop: "field." + dumb}, {y : 300}, 0.3, TweenEase.INOUT_QUAD);
                }
                if (modBeat % 32 == 0) {
                    var oSide:Int = (curSide + 1) % 2;
                    var w:Float = 200;
                    if (curSide == 0) {
                        w = w * -1;
                    }
                    tweenStart({obj_game: obj_game, prop: "field." + curSide}, {x : w, z : 0}, 1, TweenEase.OUT_QUAD);
                    // The last line in the Lua code was incomplete: tweenStart({obj_game, "field."..oSide}, {x = 0
                    // Assuming it intended to tween x to 0 and maybe z like the other field tween in mod 0.
                    // Translating the incomplete line as best as possible, assuming x=0 was the only property.
                    tweenStart({obj_game: obj_game, prop: "field." + oSide}, {x : 0}, 1, TweenEase.OUT_QUAD); // Duration and ease added based on context
                    // If more properties were intended, they need to be added here. Example: {x: 0, z: -100}
                    curSide = oSide; // Assuming curSide should be updated here as well
                }
            }
        }
    }
}
