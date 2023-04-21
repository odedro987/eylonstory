package states;

import core.Formulas;
import core.GameStorage;
import core.Globals;
import entities.Arrow;
import entities.Mob;
import entities.MobSpawner;
import entities.Player;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxBitmapText;
import ui.DamageManager;
import ui.components.ExpBar;
import ui.components.Indicator;

class MissionState extends FlxState
{
	var missionIndex:Int;
	var killCount:Int;
	var score:Float;
	var arrowsMissed:Int;
	var arrowsHit:Int;

	var damageManager:DamageManager;
	var player:Player;
	var mobSpawner:MobSpawner;
	var indicator:Indicator;
	var floor:FlxSprite;
	var expBar:ExpBar;

	var levelText:FlxBitmapText;
	var missionScoreText:FlxBitmapText;
	var killCountText:FlxBitmapText;
	var powerText:FlxBitmapText;

	public function new(missionIndex:Int)
	{
		super();
		this.missionIndex = missionIndex;
		score = 0;
		killCount = 0;
		arrowsMissed = 0;
		arrowsHit = 0;
	}

	override public function create()
	{
		super.create();

		var bg = new FlxSprite(0, 0);
		bg.makeGraphic(FlxG.width, FlxG.height, 0xff148dd3);
		add(bg);
		floor = new FlxSprite(0, 380);
		floor.makeGraphic(FlxG.width, 100, 0xff098019);
		add(floor);

		player = new Player({
			level: GameStorage.store.playerLevel,
			maxMp: 10,
			mastery: 0.15,
			critChance: 0.2,
			critDamage: 1.1,
			currentExp: GameStorage.store.playerExp,
			expGoal: Formulas.calculateExpGoal(GameStorage.store.playerLevel + 1)
		});
		add(player);

		mobSpawner = new MobSpawner(GameData.MISSION_DATA[missionIndex].possibleMobs, GameData.MISSION_DATA[missionIndex].spawnRate);
		add(mobSpawner);

		damageManager = new DamageManager();
		add(damageManager);

		indicator = new Indicator();
		add(indicator);

		expBar = new ExpBar(0, 0, 500, 20, player.playerInfo.expGoal, 5);
		expBar.updateValue(GameStorage.store.playerExp);
		add(expBar);

		levelText = Globals.createBitmapText(30, 7, "Lvl: " + player.playerInfo.level, 1.25, false);
		add(levelText);
		missionScoreText = Globals.createBitmapText(30, 30, "Score: 0", 1.25, false);
		add(missionScoreText);
		killCountText = Globals.createBitmapText(30, 40, "Mobs left: " + GameData.MISSION_DATA[missionIndex].killGoal, 1.25, false);
		add(killCountText);
		powerText = Globals.createBitmapText(30, 50, "Power: 0%", 1.25, false);
		add(powerText);
	}

	function endMission()
	{
		var accuracy = Formulas.calculateAccuracy(arrowsHit, arrowsMissed);
		var repel = Formulas.calculateRepel(indicator.getRepel());
		FlxG.switchState(new GameOverState(score, accuracy, repel, missionIndex));
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		powerText.text = "Power: " + (Math.round(((player.shootForce - Globals.MIN_FORCE) / (Globals.MAX_FORCE - Globals.MIN_FORCE)) * 100 * 10) / 10);

		if (killCount >= GameData.MISSION_DATA[missionIndex].killGoal || indicator.getX() <= indicator.getStartX())
		{
			endMission();
		}

		var sorted = mobSpawner.members.filter(mob -> mob.alive);
		sorted.sort((mob1, mob2) -> Std.int(mob1.x - mob2.x));

		if (sorted.length > 0 && sorted[0].x < indicator.getX())
		{
			indicator.setFollow(sorted[0]);
		}

		FlxG.overlap(player.arrows, mobSpawner, (arrow:Arrow, mob:Mob) ->
		{
			if (!arrow.getIsConsumed() && !mob.isDying)
			{
				arrow.setIsConsumed(true);
				arrow.kill();
				arrowsHit++;
				var dmgObj = Formulas.getRandomDamage(player.playerInfo);
				var damageCap = Math.min(dmgObj.damage, mob.health);
				var isDead = mob.dealDamage(dmgObj.damage);
				damageManager.spawnDamage(mob.x + mob.width / 2, mob.y, dmgObj.damage, dmgObj.isCrit);

				if (isDead)
				{
					killCount++;
					killCountText.text = "Mobs left: " + (GameData.MISSION_DATA[missionIndex].killGoal - killCount);
					player.addExp(mob.mobData.exp);
					levelText.text = "Lvl: " + player.playerInfo.level;
					expBar.updateMax(player.playerInfo.expGoal);
					expBar.updateValue(player.playerInfo.currentExp);
				}

				var pointMultiplier = Formulas.calculatePointsMultiplier(mob.x, arrow.getAirFrames());
				score += Formulas.calculateDamageScore(pointMultiplier, damageCap);
				missionScoreText.text = "Score: " + score;
			}
		});

		FlxG.overlap(player.arrows, floor, (arrow:Arrow, floor:FlxSprite) ->
		{
			arrow.kill();
			arrowsMissed++;
		});
	}
}
