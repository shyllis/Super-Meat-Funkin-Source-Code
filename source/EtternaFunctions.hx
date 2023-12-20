class EtternaFunctions {
	public static var a1 = 0.254829592;
	public static var a2 = -0.284496736;
	public static var a3 = 1.421413741;
	public static var a4 = -1.453152027;
	public static var a5 = 1.061405429;
	public static var p = 0.3275911;

	public static function erf(x:Float):Float {
		var sign = 1;
		if (x < 0)
			sign = -1;
		x = Math.abs(x);

		var t = 1.0 / (1.0 + p * x);
		var y = 1.0 - (((((a5 * t + a4) * t) + a3) * t + a2) * t + a1) * t * Math.exp(-x * x);

		return sign * y;
	}

	public static function getNotes():Int {
		var notes:Int = 0;
		for (i in 0...PlayState.SONG.notes.length) {
			for (ii in 0...PlayState.SONG.notes[i].sectionNotes.length) {
				var n = PlayState.SONG.notes[i].sectionNotes[ii];
				if (n[1] <= 0)
					notes++;
			}
		}
		return notes;
	}

	public static function getHolds():Int {
		var notes:Int = 0;
		for (i in 0...PlayState.SONG.notes.length) {
			for (ii in 0...PlayState.SONG.notes[i].sectionNotes.length) {
				var n = PlayState.SONG.notes[i].sectionNotes[ii];
				
				if (n[1] > 0)
					notes++;
			}
		}
		return notes;
	}

	public static function getMapMaxScore():Int {
		return (getNotes() * 350);
	}

	public static function wife3(maxms:Float, ts:Float) {
		var max_points = 1.0;
		var miss_weight = -5.5;
		var ridic = 5 * ts;
		var max_boo_weight = 180 * ts;
		var ts_pow = 0.75;
		var zero = 65 * (Math.pow(ts, ts_pow));
		var power = 2.5;
		var dev = 22.7 * (Math.pow(ts, ts_pow));

		if (maxms <= ridic)
			return max_points;
		else if (maxms <= zero)
			return max_points * erf((zero - maxms) / dev);
		else if (maxms <= max_boo_weight)
			return (maxms - zero) * miss_weight / (max_boo_weight - zero);
		else
			return miss_weight;
	}
}
