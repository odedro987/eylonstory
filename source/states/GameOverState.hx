package states;

import core.Formulas;
import core.GameStorage;
import core.Globals;
import flixel.FlxG;
import flixel.FlxState;
import ui.RankMedal;
import ui.SpriteButton;

class GameOverState extends FlxState
{
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
	}

	override public function create()
	{
		super.create();

		var points = Formulas.calculateTotalPoints(score, repel, accuracy);
		var rank = Formulas.calculateMissionRank(points, GameData.MISSION_DATA[missionIndex].sRankReq);
		var mesos = Formulas.calculateMissionMesos(score, repel, accuracy);
		var bonusExp = Formulas.calculateMissionBonusExp(points, rank, 1);
		var gp = Formulas.calculateMissionGP(rank);

		add(Globals.createBitmapText(FlxG.width / 2, FlxG.height / 4, "Score: " + score, 2));
		add(Globals.createBitmapText(FlxG.width / 2, FlxG.height / 4 + 20, "Accuracy: " + accuracy + "%", 2));
		add(Globals.createBitmapText(FlxG.width / 2, FlxG.height / 4 + 40, "Repel: " + repel + "%", 2));
		add(Globals.createBitmapText(FlxG.width / 2, FlxG.height / 4 + 60, "Bonus EXP: " + bonusExp, 2));
		add(Globals.createBitmapText(FlxG.width / 2, FlxG.height / 4 + 80, "Mesos: " + mesos, 2));
		add(Globals.createBitmapText(FlxG.width / 2, FlxG.height / 4 + 140, "Total Points: " + points, 3));
		var rankMedal = new RankMedal(FlxG.width / 2, FlxG.height / 4 + 140 + 35, rank);
		rankMedal.scale.set(2, 2);
		add(rankMedal);

		var nextArrow = new SpriteButton(FlxG.width / 2 + 60, FlxG.height / 4 + 140 + 35, AssetPaths.arrow_button__png, 46, 36,
			() -> FlxG.switchState(new MenuState()));
		add(nextArrow);

		// Update mission attempts
		GameStorage.store.missionRecords[missionIndex].attempts++;
		// Update mission highscore if higher than last highscore
		var lastHighscore = GameStorage.store.missionRecords[missionIndex].highscore;
		if (lastHighscore < points)
		{
			GameStorage.store.missionRecords[missionIndex].highscore = points;
			// Update GP if higher than last earned GP from the mission
			var lastRank = Formulas.calculateMissionRank(lastHighscore, GameData.MISSION_DATA[missionIndex].sRankReq);
			var lastGP = Formulas.calculateMissionGP(lastRank);
			if (lastGP < gp)
			{
				GameStorage.store.playerGP += gp - lastGP;
			}
		}
		GameStorage.store.playerMesos += mesos;
		GameStorage.store.playerExp += bonusExp;
		// Level up player if adding bonus exp exceeds exp goal
		var expGoal = Formulas.calculateExpGoal(GameStorage.store.playerLevel);
		if (GameStorage.store.playerExp >= expGoal)
		{
			GameStorage.store.playerExp -= expGoal;
			GameStorage.store.playerLevel++;
		}

		GameStorage.save();
	}
}
