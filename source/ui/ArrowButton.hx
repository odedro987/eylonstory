package ui;

import flixel.FlxSprite;
import flixel.ui.FlxButton.FlxTypedButton;

class ArrowButton extends FlxTypedButton<FlxSprite>
{
	public function new(x:Float, y:Float, ?onClick:Void->Void)
	{
		super(x, y, onClick);
		loadGraphic(AssetPaths.arrow__png, true, 46, 36);
		graphicLoaded();
	}
}
