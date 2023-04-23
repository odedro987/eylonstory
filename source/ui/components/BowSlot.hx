package ui.components;

import core.Globals;
import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
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
	var x:Float;
	var y:Float;

	public var bowIndex:Int;

	public function new(x:Float, y:Float, id:Int, bowIndex:Int, mesosMultiplier:Float, ?onClick:Int->Void)
	{
		super(5);

		this.x = x;
		this.y = y;
		this.id = id;
		this.bowIndex = bowIndex;

		slotSprite = new FlxSprite(x, y);
		slotSprite.loadGraphic(AssetPaths.shop_slot__png, true, 199, 35);

		button = new FlxTypedButton(x, y, () ->
		{
			setSelected(true);
			onClick(id);
		});
		button.setSize(slotSprite.frameWidth, slotSprite.frameHeight);
		add(button);

		add(slotSprite);

		bowSprite = new FlxSprite(x, y, GameData.BOW_DATA[bowIndex].sprite);
		add(bowSprite);

		nameText = Globals.createBitmapText(x + 70, y + 5, GameData.BOW_DATA[bowIndex].name, 1.25, false);
		add(nameText);

		mesosText = Globals.createBitmapText(x + 85, y + 25, GameData.BOW_DATA[bowIndex].mesosCost * mesosMultiplier + " Mesos", 1.25, false);
		add(mesosText);
	}

	public function setSelected(flag:Bool)
	{
		slotSprite.animation.frameIndex = flag ? 1 : 0;
	}

	public function getPosition()
	{
		return FlxPoint.get(x, y);
	}

	public function setPosition(x:Float, y:Float)
	{
		slotSprite.setPosition(x, y);
		button.setPosition(x, y);
		bowSprite.setPosition(x, y);
		nameText.setPosition(x, y);
		mesosText.setPosition(x, y);
	}
}
