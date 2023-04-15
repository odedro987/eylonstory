package states;

import GameStorage.MissionRecord;
import flixel.FlxG;
import flixel.FlxState;
import ui.MissionPanel;

class MenuState extends FlxState
{
	override public function create()
	{
		super.create();
		FlxG.mouse.load(AssetPaths.cursor__png);

		if (!GameStorage.hasLoaded)
		{
			GameStorage.init();
			var hasData = GameStorage.load();

			if (!hasData)
			{
				var emptyRecord:Array<MissionRecord> = [];
				for (i in 0...GameData.MISSION_DATA.length)
				{
					emptyRecord.push({highscore: 0, attempts: 0});
				}

				GameStorage.initStore({
					playerLevel: 1,
					playerExp: 0,
					playerMesos: 0,
					playerGP: 0,
					missionRecords: emptyRecord
				});
			}
		}

		add(new MissionPanel(FlxG.width, 10));
	}
}
