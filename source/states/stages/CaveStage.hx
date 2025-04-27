package states.stages;

import states.stages.objects.*;
import Reflect;
import Std;
import Math;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import haxe.ds.Vector;

// --- Placeholder definitions for engine-provided functions and classes ---
// These functions and classes are assumed to be provided by the target Haxe game engine (e.g., FNF engine).
// They are included here to make the translated code structurally complete and runnable *if* these definitions match the engine's API.

/**
 * Placeholder for the engine's sprite loading function.
 * Replace with the actual engine function (e.g., Paths.getSparrowAtlas, new FlxSprite().loadGraphic).
 */
@:keep function sprite_load(path:String):FlxSprite {
    // Engine-specific implementation needed here
    // Example: return new FlxSprite().loadGraphic(Paths.image(path));
    trace('sprite_load called with: $path. Engine implementation needed.');
    var spr:FlxSprite = new FlxSprite(); // Return a dummy sprite to avoid null errors
    return spr;
}

/**
 * Placeholder for the engine's function to set sprite offset by fraction.
 * Replace with the actual engine function (e.g., sprite.setGraphicSize, sprite.updateHitbox).
 */
@:keep function offset_setby_fraction(sprite:FlxSprite, x:Float, y:Float):Void {
    // Engine-specific implementation needed here
    // Example: if (Std.isOfType(sprite, FlxSprite)) {
    //              var flxSprite:FlxSprite = cast sprite;
    //              flxSprite.offset.set(flxSprite.frameWidth * x, flxSprite.frameHeight * y);
    //          }
    trace('offset_setby_fraction called for sprite. Engine implementation needed.');
    if (sprite != null && Reflect.hasField(sprite, "offset") && Reflect.hasField(sprite, "frameWidth") && Reflect.hasField(sprite, "frameHeight")) {
       Reflect.setField(sprite, "offset", { x: Reflect.getProperty(sprite, "frameWidth") * x, y: Reflect.getProperty(sprite, "frameHeight") * y });
    }
}

/**
 * Placeholder for the engine's FlxSprite property setting function.
 * Replace with the actual engine function or use direct property access.
 */
@:keep function prop_set(obj:FlxSprite, prop:String, value:FlxSprite):Void {
    // Engine-specific implementation needed here
    // Example using Reflect API for basic cases:
    trace('prop_set called: obj=$obj, prop=$prop, value=$value. Engine implementation or Reflect needed.');
    var fields = prop.split('.');
    var currentObj = obj;
    for (i in 0...fields.length - 1) {
        var fieldName = fields[i];
        if (Reflect.hasField(currentObj, fieldName)) {
            currentObj = Reflect.field(currentObj, fieldName);
        } else {
            // Handle potential array access like "cam.0"
            var index = Std.parseInt(fieldName);
            if (index != null && Std.isOfType(currentObj, Array)) {
                 var arr:Array<FlxSprite> = cast currentObj;
                 if (index >= 0 && index < arr.length) {
                    currentObj = arr[index];
                 } else {
                    trace('prop_set error: Index $index out of bounds for field ${fields[i-1]}');
                    return;
                 }
            } else if (index != null && Std.isOfType(currentObj, Vector)) {
                 #if (!cpp) // Vector access syntax varies across targets
                 var vec:Vector<FlxSprite> = cast currentObj;
                 if (index >= 0 && index < vec.length) {
                    currentObj = vec[index];
                 } else {
                    trace('prop_set error: Index $index out of bounds for Vector field ${fields[i-1]}');
                    return;
                 }
                 #else
                 trace('prop_set error: Vector access in prop_set not fully implemented for cpp target.');
                 return;
                 #end
            }
            else {
                trace('prop_set error: Field $fieldName not found in object');
                return;
            }
        }
    }
    var finalField = fields[fields.length - 1];
    var index = Std.parseInt(finalField);
     if (index != null && Std.isOfType(currentObj, Array)) {
         var arr:Array<FlxSprite> = cast currentObj;
         if (index >= 0) {
            while (arr.length <= index) arr.push(null); // Ensure array is large enough
            arr[index] = value;
         } else {
             trace('prop_set error: Invalid index $index for array field ${fields[fields.length-2]}');
         }
    } else if (index != null && Std.isOfType(currentObj, Vector)) {
         #if (!cpp)
         var vec:Vector<FlxSprite> = cast currentObj;
         if (index >= 0 && index < vec.length) { // Assume vector size is fixed or managed elsewhere
            vec[index] = value;
         } else {
             trace('prop_set error: Index $index out of bounds for Vector field ${fields[fields.length-2]}');
         }
         #else
          trace('prop_set error: Vector access in prop_set not fully implemented for cpp target.');
         #end
    }
    else if (Reflect.hasField(currentObj, finalField)) {
        Reflect.setField(currentObj, finalField, value);
    } else {
         // Optionally allow creating new fields
         Reflect.setField(currentObj, finalField, value);
         // trace('prop_set warning: Field $finalField did not exist, created dynamically.');
    }

}

/**
 * Placeholder for the engine's drawing color setting function.
 * Replace with the actual engine function (e.g., FlxG.camera.buffer.setPixel).
 */
@:keep function draw_set_color(color:Int):Void {
    // Engine-specific implementation needed here
    trace('draw_set_color called: color=$color. Engine implementation needed.');
    // Example: Could store color in a static variable for subsequent draw calls
}

/**
 * Placeholder for the engine's rectangle drawing function.
 * Replace with the actual engine function (e.g., FlxG.camera.drawRect).
 */
@:keep function draw_rectangle(x1:Float, y1:Float, x2:Float, y2:Float, outline:Bool):Void {
    // Engine-specific implementation needed here
    trace('draw_rectangle called: $x1, $y1, $x2, $y2, outline=$outline. Engine implementation needed.');
    // Example: FlxG.camera.drawRect(x1, y1, x2 - x1, y2 - y1, FlxColor.TRANSPARENT, { thickness: outline ? 1 : 0, color: storedColor });
}

/**
 * Placeholder for the engine's scrolled sprite drawing function.
 * Replace with the actual engine function.
 */
