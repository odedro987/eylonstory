package states;

import core.GameStorage;
import core.Globals;
import core.SoundManager;
import flixel.FlxG;
import flixel.FlxState;
import ui.MissionPanel;
import ui.SpriteButton;

class MenuState extends FlxState
{
	override public function create()
	{
		super.create();
		FlxG.mouse.load(AssetPaths.cursor__png);

		SoundManager.playOrContinue(AssetPaths.login_screen__ogg);

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
		add(new MissionPanel(FlxG.width - 280, 10));

		add(new SpriteButton(FlxG.width / 2, 20, AssetPaths.shop_button__png, 54, 34, () -> FlxG.switchState(new ShopState())));
	}
}
