package states;

import core.SoundManager;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import ui.Shop;

class ShopState extends FlxState
{
	override public function create()
	{
		super.create();

		add(new FlxSprite(0, 0, AssetPaths.bg1__png));

		SoundManager.play(AssetPaths.cash_shop__ogg);

		add(new Shop(FlxG.width / 2 - 230, FlxG.height / 10));
	}
}
