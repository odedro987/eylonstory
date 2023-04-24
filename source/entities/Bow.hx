package entities;

import GameData.BowData;
import flixel.FlxSprite;

class Bow extends FlxSprite
{
	var offsets:Array<Array<Int>>;

	public function new(x:Float, y:Float, data:BowData)
	{
		super();
		offsets = data.handOffset;
		loadGraphic(data.sprite, true, data.frameWidth, data.frameHeight);
	}

	override function setPosition(x:Float = 0.0, y:Float = 0.0)
	{
		super.setPosition(x - offsets[animation.frameIndex][0], y - offsets[animation.frameIndex][1]);
	}
}
