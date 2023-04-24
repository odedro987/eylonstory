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
	var icon:String;
	var sprite:String;
	var untradable:Bool;
	var handOffset:Array<Array<Int>>;
	var frameWidth:Int;
	var frameHeight:Int;
}

class GameData
{
	public static var BOW_DATA:Array<BowData> = [
		{
			name: "War Bow",
			pointsReq: 0,
			mesosCost: 0,
			weaponAttack: 25,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/01_war_bow.png",
			untradable: true,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Admin Bow",
			pointsReq: 0,
			mesosCost: 0,
			weaponAttack: 2555,
			sprite: "assets/images/bows/27_genesis_bow.png",
			icon: "assets/images/bows/icons/27_genesis_bow.png",
			untradable: true,
			handOffset: [[47, 51], [36, 45], [20, 44]],
			frameWidth: 100,
			frameHeight: 100,
		},
		{
			name: "Composite Bow",
			pointsReq: 280000,
			mesosCost: 1800,
			weaponAttack: 30,
			sprite: "assets/images/bows/02_composite_bow.png",
			icon: "assets/images/bows/icons/02_composite_bow.png",
			untradable: false,
			handOffset: [[16, 33], [15, 23], [4, 23]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Archer's Bow",
			pointsReq: 750000,
			mesosCost: 5600,
			weaponAttack: 35,
			sprite: "assets/images/bows/03_archers_bow.png",
			icon: "assets/images/bows/icons/03_archers_bow.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Battle Bow",
			pointsReq: 140000,
			mesosCost: 8000,
			weaponAttack: 40,
			sprite: "assets/images/bows/04_battle_bow.png",
			icon: "assets/images/bows/icons/04_battle_bow.png",
			untradable: false,
			handOffset: [[25, 34], [17, 22], [8, 23]],
			frameWidth: 60,
			frameHeight: 60,
		},
		{
			name: "Ryden",
			pointsReq: 140000,
			mesosCost: 8000,
			weaponAttack: 45,
			sprite: "assets/images/bows/05_ryden.png",
			icon: "assets/images/bows/icons/05_ryden.png",
			untradable: false,
			handOffset: [[29, 38], [19, 29], [17, 30]],
			frameWidth: 70,
			frameHeight: 70,
		},
		{
			name: "Red Viper",
			pointsReq: 2000000,
			mesosCost: 12600,
			weaponAttack: 50,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/06_red_viper.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Maple Bow",
			pointsReq: 2200000,
			mesosCost: 15000,
			weaponAttack: 52,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/07_maple_bow.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Vaulter 2000",
			pointsReq: 3000000,
			mesosCost: 17000,
			weaponAttack: 55,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/08_vaulter_2000.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Maple Soul Searcher",
			pointsReq: 3000000,
			mesosCost: 17000,
			weaponAttack: 58,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/09_maple_soul_searcher.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Olympus",
			pointsReq: 4500000,
			mesosCost: 22500,
			weaponAttack: 65,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/10_olympus.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Asianic Bow",
			pointsReq: 5000000,
			mesosCost: 22500,
			weaponAttack: 75,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/11_asianic_bow.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Maple Kandiva Bow",
			pointsReq: 6500000,
			mesosCost: 26000,
			weaponAttack: 78,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/12_maple_kandiva_bow.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Red Hinkel",
			pointsReq: 8500000,
			mesosCost: 32000,
			weaponAttack: 80,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/13_red_hinkel.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Golden Arund",
			pointsReq: 10000000,
			mesosCost: 38500,
			weaponAttack: 85,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/14_golden_arund.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Legendary Maple Stormsinger",
			pointsReq: 12000000,
			mesosCost: 40000,
			weaponAttack: 87,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/15_legendary_maple_stormsinger.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Metus",
			pointsReq: 15000000,
			mesosCost: 45000,
			weaponAttack: 90,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/16_metus.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "White Nisrock",
			pointsReq: 20000000,
			mesosCost: 52500,
			weaponAttack: 95,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/17_white_nisrock.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Dragon Shiner Bow",
			pointsReq: 30000000,
			mesosCost: 60000,
			weaponAttack: 100,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/18_dragon_shiner_bow.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Timeless Engaw",
			pointsReq: 50000000,
			mesosCost: 70000,
			weaponAttack: 107,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/19_timeless_engaw.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Maple Treasure Longbow",
			pointsReq: 60000000,
			mesosCost: 90000,
			weaponAttack: 123,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/20_maple_treasure_longbow.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "VIP Bow",
			pointsReq: 100000000,
			mesosCost: 120000,
			weaponAttack: 135,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/21_vip_bow.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Royal Von Leon Bow",
			pointsReq: 120000000,
			mesosCost: 140000,
			weaponAttack: 145,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/22_royal_von_leon_bow.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Meister Battle Bow",
			pointsReq: 140000000,
			mesosCost: 180000,
			weaponAttack: 158,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/23_meister_battle_bow.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Lightseeker",
			pointsReq: 150000000,
			mesosCost: 250000,
			weaponAttack: 190,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/24_lightseeker.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Terminus Stormchaser",
			pointsReq: 200000000,
			mesosCost: 350000,
			weaponAttack: 205,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/25_terminus_stormchaser.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Arcane Umbra Bow",
			pointsReq: 300000000,
			mesosCost: 850000,
			weaponAttack: 260,
			sprite: "assets/images/bows/01_war_bow.png",
			icon: "assets/images/bows/icons/26_arcane_umbra_bow.png",
			untradable: false,
			handOffset: [[19, 29], [13, 18], [7, 17]],
			frameWidth: 50,
			frameHeight: 50,
		},
		{
			name: "Genesis Bow",
			pointsReq: 500000000,
			mesosCost: 1500000,
			weaponAttack: 320,
			sprite: "assets/images/bows/genesis_bow.png",
			icon: "assets/images/bows/icons/27_genesis_bow.png",
			untradable: false,
			handOffset: [[47, 51], [36, 45], [20, 44]],
			frameWidth: 50,
			frameHeight: 50,
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
