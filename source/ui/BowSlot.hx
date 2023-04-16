package ui;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxBitmapText;

class BowSlot extends FlxTypedGroup<FlxSprite>
{
	var bowSprite:FlxSprite;
	var slotSprite:FlxSprite;
	var nameText:FlxBitmapText;
	var mesosText:FlxBitmapText;

	public function new(x:Float, y:Float, bowIndex:Int)
	{
		super(4);

		slotSprite = new FlxSprite(x, y);
		slotSprite.loadGraphic(AssetPaths.item_slot__png, true, 199, 35);
		add(slotSprite);

		bowSprite = new FlxSprite(x, y, GameData.BOW_DATA[bowIndex].sprite);
		add(bowSprite);

		nameText = Globals.createBitmapText(x + 70, y + 5, GameData.BOW_DATA[bowIndex].name, 1.25, false);
		add(nameText);

		mesosText = Globals.createBitmapText(x + 85, y + 25, GameData.BOW_DATA[bowIndex].mesosCost + " Mesos", 1.25, false);
		add(mesosText);
	}
}
