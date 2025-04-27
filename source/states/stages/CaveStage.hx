package states.stages;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import states.PlayState;
import states.stages.objects.*;

class CaveStage extends BaseStage
{
    var bg:FlxSprite;
    var superBg:FlxSprite;
    var es1:FlxSprite;
    var cal1:FlxSprite;
    var cal2:FlxSprite;
    var ground:FlxSprite;
    var ceil:FlxSprite;

    override function create()
    {
        super.create();

        superBg = new FlxSprite().loadGraphic(Paths.image('cavebg/super_bg'));
        superBg.scrollFactor.set(0.1, 0.1);
        add(superBg);

        bg = new FlxSprite().loadGraphic(Paths.image('cavebg/bg'));
        bg.scrollFactor.set(0.3, 0.3);
        add(bg);

        es1 = new FlxSprite().loadGraphic(Paths.image('cavebg/es1'));
        es1.scrollFactor.set(0.6, 0.6);
        add(es1);

        cal2 = new FlxSprite().loadGraphic(Paths.image('cavebg/cal2'));
        cal2.scrollFactor.set(0.5, 0.5);
        add(cal2);

        cal1 = new FlxSprite().loadGraphic(Paths.image('cavebg/cal1'));
        cal1.scrollFactor.set(0.7, 0.7);
        add(cal1);

        ceil = new FlxSprite().loadGraphic(Paths.image('cavebg/ceil'));
        ceil.scrollFactor.set(0.1, 0.1);
        ceil.y = -FlxG.height * 0.1;
        add(ceil);

        ground = new FlxSprite().loadGraphic(Paths.image('cavebg/ground'));
        ground.scrollFactor.set(0.8, 0.8);
        add(ground);
    }
}
