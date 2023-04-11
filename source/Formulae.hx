import GameData.MissionRank;

class Formulae
{
	public static function calculateExpGoal(level:Int)
	{
		return Math.floor((level * (level + 1) * (level + 2)) / 2);
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
}
