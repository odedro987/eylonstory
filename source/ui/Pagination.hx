package ui;

import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import ui.util.SpriteButton;

class Pagination<T:FlxBasic> extends FlxTypedGroup<FlxSprite>
{
	var prevArrow:SpriteButton;
	var nextArrow:SpriteButton;
	var lastPage:Float;
	var itemsPerPage:Int;
	var needArrows:Void->Bool;

	public var currentPage:Float;
	public var renderPage:Void->Void;

	public function new(x:Float, y:Float, list:FlxTypedGroup<T>, itemsPerPage:Int, gap:Float = 180)
	{
		super(2);

		this.itemsPerPage = itemsPerPage;
		currentPage = 0;
		lastPage = 0;

		needArrows = () -> list.length > itemsPerPage;

		renderPage = () ->
		{
			for (i in 0...itemsPerPage)
			{
				list.members[Math.round(Math.min(lastPage * itemsPerPage + i, list.length - 1))].exists = false;
				list.members[Math.round(Math.min(currentPage * itemsPerPage + i, list.length - 1))].exists = true;
			}
		}

		prevArrow = new SpriteButton(x, y, AssetPaths.arrow_button__png, 46, 36, () -> renderPrevPage());
		prevArrow.flipX = true;
		add(prevArrow);

		nextArrow = new SpriteButton(x + gap, y, AssetPaths.arrow_button__png, 46, 36, () -> renderNextPage(list.length));
		add(nextArrow);

		if (list.length > 0)
		{
			renderPage();
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		prevArrow.exists = nextArrow.exists = needArrows();
	}

	public function renderPrevPage()
	{
		if (currentPage > 0)
		{
			lastPage = currentPage;
			currentPage--;
			renderPage();
		}
	}

	public function renderNextPage(length:Int)
	{
		if (currentPage < length / itemsPerPage - 1)
		{
			lastPage = currentPage;
			currentPage++;
			renderPage();
		}
	}
}
