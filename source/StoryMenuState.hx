package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
#if windows
import Discord.DiscordClient;
#end
import flixel.graphics.FlxGraphic;

using StringTools;

class StoryMenuState extends MusicBeatState {
	var weekData:Array<Dynamic> = [['Meat', 'Song2']];
	
	var scoreText:FlxText;
	var diffText:FlxText;
	var storyText:FlxText;
	var banner:FlxSprite;

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;
	
	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	override function create() {
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();

		#if windows
		DiscordClient.changePresence("Story Mode Menu", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (!FlxG.sound.music.playing) {
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			FlxG.sound.music.time = 3000;
		}

		persistentUpdate = persistentDraw = true;

		scoreText = new FlxText(10, 24, 0, "SCORE: 49324858", 32);
		scoreText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		scoreText.screenCenter(X);
		add(scoreText);

		diffText = new FlxText(0, scoreText.y + 36, 0, "HARD", 24);
		diffText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER);
		diffText.screenCenter(X);
		add(diffText);

		banner = new FlxSprite().loadGraphic(Paths.image('storymenu/banner'));
		banner.updateHitbox();
		banner.screenCenter();
		add(banner);

		storyText = new FlxText(0, FlxG.height * 0.94, 0, "< Meatboy >", 24);
		storyText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER);
		storyText.screenCenter(X);
		add(storyText);

		#if !switch
		intendedScore = Highscore.getWeekScore(0, 0);
		#end

		super.create();
	}

	override function update(elapsed:Float) {
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.5));

		scoreText.text = "WEEK SCORE:" + lerpScore;
		
		scoreText.screenCenter(X);
		diffText.screenCenter(X);
		
		if (!movedBack) {
			if (controls.ACCEPT)
				selectWeek();
		}

		if (controls.BACK && !movedBack && !selectedWeek) {
			movedBack = true;
			FlxG.switchState(new MainMenuState());
		}

		super.update(elapsed);
	}

	function selectWeek() {
		if (stopspamming == false) {
			FlxG.sound.play(Paths.sound('confirmMenu'));

			FlxFlicker.flicker(storyText, 1, 0.06, false, false);
			stopspamming = true;
		}

		selectedWeek = true;
		PlayState.storyPlaylist = weekData[0];
		PlayState.isStoryMode = true;
		PlayState.storyDifficulty = 0;
		PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0], " ", "-").toLowerCase(),
			StringTools.replace(PlayState.storyPlaylist[0], " ", "-").toLowerCase());
		PlayState.storyWeek = 0;
		PlayState.campaignScore = 0;
		new FlxTimer().start(1, function(tmr:FlxTimer) {FlxG.switchState(new PlayState()); });
	}
}
