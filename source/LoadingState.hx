package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.utils.Assets;
import sys.thread.Thread;

using StringTools;

class LoadingState extends MusicBeatState
{
	public static var target:FlxState;
	public static var stopMusic = false;
	static var imagesToCache:Array<String> = [];

	var screen:LoadingScreen;

	public function new()
	{
		super();
	}

	override function create()
	{
		super.create();

		screen = new LoadingScreen();
		add(screen);

		screen.max = imagesToCache.length;

		for (image in Assets.list(IMAGE))
		{
			var library = image.startsWith('assets/shared') ? 'shared' : '';
			if (image.startsWith('assets/shared'))
				library = 'shared';

			if (image.startsWith('assets/shared/images/characters') 
				|| image.startsWith('assets/shared/images/bgs'))
				imagesToCache.push(Paths.getPath(StringTools.replace(image, 'assets/shared/', ''), IMAGE, library));
			else if (image.startsWith('assets/images/icons'))
					imagesToCache.push(image);
			}

		FlxG.camera.fade(FlxG.camera.bgColor, 0.5, true);

		FlxGraphic.defaultPersist = true;
		Thread.create(() ->
		{
			for (image in imagesToCache)
			{
				screen.setLoadingText("Loading images..." + image);
				trace("Caching image " + image);
				FlxG.bitmap.add(image);
				screen.progress += 1;
			}
			FlxGraphic.defaultPersist = false;
			screen.setLoadingText("Done!");
			trace("Done caching");
			
			FlxG.camera.fade(FlxColor.BLACK, 1, false);
			new FlxTimer().start(1, function(_:FlxTimer)
			{
				screen.kill();
				screen.destroy();
				loadAndSwitchState(target, false);
			});
		});
	}

	public static function loadAndSwitchState(target:FlxState, stopMusic = false)
	{
		Paths.setCurrentLevel("week" + PlayState.storyWeek);

		if (stopMusic && FlxG.sound.music != null)
			FlxG.sound.music.stop();
		Main.dumping = false;
		FlxG.switchState(target);
	}
}