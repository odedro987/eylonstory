package states;

import GameData.MapData;
import entities.Mob;
import entities.MobSpawner;
import entities.Player;
import entities.Star;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import ui.DamageManager;
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

		damageManager = new DamageManager();

		var bg = new FlxSprite(0, 0);
		bg.makeGraphic(FlxG.width, FlxG.height, 0xff148dd3);
		add(bg);
		floor = new FlxSprite(0, 380);
		floor.makeGraphic(FlxG.width, 100, 0xff098019);
		add(floor);

		player = new Player();
		add(player);

		mobSpawner = new MobSpawner(mapData.possibleMobs, mapData.spawnRate);
		add(mobSpawner);

		add(damageManager);

		indicator = new Indicator();
		add(indicator);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (killCount >= mapData.killGoal)
		{
			var accuracy = Math.round((starsHit / (starsMissed + starsHit)) * 100 * 100) / 100;
			var repel = Math.round(indicator.getRepel() * 100 * 100) / 100;
			var points = Math.round(((score * accuracy) * repel) * 0.001);
			FlxG.switchState(new GameOverState(points, accuracy, repel));
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
				}

				var pointMultiplier = (mob.x + 300) / (300 - Math.min(star.getAirFrames(), 80));
				score += Math.round((10 * pointMultiplier) * damageScore);
			}
		});

		FlxG.overlap(player.stars, floor, (star:Star, floor:FlxSprite) ->
		{
			star.kill();
			starsMissed++;
		});
	}
}
