package ui.components;

import flixel.FlxSprite;

enum abstract MissionRank(Int)
{
	var E;
	var D;
	var C;
	var B;
	var A;
	var AA;
	var AAA;
	var S;
}

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