@:keep function draw_sprite_scrolled(sprite:, camX:Float, camY:Float, x:Float, scrollX:Float, scrollY:Float):Void {
    // Engine-specific implementation needed here
    trace('draw_sprite_scrolled called. Engine implementation needed.');
    // Example: This often requires manual calculation and drawing onto a camera buffer or using engine-specific sprite properties/methods.
    //          Could involve setting sprite.scrollFactor, sprite.x/y and drawing to a specific camera.
    if (Std.isOfType(sprite, FlxSprite)) {
        var flxSprite:FlxSprite = cast sprite;
        // This is a simplified example, actual scrolling draw might be more complex
        flxSprite.scrollFactor.set(scrollX, scrollY);
        flxSprite.x = x; // Assuming x, y are world coordinates adjusted for camera
        flxSprite.y = 0; // Original Lua code only provides x offset, assuming y=0? Needs clarification.
        // Need to ensure the sprite is added to a FlxState or drawn manually to a camera
        // flxSprite.draw(); // This depends heavily on context (where drawBG is called)
    }
}

/**
 * Placeholder for the engine's scroll position calculation function.
 * Replace with the actual engine function.
 */
@:keep function scroll_get_pos(camX:Float, camY:Float, scrollFactor:Float):Array<Float> {
    // Engine-specific implementation needed here
    trace('scroll_get_pos called: $camX, $camY, $scrollFactor. Engine implementation needed.');
    // Example: return [camX * scrollFactor, camY * scrollFactor];
    // This calculation might depend on the specific camera system used by the engine.
    // Let's assume a simple camera at (0,0) for placeholder purposes.
    return [camX * scrollFactor, camY * scrollFactor];
}

/**
 * Placeholder for the engine's floor/ceiling drawing function.
 * Replace with the actual engine function. This might involve tiling a sprite.
 */
@:keep function draw_floor(sprite:, camX:Float, camY:Float, y:Float, scrollX:Float, scrollY:Float, ?ceil:Bool = false):Void {
    // Engine-specific implementation needed here
    trace('draw_floor called: y=$y, scrollX=$scrollX, scrollY=$scrollY, ceil=$ceil. Engine implementation needed.');
    // Example: This might involve creating a tiled sprite or manually drawing tiles.
    if (Std.isOfType(sprite, FlxSprite)) {
         var flxSprite:FlxSprite = cast sprite;
         flxSprite.scrollFactor.set(scrollX, scrollY);
         flxSprite.x = 0; // Assuming it spans horizontally
         flxSprite.y = y;
         // Need to ensure the sprite is added to a FlxState or drawn manually
         // flxSprite.draw();
    }
}

/**
 * Placeholder for the main game state class (e.g., PlayState).
 * Assumed to hold references to characters and camera properties.
 */
class CaveStage extends BaseStage // Replace MusicBeatState with your actual base class if different
    // These need to be initialized appropriately by the engine/game state
    bf:Character = { x: 0.0, prop: { cam: [0.0, 0.0] } }; // Example structure matching prop_set usage
    dad:Character = { x: 0.0 };
    gf:Character = { x: 0.0 };
    defaultCamZoom:Float = 1.0;
    public static var camToZoom:Float = 1.0;

    // Helper to initialize dummy data if needed for standalone testing
    public static function initDefaults() {
       bf = { x: 0.0, y: 0.0, prop: { cam: [100.0, 100.0] } }; // Example with initial cam values
       dad = { x: 0.0, y: 0.0 };
       gf = { x: 0.0, y: 0.0 };
       camZoom = 1.0;
       camToZoom = 1.0;
    }
}

/**
 * Placeholder for color constants.
 * Replace with actual engine constants (e.g., FlxColor.BLACK).
 */
class Colors {
    public static inline var c_black:Int = FlxColor.BLACK; // 0xFF000000;
    public static inline var c_white:Int = FlxColor.WHITE; // 0xFFFFFFFF;
}

// --- End of Placeholder definitions ---


// Translated Haxe Code
class CaveStage // Using a class to encapsulate the functions
{
    // Static variables to hold sprite references, similar to Lua globals
    // Using Dynamic assuming the exact type from sprite_load isn't known,
    // but FlxSprite or engine-specific sprite class is likely.
    static var bg:FlxSprite;
    static var super_bg:FlxSprite;
    static var es1:FlxSprite;
    static var cal1:FlxSprite;
    static var cal2:FlxSprite;
    static var ground:FlxSprite;
    static var ceil:FlxSprite;

    // Corresponds to Lua's create() function
    public static function create():Void
    {
        modInit(0);

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
        offset_setby_fraction(ceil, 0.5, 1 - 0.1); // Calculation preserved

        // Accessing game objects via the assumed PlayState class
        PlayState.bf.x = 750;
        PlayState.dad.x = -750;
        // Using prop_set, assuming it exists and handles the path "prop.cam.0" / "prop.cam.1"
        // Adjusted Lua 1-based index [1] and [2] in the *value expression* to Haxe 0-based index [0] and [1]
        // Assumes PlayState.bf.prop.cam is an array or similar 0-indexed structure
        prop_set(PlayState.bf, "prop.cam.0", PlayState.bf.prop.cam[0] - 300);
        prop_set(PlayState.bf, "prop.cam.1", PlayState.bf.prop.cam[1] - 50);
        PlayState.gf.x = 80;
        PlayState.camZoom = 0.55;
        PlayState.camToZoom = PlayState.camZoom; // Assign the value, not reference
    }

    // Corresponds to Lua's drawBG() function
    public static function drawBG():Void
    {
        draw_set_color(Colors.c_black);
        draw_rectangle(-4000, -4000, 4000, 4000, false);
        draw_set_color(Colors.c_white);

        draw_sprite_scrolled(super_bg, 0, 0, -400, 0.1, 0.1);
        draw_sprite_scrolled(bg, 0, 0, 300, 0.3, 0.3);
        // Lua's gp = scroll_get_pos(...) returns a table, Haxe returns Array<Float>
        var gp:Array<Float> = scroll_get_pos(0, -200, 0.1);
        // Accessing array elements: Lua uses 1-based indexing (gp[1], gp[2]), Haxe uses 0-based (gp[0], gp[1])
        draw_floor(ceil, 0, 0, -1200, gp[0], gp[1], true);

        draw_sprite_scrolled(cal2, 0, -70, -350, 0.5, 0.5);
        draw_sprite_scrolled(es1, 0, 0, 0, 0.6, 0.6);
        draw_sprite_scrolled(cal1, 0, -70, -600, 0.7, 0.7);
        // Lua's local gp creates a new variable in this scope. Haxe's var does the same.
        var gp:Array<Float> = scroll_get_pos(0, -100, 0.8);
        // Accessing array elements: Adjusting indices from Lua 1-based to Haxe 0-based
        draw_floor(ground, 0, 0, 0, gp[0], gp[1]); // Default for 'ceil' parameter is false
    }
}

