package ui;

import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import ui.util.SpriteButton;

class Pagination<T:FlxBasic> extends FlxTypedGroup<FlxSprite>
{
	var prevArrow:SpriteButton;
	var nextArrow:SpriteButton;
	var currentPage:Float;
	var lastPage:Float;

	public function new(x:Float, y:Float, list:FlxTypedGroup<T>, itemsPerPage:Int, gap:Float = 180)
	{
		super(2);

		currentPage = 0;
		lastPage = 0;

		function renderPage()
		{
			for (i in 0...itemsPerPage)
			{
				list.members[Math.round(Math.min(lastPage * itemsPerPage + i, list.length - 1))].exists = false;
				list.members[Math.round(Math.min(currentPage * itemsPerPage + i, list.length - 1))].exists = true;
			}
		}

		prevArrow = new SpriteButton(x, y + 360, AssetPaths.arrow_button__png, 46, 36, () ->
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

		nextArrow = new SpriteButton(x + gap, y + 360, AssetPaths.arrow_button__png, 46, 36, () ->
		{
			if (currentPage < list.length / itemsPerPage - 1)
			{
				lastPage = currentPage;
				currentPage++;
				renderPage();
			}
		});
		add(nextArrow);

		renderPage();
	}
}
