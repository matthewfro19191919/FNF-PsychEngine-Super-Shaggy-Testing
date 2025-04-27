package states.stages;

import states.stages.objects.*;
import haxe.ds.Vector;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.system.FlxSound;
import Math;

// Assuming this class extends a base state like MusicBeatState or similar
// which provides the necessary functions and variables (curBeat, lowQuality, etc.)
class CaveStage extends BaseStage // Replace MusicBeatState with your actual base class if different
{
    override public function create():Void
    {
        var bg:BGSprite = new BGSprite('cavebg/bg', -1000, 300);
	    add(bg);

        var super_bg:BGSprite = new BGSprite('cavebg/super_bg', -1000, -300);
	    add(super_bg);

        var ground:BGSprite = new BGSprite('cavebg/ground', -1000, 900);
	    add(ground);
    
        var ceil:BGSprite = new BGSprite('cavebg/ceil', -1000, -700);
	    add(ceil);

        var cal1:BGSprite = new BGSprite('cavebg/cal1', -1000, -300);
	    add(cal1);
  
        var cal2:BGSprite = new BGSprite('cavebg/cal2', -450, -100);
	    add(cal2);

        var es1:BGSprite = new BGSprite('cavebg/es1', -950, 400);
	    add(es1);
    }
}