// --- Assumed External Dependencies ---
// These types and functions are assumed to exist in the Haxe environment
// where this script will be used (e.g., provided by the game engine).

// Assumed structure for the 'sys' object
typedef Sys = {
    public var skin:{ public var sep:Float; };
    public var opt:{ public var downscroll:Bool; };
}

// Assumed global functions or static methods from the engine
// Note: The exact signature of tweenStart might vary based on the engine's tween library.
// This signature assumes it takes an Array<Dynamic> where target[0] is the object
// and target[1] is the property path string.
typedef Externals = {
    public static var sys:Sys;
    public static var obj_game:Dynamic; // The main game object, likely Dynamic
    public static function tweenStart(target:Array<Dynamic>, properties:Dynamic, duration:Float, ease:String, ?delay:Float):Void;
    public static function console_add(value:Dynamic):Void;
    // Assuming degtorad and radtodeg might be provided externally as well
    // If not, the helper implementations within ModScript will be used.
    // public static function degtorad(degrees:Float):Float;
    // public static function radtodeg(radians:Float):Float;
}

// --- Main Translated Class ---
// Encapsulates the state and functions from the Lua script using static members.
class ModScript {

    // --- Global Variables ---
    public static var mod:Int = 0;
    public static var subMod:Int = 0;
    public static var modBeat:Int = 0;
    public static var modStep:Int = 0;
    public static var started:Bool = false;

    // --- Assumed Context Access ---
    // These provide access to the assumed external objects/functions.
    // They must be initialized by the external environment before use.
    static var sys(get, never):Sys;
    static function get_sys():Sys return Externals.sys;

    static var obj_game(get, never):Dynamic;
    static function get_obj_game():Dynamic return Externals.obj_game;

    static var tweenStart(get, never):Array<Dynamic>->Dynamic->Float->String->Null<Float>->Void;
    static function get_tweenStart() return Externals.tweenStart;

    static var console_add(get, never):Dynamic->Void;
    static function get_console_add() return Externals.console_add;

    // --- Helper Functions ---

    // Helper function to mimic Lua's prop_set(obj, path, value)
    // Handles nested properties and array indices in the path string
    static function prop_set(target:Dynamic, path:String, value:Dynamic):Void {
        var parts = path.split('.');
        var current:Dynamic = target;
        var currentPath = ""; // For error reporting

        for (i in 0...parts.length - 1) {
            var part = parts[i];
            currentPath += (currentPath == "" ? "" : ".") + part;

            if (current == null) {
                trace('Error: prop_set failed. Object is null at path "${currentPath}" for full path "${path}"');
                return;
            }

            var index = Std.parseInt(part);
            var next:Dynamic = null;

            // Check if part is a valid integer index string (e.g., "0", "1")
            if (index != null && Std.string(index) == part) {
                 if (Std.isOfType(current, Array)) {
                     var arr:Array<Dynamic> = cast current;
                     if (index >= 0 && index < arr.length) {
                         next = arr[index];
                     } else {
                         // Error if index is out of bounds during traversal,
                         // as intermediate arrays/objects are assumed to exist.
                         trace('Error: prop_set failed. Array index ${index} out of bounds (length ${arr.length}) at path "${currentPath}" for full path "${path}"');
                         return;
                     }
                 } else {
                     trace('Error: prop_set failed. Tried to access index ${index} on a non-Array type (${Type.typeof(current)}) at path "${currentPath}" for full path "${path}"');
                     return;
                 }
            } else { // Part is a field name
                try {
                    // Use Reflect.field for potentially better performance and null checking
                    next = Reflect.field(current, part);
                    // Check if field genuinely doesn't exist vs. being null
                    if (next == null && !Reflect.hasField(current, part)) {
                         trace('Error: prop_set failed. Field "${part}" not found at path "${currentPath}" for full path "${path}"');
                         return;
                    }
                } catch (e:Dynamic) {
                     trace('Error: prop_set failed accessing field "${part}" at path "${currentPath}" for full path "${path}": ${e}');
                     return;
                }
            }
             current = next;
        }

        // Set the final part
        var finalPart = parts[parts.length - 1];
        currentPath += (currentPath == "" ? "" : ".") + finalPart;

        if (current == null) {
            // This can happen if the second-to-last part resolved to null
            trace('Error: prop_set failed. Object is null before setting final property at path "${currentPath}" (was null at "${parts.slice(0, -1).join('.')}") for full path "${path}"');
            return;
        }

        var finalIndex = Std.parseInt(finalPart);
        // Check if finalPart is a valid integer index string
        if (finalIndex != null && Std.string(finalIndex) == finalPart) {
            if (Std.isOfType(current, Array)) {
                var arr:Array<Dynamic> = cast current;
                if (finalIndex >= 0) {
                     // Ensure array is large enough (Haxe arrays auto-extend with nulls when setting out of bounds)
                     // Explicitly push nulls for clarity and potential compatibility if target isn't standard Haxe Array
                     while (arr.length <= finalIndex) {
                         arr.push(null);
                     }
                     arr[finalIndex] = value;
                } else {
                     trace('Error: prop_set failed. Final array index ${finalIndex} is invalid at path "${currentPath}" for full path "${path}"');
                }
            } else {
                trace('Error: prop_set failed. Tried to set index ${finalIndex} on a non-Array type (${Type.typeof(current)}) at path "${currentPath}" for full path "${path}"');
            }
        } else { // Final part is a field name
            Reflect.setField(current, finalPart, value);
        }
    }

    // Helper math functions (use these if not provided externally)
    static inline function degtorad(degrees:Float):Float {
        #if (haxe_ver >= 4.0) // Check if Math.degToRad exists (added in Haxe 4)
        return Math.degToRad(degrees);
        #else
        return degrees * Math.PI / 180;
        #end
    }

    static inline function radtodeg(radians:Float):Float {
         #if (haxe_ver >= 4.0) // Check if Math.radToDeg exists (added in Haxe 4)
         return Math.radToDeg(radians);
         #else
         return radians * 180 / Math.PI;
         #end
    }

