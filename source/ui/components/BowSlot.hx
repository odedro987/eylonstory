package ui.components;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

typedef BowSlotData =
{
	var bowIndex:Int;
	var scrollSlots:Int;
	var successfulScrollCount:Int;
	var bonusWatk:Int;
}

class BowSlot extends FlxTypedGroup<FlxBasic>
{
	var sprite:FlxSprite;
	var tooltip:BowTooltip;

	public function new(x:Float, y:Float, data:BowSlotData)
	{
		super();

		sprite = new FlxSprite(x, y, GameData.BOW_DATA[data.bowIndex].sprite);
		add(sprite);

		tooltip = new BowTooltip(x, y, data);
		tooltip.exists = false;
		tooltip.camera = FlxG.cameras.list[1];
		add(tooltip);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.overlaps(sprite))
		{
			tooltip.exists = true;
			tooltip.setPosition(FlxG.mouse.x + 16, FlxG.mouse.y);
		}
		else
		{
			tooltip.exists = false;
		}
	}
}
