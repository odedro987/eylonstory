package ui;

import core.GameStorage;
import core.Globals;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxBitmapText;
import states.MenuState;
import ui.components.BowSlot;
import ui.util.SpriteButton;

class Shop extends FlxTypedGroup<FlxBasic>
{
	var shopItems:FlxTypedGroup<BowSlot>;
	var shopPagination:Pagination<BowSlot>;
	var inventoryItems:FlxTypedGroup<BowSlot>;
	var inventoryPagination:Pagination<BowSlot>;
	var shopUI:FlxSprite;
	var buyItem:SpriteButton;
	var sellItem:SpriteButton;
	var leaveShop:SpriteButton;
	var mesosText:FlxBitmapText;
	var itemsPerPage:Int;
	var selectedShopSlot:Int;
	var selectedInventorySlot:Int;
	var x:Float;
	var y:Float;

	public function new(x:Float, y:Float, itemsPerPage:Int = 5)
	{
		super(9);

		this.x = x;
		this.y = y;
		this.selectedShopSlot = -1;
		this.selectedInventorySlot = -1;
		this.itemsPerPage = itemsPerPage;

		shopUI = new FlxSprite(x, y, AssetPaths.shop_extended__png);
		add(shopUI);

		buyItem = new SpriteButton(x + 141, y + 14, AssetPaths.buy_item_button__png, 80, 18, () ->
		{
			if (selectedShopSlot == -1)
				return;

			if (GameStorage.store.playerMesos >= GameData.BOW_DATA[selectedShopSlot].mesosCost)
			{
				GameStorage.store.playerMesos -= GameData.BOW_DATA[selectedShopSlot].mesosCost;
				GameStorage.store.ownedBows.push({
					bowIndex: shopItems.members[selectedShopSlot].bowIndex,
					scrollSlots: 7,
					bonusWatk: 0,
					successfulScrollCount: 0
				});
				mesosText.text = GameStorage.store.playerMesos + "";
				GameStorage.save();
				// Reset selection
				shopItems.members[selectedShopSlot].setSelected(false);
				selectedShopSlot = -1;
				rerenderInventory();
			}
		});
		add(buyItem);

		sellItem = new SpriteButton(x + 371, y + 34, AssetPaths.sell_item_button__png, 80, 18, () ->
		{
			if (selectedInventorySlot == -1)
				return;

			var bowIndex = GameStorage.store.ownedBows[selectedInventorySlot].bowIndex;
			GameStorage.store.playerMesos += Math.floor(GameData.BOW_DATA[bowIndex].mesosCost / 2);
			GameStorage.store.ownedBows.remove(GameStorage.store.ownedBows[selectedInventorySlot]);
			inventoryItems.remove(inventoryItems.members[selectedInventorySlot]);
			mesosText.text = GameStorage.store.playerMesos + "";
			GameStorage.save();
			// Reset selection
			selectedInventorySlot = -1;
			rerenderInventory();
		});
		add(sellItem);

		leaveShop = new SpriteButton(x + 141, y + 34, AssetPaths.leave_shop_button__png, 80, 18, () -> FlxG.switchState(new MenuState()));
		add(leaveShop);

		shopItems = new FlxTypedGroup();
		for (i in 0...GameData.BOW_DATA.length)
		{
			var bow = new BowSlot(x + 5, y + 126 + 40 * (i % itemsPerPage), i, i, 1, id ->
			{
				if (selectedShopSlot == id)
					return;
				shopItems.members[id].setSelected(true);
				if (selectedShopSlot != -1)
				{
					shopItems.members[selectedShopSlot].setSelected(false);
				}
				selectedShopSlot = id;
			});
			bow.exists = false;
			shopItems.add(bow);
		}
		add(shopItems);
		shopPagination = new Pagination(x + 20, y + 360, shopItems, itemsPerPage, 140);
		add(shopPagination);

		inventoryItems = new FlxTypedGroup();
		for (i in 0...GameStorage.store.ownedBows.length)
		{
			var bowIndex = GameStorage.store.ownedBows[i].bowIndex;
			var bow = new BowSlot(x + 235, y + 126 + 40 * (i % itemsPerPage), i, bowIndex, 0.5, id ->
			{
				if (selectedInventorySlot == id)
					return;
				inventoryItems.members[id].setSelected(true);
				if (selectedInventorySlot != -1)
				{
					inventoryItems.members[selectedInventorySlot].setSelected(false);
				}
				selectedInventorySlot = id;
			});
			bow.exists = false;
			inventoryItems.add(bow);
		}
		add(inventoryItems);
		inventoryPagination = new Pagination(x + 250, y + 360, inventoryItems, itemsPerPage, 140);
		add(inventoryPagination);

		mesosText = Globals.createBitmapText(x + 390, y + 70, GameStorage.store.playerMesos + "", 1.25, false);
		add(mesosText);
	}

	function rerenderInventory()
	{
		inventoryItems.forEach(slot -> slot.destroy());
		inventoryItems.clear();
		for (i in 0...GameStorage.store.ownedBows.length)
		{
			var bowIndex = GameStorage.store.ownedBows[i].bowIndex;
			var bow = new BowSlot(x + 235, y + 126 + 40 * (i % itemsPerPage), i, bowIndex, 0.5, id ->
			{
				if (selectedInventorySlot == id)
					return;
				inventoryItems.members[id].setSelected(true);
				if (selectedInventorySlot != -1)
				{
					inventoryItems.members[selectedInventorySlot].setSelected(false);
				}
				selectedInventorySlot = id;
			});
			bow.exists = false;
			inventoryItems.add(bow);
		}
		inventoryPagination.renderPage();
	}
}
