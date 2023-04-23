package core;

import flixel.util.FlxSave;

class GameStorage
{
	public static var gameSave:FlxSave;
	public static var store:Store;
	public static var hasLoaded:Bool = false;

	public static function init()
	{
		gameSave = new FlxSave();
		gameSave.bind("EylonStoryStore");
	}

	public static function initStore(initialStore:Store)
	{
		store = initialStore;
		hasLoaded = true;
	}

	public static function save()
	{
		gameSave.data.lastSave = Date.now().toString();
		gameSave.data.playerLevel = store.playerLevel;
		gameSave.data.playerExp = store.playerExp;
		gameSave.data.playerMesos = store.playerMesos;
		gameSave.data.playerGP = store.playerGP;
		gameSave.data.missionRecords = store.missionRecords;
		gameSave.data.playerCurrentBow = store.playerCurrentBow;
		gameSave.data.ownedBows = store.ownedBows;
		var totalPoints = 0;
		for (rec in store.missionRecords)
		{
			totalPoints += rec.highscore;
		}
		gameSave.data.totalPoints = totalPoints;
		gameSave.flush();
	}

	public static function load()
	{
		if (gameSave.data.lastSave == null)
		{
			return false;
		}

		if (gameSave.data.playerLevel == null
			|| gameSave.data.playerExp == null
			|| gameSave.data.playerMesos == null
			|| gameSave.data.playerGP == null
			|| gameSave.data.playerCurrentBow == null
			|| gameSave.data.totalPoints == null
			|| gameSave.data.missionRecords == null
			|| gameSave.data.ownedBows == null)
		{
			trace("save data corrupted, resetting save file");
			gameSave.erase();
			return false;
		}

		store = {
			playerLevel: gameSave.data.playerLevel,
			playerExp: gameSave.data.playerExp,
			playerMesos: gameSave.data.playerMesos,
			playerGP: gameSave.data.playerGP,
			playerCurrentBow: gameSave.data.playerCurrentBow,
			totalPoints: gameSave.data.totalPoints,
			ownedBows: gameSave.data.ownedBows,
			missionRecords: gameSave.data.missionRecords,
		}

		hasLoaded = true;
		return true;
	}
}

typedef Store =
{
	var playerLevel:Int;
	var playerExp:Int;
	var playerMesos:Int;
	var playerGP:Int;
	var playerCurrentBow:Int;
	var totalPoints:Int;
	var ownedBows:Array<BowRecord>;
	var missionRecords:Array<MissionRecord>;
}

typedef MissionRecord =
{
	var highscore:Int;
	var attempts:Int;
}

typedef BowRecord =
{
	var bowIndex:Int;
	var scrollSlots:Int;
	var successfulScrollCount:Int;
	var bonusWatk:Int;
}
