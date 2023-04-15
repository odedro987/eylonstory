package ui;

import flixel.FlxBasic;
import flixel.group.FlxGroup.FlxTypedGroup;
import ui.MissionBanner.MissionBannerState;

class MissionPanel extends FlxTypedGroup<FlxBasic>
{
	var missions:FlxTypedGroup<MissionBanner>;
	var prevArrow:ArrowButton;
	var nextArrow:ArrowButton;
	var currentPage:Float;
	var lastPage:Float;

	public function new(x:Float, y:Float)
	{
		super(3);

		currentPage = 0;
		lastPage = 0;

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

			var mission = new MissionBanner(x - 280, y + 90 * (i % 4), i, missionState);
			if (highscore > 0)
			{
				mission.setClear(Formulas.calculateMissionRank(highscore, GameData.MISSION_DATA[i].sRankReq), highscore);
			}
			if (GameData.MISSION_DATA[i].gpReq < 20) {}
			mission.exists = false;
			missions.add(mission);
		}
		add(missions);
		renderPage();

		prevArrow = new ArrowButton(x - 260, y + 360, () ->
		{
			if (currentPage > 0)
			{
				lastPage = currentPage;
				currentPage--;
				renderPage();
			}
		});
		prevArrow.flipX = true;
		add(prevArrow);

		nextArrow = new ArrowButton(x - 80, y + 360, () ->
		{
			if (currentPage < missions.length / 4 - 1)
			{
				lastPage = currentPage;
				currentPage++;
				renderPage();
			}
		});
		add(nextArrow);
	}

	function renderPage()
	{
		for (i in 0...4)
		{
			missions.members[Math.round(Math.min(lastPage * 4 + i, missions.length - 1))].exists = false;
			missions.members[Math.round(Math.min(currentPage * 4 + i, missions.length - 1))].exists = true;
		}
	}
}
