import openfl.utils.Dictionary;

typedef MobData =
{
	var health:Int;
	var exp:Int;
	var speed:Float;
	var sprite:String;
	var width:Int;
	var height:Int;
	var animations:Map<String, Array<Int>>;
}

typedef MapData =
{
	var killGoal:Int;
	var possibleMobs:Array<String>;
	var spawnRate:Float;
}

class GameData
{
	public static var MOB_DATA:Map<String, MobData> = [
		"green_snail" => {
			health: 8,
			exp: 3,
			speed: 16,
			sprite: "assets/images/mobs/snail.png",
			width: 44,
			height: 33,
			animations: [
				"idle" => [0],
				"hit" => [6],
				"move" => [1, 2, 3, 4, 5, 4, 3, 2],
				"die" => [6, 7, 8, 9, 10, 11, 12, 13, 14]
			]
		}
	];

	public static var MAP_DATA:Map<String, MapData> = [
		"snail_hunting_ground_1" => {
			killGoal: 10,
			possibleMobs: ["green_snail"],
			spawnRate: 1
		}
	];
}
