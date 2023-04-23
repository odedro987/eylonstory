package ui;

import core.GameStorage;
import core.Globals;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxBitmapText;
import ui.components.InventorySlot;

class Inventory extends FlxTypedGroup<FlxBasic>
{
	var sprite:FlxSprite;
	var slots:FlxTypedGroup<InventorySlot>;
	var mesosText:FlxBitmapText;
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

		mesosText = Globals.createBitmapText(x + 52, y + 271, GameStorage.store.playerMesos + "", 1.25, false);
		add(mesosText);
	}

}
