package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.ui.FlxButton;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();

		FlxG.mouse.load(AssetPaths.cursor__png);

		var btn = new FlxButton(100, 100, "start", () -> FlxG.switchState(new MapState(GameData.MAP_DATA["snail_hunting_ground_1"])));
		add(btn);
	}
}
