package ui.components;

import flixel.FlxSprite;

class EquipedCursor extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic(AssetPaths.equip_cursor__png, true, 34, 34);
		animation.add("move", [0, 1], 4);
		animation.play("move");
	}
}
