package ui;

import GameData.MissionRank;
import flixel.FlxSprite;

class RankMedal extends FlxSprite
{
	public function new(x:Float, y:Float, rank:MissionRank)
	{
		super(x, y, "assets/images/ranks/" + rank + "_rank.png");
	}
}
