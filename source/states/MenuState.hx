package states;

import GameData.MissionRank;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import ui.ArrowButton;
import ui.MissionBanner;
import ui.MissionPanel;

class MenuState extends FlxState
{
	override public function create()
	{
		super.create();
		FlxG.mouse.load(AssetPaths.cursor__png);

		add(new MissionPanel(FlxG.width, 10));
	}
}
