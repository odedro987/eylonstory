import flixel.util.FlxSave;

typedef MissionRecord =
{
	var highscore:Int;
	var attempts:Int;
}

typedef BowRecord =
{
	var bowIndex:Int;
	var scrollSlots:Int;
	var bonusWatk:Int;
}

typedef Store =
{
	var playerLevel:Int;
	var playerExp:Int;
	var playerMesos:Int;
	var playerGP:Int;
	var playerCurrentBow:Int;
	var ownedBows:Array<BowRecord>;
	var missionRecords:Array<MissionRecord>;
}

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
			|| gameSave.data.missionRecords == null
			|| gameSave.data.playerCurrentBow == null
			|| gameSave.data.ownedBows == null)
		{
			trace("save data corrupted, resetting");
			gameSave.erase();
			return false;
		}

		store = {
			playerLevel: gameSave.data.playerLevel,
			playerExp: gameSave.data.playerExp,
			playerMesos: gameSave.data.playerMesos,
			playerGP: gameSave.data.playerGP,
			playerCurrentBow: gameSave.data.playerCurrentBow,
			ownedBows: gameSave.data.ownedBows,
			missionRecords: gameSave.data.missionRecords,
		}

		hasLoaded = true;
		return true;
	}
}
