package states;

import flixel.FlxG;
import flixel.FlxState;
import ui.Shop;

class ShopState extends FlxState
{
	override public function create()
	{
		super.create();

		add(new Shop(FlxG.width / 2 - 115, FlxG.height / 10));
	}
}
