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

typedef BowData =
{
	var name:String;
	var weaponAttack:Int;
	var mesosCost:Int;
	var pointsReq:Int;
	var sprite:String;
}

class GameData
{
	public static var BOW_DATA:Array<BowData> = [
		{
			name: "War Bow",
			pointsReq: 0,
			mesosCost: 0,
			weaponAttack: 25,
			sprite: "assets/images/bows/war_bow.png"
		},
		{
			name: "Composite Bow",
			pointsReq: 280000,
			mesosCost: 1800,
			weaponAttack: 30,
			sprite: "assets/images/bows/composite_bow.png"
		},
		{
			name: "Archer's Bow",
			pointsReq: 750000,
			mesosCost: 5600,
			weaponAttack: 35,
			sprite: "assets/images/bows/archers_bow.png"
		},
		{
			name: "Battle Bow",
			pointsReq: 1400000,
			mesosCost: 8000,
			weaponAttack: 40,
			sprite: "assets/images/bows/battle_bow.png"
		},
		{
			name: "Ryden",
			pointsReq: 1400000,
			mesosCost: 8000,
			weaponAttack: 45,
			sprite: "assets/images/bows/ryden.png"
		},
		{
			name: "Red Viper",
			pointsReq: 2000000,
			mesosCost: 12600,
			weaponAttack: 50,
			sprite: "assets/images/bows/red_viper.png"
		},
		{
			name: "Maple Bow",
			pointsReq: 2200000,
			mesosCost: 15000,
			weaponAttack: 52,
			sprite: "assets/images/bows/maple_bow.png"
		},
		{
			name: "Vaulter 2000",
			pointsReq: 3000000,
			mesosCost: 17000,
			weaponAttack: 55,
			sprite: "assets/images/bows/vaulter_2000.png"
		},
		{
			name: "Maple Soul Searcher",
			pointsReq: 3000000,
			mesosCost: 17000,
			weaponAttack: 58,
			sprite: "assets/images/bows/maple_soul_searcher.png"
		},
		{
			name: "Olympus",
			pointsReq: 4500000,
			mesosCost: 22500,
			weaponAttack: 65,
			sprite: "assets/images/bows/olympus.png"
		},
		{
			name: "Asianic Bow",
			pointsReq: 5000000,
			mesosCost: 22500,
			weaponAttack: 75,
			sprite: "assets/images/bows/asianic_bow.png"
		},
		{
			name: "Maple Kandiva Bow",
			pointsReq: 6500000,
			mesosCost: 26000,
			weaponAttack: 78,
			sprite: "assets/images/bows/maple_kandiva_bow.png"
		},
		{
			name: "Red Hinkel",
			pointsReq: 8500000,
			mesosCost: 32000,
			weaponAttack: 80,
			sprite: "assets/images/bows/red_hinkel.png"
		},
		{
			name: "Golden Arund",
			pointsReq: 10000000,
			mesosCost: 38500,
			weaponAttack: 85,
			sprite: "assets/images/bows/golden_arund.png"
		},
		{
			name: "Legendary Maple Stormsinger",
			pointsReq: 12000000,
			mesosCost: 40000,
			weaponAttack: 87,
			sprite: "assets/images/bows/legendary_maple_stormsinger.png"
		},
		{
			name: "Metus",
			pointsReq: 15000000,
			mesosCost: 45000,
			weaponAttack: 90,
			sprite: "assets/images/bows/metus.png"
		},
		{
			name: "White Nisrock",
			pointsReq: 20000000,
			mesosCost: 52500,
			weaponAttack: 95,
			sprite: "assets/images/bows/white_nisrock.png"
		},
		{
			name: "Dragon Shiner Bow",
			pointsReq: 30000000,
			mesosCost: 60000,
			weaponAttack: 100,
			sprite: "assets/images/bows/dragon_shiner_bow.png"
		},
		{
			name: "Timeless Engaw",
			pointsReq: 50000000,
			mesosCost: 70000,
			weaponAttack: 107,
			sprite: "assets/images/bows/timeless_engaw.png"
		},
		{
			name: "Maple Treasure Longbow",
			pointsReq: 60000000,
			mesosCost: 90000,
			weaponAttack: 123,
			sprite: "assets/images/bows/maple_treasure_longbow.png"
		},
		{
			name: "VIP Bow",
			pointsReq: 100000000,
			mesosCost: 120000,
			weaponAttack: 135,
			sprite: "assets/images/bows/vip_bow.png"
		},
		{
			name: "Royal Von Leon Bow",
			pointsReq: 120000000,
			mesosCost: 140000,
			weaponAttack: 145,
			sprite: "assets/images/bows/royal_von_leon_bow.png"
		},
		{
			name: "Meister Battle Bow",
			pointsReq: 140000000,
			mesosCost: 180000,
			weaponAttack: 158,
			sprite: "assets/images/bows/meister_battle_bow.png"
		},
		{
			name: "Lightseeker",
			pointsReq: 150000000,
			mesosCost: 250000,
			weaponAttack: 190,
			sprite: "assets/images/bows/lightseeker.png"
		},
		{
			name: "Terminus Stormchaser",
			pointsReq: 200000000,
			mesosCost: 350000,
			weaponAttack: 205,
			sprite: "assets/images/bows/terminus_stormchaser.png"
		},
		{
			name: "Arcane Umbra Bow",
			pointsReq: 300000000,
			mesosCost: 850000,
			weaponAttack: 260,
			sprite: "assets/images/bows/arcane_umbra_bow.png"
		},
		{
			name: "Genesis Bow",
			pointsReq: 500000000,
			mesosCost: 1500000,
			weaponAttack: 320,
			sprite: "assets/images/bows/genesis_bow.png"
		},
	];

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
