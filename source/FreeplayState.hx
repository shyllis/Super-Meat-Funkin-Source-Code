package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.util.FlxColor;
#if windows
import Discord.DiscordClient;
#end

using StringTools;

class FreeplayState extends MusicBeatState {
	var songName:String = 'Meat';

	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	var bg:FlxSprite;
	var barThing:FlxSprite;
	var songOneBanner:FlxSprite;
	var songTwoBanner:FlxSprite;

	var balls:Bool = false;

	override function create() {
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		#if windows
		DiscordClient.changePresence("Freeplay Menu", null);
		#end

		if (!FlxG.sound.music.playing) {
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			FlxG.sound.music.time = 3000;
		}

		bg = new FlxSprite().loadGraphic(Paths.image('daMeatBG'));
		add(bg);
		
		barThing = new FlxSprite().loadGraphic(Paths.image('freeplay/barThingy'));
		barThing.updateHitbox();
		barThing.screenCenter();
		add(barThing);

		songOneBanner = new FlxSprite().loadGraphic(Paths.image('freeplay/song1banner'));
		songOneBanner.updateHitbox();
		songOneBanner.screenCenter();
		add(songOneBanner);

		songTwoBanner = new FlxSprite().loadGraphic(Paths.image('freeplay/song2banner'));
		songTwoBanner.updateHitbox();
		songTwoBanner.screenCenter();
		add(songTwoBanner);

		scoreText = new FlxText(30, 24, 0, "PERSONAL BEST: 0", 32);
		scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
		scoreText.screenCenter(X);
		add(scoreText);

		diffText = new FlxText(0, scoreText.y + 36, 0, "HARD", 24);
		diffText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER);
		add(diffText);

		changeSelection();

		super.create();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		scoreText.screenCenter(X);
		diffText.screenCenter(X);

		if (FlxG.sound.music.volume < 0.7)
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.4));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		scoreText.text = "PERSONAL BEST:" + lerpScore;

		if (controls.LEFT_P || controls.RIGHT_P)
			changeSelection();

		if (controls.BACK)
			FlxG.switchState(new MainMenuState());

		if (controls.ACCEPT) {
			var songLowercase:String = songName.toLowerCase();

			PlayState.SONG = Song.loadFromJson(songLowercase, songLowercase);
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = 0;
			PlayState.storyWeek = 0;
			FlxG.switchState(new PlayState());
		}
	}

	function changeSelection() {
		balls = !balls;

		if (balls) {
			songName = 'Meat';
			songOneBanner.alpha = 1;
			songTwoBanner.alpha = 0.5;
		} else {
			songName = 'Song2';
			songOneBanner.alpha = 0.5;
			songTwoBanner.alpha = 1;
		}

		var songHighscore = StringTools.replace(songName, " ", "-");

		#if !switch
		intendedScore = Highscore.getScore(songHighscore, 0);
		#end
	}
}