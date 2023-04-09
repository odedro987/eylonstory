import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class DamageManager extends FlxTypedGroup<FlxBasic>
{
	var damageUnits:FlxTypedGroup<DamageUnit>;
	var crits:FlxTypedGroup<FlxSprite>;

	public function new()
	{
		super(2);
		crits = new FlxTypedGroup<FlxSprite>();
		add(crits);
		damageUnits = new FlxTypedGroup<DamageUnit>();
		add(damageUnits);
	}

	public function spawnDamage(x:Float, y:Float, damage:Int, isCrit:Bool)
	{
		var str = Std.string(damage);
		var mid = str.length % 2 == 0 ? x - 39 : x;
		var space = isCrit ? 30 : 20;
		if (isCrit)
		{
			var crit = crits.recycle(DamageCrit);
			crit.x = mid - space * Math.floor(str.length / 2) - 30;
			crit.y = y - 20;
		}

		for (i in 0...str.length)
		{
			var unit = damageUnits.recycle(DamageUnit);
			unit.loadDamageGraphic(Std.parseInt(str.charAt(i)), isCrit);
			unit.y = y + (i % 2) * 3;
			if (i == 0)
			{
				unit.scale.set(1.25, 1.25);
			}
			unit.x = mid + space * (i - Math.floor(str.length / 2));
		}
	}
}

private class DamageUnit extends FadingSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic(AssetPaths.damage_font__png, true, 39, 40);
	}

	override function resetState()
	{
		super.resetState();
	}

	public function loadDamageGraphic(damageUnit:Int, isCrit:Bool)
	{
		animation.frameIndex = damageUnit + (isCrit ? 10 : 0);
	}
}

private class DamageCrit extends FadingSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic(AssetPaths.crit_damage__png, true, 61, 57);
	}

	override function resetState()
	{
		super.resetState();
	}
}

private class FadingSprite extends FlxSprite
{
	var lifeTimer:Float;

	public function new(x:Float, y:Float)
	{
		super(x, y);
		velocity.y = -20;
		lifeTimer = 0;
	}

	public function resetState()
	{
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
