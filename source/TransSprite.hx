package;

import flixel.FlxG;
import flixel.FlxSprite;
import flash.display.Graphics;
import flixel.FlxSubState;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class TransSprite extends FlxSubState {

    var saw:FlxSprite;
    var cube:FlxSprite;

	public function new() {
		super();
        saw = new FlxSprite().loadGraphic('transition/saw.png');
        saw.setGraphicSize(Std.int(saw.width * 4));
        saw.y = -1000;
        saw.screenCenter(X);
        saw.color = FlxColor.BLACK;
        add(saw);

        cube = new FlxSprite(1200, 600).loadGraphic('transition/cube.png');
        cube.color = FlxColor.BLACK;
        add(cube);

        var black:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        black.alpha = 0.0001;
        add(black);

        FlxTween.tween(saw, {y: -300}, 0.5);
        FlxTween.tween(cube, {x: 575}, 0.5);
        new FlxTimer().start(0.5, function(tmr:FlxTimer)
            black.alpha = 1);
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
       
        saw.angle += 5;
	}

	override function destroy() {
		super.destroy();
	}
}
