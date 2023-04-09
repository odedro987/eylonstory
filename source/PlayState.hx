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
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		FlxG.overlap(player.stars, mobs, (star:Star, mob:Mob) ->
		{
			star.kill();
			mob.dealDamage(3);
			damageManager.spawnDamage(mob.x, mob.y, 3);
		});
	}
}
