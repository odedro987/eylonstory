enum abstract MissionRank(String)
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

typedef MobData =
{
	var health:Int;
	var exp:Int;
	var speed:Float;
	var sprite:String;
	var width:Int;
	var height:Int;
	var knockbackThreshold:Int;
	var animations:Map<String, Array<Int>>;
}

typedef MapData =
{
	var name:String;
	var killGoal:Int;
	var possibleMobs:Array<String>;
	var spawnRate:Float;
	var sRankReq:Float;
	var gpReq:Float;
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
			knockbackThreshold: 1,
			animations: [
				"idle" => [0],
				"hit" => [6],
				"move" => [1, 2, 3, 4, 5, 4, 3, 2],
				"die" => [6, 7, 8, 9, 10, 11, 12, 13, 14]
			]
		},
		"blue_snail" => {
			health: 15,
			exp: 4,
			speed: 20,
			sprite: "assets/images/mobs/blue_snail.png",
			width: 56,
			height: 40,
			knockbackThreshold: 1,
			animations: ["idle" => [0], "hit" => [8], "move" => [4, 5, 6, 7, 6, 5], "die" => [12, 13, 14]]
		},
		"red_snail" => {
			health: 40,
			exp: 8,
			speed: 20,
			sprite: "assets/images/mobs/red_snail.png",
			width: 56,
			height: 40,
			knockbackThreshold: 1,
			animations: ["idle" => [0], "hit" => [8], "move" => [4, 5, 6, 7, 6, 5], "die" => [12, 13, 14]]
		}
	];

	public static var MAP_DATA:Map<String, MapData> = [
		"green_snails_only" => {
			name: "Green Snails Only",
			killGoal: 10,
			possibleMobs: ["green_snail", "blue_snail"],
			spawnRate: 3,
			sRankReq: 74000,
			gpReq: 0
		},
		"rainbow_snails" => {
			name: "Rainbow Snails",
			killGoal: 10,
			possibleMobs: ["green_snail", "blue_snail", "red_snail"],
			spawnRate: 3,
			sRankReq: 200000,
			gpReq: 3
		}
	];
}
