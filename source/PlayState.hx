package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayState extends FlxState
{
	var damageManager:DamageManager;
	var player:Player;
	var mobs:FlxTypedGroup<Mob>;
	var indicator:Indicator;

	override public function create()
	{
		super.create();

		damageManager = new DamageManager();

		FlxG.mouse.load(AssetPaths.cursor__png);

		var bg = new FlxSprite(0, 0);
		bg.makeGraphic(FlxG.width, FlxG.height, 0xff148dd3);
		add(bg);
		var floor = new FlxSprite(0, 380);
		floor.makeGraphic(FlxG.width, 100, 0xff098019);
		add(floor);

		player = new Player();
		add(player);

		mobs = new FlxTypedGroup<Mob>();
		mobs.add(new Mob(GameData.MOB_DATA["green_snail"]));
		add(mobs);

		add(damageManager.damageUnits);

		indicator = new Indicator();
		add(indicator);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		var sorted = mobs.members.filter(mob -> mob.alive);
		sorted.sort((mob1, mob2) -> Std.int(mob1.x - mob2.x));

		if (sorted.length > 0 && sorted[0].x < indicator.getX())
		{
			indicator.setFollow(sorted[0]);
		}

		FlxG.overlap(player.stars, mobs, (star:Star, mob:Mob) ->
		{
			star.kill();
			mob.dealDamage(30);
			damageManager.spawnDamage(mob.x, mob.y, 30);
		});
	}
}
