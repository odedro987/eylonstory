package states;

import core.SoundManager;
import flixel.FlxG;
import flixel.FlxState;
import ui.Shop;

class ShopState extends FlxState
{
	override public function create()
	{
		super.create();

		SoundManager.play(AssetPaths.cash_shop__ogg);

		add(new Shop(FlxG.width / 2 - 115, FlxG.height / 10));
	}
}
