package states;

import flixel.FlxG;
import flixel.FlxState;
import ui.Shop;

class ShopState extends FlxState
{
	override public function create()
	{
		super.create();

		FlxG.sound.playMusic(AssetPaths.cash_shop__ogg, 1, true);

		add(new Shop(FlxG.width / 2 - 115, FlxG.height / 10));
	}
}
