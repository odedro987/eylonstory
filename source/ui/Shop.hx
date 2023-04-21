package ui;

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

	public function new(x:Float, y:Float, itemsPerPage:Int = 5)
	{
		super(6);

		this.itemsPerPage = itemsPerPage;

		shopUI = new FlxSprite(x, y, AssetPaths.shop__png);
		add(shopUI);

		buyItem = new SpriteButton(x + 141, y + 14, AssetPaths.buy_item_button__png, 80, 18, () ->
		{
			trace("buy");
		});
		add(buyItem);

		leaveShop = new SpriteButton(x + 141, y + 34, AssetPaths.leave_shop_button__png, 80, 18, () -> FlxG.switchState(new MenuState()));
		add(leaveShop);

		items = new FlxTypedGroup();
		for (i in 0...GameData.BOW_DATA.length)
		{
			var bow = new BowSlot(x + 5, y + 126 + 40 * (i % itemsPerPage), i);
			bow.exists = false;
			items.add(bow);
		}
		add(items);

		add(new Pagination(x + 20, y, items, itemsPerPage, 140));
	}
}
