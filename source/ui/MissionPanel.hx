package ui;

import GameData.MissionRank;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import ui.MissionBanner.MissionState;

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
		for (i in 0...GameData.MAP_DATA.length)
		{
			var mission = new MissionBanner(x - 280, y + 90 * (i % 4), i,
				GameData.MAP_DATA[i].gpReq < 30 ? MissionState.FAIL : GameData.MAP_DATA[i].gpReq < 55 ? MissionState.NEW : MissionState.LOCKED);
			if (GameData.MAP_DATA[i].gpReq < 20)
			{
				mission.setClear(MissionRank.S, 100000000);
			}
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
