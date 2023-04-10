import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText.FlxTextBorderStyle;

class Globals
{
	// Mob vars
	public static inline var FLICH_TIME = 0.5;

	// Player vars
	public static inline var MAX_FORCE = 600;

	// Font
	public static var fontXNA:FlxBitmapFont;

	public static inline function createBitmapText(x:Float, y:Float, text:String, size:Float = 1, autoSize:Bool = true)
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
