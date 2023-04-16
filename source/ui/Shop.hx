package ui;

import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class Shop extends FlxTypedGroup<FlxBasic>
{
	var items:FlxTypedGroup<BowSlot>;
	var shopUI:FlxSprite;
	var prevArrow:ArrowButton;
	var nextArrow:ArrowButton;
	var currentPage:Float;
	var lastPage:Float;
	var itemsPerPage:Int;

	public function new(x:Float, y:Float, itemsPerPage:Int = 5)
	{
		super(4);

		currentPage = 0;
		lastPage = 0;
		this.itemsPerPage = itemsPerPage;

		shopUI = new FlxSprite(x, y, AssetPaths.shop__png);
		add(shopUI);

		items = new FlxTypedGroup();
		for (i in 0...GameData.BOW_DATA.length)
		{
			var bow = new BowSlot(x + 5, y + 126 + 40 * (i % itemsPerPage), i);
			bow.exists = false;
			items.add(bow);
		}
		add(items);
		renderPage();

		prevArrow = new ArrowButton(x + 20, y + 350, () ->
		{
			if (currentPage > 0)
			{
				lastPage = currentPage;
				currentPage--;
				renderPage();
			}
		});
		prevArrow.flipX = true;
		add(prevArrow);
		nextArrow = new ArrowButton(x + 160, y + 350, () ->
		{
			if (currentPage < items.length / itemsPerPage - 1)
			{
				lastPage = currentPage;
				currentPage++;
				renderPage();
			}
		});
		add(nextArrow);
	}

	function renderPage()
	{
		for (i in 0...itemsPerPage)
		{
			items.members[Math.round(Math.min(lastPage * itemsPerPage + i, items.length - 1))].exists = false;
			items.members[Math.round(Math.min(currentPage * itemsPerPage + i, items.length - 1))].exists = true;
		}
	}
}
