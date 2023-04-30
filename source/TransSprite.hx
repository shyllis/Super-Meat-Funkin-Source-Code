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
    var black:FlxSprite;

	public function new(type:String) {
		super();
        saw = new FlxSprite().loadGraphic('transition/saw.png');
        saw.setGraphicSize(Std.int(saw.width * 4));
        saw.color = FlxColor.BLACK;
		saw.antialiasing = true;

        cube = new FlxSprite(1200, 600).loadGraphic('transition/cube.png');
        cube.color = FlxColor.BLACK;
		cube.antialiasing = true;

        black = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        add(black);

        switch (type) {
            case 'in':
                add(saw);
                add(cube);
                saw.y = -1000;
                saw.screenCenter(X);
                black.alpha = 0.0001;
                FlxTween.tween(saw, {y: -300}, 0.4);
                FlxTween.tween(cube, {x: 650}, 0.4);
                new FlxTimer().start(0.4, function(tmr:FlxTimer)
                    black.alpha = 1);
            case 'out':
                add(saw);
                saw.screenCenter();
                FlxTween.tween(black, {alpha: 0}, 0.2);
                FlxTween.tween(saw, {y: 2000}, 0.4);
                new FlxTimer().start(0.4, function(tmr:FlxTimer) {close();} );
            case 'gamein':
                add(saw);
                saw.screenCenter(Y);
                saw.x = -1010;
                black.alpha = 0.0001;
                FlxTween.tween(saw, {x: 470}, 0.4);
                new FlxTimer().start(0.4, function(tmr:FlxTimer)
                    black.alpha = 1);
            case 'gameout':
                add(saw);
                saw.screenCenter();
                FlxTween.tween(black, {alpha: 0}, 0.2);
                FlxTween.tween(saw, {x: 2000}, 0.4);
                new FlxTimer().start(0.4, function(tmr:FlxTimer) {close();} );
            case 'indamned':
                add(saw);
                add(cube);
                cube.y = 700;
                saw.y = -1000;
                saw.screenCenter(X);
                black.alpha = 0.0001;
                FlxTween.tween(saw, {y: -300}, 0.4);
                FlxTween.tween(cube, {x: 650}, 0.4);
                new FlxTimer().start(0.4, function(tmr:FlxTimer)
                    black.alpha = 1);
            default:
                FlxTween.tween(black, {alpha: 0}, 0.4);
                new FlxTimer().start(0.4, function(tmr:FlxTimer) {close();} );
        }

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
