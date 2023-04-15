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

typedef MissionData =
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

	public static var MISSION_DATA:Array<MissionData> = [
		{
			name: "Green Snails Only",
			killGoal: 25,
			possibleMobs: ["green_snail", "blue_snail"],
			spawnRate: 1.5,
			sRankReq: 74000,
			gpReq: 0
		},
		{
			name: "Rainbow Snails",
			killGoal: 25,
			possibleMobs: ["green_snail", "blue_snail", "red_snail"],
			spawnRate: 1.5,
			sRankReq: 200000,
			gpReq: 3
		},
		{
			name: "Red Snerg Rush",
			killGoal: 25,
			possibleMobs: ["green_snail", "blue_snail", "red_snail"],
			spawnRate: 1.5,
			sRankReq: 450000,
			gpReq: 25
		},
		{
			name: "Shroom & Friend",
			killGoal: 25,
			possibleMobs: ["green_snail", "blue_snail", "red_snail"],
			spawnRate: 1.5,
			sRankReq: 550000,
			gpReq: 20
		},
		{
			name: "Shroom & Big Friend",
			killGoal: 25,
			possibleMobs: ["green_snail", "blue_snail", "red_snail"],
			spawnRate: 1.5,
			sRankReq: 850000,
			gpReq: 25
		},
		{
			name: "Trouble Bubbling",
			killGoal: 25,
			possibleMobs: ["green_snail", "blue_snail", "red_snail"],
			spawnRate: 1.5,
			sRankReq: 1500000,
			gpReq: 32
		},
		{
			name: "Logger's Nightmare",
			killGoal: 25,
			possibleMobs: ["green_snail", "blue_snail", "red_snail"],
			spawnRate: 1.5,
			sRankReq: 2750000,
			gpReq: 40
		},
		{
			name: "Double Bubble Trouble",
			killGoal: 25,
			possibleMobs: ["green_snail", "blue_snail", "red_snail"],
			spawnRate: 1.5,
			sRankReq: 2100000,
			gpReq: 46
		},
		{
			name: "Slithers & Spikes",
			killGoal: 25,
			possibleMobs: ["green_snail", "blue_snail", "red_snail"],
			spawnRate: 1.5,
			sRankReq: 2400000,
			gpReq: 52
		},
		{
			name: "Fungi Force",
			killGoal: 25,
			possibleMobs: ["green_snail", "blue_snail", "red_snail"],
			spawnRate: 1.5,
			sRankReq: 2550000,
			gpReq: 60
		},
		{
			name: "March of the Slime King",
			killGoal: 25,
			possibleMobs: ["green_snail", "blue_snail", "red_snail"],
			spawnRate: 1.5,
			sRankReq: 4000000,
			gpReq: 100
		},
		{
			name: "Land of Wild Boar",
			killGoal: 25,
			possibleMobs: ["green_snail", "blue_snail", "red_snail"],
			spawnRate: 1.5,
			sRankReq: 3600000,
			gpReq: 68
		},
		{
			name: "Land of Wild Boar II",
			killGoal: 25,
			possibleMobs: ["green_snail", "blue_snail", "red_snail"],
			spawnRate: 1.5,
			sRankReq: 4500000,
			gpReq: 75
		},
		{
			name: "Leporidae Marching Band",
			killGoal: 25,
			possibleMobs: ["green_snail", "blue_snail", "red_snail"],
			spawnRate: 1.5,
			sRankReq: 7300000,
			gpReq: 82
		}
	];
}
