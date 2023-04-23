package ui;

import core.GameStorage;
import core.Globals;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxBitmapText;
import states.MenuState;
import ui.components.ShopSlot;
import ui.util.SpriteButton;

class Shop extends FlxTypedGroup<FlxBasic>
{
	var shopItems:FlxTypedGroup<ShopSlot>;
	var shopPagination:Pagination<ShopSlot>;
	var inventoryItems:FlxTypedGroup<ShopSlot>;
	var inventoryPagination:Pagination<ShopSlot>;
	var shopUI:FlxSprite;
	var buyButton:SpriteButton;
	var sellButton:SpriteButton;
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

		buyButton = new SpriteButton(x + 141, y + 14, AssetPaths.buy_item_button__png, 80, 18, () ->
		{
			if (selectedShopSlot > -1)
				buyItem();
		});
		add(buyButton);

		sellButton = new SpriteButton(x + 371, y + 34, AssetPaths.sell_item_button__png, 80, 18, () ->
		{
			if (selectedInventorySlot > -1)
				sellItem();
		});
		add(sellButton);

		leaveShop = new SpriteButton(x + 141, y + 34, AssetPaths.leave_shop_button__png, 80, 18, () -> FlxG.switchState(new MenuState()));
		add(leaveShop);

		mesosText = Globals.createBitmapText(x + 390, y + 70, GameStorage.store.playerMesos + "", 1.25, false);
		add(mesosText);

		shopItems = new FlxTypedGroup();
		var idx = 0;
		for (bowIndex in 0...GameData.BOW_DATA.length)
		{
			if (!GameData.BOW_DATA[bowIndex].untradable)
			{
				var bow = new ShopSlot(x + 5, y + 126 + 40 * (idx % itemsPerPage), idx, {
					bowIndex: bowIndex,
					scrollSlots: 7,
					successfulScrollCount: 0,
					bonusWatk: 0
				}, 1, id ->
				{
					if (selectedShopSlot == id)
						return;
					shopItems.members[id].setSelected(true);
					resetSelection();
					selectedShopSlot = id;
				});
				bow.exists = false;
				shopItems.add(bow);
				idx++;
			}
		}
		add(shopItems);

		shopPagination = new Pagination(x + 20, y + 360, shopItems, itemsPerPage, 140);
		add(shopPagination);

		inventoryItems = new FlxTypedGroup();
		idx = 0;
		for (i in 0...GameStorage.store.ownedBows.length)
		{
			var bowData = GameStorage.store.ownedBows[i];
			if (!GameData.BOW_DATA[bowData.bowIndex].untradable)
			{
				var bow = new ShopSlot(x + 235, y + 126 + 40 * (idx % itemsPerPage), idx, {
					bowIndex: bowData.bowIndex,
					scrollSlots: bowData.scrollSlots,
					successfulScrollCount: bowData.successfulScrollCount,
					bonusWatk: bowData.bonusWatk
				}, 0.5, id ->
				{
					if (selectedInventorySlot == id)
						return;
					inventoryItems.members[id].setSelected(true);
					resetSelection();
					selectedInventorySlot = id;
				});
				bow.exists = false;
				inventoryItems.add(bow);
				idx++;
			}
		}
		add(inventoryItems);

		inventoryPagination = new Pagination(x + 250, y + 360, inventoryItems, itemsPerPage, 140);
		add(inventoryPagination);
	}

	function rerenderInventory()
	{
		inventoryItems.forEach(slot -> slot.destroy());
		inventoryItems.clear();
		var idx = 0;
		for (i in 0...GameStorage.store.ownedBows.length)
		{
			var bowData = GameStorage.store.ownedBows[i];
			if (!GameData.BOW_DATA[bowData.bowIndex].untradable)
			{
				var bow = new ShopSlot(x + 235, y + 126 + 40 * (idx % itemsPerPage), idx, {
					bowIndex: bowData.bowIndex,
					scrollSlots: bowData.scrollSlots,
					successfulScrollCount: bowData.successfulScrollCount,
					bonusWatk: bowData.bonusWatk
				}, 0.5, id ->
				{
					if (selectedInventorySlot == id)
						return;
					inventoryItems.members[id].setSelected(true);
					resetSelection();
					selectedInventorySlot = id;
				});
				bow.exists = false;
				inventoryItems.add(bow);
				idx++;
			}
		}
		inventoryPagination.renderPage();

		if (inventoryPagination.currentPage * itemsPerPage >= inventoryItems.length)
			inventoryPagination.renderPrevPage();
	}

	function buyItem()
	{
		var bowIndex = shopItems.members[selectedShopSlot].bowIndex;
		if (GameStorage.store.playerMesos >= GameData.BOW_DATA[bowIndex].mesosCost)
		{
			GameStorage.store.playerMesos -= GameData.BOW_DATA[bowIndex].mesosCost;
			GameStorage.store.ownedBows.push({
				bowIndex: bowIndex,
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
	}

	function sellItem()
	{
		var bowIndex = GameStorage.store.ownedBows[selectedInventorySlot].bowIndex;
		GameStorage.store.playerMesos += Math.floor(GameData.BOW_DATA[bowIndex].mesosCost / 2);
		GameStorage.store.ownedBows.remove(GameStorage.store.ownedBows[selectedInventorySlot]);
		inventoryItems.remove(inventoryItems.members[selectedInventorySlot]);
		mesosText.text = GameStorage.store.playerMesos + "";
		GameStorage.save();
		// Reset selection
		selectedInventorySlot = -1;
		rerenderInventory();
	}

	function resetSelection()
	{
		if (selectedShopSlot != -1)
		{
			shopItems.members[selectedShopSlot].setSelected(false);
			selectedShopSlot = -1;
		}

		if (selectedInventorySlot != -1)
		{
			inventoryItems.members[selectedInventorySlot].setSelected(false);
			selectedInventorySlot = -1;
		}
	}
}
