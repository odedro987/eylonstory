package states;

import entities.Mob;
import entities.MobSpawner;
import entities.Player;
import entities.Star;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxBitmapText;
import haxe.display.Display.Package;
import ui.DamageManager;
import ui.ExpBar;
import ui.Indicator;

class MissionState extends FlxState
{
	var missionIndex:Int;
	var killCount:Int;
	var score:Float;
	var starsMissed:Float;
	var starsHit:Float;

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
		starsMissed = 0;
		starsHit = 0;
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
			expGoal: Formulae.calculateExpGoal(GameStorage.store.playerLevel + 1)
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
		var accuracy = Math.round((starsHit / (starsMissed + starsHit)) * 100 * 100) / 100;
		var repel = Math.max(Math.round(indicator.getRepel() * 100 * 100) / 100, 0);
		FlxG.switchState(new GameOverState(score, accuracy, repel, missionIndex));
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		powerText.text = "Power: " + (Math.round(((player.throwForce - Globals.MIN_FORCE) / (Globals.MAX_FORCE - Globals.MIN_FORCE)) * 100 * 10) / 10);

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

		FlxG.overlap(player.stars, mobSpawner, (star:Star, mob:Mob) ->
		{
			if (!star.getIsConsumed() && !mob.isDying)
			{
				star.setIsConsumed(true);
				star.kill();
				starsHit++;
				var maxDmg = 20 * player.playerInfo.level * ((40 + 15) / 100);
				var minDmg = player.playerInfo.mastery * maxDmg;
				var dmg = Math.round(FlxG.random.float(minDmg, maxDmg));
				var isCrit = FlxG.random.float() <= player.playerInfo.critChance;
				if (isCrit)
				{
					dmg = Math.round(dmg * player.playerInfo.critDamage);
				}
				var damageScore = Math.min(dmg, mob.health);
				var isDead = mob.dealDamage(dmg);
				damageManager.spawnDamage(mob.x + mob.width / 2, mob.y, dmg, isCrit);

				if (isDead)
				{
					killCount++;
					killCountText.text = "Mobs left: " + (GameData.MISSION_DATA[missionIndex].killGoal - killCount);
					player.addExp(mob.mobData.exp);
					levelText.text = "Lvl: " + player.playerInfo.level;
					expBar.updateMax(player.playerInfo.expGoal);
					expBar.updateValue(player.playerInfo.currentExp);
				}

				var pointMultiplier = (mob.x + 350) / (350 - Math.min(star.getAirFrames(), 90));
				score += Math.round((10 * pointMultiplier) * damageScore);
				missionScoreText.text = "Score: " + score;
			}
		});

		FlxG.overlap(player.stars, floor, (star:Star, floor:FlxSprite) ->
		{
			star.kill();
			starsMissed++;
		});
	}
}
