import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;

class MobSpawner extends FlxTypedGroup<Mob>
{
	var possibleMobs:Array<String>;
	var spawnRate:Float;

	var timer:Float;

	public function new(possibleMobs:Array<String>, spawnRate:Float)
	{
		super();
		this.possibleMobs = possibleMobs;
		this.spawnRate = spawnRate;
		timer = 0;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		timer += elapsed;
		if (timer >= 5 / spawnRate)
		{
			timer = 0;
			var mob = recycle(Mob);
			mob.loadData(GameData.MOB_DATA[possibleMobs[FlxG.random.int(0, possibleMobs.length - 1)]]);
			mob.x = FlxG.width + FlxG.random.int(0, 50);
			mob.y = 380 - mob.height;
		}
	}
}
