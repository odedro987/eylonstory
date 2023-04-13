package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import ui.RankMedal;

class GameOverState extends FlxState
{
	var points:Int;
	var score:Float;
	var accuracy:Float;
	var repel:Float;
	var missionIndex:Int;

	public function new(score:Float, accuracy:Float, repel:Float, missionIndex:Int)
	{
		super();
		this.score = score;
		this.accuracy = accuracy;
		this.repel = repel;
		this.missionIndex = missionIndex;
		this.points = Math.round(((score * accuracy) * repel) * 0.001);
	}

	override public function create()
	{
		super.create();

		add(Globals.createBitmapText(FlxG.width / 2, FlxG.height / 3, "Score: " + score, 2));
		add(Globals.createBitmapText(FlxG.width / 2, FlxG.height / 3 + 20, "Accuracy: " + accuracy + "%", 2));
		add(Globals.createBitmapText(FlxG.width / 2, FlxG.height / 3 + 40, "Repel: " + repel + "%", 2));
		add(Globals.createBitmapText(FlxG.width / 2, FlxG.height / 3 + 100, "Total Points: " + points, 3));
		var rank = Formulae.calculateMissionRank(points, GameData.MISSION_DATA[missionIndex].sRankReq);
		var rankMedal = new RankMedal(FlxG.width / 2, FlxG.height / 3 + 100 + 35, rank);
		rankMedal.scale.set(2, 2);
		add(rankMedal);

		GameStorage.store.missionRecords[missionIndex].attempts++;
		GameStorage.store.missionRecords[missionIndex].highscore = points;

		GameStorage.save();
	}
}
