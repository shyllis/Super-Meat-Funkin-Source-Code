import flixel.FlxG;

class Ratings {
	public static function GenerateLetterRank(accuracy:Float) {
		var ranking:String = "D";

		var wifeConditions:Array<Bool> = [
			accuracy >= 90, accuracy >= 80, accuracy >= 70, accuracy >= 60, accuracy >= 40
		];

		for (i in 0...wifeConditions.length) {
			var b = wifeConditions[i];
			if (b) {
				switch (i) {
					case 0:
						ranking = "A";
					case 1:
						ranking = "B";
					case 2:
						ranking = "C";
					case 3:
						ranking = "D";
					case 4:
						ranking = "F";
				}
				break;
			}
		}

		if (accuracy == 0)
			ranking = "F";

		return ranking;
	}

	public static function CalculateRating(noteDiff:Float, ?customSafeZone:Float):String {
		var customTimeScale = Conductor.timeScale;

		if (customSafeZone != null)
			customTimeScale = customSafeZone / 166;

		if (FlxG.save.data.botplay)
			return "good";

		if (noteDiff > 135 * customTimeScale)
			return "miss";
		else if (noteDiff > 100 * customTimeScale)
			return "shit";
		else if (noteDiff > 75 * customTimeScale)
			return "bad";
		else if (noteDiff > 30 * customTimeScale)
			return "good";
		else if (noteDiff < -30 * customTimeScale)
			return "good";
		else if (noteDiff < -75 * customTimeScale)
			return "bad";
		else if (noteDiff < -100 * customTimeScale)
			return "shit";
		else if (noteDiff < -135 * customTimeScale)
			return "miss";
		return "sick";
	}
}
