package states;

import GameStorage.MissionRecord;
import flixel.FlxG;
import flixel.FlxState;
import flixel.system.FlxSound;
import ui.MissionPanel;
import ui.Shop;

class MenuState extends FlxState
{
	override public function create()
	{
		super.create();
		FlxG.mouse.load(AssetPaths.cursor__png);

		if (FlxG.sound.music == null) // don't restart the music if it's already playing
		{
			FlxG.sound.playMusic(AssetPaths.login_screen__ogg, 1, true);
		}

		if (!GameStorage.hasLoaded)
		{
			GameStorage.init();
			var hasData = GameStorage.load();

			if (!hasData)
			{
				var emptyRecord:Array<MissionRecord> = [];
				for (i in 0...GameData.MISSION_DATA.length)
				{
					emptyRecord.push({highscore: 0, attempts: 0});
				}

				GameStorage.initStore({
					playerLevel: 1,
					playerExp: 0,
					playerMesos: 0,
					playerGP: 0,
					playerCurrentBow: 0,
					ownedBows: [{bowIndex: 0, bonusWatk: 0, scrollSlots: 7}],
					missionRecords: emptyRecord
				});
			}
		}

		add(Globals.createBitmapText(120, 20, "GP: " + GameStorage.store.playerGP, 2, false));
		add(Globals.createBitmapText(120, 40, "Mesos: " + GameStorage.store.playerMesos, 2, false));
		add(new MissionPanel(FlxG.width, 10));

		add(new Shop(20, 60));
	}
}
