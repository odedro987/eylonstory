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
	var untradableText:FlxBitmapText;
	var spriteBG:FlxSprite;
	var sprite:FlxSprite;
	var pointsReqText:FlxBitmapText;
	var watkText:FlxBitmapText;
	var upgradesLeftText:FlxBitmapText;

	var yOffset:Int;

	public function new(x:Float, y:Float, data:BowSlotData)
	{
		super();

		var bData = GameData.BOW_DATA[data.bowIndex];
		yOffset = bData.untradable ? 20 : 0;

		bg = new FlxSprite(x, y);
		bg.makeGraphic(240, 115 + yOffset, 0xc421098d);
		add(bg);

		var isLong = bData.name.length > 18;
		nameText = Globals.createBitmapText(x + (isLong ? 110 : 60), y + 10, bData.name, isLong ? 1.5 : 2, false);
		if (data.successfulScrollCount > 0)
		{
			nameText.text += "(+" + data.successfulScrollCount + ")";
		}
		add(nameText);

		untradableText = Globals.createBitmapText(x + bg.width / 2, y + 25, "<--UNTRADABLE-->", 1);
		untradableText.color = 0xffd4671f;
		if (bData.untradable)
		{
			add(untradableText);
		}

		spriteBG = new FlxSprite(x + 8, y + yOffset + 30);
		spriteBG.makeGraphic(76, 76, 0xa1ffffff);
		add(spriteBG);

		sprite = new FlxSprite(x + 8 + 19, y + yOffset + 30 + 19, bData.icon);
		sprite.scale.set(2, 2);
		add(sprite);

		pointsReqText = Globals.createBitmapText(x + 90, y + yOffset + 30, "REQUIRED POINTS : " + bData.pointsReq, 1, false);
		if (GameStorage.store.totalPoints < bData.pointsReq)
		{
			pointsReqText.color = 0xffbd0404;
		}
		add(pointsReqText);

		watkText = Globals.createBitmapText(x + 90, y + yOffset + 45, "WEAPON ATTACK : " + (bData.weaponAttack + data.bonusWatk), 1, false);
		add(watkText);

		upgradesLeftText = Globals.createBitmapText(x + 90, y + yOffset + 60, "UPGRADES AVAILABLE : " + (data.scrollSlots - data.successfulScrollCount), 1,
			false);
		add(upgradesLeftText);
	}

	public function setPosition(x:Float, y:Float)
	{
		bg.setPosition(x, y);
		var isLong = nameText.text.length > 18;
		nameText.setPosition(x + (isLong ? 60 : 110), y + 10);
		untradableText.setPosition(x + bg.width / 2 - untradableText.fieldWidth / 2, y + 25);
		spriteBG.setPosition(x + 8, y + yOffset + 30);
		sprite.setPosition(x + 8 + 19, y + yOffset + 30 + 19);
		pointsReqText.setPosition(x + 90, y + yOffset + 30);
		watkText.setPosition(x + 90, y + yOffset + 45);
		upgradesLeftText.setPosition(x + 90, y + yOffset + 60);
	}
}
