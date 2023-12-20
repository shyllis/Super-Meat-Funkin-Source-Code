import flixel.FlxG;

class KeyBinds {
	public static function resetBinds():Void {
		FlxG.save.data.upBind = "W";
		FlxG.save.data.downBind = "S";
		FlxG.save.data.leftBind = "A";
		FlxG.save.data.rightBind = "D";
		FlxG.save.data.resetBind = "R";
		PlayerSettings.player1.controls.loadKeyBinds();
	}

	public static function keyCheck():Void {
		if (FlxG.save.data.upBind == null)
			FlxG.save.data.upBind = "W";

		if (FlxG.save.data.downBind == null)
			FlxG.save.data.downBind = "S";
		
		if (FlxG.save.data.leftBind == null)
			FlxG.save.data.leftBind = "A";
			
		if (FlxG.save.data.rightBind == null)
			FlxG.save.data.rightBind = "D";
			
		if (FlxG.save.data.resetBind == null)
			FlxG.save.data.resetBind = "R";
	}
}