    // --- State Variables ---
    // local l = sys.skin.sep; // Calculated where needed or initialized
    public static var cnt:Array<Float>; // = [l*1.5, l / 2, -l / 2, -l*1.5]; // Initialized in create()

    public static var centerY:Float = 270;

    // rot = 0;
    public static var rot:Float = 0;
    // rotspd = 1;
    public static var rotspd:Float = 1;
    // circAng = degtorad(180);
    public static var circAng:Float; // Initialized in create()

    // curSide was identified as needing persistent state
    public static var curSide:Int = 1;

    // --- Translated Functions ---

    public static function create():Void {
        // Initialize state variables that depend on context or calculations
        var l = sys.skin.sep; // Get separator from context
        cnt = [l*1.5, l / 2, -l / 2, -l*1.5];
        circAng = degtorad(180);

        // Reset other state
        mod = 0; // Explicitly reset mod here, though modInit(0) does it too
        subMod = 0;
        modBeat = 0;
        modStep = 0;
        started = false;
        rot = 0;
        rotspd = 1;
        curSide = 1; // Reset curSide on create

        // Call modInit for the initial state
        modInit(0);
    }

    public static function modInit(Mod:Int):Void {
        mod = Mod;
        subMod = 0; // Reset subMod on every modInit
        modBeat = 0; // Reset modBeat on every modInit
        modStep = 0; // Reset modStep on every modInit

        // Ensure 'cnt' is initialized if create() wasn't called first (e.g., direct call to modInit)
        if (cnt == null) {
             var l = sys.skin.sep;
             cnt = [l*1.5, l / 2, -l / 2, -l*1.5];
        }

        tweenStart([obj_game, "field.0"], { x : 0.0, y : 0.0, z : 0.0 }, 0.1, "inout_quad");
        tweenStart([obj_game, "field.1"], { x : 0.0, y : 0.0, z : 0.0 }, 0.1, "inout_quad");
        for (i in 0...8) {
            prop_set(obj_game, "strums." + i + ".lines.0.p", []); // Set 'p' to an empty array
            tweenStart([obj_game, "strums." + i + ".lines.0"], { a : 270.0, ax : 0.0, ay : 0.0, w : 1.0 }, 0.1, "inout_quad");
            tweenStart([obj_game, "strums." + i + ".lines.1"], { a : 270.0, ax : 0.0, ay : 0.0, w : 1.0 }, 0.1, "inout_quad");
            tweenStart([obj_game, "strums." + i + ".pos"], { x : 0.0, y : 0.0, z : 0.0 }, 0.1, "inout_quad");
            tweenStart([obj_game, "strums." + i + ".ang3D"], { x : 0.0, y : 0.0, z : 0.0 }, 0.1, "inout_quad");
            tweenStart([obj_game, "strums." + i + ".dir"], { x : 0.0, y : 0.0, z : 0.0 }, 0.1, "inout_quad");
        }

        if (mod == 0) {
            curSide = 1; // Reset curSide specifically for mod 0 start
            for (i in 0...8) {
                // Set 'p' to an array containing one point object
                prop_set(obj_game, "strums." + i + ".lines.0.p", [{ x : 0.0, y : 360.0, z : 0.0 }]);
            }
        }
        else if (mod == 1) {
            for (i in 0...8) {
                prop_set(obj_game, "strums." + i + ".lines.0.p", [{ x : 0.0, y : 360.0, z : 0.0 }]);
            }
        }
        else if (mod == 2) {
            for (i in 0...8) {
                // Set 'p' to an array containing two point objects
                prop_set(obj_game, "strums." + i + ".lines.0.p", [{ x : 0.0, y : 720.0 / 4.0, z : 0.0 }, { x : 0.0, y : 720.0 / 4.0 * 3.0, z : 0.0 }]);
            }

            var l = sys.skin.sep;
            var woo = l * 0.8;
            for (i in 0...2) {
                //idk (comment preserved)
                var num0 = i*4;
                var num1 = i*4 + 1;
                var num2 = i*4 + 2;
                var num3 = i*4 + 3;

                var vdir:Float = 1.0;

                if (sys.opt.downscroll) {
                    vdir = -1.0;
                }
                tweenStart([obj_game, "strums." + num0 + ".pos"], { x : l * 1.5 - woo }, 0.2, "inout_quad");
                tweenStart([obj_game, "strums." + num3 + ".pos"], { x : -l * 1.5 + woo }, 0.2, "inout_quad");
                tweenStart([obj_game, "strums." + num1 + ".pos"], { x : l / 2.0, y : woo * vdir }, 0.2, "inout_quad");
                tweenStart([obj_game, "strums." + num2 + ".pos"], { x : -l / 2.0, y : -woo * vdir }, 0.2, "inout_quad");
            }
            tweenStart([obj_game, "field.1"], { x : 380.0, y : centerY }, 0.3, "inout_quad");
            tweenStart([obj_game, "field.1"], { z : -100.0 }, 0.5, "inout_quad");
            tweenStart([obj_game, "field.0"], { y : 380.0 }, 1.0, "inout_quad");

            var an:Array<Float> = [-90.0, 0.0, 180.0, 90.0]; // Haxe Array, 0-based index
            if (sys.opt.downscroll) {
                an[1] = 180.0; // Haxe index 1 (Original Lua index 2)
                an[2] = 0.0;   // Haxe index 2 (Original Lua index 3)
            }
            for (i in 0...8) {
                // Access Haxe array using 0-based index: an[i % 4]
                tweenStart([obj_game, "strums." + i + ".dir"], { z : an[i % 4] }, 0.2, "inout_quad");
            }
        }
        else if (mod == 3) {
            tweenStart([obj_game, "field.1"], { x : 380.0, y : centerY }, 0.8, "out_quad");
            tweenStart([obj_game, "field.0"], { x : -380.0, y : centerY }, 0.8, "out_quad");
            for (i in 0...8) {
                tweenStart([obj_game, "strums." + i + ".lines.0"], { ay : -60.0, w : 0.9 }, 0.11, "inout_quad");
                prop_set(obj_game, "strums." + i + ".lines.0.p", [{ x : 0.0, y : 200.0, z : 100.0 }]);
                tweenStart([obj_game, "strums." + i + ".lines.1"], { ay : -90.0 }, 0.11, "inout_quad");
                // Access Haxe array using 0-based index: cnt[i % 4]
                tweenStart([obj_game, "strums." + i + ".pos"], { x : cnt[i % 4] }, 0.11, "inout_quad");
            }
        }
        else if (mod == 4) {
            for (i in 0...8) {
                var w:Float = 80.0;
                if (i % 4 < 2) { w = w * -1.0; }
                tweenStart([obj_game, "strums." + i + ".lines.0"], { ay : -30.0 }, 0.11, "inout_quad");
                prop_set(obj_game, "strums." + i + ".lines.0.p", [{ x : 0.0, y : 360.0, z : 40.0 }]);
                // Access Haxe array using 0-based index: cnt[i % 4]
                tweenStart([obj_game, "strums." + i + ".pos"], { x : cnt[i % 4] + w }, 0.11, "inout_quad");
            }
        }
        else if (mod == 5) {
            for (i in 0...8) {
                tweenStart([obj_game, "strums." + i + ".dir"], { x : 50.0 }, 1.0, "inout_quad");
                tweenStart([obj_game, "strums." + i + ".ang3D"], { x : -50.0 }, 1.0, "inout_quad");
            }
            // curSide state carries over for mod 5 usage in onBeatHit
        }
    }

