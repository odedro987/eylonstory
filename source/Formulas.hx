import GameData.MissionRank;
import entities.Player.PlayerInfo;
import flixel.FlxG;

class Formulas
{
	public static function calculateExpGoal(level:Int)
	{
		return Math.floor((level * (level + 1) * (level + 2)) / 2);
	}

	public static function getRandomDamage(playerInfo:PlayerInfo)
	{
		var maxDmg = 20 * playerInfo.level * ((40 + 15) / 100);
		var minDmg = playerInfo.mastery * maxDmg;
		var dmg = Math.round(FlxG.random.float(minDmg, maxDmg));
		var isCrit = FlxG.random.float() <= playerInfo.critChance;
		if (isCrit)
		{
			dmg = Math.round(dmg * playerInfo.critDamage);
		}

		return {
			damage: dmg,
			isCrit: isCrit
		};
	}

	public static function calculateTotalPoints(score:Float, repel:Float, accuracy:Float)
	{
		return Math.round(((score * accuracy) * repel) * 0.001);
	}

	public static function calculateMissionRank(totalPoints:Float, sRankReq:Float)
	{
		var percent = totalPoints / sRankReq;

		if (percent == 0)
			return MissionRank.E;
		if (percent < 0.5)
			return MissionRank.D;
		if (percent < 0.6)
			return MissionRank.C;
		if (percent < 0.7)
			return MissionRank.B;
		if (percent < 0.8)
			return MissionRank.A;
		if (percent < 0.9)
			return MissionRank.AA;
		if (percent < 0.95)
			return MissionRank.AAA;

		return MissionRank.S;
	}

	public static function calculateMissionGP(missionRank:MissionRank)
	{
		return switch (missionRank)
		{
			case E: 0;
			case D: 3;
			case C: 5;
			case B: 8;
			case A: 10;
			case AA: 12;
			case AAA: 13;
			case S: 15;
			default: 0;
		}
	}

	public static function calculateMissionMesos(score:Float, repel:Float, accuracy:Float)
	{
		return Math.round(((Math.pow(score, 0.72) * repel) * accuracy) * 6E-5);
	}

	public static function calculateMissionBonusExp(totalPoints:Float, missionRank:MissionRank, playerLevel:Float)
	{
		if (missionRank == MissionRank.E)
			return 0;

		return Math.round((totalPoints * (2 + cast(missionRank, Int))) / (20000 * Math.sqrt(playerLevel)));
	}
}
