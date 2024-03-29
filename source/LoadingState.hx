package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.graphics.FlxGraphic;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.utils.Assets;
import sys.thread.Thread;

using StringTools;

//totally not stolen from indie cock (cross)

class LoadingState extends MusicBeatState {
	public static var target:FlxState;
	public static var stopMusic = false;
	static var imagesToCache:Array<String> = [];
	static var soundsToCache:Array<String> = [];

	var screen:LoadingScreen;

	public function new() {
		super();
	}

	override function create() {
		super.create();

		screen = new LoadingScreen();
		add(screen);

		for (image in Assets.list(IMAGE)) {
			var library = image.startsWith('assets/shared') ? 'shared' : '';

			if (image.startsWith('assets/shared/images/characters') || image.startsWith('assets/shared/images/bgs') || image.startsWith('assets/shared/images/ranks'))
				imagesToCache.push(Paths.getPath(StringTools.replace(image, 'assets/shared/', ''), IMAGE, library));
			else if (image.startsWith('assets/images/icons'))
				imagesToCache.push(image);
		}

		for (sound in Assets.list(SOUND)) {
			var library = sound.startsWith('assets/shared') ? 'shared' : '';

			if (sound.startsWith('assets/shared/sounds'))
				soundsToCache.push(Paths.getPath(StringTools.replace(sound, 'assets/shared/', ''), SOUND, library));
			else if (sound.startsWith('assets/sounds'))
				soundsToCache.push(sound);
		}

		screen.max = soundsToCache.length + imagesToCache.length;

		FlxG.camera.fade(FlxG.camera.bgColor, 0.5, true);

		FlxGraphic.defaultPersist = true;
		Thread.create(() -> 
		{
			screen.setLoadingText("Loading images...");
			for (image in imagesToCache) {
				FlxG.bitmap.add(image);
				screen.progress += 1;
			}
			
			screen.setLoadingText("Loading sounds...");
			for (sound in soundsToCache) {
				FlxG.sound.cache(sound);
				screen.progress += 1;
			}
			
			FlxGraphic.defaultPersist = false;
			screen.setLoadingText("Done!");
			
			FlxG.camera.fade(FlxColor.BLACK, 1, false);
			new FlxTimer().start(1, function(_:FlxTimer) {
				screen.kill();
				screen.destroy();
				loadAndSwitchState(target, false);
			});
		});
	}	
	
	public static function loadAndSwitchState(target:FlxState, stopMusic = false) {
		Paths.setCurrentLevel("week" + PlayState.storyWeek);

		if (stopMusic && FlxG.sound.music != null)
			FlxG.sound.music.stop();
		Main.dumping = false;
		FlxG.switchState(target);
	}
}