    public static function update(elapsed:Float):Void {
        if (started) {
            if (mod == 0) {
                rot = rot + elapsed * 5.0;
                for (i in 0...8) {
                    prop_set(obj_game, "strums." + i + ".pos.z", Math.cos(rot + i) * 40.0);
                }

                if (subMod == 1) {
                    for (i in 0...8) {
                        prop_set(obj_game, "strums." + i + ".dir.z", Math.cos(rot + i) * 10.0);
                        prop_set(obj_game, "strums." + i + ".ang3D.z", Math.cos(rot + i) * 4.0);
                    }
                }
            }
            else if (mod == 3) {
                if (subMod == 2) {
                    rotspd = rotspd + elapsed;
                }
                else if (subMod == 3) {
                    rotspd = rotspd - elapsed * 1.21;
                    if (rotspd < 0.0) {
                        rotspd = 0.0;
                    }
                    else {
                        // Haxe equivalent of Lua's math.random(min, max) for integers: Std.random(max - min + 1) + min
                        // Std.random(4 - (-4) + 1) + (-4) = Std.random(9) - 4
                        var rndX = Std.random(9) - 4;
                        var rndY = Std.random(9) - 4;
                        tweenStart([obj_game, "field.1"], { x : 380.0 + rndX, y : centerY + rndY }, 0.01, "out_quad");
                        rndX = Std.random(9) - 4; // Generate new random numbers
                        rndY = Std.random(9) - 4;
                        tweenStart([obj_game, "field.0"], { x : -380.0 + rndX, y : centerY + rndY }, 0.01, "out_quad");
                    }
                }
                circAng = circAng + elapsed * rotspd;
                for (i in 0...8) {
                    var off:Float = -((i % 4) - 2.0) / 2.5; // Ensure float division
                    var len:Float = 300.0;
                    var xlen:Float = len;
                    if (subMod >= 1) { xlen = 500.0; }
                    var an:Float = circAng + off;
                    if (i < 4) { an = an + degtorad(180.0); }
                    // Access Haxe array using 0-based index: cnt[i % 4]
                    prop_set(obj_game, "strums." + i + ".pos.x", cnt[i % 4] + Math.cos(an) * xlen);
                    prop_set(obj_game, "strums." + i + ".pos.y", -Math.sin(an) * len);

                    prop_set(obj_game, "strums." + i + ".dir.z", 270.0 + radtodeg(an - off));
                }
            }
            else if (mod == 5) {
                //[[ (Lua comment start)
                //for i = 0, 7, 1 do
                //    prop_set(obj_game, "strums."..i..".pos.z", math.cos(rot + i) * 100);
                //end]] (Lua comment end)
                // Translated comment block:
                /*
                for (i in 0...8) {
                    prop_set(obj_game, "strums." + i + ".pos.z", Math.cos(rot + i) * 100.0);
                }
                */
            }
        }
    }

