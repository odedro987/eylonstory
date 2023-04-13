package ui;

import GameData.MissionRank;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxBitmapText;
import flixel.ui.FlxButton.FlxTypedButton;
import states.MapState;

enum abstract MissionState(Int)
{
	var LOCKED;
	var NEW;
	var CLEAR;
}

class MissionBanner extends FlxTypedGroup<FlxSprite>
{
	var state:MissionState;
	var missionName:String;

	var banner:FlxSprite;
	var rankMedal:RankMedal;
	var name:FlxBitmapText;
	var infoText:FlxBitmapText;

	public function new(x:Float, y:Float, missionName:String, state:MissionState = MissionState.LOCKED)
	{
		super(4);

		this.missionName = missionName;
		this.state = state;

		banner = new FlxSprite(x, y);
		banner.loadGraphic(AssetPaths.mission_banner__png, true, 270, 80);
		banner.animation.frameIndex = cast(state, Int);
		add(banner);

		name = Globals.createBitmapText(x + 60, y + 10, GameData.MAP_DATA[missionName].name, 1.5, false);
		add(name);

		rankMedal = new RankMedal(x + 213, y + 44, MissionRank.E);
		rankMedal.kill();
		add(rankMedal);

		infoText = Globals.createBitmapText(x + 60, y + 60, "", 1.5, false);
		if (state == MissionState.LOCKED)
		{
			infoText.text = "Required GP: " + GameData.MAP_DATA[missionName].gpReq;
		}
		add(infoText);
	}

	public function setClear(rank:MissionRank, points:Int)
	{
		banner.animation.frameIndex = cast(MissionState.CLEAR, Int);
		rankMedal.updateRank(rank);
		rankMedal.revive();
		infoText.text = "Best Score: " + points;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (state != MissionState.LOCKED && FlxG.mouse.justPressed && FlxG.mouse.overlaps(banner))
		{
			FlxG.switchState(new MapState(GameData.MAP_DATA[missionName]));
		}
	}
}
