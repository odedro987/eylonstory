package states;

import GameData.MissionRank;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;
import ui.ArrowButton;
import ui.MissionBanner;
import ui.RankMedal;

class MenuState extends FlxState
{
	override public function create()
	{
		super.create();
		FlxG.mouse.load(AssetPaths.cursor__png);

		var mission = new MissionBanner(840 - 300, 40, "green_snails_only");
		mission.setClear(MissionRank.AAA, 70254);
		add(mission);
		add(new MissionBanner(840 - 300, 40 + 90, "rainbow_snails", MissionState.NEW));
		add(new MissionBanner(840 - 300, 40 + 90 + 90, "forgotten_path_of_time_II"));
	}
}
