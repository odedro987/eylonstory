package states;

import core.SoundManager;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import ui.Shop;

class ShopState extends FlxState
{
	override public function create()
	{
		super.create();

		var tooltipCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height, 1);
		tooltipCamera.bgColor = 0x00000000;
		FlxG.cameras.add(tooltipCamera, false);

		add(new FlxSprite(0, 0, AssetPaths.bg1__png));

		SoundManager.play(AssetPaths.cash_shop__ogg);

		add(new Shop(FlxG.width / 2 - 230, FlxG.height / 10));
	}
}
