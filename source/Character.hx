package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

using StringTools;

class Character extends FlxSprite {
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';
	public var barColor:FlxColor;
	
	public var stunned:Bool = false;
	public var dadVar:Float = 4;
	public var danceIdle:Bool = false;

	public var holdTimer:Float = 0;
	
	public var positionX:Float = 0;
	public var positionY:Float = 0;
	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false) {
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;
		antialiasing = true;

		switch (curCharacter) {
			case 'gf':
				frames = Paths.getSparrowAtlas('characters/GF_assets', 'shared');
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');

				danceIdle = true;

				barColor = 0xFFA2044B;
			case 'meatboy':
				frames = Paths.getSparrowAtlas('characters/meatboy', 'shared');
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Up', 24);
				animation.addByPrefix('singRIGHT', 'Right', 24);
				animation.addByPrefix('singDOWN', 'Down', 24);
				animation.addByPrefix('singLEFT', 'Left', 24);
				
				addOffset('idle', 249, -80);
				addOffset('singDOWN', 273, -108);
				addOffset('singRIGHT', 235, -80);
				addOffset('singUP', 235, -32);
				addOffset('singLEFT', 218, -98);
		
				playAnim('idle');
	
				setGraphicSize(Std.int(width * 0.35));
				
				positionX = -70;
				positionY = 190;
		
				barColor = 0xffce1224;
			case 'meatboyonfire':
				frames = Paths.getSparrowAtlas('characters/meatboy', 'shared');
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Up', 24);
				animation.addByPrefix('singRIGHT', 'Right', 24);
				animation.addByPrefix('singDOWN', 'Down', 24);
				animation.addByPrefix('singLEFT', 'Left', 24);
				
				addOffset('idle', 249, -80);
				addOffset('singDOWN', 273, -108);
				addOffset('singRIGHT', 235, -80);
				addOffset('singUP', 235, -32);
				addOffset('singLEFT', 218, -98);
		
				playAnim('idle');
	
				setGraphicSize(Std.int(width * 0.35));
				
				positionX = 700;
				positionY = 350;
		
				barColor = 0xffce1224;
			case 'drfetus':
				frames = Paths.getSparrowAtlas('characters/fetus', 'shared');
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Up', 24);
				animation.addByPrefix('singRIGHT', 'Right', 24);
				animation.addByPrefix('singDOWN', 'Down', 24);
				animation.addByPrefix('singLEFT', 'Left', 24);

				addOffset('idle', 249, -80);
				addOffset('singRIGHT', 248, -89);
				addOffset('singDOWN', 257, -96);
				addOffset('singLEFT', 253, -98);
				addOffset('singUP', 234, -77);
		
				playAnim('idle');
		
				setGraphicSize(Std.int(width * 0.4));

				positionX = 70;
				positionY = 150;
		
				barColor = 0xffECB0B0;
			case 'bf':
				frames = Paths.getSparrowAtlas('characters/meatbf', 'shared');
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Up', 24);
				animation.addByPrefix('singRIGHT', 'Right', 24);
				animation.addByPrefix('singDOWN', 'Down', 24);
				animation.addByPrefix('singLEFT', 'Left', 24);
				animation.addByPrefix('singUPmiss', 'MissUp', 24, false);
				animation.addByPrefix('singLEFTmiss', 'MissLeft', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'MissRight', 24, false);
				animation.addByPrefix('singDOWNmiss', 'MissDown', 24, false);
				animation.addByPrefix('scared', 'WHAT', 24);

				addOffset('scared', 2, 6);
				addOffset('singDOWN', 19, -11);
				addOffset('singRIGHTmiss', 10, 2);
				addOffset('singLEFTmiss', 18, -12);
				addOffset('singUP', 5, 44);
				addOffset('idle', -5, -10);
				addOffset('singDOWNmiss', -8, -17);
				addOffset('singRIGHT', 42, -5);
				addOffset('singUPmiss', 11, 77);
				addOffset('singLEFT', 33, -8);

				playAnim('idle');
				
				setGraphicSize(Std.int(width * 0.4));

				flipX = true;

				positionX = -150;
				positionY = -110;

				barColor = 0xFF31b0d1;
		}

		recalculateDanceIdle();
		dance();

		if (isPlayer)
			flipX = !flipX;
	}

	override function update(elapsed:Float) {
		if (!curCharacter.startsWith('bf')) {
			if (animation.curAnim.name.startsWith('sing')) {
				holdTimer += elapsed;
			}

			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001) {
				dance();
				holdTimer = 0;
			}
		}
		super.update(elapsed);
	}

	private var danced:Bool = false;

	public function dance() {
		if (danceIdle) {
			if (!animation.curAnim.name.startsWith('hair')) {
				danced = !danced;

				if (danced)
					playAnim('danceRight');
				else
					playAnim('danceLeft');
			}
	    } else
			playAnim('idle', true);
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void {
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName)) {
			offset.set(daOffset[0], daOffset[1]);
		} else
			offset.set(0, 0);

		if (curCharacter == 'gf') {
			if (AnimName == 'singLEFT') {
				danced = true;
			} else if (AnimName == 'singRIGHT') {
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN') {
				danced = !danced;
			}
		}
	}

	public var danceEveryNumBeats:Int = 2;
	private var settingCharacterUp:Bool = true;
	public function recalculateDanceIdle() {
		var lastDanceIdle:Bool = danceIdle;
		danceIdle = (animation.getByName('danceLeft') != null && animation.getByName('danceRight') != null);

		if(settingCharacterUp)
			danceEveryNumBeats = (danceIdle ? 1 : 2);
		else if(lastDanceIdle != danceIdle) {
			var calc:Float = danceEveryNumBeats;
			if(danceIdle)
				calc /= 2;
			else
				calc *= 2;

			danceEveryNumBeats = Math.round(Math.max(calc, 1));
		}

		settingCharacterUp = false;
	}
	
	public function addOffset(name:String, x:Float = 0, y:Float = 0) {
		animOffsets[name] = [x, y];
	}
}
