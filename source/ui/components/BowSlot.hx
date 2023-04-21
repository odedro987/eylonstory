package ui.components;

import core.Globals;
import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxBitmapText;
import flixel.ui.FlxButton.FlxTypedButton;

class BowSlot extends FlxTypedGroup<FlxSprite>
{
	var button:FlxTypedButton<FlxSprite>;
	var bowSprite:FlxSprite;
	var slotSprite:FlxSprite;
	var nameText:FlxBitmapText;
	var mesosText:FlxBitmapText;

	var id:Int;

	public var bowIndex:Int;

	public function new(x:Float, y:Float, id:Int, bowIndex:Int, ?onClick:Int->Void)
	{
		super(5);

		this.id = id;
		this.bowIndex = bowIndex;

		slotSprite = new FlxSprite(x, y);
		slotSprite.loadGraphic(AssetPaths.item_slot__png, true, 199, 35);

		button = new FlxTypedButton(x, y, () ->
		{
			onClick(id);
		});
		button.setSize(slotSprite.frameWidth, slotSprite.frameHeight);
		add(button);

		add(slotSprite);

		bowSprite = new FlxSprite(x, y, GameData.BOW_DATA[bowIndex].sprite);
		add(bowSprite);

		nameText = Globals.createBitmapText(x + 70, y + 5, GameData.BOW_DATA[bowIndex].name, 1.25, false);
		add(nameText);

		mesosText = Globals.createBitmapText(x + 85, y + 25, GameData.BOW_DATA[bowIndex].mesosCost + " Mesos", 1.25, false);
		add(mesosText);
	}

	public function setSelected(flag:Bool)
	{
		slotSprite.animation.frameIndex = flag ? 1 : 0;
	}
}
