package states;

import GameData.MapData;
import entities.Mob;
import entities.MobSpawner;
import entities.Player;
import entities.Star;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText;
import ui.DamageManager;
import ui.ExpBar;
import ui.Indicator;

class MapState extends FlxState
{
	var mapData:MapData;
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

	var missionScoreText:FlxBitmapText;
	var killCountText:FlxBitmapText;

	public function new(data:MapData)
	{
		super();
		mapData = data;
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
			level: 1,
			maxMp: 10,
			currentExp: 0,
			expGoal: Formulae.calculateExpGoal(2)
		});
		add(player);

		mobSpawner = new MobSpawner(mapData.possibleMobs, mapData.spawnRate);
		add(mobSpawner);

		damageManager = new DamageManager();
		add(damageManager);

		indicator = new Indicator();
		add(indicator);

		missionScoreText = Globals.createBitmapText(30, 30, "Score: 0", 1.25, false);
		add(missionScoreText);
		killCountText = Globals.createBitmapText(30, 40, "Mobs left: " + mapData.killGoal, 1.25, false);
		add(killCountText);

		expBar = new ExpBar(0, 0, 500, 20, player.playerInfo.expGoal, 5);
		add(expBar);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (killCount >= mapData.killGoal)
		{
			var accuracy = Math.round((starsHit / (starsMissed + starsHit)) * 100 * 100) / 100;
			var repel = Math.round(indicator.getRepel() * 100 * 100) / 100;
			FlxG.switchState(new GameOverState(score, accuracy, repel));
		}

		var sorted = mobSpawner.members.filter(mob -> mob.alive);
		sorted.sort((mob1, mob2) -> Std.int(mob1.x - mob2.x));

		if (sorted.length > 0 && sorted[0].x < indicator.getX())
		{
			indicator.setFollow(sorted[0]);
		}

		FlxG.overlap(player.stars, mobSpawner, (star:Star, mob:Mob) ->
		{
			if (!mob.isDying)
			{
				star.kill();
				starsHit++;
				var rnd = FlxG.random.float();
				var dmg = FlxG.random.int(1, 15) + (rnd >= 0.8 ? 15 : 0);
				var damageScore = Math.min(dmg, mob.health);
				var isDead = mob.dealDamage(dmg);
				damageManager.spawnDamage(mob.x + mob.width / 2, mob.y, dmg, rnd >= 0.8);

				if (isDead)
				{
					killCount++;
					killCountText.text = "Mobs left: " + (mapData.killGoal - killCount);
					player.addExp(mob.exp);
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