    public static function onBeatHit(beat:Int):Void {
        //prop_set(obj_game, "strums.1.pos.x", -40); // Example commented line
        //obj_fnf.gf.prop.beatDance = 4; // Example commented line (assumes obj_fnf exists)
        //console_add(s.xscale); // Example commented line (assumes 's' exists)

        if (beat == 0) {
            started = true;
        }

        if (started) {
            // --- Beat-based state changes ---
            // Using 'else if' chain for mutually exclusive beat triggers
            if (beat == 32) {
                subMod = 1;
            } else if (beat == 64) {
                modInit(1);
            } else if (beat == 128) {
                modInit(2);
            } else if (beat == 192) {
                modInit(3);
            } else if (beat == 256) {
                modInit(4);
            } else if (beat == 296) { // Occurs *after* 288 in original code
                modInit(0);
            } else if (beat == 288) {
                mod = -1; // Special state not handled by modInit
                for (i in 0...8) {
                    tweenStart([obj_game, "strums." + i + ".pos"], { x : 0.0, y : 0.0, z : 0.0 }, 3.0, "inout_quad");
                }
            } else if (beat == 328) {
                modInit(5);
            } else if (beat == 392) {
                modInit(3);
                subMod = 1; // Set subMod *after* modInit resets it to 0
            } else if (beat == 456) {
                subMod = 2;
            } else if (beat == 464) {
                subMod = 3;
            }

            // --- Mod-specific beat actions ---
            // These run *after* the state change for the current beat has occurred.
            if (mod == 0) {
                for (i in 0...8) {
                    var h:Float = 20.0;
                    if (beat % 2 == 0) { h = h * -1.0; }
                    if (i % 2 == 0) { h = h * -1.0; }
                    tweenStart([obj_game, "strums." + i + ".pos"], { y : 40.0 + h }, 0.2, "out_quad");
                    tweenStart([obj_game, "strums." + i + ".pos"], { y : 0.0 }, 0.2, "in_quad", 0.2); // Delay added

                    //prop_set(obj_game, "strums."..i..".lines.0.p.0.x", h); // Original commented line
                    // Translated commented line (assuming path targets x of first point in p array):
                    // prop_set(obj_game, "strums." + i + ".lines.0.p.0.x", h);

                    h = 100.0; // Reset h for the next tween
                    if (beat % 2 == 0) { h = h * -1.0; }
                    // Assuming path targets the first point object {x,y,z} within the 'p' array: "lines.0.p.0"
                    tweenStart([obj_game, "strums." + i + ".lines.0.p.0"], { x : h }, 0.2, "out_quad");
                    tweenStart([obj_game, "strums." + i + ".lines.0.p.0"], { x : 0.0 }, 0.2, "in_quad", 0.2); // Delay added
                }

                if (modBeat % 16 == 0) {
                    var oSide = (curSide + 1) % 2;
                    var w:Float = 200.0;
                    if (curSide == 0) {
                        w = w * -1.0;
                    }
                    tweenStart([obj_game, "field." + curSide], { x : w, z : 0.0 }, 1.0, "out_quad");
                    tweenStart([obj_game, "field." + oSide], { x : 0.0, z : -100.0 }, 1.0, "out_quad");
                    curSide = oSide;
                }
            }
            else if (mod == 1) {
                var a:Float = 30.0;
                if (beat % 2 == 1) { a = a * -1.0; }

                if (beat % 4 == 3) {
                    for (i in 0...2) { // Loops 0, 1
                        tweenStart([obj_game, "field." + i], { z : 100.0 }, 0.3, "out_quad");
                        tweenStart([obj_game, "field." + i], { z : 0.0 }, 0.3, "in_quad", 0.3); // Delay added
                    }
                }

                // Need a separate variable for sx calculation if 'a' changes mid-loop and is needed later
                var originalA = a; // Store the initial value of 'a' for this beat
                for (i in 0...8) { //angle & horizontal bounce
                    if (beat % 4 == 3) {
                        prop_set(obj_game, "strums." + i + ".ang3D.z", 360.0);
                    }
                    // Use the 'a' that might have been flipped in the previous iteration
                    tweenStart([obj_game, "strums." + i + ".ang3D"], { z : a / 7.0 }, 0.18, "inout_quad");
                    tweenStart([obj_game, "strums." + i + ".ang3D"], { z : 0.0 }, 0.18, "inout_quad", 0.18); // Delay added

                    // Flip 'a' for the *next* iteration's angle tween and the current iteration's position tween
                    if (i % 2 == 1) { a = a * -1.0; }

                    // Lua: sx = (i % 4) - 2 * 50 --> (i%4) - 100
                    var sx:Float = (i % 4) - 100.0;
                    // Use the potentially flipped 'a' for position tween
                    tweenStart([obj_game, "strums." + i + ".pos"], { x : sx + a * 1.2 }, 0.2, "out_quad");
                    tweenStart([obj_game, "strums." + i + ".pos"], { x : sx }, 0.2, "in_quad", 0.2); // Delay added

                    if (beat % 4 == i % 4) {
                        tweenStart([obj_game, "strums." + i + ".pos"], { z : -300.0 }, 0.2, "out_quad");
                        tweenStart([obj_game, "strums." + i + ".pos"], { z : 0.0 }, 0.2, "in_quad", 0.2); // Delay added
                    }
                }

                // Mod 1 beat-specific events based on modBeat
                var up:Float = 400.0;
                var shift:Float = 50.0;
                if (modBeat == 0) { //show opponent, hide player
                    tweenStart([obj_game, "field.1"], { x : 300.0, y : shift }, 0.9, "out_quad");
                    tweenStart([obj_game, "field.0"], { y : -300.0 }, 0.5, "in_quad");
                } else if (modBeat == 4) { //shift half receptors upwards (start moving field)
                    // Lua: for i = 4, 7, 2 do -> loops i = 4, 6
                    for (i in 4...8) {
                       if (i % 2 == 0) { // Only run for i = 4, 6
                           tweenStart([obj_game, "strums." + i + ".pos"], { y : up }, 2.0, "inout_quad");
                           tweenStart([obj_game, "strums." + i + ".dir"], { x : -180.0 }, 2.0, "inout_quad");
                       }
                    }
                    tweenStart([obj_game, "field.1"], { x : 500.0 }, 8.0, "linear");
                } else if (modBeat == 12) { //the other half
                    // Lua: for i = 5, 7, 2 do -> loops i = 5, 7
                     for (i in 5...8) {
                       if (i % 2 != 0) { // Only run for i = 5, 7
                           tweenStart([obj_game, "strums." + i + ".pos"], { y : up }, 2.0, "inout_quad");
                           tweenStart([obj_game, "strums." + i + ".dir"], { x : -180.0 }, 2.0, "inout_quad");
                       }
                    }
                } else if (modBeat == 18) {
                    for (i in 4...8) { // Loops 4, 5, 6, 7
                        // Path: "lines.0.p.0" targets the first point object in the 'p' array
                        tweenStart([obj_game, "strums." + i + ".lines.0.p.0"], { x : 20.0 }, 1.0, "inout_quad");
                        tweenStart([obj_game, "strums." + i + ".lines.0"], { w : 0.8, a : 270.0 - 30.0 }, 1.0, "inout_quad");
                    }
                } else if (modBeat == 26 || modBeat == 28) {
                    for (i in 4...8) { // Loops 4, 5, 6, 7
                        tweenStart([obj_game, "strums." + i + ".ang3D"], { x : -45.0 }, 0.2, "out_quad");
                        tweenStart([obj_game, "strums." + i + ".ang3D"], { x : 0.0 }, 0.2, "in_quad", 0.2); // Delay added
                    }
                } else if (modBeat == 30) { //show player hide opponent
                    tweenStart([obj_game, "field.1"], { x : 0.0, y : -300.0 }, 0.9, "in_quad");
                    tweenStart([obj_game, "field.0"], { x : -200.0, y : shift }, 0.5, "out_quad");
                    for (i in 4...8) { // Loops 4, 5, 6, 7
                        tweenStart([obj_game, "strums." + i + ".pos"], { y : 0.0 }, 1.0, "inout_quad");
                        tweenStart([obj_game, "strums." + i + ".dir"], { x : 0.0 }, 1.0, "inout_quad");
                    }
                } else if (modBeat == 36) { //movii (starts)
                    // Lua: for i = 0, 3, 2 do -> loops i = 0, 2
                     for (i in 0...4) {
                       if (i % 2 == 0) { // Only run for i = 0, 2
                           tweenStart([obj_game, "strums." + i + ".pos"], { y : up }, 2.0, "inout_quad");
                           tweenStart([obj_game, "strums." + i + ".dir"], { x : -180.0 }, 2.0, "inout_quad");
                       }
                    }
                    tweenStart([obj_game, "field.0"], { x : -400.0 }, 8.0, "linear");
                } else if (modBeat == 44) { //the other half
                    // Lua: for i = 1, 3, 2 do -> loops i = 1, 3
                     for (i in 1...4) {
                       if (i % 2 != 0) { // Only run for i = 1, 3
                           tweenStart([obj_game, "strums." + i + ".pos"], { y : up }, 2.0, "inout_quad");
                           tweenStart([obj_game, "strums." + i + ".dir"], { x : -180.0 }, 2.0, "inout_quad");
                       }
                    }
                } else if (modBeat == 50) {
                    for (i in 0...4) { // Loops 0, 1, 2, 3
                        // Path: "lines.0.p.0"
                        tweenStart([obj_game, "strums." + i + ".lines.0.p.0"], { x : -20.0 }, 1.0, "inout_quad");
                        tweenStart([obj_game, "strums." + i + ".lines.0"], { w : 0.8, a : 270.0 + 30.0 }, 1.0, "inout_quad");
                    }
                } else if (modBeat == 58 || modBeat == 60) {
                    for (i in 0...4) { // Loops 0, 1, 2, 3
                        tweenStart([obj_game, "strums." + i + ".ang3D"], { x : -45.0 }, 0.2, "out_quad");
                        tweenStart([obj_game, "strums." + i + ".ang3D"], { x : 0.0 }, 0.2, "in_quad", 0.2); // Delay added
                    }
                }
            }
            else if (mod == 2) {
                if (modBeat % 4 == 0) {
                    for (i in 0...8) {
                        // Path assumes p is array: "lines.0.p.0.z" and "lines.0.p.1.z"
                        prop_set(obj_game, "strums." + i + ".lines.0.p.0.z", 0.0);
                        prop_set(obj_game, "strums." + i + ".lines.0.p.1.z", 0.0);
                        // Path assumes p is array: "lines.0.p.0" and "lines.0.p.1" target the point objects
                        tweenStart([obj_game, "strums." + i + ".lines.0.p.0"], { x : 300.0 }, 0.05, "out_quad");
                        tweenStart([obj_game, "strums." + i + ".lines.0.p.1"], { x : -300.0 }, 0.05, "out_quad");
                        tweenStart([obj_game, "strums." + i + ".lines.0.p.0"], { x : 0.0 }, 0.3, "in_quad", 0.05); // Delay added
                        tweenStart([obj_game, "strums." + i + ".lines.0.p.1"], { x : 0.0 }, 0.3, "in_quad", 0.05); // Delay added
                    }
                }
                // Lua used 'if', not 'elseif', so this condition is checked independently
                if (modBeat % 4 == 3) {
                    for (i in 0...8) {
                        // Path: "lines.0.p.0" and "lines.0.p.1"
                        tweenStart([obj_game, "strums." + i + ".lines.0.p.0"], { x : -300.0 }, 0.3, "inout_quad");
                        tweenStart([obj_game, "strums." + i + ".lines.0.p.1"], { x : 300.0 }, 0.3, "inout_quad");
                    }
                    //[[ (Lua comment start)
                    //for i = 0, 7, 1 do
                    //    tweenStart({obj_game, "strums."..i..".lines.0.p.0"}, {z = 1000}, 0.3, "in_quad");
                    //    tweenStart({obj_game, "strums."..i..".lines.0.p.1"}, {z = -1000}, 0.3, "in_quad");
                    //end]] (Lua comment end)
                    // Translated comment block:
                    /*
                    for (i in 0...8) {
                        tweenStart([obj_game, "strums." + i + ".lines.0.p.0"], { z : 1000.0 }, 0.3, "in_quad");
                        tweenStart([obj_game, "strums." + i + ".lines.0.p.1"], { z : -1000.0 }, 0.3, "in_quad");
                    }
                    */
                }

                var a:Float = 8.0;
                if (modBeat % 2 == 1) { a = a * -1.0; }
                for (i in 0...8) {
                    tweenStart([obj_game, "strums." + i + ".ang3D"], { z : a }, 0.2, "out_quad");
                    tweenStart([obj_game, "strums." + i + ".ang3D"], { z : 0.0 }, 0.2, "in_quad", 0.2); // Delay added

                    var ind:Array<Int> = [3, 2, 0, 1]; // Haxe Array, 0-based index
                    // Access Haxe array using 0-based index: ind[i % 4]
                    if (beat % 4 == ind[i % 4]) {
                        tweenStart([obj_game, "strums." + i + ".ang3D"], { y : a * 4.0 }, 0.2, "out_quad");
                        tweenStart([obj_game, "strums." + i + ".ang3D"], { y : 0.0 }, 0.2, "in_quad", 0.2); // Delay added
                    }
                }

                // Mod 2 beat-specific events based on modBeat
                if (modBeat == 1) {
                    //tweenStart({obj_game, "field.1"}, {z = -200}, 7, "linear"); // Original comment
                    // Translated comment: tweenStart([obj_game, "field.1"], { z : -200.0 }, 7.0, "linear");
                } else if (modBeat == 14) {
                    tweenStart([obj_game, "field.0"], { x : -380.0, y : centerY }, 0.3, "inout_quad");
                    tweenStart([obj_game, "field.0"], { z : -100.0 }, 0.5, "inout_quad");
                    tweenStart([obj_game, "field.1"], { x : 0.0, z : -400.0 }, 0.2, "inout_quad");
                    tweenStart([obj_game, "field.1"], { y : -400.0, z : 0.0 }, 0.7, "in_elastic");
                } else if (modBeat == 16) {
                    //tweenStart({obj_game, "field.0"}, {z = -200}, 7, "linear"); // Original comment
                    // Translated comment: tweenStart([obj_game, "field.0"], { z : -200.0 }, 7.0, "linear");
                    for (i in 4...8) { // Loops 4, 5, 6, 7
                        prop_set(obj_game, "strums." + i + ".pos.x", 0.0);
                        prop_set(obj_game, "strums." + i + ".pos.y", 0.0);
                        prop_set(obj_game, "strums." + i + ".dir.z", -180.0);
                    }
                } else if (modBeat == 32) {
                    tweenStart([obj_game, "field.1"], { y : 0.0 }, 0.4, "out_quad");
                    tweenStart([obj_game, "field.0"], { x : 0.0 }, 0.6, "inout_quad");
                    for (i in 4...8) { // Loops 4, 5, 6, 7
                        tweenStart([obj_game, "strums." + i + ".dir"], { z : 0.0 }, 0.4, "out_quad");
                    }
                } else if (modBeat == 46) {
                    tweenStart([obj_game, "field.1"], { y : -400.0, z : 0.0 }, 0.7, "in_elastic");
                    tweenStart([obj_game, "field.0"], { x : -380.0 }, 0.6, "inout_quad");
                } else if (modBeat == 48) {
                    var l = sys.skin.sep;

                    tweenStart([obj_game, "strums.0.pos"], { x : l * 1.5 }, 6.0, "inout_quad");
                    tweenStart([obj_game, "strums.3.pos"], { x : -l * 1.5 }, 6.0, "inout_quad");
                    tweenStart([obj_game, "strums.1.pos"], { x : l / 2.0, y : 0.0 }, 6.0, "inout_quad");
                    tweenStart([obj_game, "strums.2.pos"], { x : -l / 2.0, y : 0.0 }, 6.0, "inout_quad");

                    for (i in 0...4) { // Loops 0, 1, 2, 3
                        tweenStart([obj_game, "strums." + i + ".lines.0"], { a : 270.0 + 100.0 }, 6.0, "inout_quad");
                        tweenStart([obj_game, "strums." + i + ".lines.1"], { a : 270.0 + 100.0 }, 6.0, "inout_quad");
                    }
                }
            }
            else if (mod == 3) {
                if (subMod < 3) {
                    for (i in 0...8) {
                        var h:Float = 20.0;
                        if (beat % 2 == 0) { h = h * -1.0; }
                        if (i % 2 == 0) { h = h * -1.0; }
                        tweenStart([obj_game, "strums." + i + ".pos"], { z : 40.0 + h }, 0.2, "out_quad");
                        tweenStart([obj_game, "strums." + i + ".pos"], { z : 0.0 }, 0.2, "in_quad", 0.2); // Delay added
                    }
                }

                // Mod 3 beat-specific events based on modBeat
                if (modBeat == 12 || modBeat == 14) {
                    tweenStart([obj_game, "field.1"], { z : -100.0 }, 0.2, "out_quad");
                    tweenStart([obj_game, "field.1"], { z : 0.0 }, 0.2, "in_quad", 0.2); // Delay added

                    tweenStart([obj_game, "field.0"], { z : 100.0 }, 0.2, "out_quad");
                    tweenStart([obj_game, "field.0"], { z : 0.0 }, 0.2, "in_quad", 0.2); // Delay added
                } else if (modBeat == 44 || modBeat == 46) {
                    tweenStart([obj_game, "field.0"], { z : -100.0 }, 0.2, "out_quad");
                    tweenStart([obj_game, "field.0"], { z : 0.0 }, 0.2, "in_quad", 0.2); // Delay added

                    tweenStart([obj_game, "field.1"], { z : 100.0 }, 0.2, "out_quad");
                    tweenStart([obj_game, "field.1"], { z : 0.0 }, 0.2, "in_quad", 0.2); // Delay added
                }
            }
            else if (mod == 4) {
                for (i in 0...8) {
                    var h:Float = 20.0;
                    if (beat % 2 == 0) { h = h * -1.0; }
                    if (i % 4 >= 2) { h = h * -1.0; } // Check if remainder is 2 or 3
                    tweenStart([obj_game, "strums." + i + ".pos"], { y : h, z : -h }, 0.1, "out_quad");
                    tweenStart([obj_game, "strums." + i + ".pos"], { y : 0.0, z : 0.0 }, 0.3, "in_quad", 0.1); // Delay added
                }
            }
            else if (mod == 5) {
                var dumb = (curSide + 1) % 2; // Uses curSide state
                if (modBeat % 4 == 0) {
                    tweenStart([obj_game, "field." + dumb], { y : 0.0 }, 0.4, "out_elastic");
                }
                // Lua used 'if', not 'elseif'
                if (modBeat % 4 == 3) {
                    tweenStart([obj_game, "field." + dumb], { y : 300.0 }, 0.3, "inout_quad");
                }
                // Lua used 'if', not 'elseif'
                if (modBeat % 32 == 0) {
                    var oSide = (curSide + 1) % 2;
                    var w:Float = 200.0;
                    if (curSide == 0) {
                        w = w * -1.0;
                    }
                    tweenStart([obj_game, "field." + curSide], { x : w, z : 0.0 }, 1.0, "out_quad");
                    tweenStart([obj_game, "field." + oSide], { x : 0.0, z : -100.0 }, 1.0, "out_quad");
                    curSide = oSide;
                }
            }
            // This check should only happen if mod is NOT -1, as mod = -1 has its own logic block triggered by beat 288
            // However, the original Lua code doesn't prevent this. It increments modBeat even if mod became -1.
            // To be exact, we increment modBeat regardless of the mod value, unless modInit was called (which resets it).
            // The only case modBeat isn't incremented is if 'started' is false.
            if (mod != -1) { // Let's assume modBeat only increments for active mods, though Lua code didn't explicitly check this.
                             // Reverting this assumption to match Lua exactly: modBeat increments if started is true.
            }
             // Increment modBeat at the end of the beat processing if started
             modBeat = modBeat + 1;

        } // end if(started)
    }

    public static function onStepHit(step:Int):Void {
        if (started) {
            if (mod == 0) {
                if (subMod == 1) {
                    for (i in 0...8) {
                        if (step % 8 == 6) {
                            var h:Float = -300.0; // Variable declared locally within the if block scope
                            if (step % 16 == 6) {
                                h = h * -1.0; // Original Lua code ends abruptly after the '*'
                                // The line was: if (step % 16 == 6) then h = h * ```
                                // Translated the logic up to the point of cutoff.
                                // No action using 'h' follows in the original code provided.
                            }
                            // No action using 'h' here either.
                        }
                    }
                }
            }
            // No other mods handled in onStepHit in the provided code.

            // Increment modStep if needed (original code doesn't use it after init)
            // modStep = modStep + 1;
        }
    }
} // End of class ModScript
