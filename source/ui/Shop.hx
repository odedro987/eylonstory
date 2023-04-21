package ui;

import core.GameStorage;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import states.MenuState;
import ui.components.BowSlot;
import ui.util.SpriteButton;

class Shop extends FlxTypedGroup<FlxBasic>
{
	var items:FlxTypedGroup<BowSlot>;
	var shopUI:FlxSprite;
	var buyItem:SpriteButton;
	var leaveShop:SpriteButton;
	var itemsPerPage:Int;
	var selectedSlot:Int;

	public function new(x:Float, y:Float, itemsPerPage:Int = 5)
	{
		super(6);

		this.selectedSlot = -1;
		this.itemsPerPage = itemsPerPage;

		shopUI = new FlxSprite(x, y, AssetPaths.shop__png);
		add(shopUI);

		buyItem = new SpriteButton(x + 141, y + 14, AssetPaths.buy_item_button__png, 80, 18, () ->
		{
			if (selectedSlot == -1)
				return;

			if (GameStorage.store.playerMesos >= GameData.BOW_DATA[selectedSlot].mesosCost)
			{
				GameStorage.store.playerMesos -= GameData.BOW_DATA[selectedSlot].mesosCost;
				GameStorage.store.ownedBows.push({
					bowIndex: items.members[selectedSlot].bowIndex,
					scrollSlots: 7,
					bonusWatk: 0,
					successfulScrollCount: 0
				});
				GameStorage.save();
			}
		});
		add(buyItem);

		leaveShop = new SpriteButton(x + 141, y + 34, AssetPaths.leave_shop_button__png, 80, 18, () -> FlxG.switchState(new MenuState()));
		add(leaveShop);

		items = new FlxTypedGroup();
		for (i in 0...GameData.BOW_DATA.length)
		{
			var bow = new BowSlot(x + 5, y + 126 + 40 * (i % itemsPerPage), i, i, id ->
			{
				if (selectedSlot == id)
					return;
				items.members[id].setSelected(true);
				if (selectedSlot != -1)
				{
					items.members[selectedSlot].setSelected(false);
				}
				selectedSlot = id;
			});
			bow.exists = false;
			items.add(bow);
		}
		add(items);

		add(new Pagination(x + 20, y, items, itemsPerPage, 140));
	}
}
