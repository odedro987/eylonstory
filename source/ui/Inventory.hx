package ui;

import core.GameStorage;
import core.Globals;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxBitmapText;
import ui.components.EquipedCursor;
import ui.components.InventorySlot;

class Inventory extends FlxTypedGroup<FlxBasic>
{
	var sprite:FlxSprite;
	var slots:FlxTypedGroup<InventorySlot>;
	var mesosText:FlxBitmapText;
	var equipedCursor:EquipedCursor;
	var lastClickedSlot:Int;
	var checkDoubleClick:Bool;
	var clickTimer:Float;

	public function new(x:Float, y:Float)
	{
		super();

		sprite = new FlxSprite(x, y, AssetPaths.inventory__png);
		add(sprite);

		slots = new FlxTypedGroup(24);
		for (i in 0...GameStorage.store.ownedBows.length)
		{
			var data = GameStorage.store.ownedBows[i];
			var slot = new InventorySlot(x + 4 + (i % 4) * 36, y + 46 + Math.floor(i / 4) * 34, {
				bowIndex: data.bowIndex,
				scrollSlots: data.scrollSlots,
				successfulScrollCount: data.successfulScrollCount,
				bonusWatk: data.bonusWatk
			});
			slots.add(slot);
		}
		add(slots);

		equipedCursor = new EquipedCursor(x, y);
		setEquippedCursorPosition(GameStorage.store.playerCurrentBow);
		add(equipedCursor);

		mesosText = Globals.createBitmapText(x + 52, y + 271, GameStorage.store.playerMesos + "", 1.25, false);
		add(mesosText);
	}

	function setEquippedCursorPosition(index:Int)
	{
		var pos = slots.members[index].getPosition();
		equipedCursor.setPosition(pos.x + 2, pos.y + 2);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (checkDoubleClick)
			clickTimer += elapsed;

		if (clickTimer > 1)
		{
			clickTimer = 0;
			checkDoubleClick = false;
			lastClickedSlot = -1;
		}

		if (FlxG.mouse.justPressed)
		{
			for (i in 0...slots.members.length)
			{
				var hasPoints = GameData.BOW_DATA[GameStorage.store.ownedBows[i].bowIndex].pointsReq <= GameStorage.store.totalPoints;
				if (!hasPoints)
					continue;
				if (FlxG.mouse.overlaps(slots.members[i]))
				{
					if (lastClickedSlot == i && clickTimer > 0)
					{
						setEquippedCursorPosition(lastClickedSlot);
						GameStorage.store.playerCurrentBow = lastClickedSlot;
						GameStorage.save();
						clickTimer = 0;
						checkDoubleClick = false;
						lastClickedSlot = -1;
						break;
					}
					lastClickedSlot = i;
					checkDoubleClick = true;
					break;
				}
			}
		}
	}
}
