import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class DamageManager
{
	public var damageUnits:FlxTypedGroup<DamageUnit>;

	public function new()
	{
		damageUnits = new FlxTypedGroup<DamageUnit>();
	}

	public function spawnDamage(x:Float, y:Float, damage:Int)
	{
		var str = Std.string(damage);
		var mid = str.length % 2 == 0 ? x - 39 : x;
		for (i in 0...str.length)
		{
			var unit = damageUnits.recycle(DamageUnit);
			unit.load(Std.parseInt(str.charAt(i)));
			unit.y = y + (i % 2) * 3;
			if (i == 0)
			{
				unit.scale.set(1.25, 1.25);
			}
			unit.x = mid + 20 * (i - Math.floor(str.length / 2));
		}
	}
}

private class DamageUnit extends FlxSprite
{
	var lifeTimer:Float;

	public function new(x:Float, y:Float, damage:Int)
	{
		super(x, y);

		loadGraphic(AssetPaths.damage_font__png, true, 39, 40);
		animation.frameIndex = damage;
		velocity.y = -20;

		lifeTimer = 0;
	}

	public function load(damageUnit:Int)
	{
		animation.frameIndex = damageUnit;
		lifeTimer = 0;
		alpha = 1;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		lifeTimer += elapsed * 1.5;
		alpha = 1 - lifeTimer * lifeTimer * lifeTimer;

		if (lifeTimer == 1)
		{
			kill();
		}
	}
}
