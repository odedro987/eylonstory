package ui;

import core.Formulas;
import core.GameStorage;
import flixel.FlxBasic;
import flixel.group.FlxGroup.FlxTypedGroup;
import ui.components.MissionBanner;

class MissionPanel extends FlxTypedGroup<FlxBasic>
{
	var missions:FlxTypedGroup<MissionBanner>;

	public function new(x:Float, y:Float)
	{
		super(3);

		missions = new FlxTypedGroup();
		for (i in 0...GameData.MISSION_DATA.length)
		{
			var highscore = -1;
			var missionState = MissionBannerState.NEW;
			if (GameData.MISSION_DATA[i].gpReq > GameStorage.store.playerGP)
			{
				missionState = MissionBannerState.LOCKED;
			}
			else if (GameStorage.store.missionRecords[i].attempts > 0)
			{
				if (GameStorage.store.missionRecords[i].highscore == 0)
				{
					missionState = MissionBannerState.FAIL;
				}
				else
				{
					highscore = GameStorage.store.missionRecords[i].highscore;
				}
			}

			var mission = new MissionBanner(x, y + 90 * (i % 4), i, missionState);
			if (highscore > 0)
			{
				mission.setClear(Formulas.calculateMissionRank(highscore, GameData.MISSION_DATA[i].sRankReq), highscore);
			}
			if (GameData.MISSION_DATA[i].gpReq < 20) {}
			mission.exists = false;
			missions.add(mission);
		}
		add(missions);

		add(new Pagination(x + 20, y, missions, 4));
	}
}
