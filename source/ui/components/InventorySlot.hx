package ui.components;

import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import ui.components.BowSlot.BowSlotData;

class InventorySlot extends FlxTypedGroup<FlxBasic>
{
	var slot:FlxSprite;
	var bowSlot:BowSlot;

	var x:Float;
	var y:Float;

	public function new(x:Float, y:Float, data:BowSlotData)
	{
		super();

		this.x = x;
		this.y = y;

		slot = new FlxSprite(x, y, AssetPaths.inventory_slot__png);
		add(slot);

		bowSlot = new BowSlot(x, y, data);
		add(bowSlot);
	}

	public function getPosition()
	{
		return FlxPoint.get(x, y);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
