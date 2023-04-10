class Formulae
{
	public static function calculateExpGoal(level:Int)
	{
		return Math.floor((level * (level + 1) * (level + 2)) / 2);
	}
}
