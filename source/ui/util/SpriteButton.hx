package ui.util;

import flixel.FlxSprite;
import flixel.ui.FlxButton.FlxTypedButton;

class SpriteButton extends FlxTypedButton<FlxSprite>
{
	public function new(x:Float, y:Float, graphic:String, width:Int, height:Int, ?onClick:Void->Void)
	{
		super(x, y, onClick);
		loadGraphic(graphic, true, width, height);
		graphicLoaded();
	}
}
