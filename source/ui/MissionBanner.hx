package ui;

import GameData.MissionRank;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxBitmapText;
import states.MissionState;

enum abstract MissionBannerState(Int)
{
	var LOCKED;
	var NEW;
	var CLEAR;
	var FAIL;
}

class MissionBanner extends FlxTypedGroup<FlxSprite>
{
	var state:MissionBannerState;
	var missionIndex:Int;

	var banner:FlxSprite;
	var rankMedal:RankMedal;
	var name:FlxBitmapText;
	var infoText:FlxBitmapText;

	public function new(x:Float, y:Float, missionIndex:Int, state:MissionBannerState = MissionBannerState.LOCKED)
	{
		super(4);

		this.missionIndex = missionIndex;
		this.state = state;

		banner = new FlxSprite(x, y);
		banner.loadGraphic(AssetPaths.mission_banner__png, true, 270, 80);
		banner.animation.frameIndex = cast(state, Int);
		add(banner);

		var missionName = GameData.MISSION_DATA[missionIndex].name;
		var isLong = missionName.length <= 18;
		name = Globals.createBitmapText(x + (isLong ? 110 : 60), y + 15, missionName, isLong ? 2 : 1.5, false);
		add(name);

		rankMedal = new RankMedal(x + 213, y + 44, MissionRank.E);
		rankMedal.kill();
		add(rankMedal);

		infoText = Globals.createBitmapText(x + 60, y + 60, "", 1.5, false);
		if (state == MissionBannerState.LOCKED)
		{
			infoText.text = "Required GP: " + GameData.MISSION_DATA[missionIndex].gpReq;
		}
		add(infoText);
	}

	public function setClear(rank:MissionRank, points:Int)
	{
		banner.animation.frameIndex = cast(MissionBannerState.CLEAR, Int);
		rankMedal.updateRank(rank);
		rankMedal.revive();
		infoText.text = "Best Score: " + points;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (state != MissionBannerState.LOCKED && FlxG.mouse.justPressed && FlxG.mouse.overlaps(banner))
		{
			FlxG.switchState(new MissionState(missionIndex));
		}
	}
}
