package ui;

import entities.Mob;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class Indicator extends FlxTypedGroup<FlxSprite>
{
	var start:FlxSprite;
	var end:FlxSprite;
	var indicator:FlxSprite;

	var repel:Float;
	var isDragged:Bool;

	var follow:Mob;

	public function new(width:Int = 500)
	{
		super();

		start = new FlxSprite(120, 390, AssetPaths.sword_indicator__png);
		add(start);
		end = new FlxSprite(120 + width, 390, AssetPaths.sword_indicator__png);
		add(end);
		indicator = new FlxSprite(120 + width, 390, AssetPaths.sword_indicator__png);
		add(indicator);

		isDragged = false;
		repel = 0;
	}

	public function setFollow(mob:Mob)
	{
		follow = mob;
		isDragged = true;
	}

	public function getX()
	{
		return indicator.x;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!isDragged && indicator.x < end.x)
		{
			indicator.x += 20 * elapsed;
		}

		if (isDragged)
		{
			if (follow.exists)
			{
				indicator.x = follow.x;
			}
			else
			{
				follow = null;
				isDragged = false;
			}
		}

		repel = (indicator.x - start.x) / (end.x - start.x);
	}
}
