package core;

import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText.FlxTextBorderStyle;

class Globals
{
	// Metadata
	public static inline var GAME_VERSION = "0.2.0";

	// Mob vars
	public static inline var FLICH_TIME = 0.5;

	// Player vars
	public static inline var MAX_FORCE = 700;
	public static inline var MIN_FORCE = 200;

	// Font
	public static var fontXNA:FlxBitmapFont;

	public static function createBitmapText(x:Float, y:Float, text:String, size:Float = 1, autoSize:Bool = true)
	{
		var bitmapText = new FlxBitmapText(fontXNA);
		bitmapText.setPosition(x, y);
		bitmapText.text = text;
		bitmapText.fieldWidth = 200;
		bitmapText.scale.set(size, size);
		bitmapText.autoSize = autoSize;
		bitmapText.setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xff000000, 1);
		return bitmapText;
	}
}
