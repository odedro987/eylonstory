package ui.components;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import ui.components.BowSlot.BowSlotData;

class InventorySlot extends FlxTypedGroup<FlxBasic>
{
	var slot:FlxSprite;
	var bowSlot:BowSlot;

	public function new(x:Float, y:Float, data:BowSlotData)
	{
		super();

		slot = new FlxSprite(x, y, AssetPaths.inventory_slot__png);
		add(slot);

		bowSlot = new BowSlot(x, y, data);
		add(bowSlot);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
