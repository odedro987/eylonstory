package states;

import core.GameStorage;
import core.Globals;
import core.SoundManager;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import ui.Inventory;
import ui.MissionPanel;
import ui.util.SpriteButton;

class MenuState extends FlxState
{
	var inventory:Inventory;

	override public function create()
	{
		super.create();
		FlxG.mouse.load(AssetPaths.cursor__png);

		var tooltipCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height, 1);
		tooltipCamera.bgColor = 0x00000000;
		FlxG.cameras.add(tooltipCamera, false);

		add(new FlxSprite(0, 0, AssetPaths.bg1__png));

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
					playerMesos: 10000,
					playerGP: 0,
					playerCurrentBow: 0,
					totalPoints: 0,
					ownedBows: [
						{
							bowIndex: 0,
							bonusWatk: 0,
							scrollSlots: 7,
							successfulScrollCount: 0
						}
					],
					missionRecords: emptyRecord
				});
			}
		}

		add(Globals.createBitmapText(120, FlxG.height - 20, "Ver. " + Globals.GAME_VERSION, 2, false));
		add(Globals.createBitmapText(120, 20, "GP: " + GameStorage.store.playerGP, 2, false));
		add(Globals.createBitmapText(120, 40, "Total Points: " + GameStorage.store.totalPoints, 2, false));
		add(new MissionPanel(FlxG.width - 280, 10));

		inventory = new Inventory(200, 40);
		inventory.exists = false;
		add(inventory);

		add(new SpriteButton(FlxG.width / 2, 20, AssetPaths.shop_button__png, 54, 34, () -> FlxG.switchState(new ShopState())));

		add(new SpriteButton(FlxG.width / 2 - 34, 20, AssetPaths.inventory_button__png, 34, 20, () -> toggleInventory()));
	}

	function toggleInventory()
	{
		inventory.exists = !inventory.exists;
	}
}
