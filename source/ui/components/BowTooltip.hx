package ui.components;

import core.GameStorage;
import core.Globals;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxBitmapText;
import ui.components.BowSlot.BowSlotData;

class BowTooltip extends FlxTypedGroup<FlxSprite>
{
	var bg:FlxSprite;
	var nameText:FlxBitmapText;
	var spriteBG:FlxSprite;
	var sprite:FlxSprite;
	var pointsReqText:FlxBitmapText;
	var watkText:FlxBitmapText;
	var upgradesLeftText:FlxBitmapText;

	public function new(x:Float, y:Float, data:BowSlotData)
	{
		super();

		var bData = GameData.BOW_DATA[data.bowIndex];

		bg = new FlxSprite(x, y);
		bg.makeGraphic(240, 115, 0xc421098d);
		add(bg);

		var isLong = bData.name.length > 18;
		nameText = Globals.createBitmapText(x + (isLong ? 110 : 60), y + 10, bData.name, isLong ? 1.5 : 2, false);
		if (data.successfulScrollCount > 0)
		{
			nameText.text += "(+" + data.successfulScrollCount + ")";
		}
		add(nameText);

		spriteBG = new FlxSprite(x + 8, y + 30);
		spriteBG.makeGraphic(76, 76, 0xa1ffffff);
		add(spriteBG);

		sprite = new FlxSprite(x + 8 + 19, y + 30 + 19, bData.sprite);
		sprite.scale.set(2, 2);
		add(sprite);

		pointsReqText = Globals.createBitmapText(x + 90, y + 30, "REQUIRED POINTS : " + bData.pointsReq, 1, false);
		if (GameStorage.store.totalPoints < bData.pointsReq)
		{
			pointsReqText.color = 0xffbd0404;
		}
		add(pointsReqText);

		watkText = Globals.createBitmapText(x + 90, y + 45, "WEAPON ATTACK : " + (bData.weaponAttack + data.bonusWatk), 1, false);
		add(watkText);

		upgradesLeftText = Globals.createBitmapText(x + 90, y + 60, "UPGRADES AVAILABLE : " + (data.scrollSlots - data.successfulScrollCount), 1, false);
		add(upgradesLeftText);
	}

	public function setPosition(x:Float, y:Float)
	{
		bg.setPosition(x, y);
		var isLong = nameText.text.length > 18;
		nameText.setPosition(x + (isLong ? 60 : 110), y + 10);
		spriteBG.setPosition(x + 8, y + 30);
		sprite.setPosition(x + 8 + 19, y + 30 + 19);
		pointsReqText.setPosition(x + 90, y + 30);
		watkText.setPosition(x + 90, y + 45);
		upgradesLeftText.setPosition(x + 90, y + 60);
	}
}
