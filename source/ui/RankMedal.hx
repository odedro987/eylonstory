package ui;

import GameData.MissionRank;
import flixel.FlxSprite;

class RankMedal extends FlxSprite
{
	public function new(x:Float, y:Float, rank:MissionRank)
	{
		super(x, y);
		loadGraphic(AssetPaths.rank_medals__png, true, 32, 32);
		updateRank(rank);
	}

	public function updateRank(rank:MissionRank)
	{
		animation.frameIndex = cast(rank, Int);
	}
}
