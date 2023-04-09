import GameData.MobData;
import flixel.FlxG;
import flixel.FlxSprite;

class Mob extends FlxSprite
{
	var exp:Int;
	var hitTimer:Float;
	var isHit:Bool;
	var speed:Float;

	static inline var FLICH_TIME = 0.5;

	public function new(data:MobData)
	{
		super(FlxG.width - 50, 380 - 33);
		loadGraphic(data.sprite, true, data.width, data.height);
		animation.add("idle", data.animations["idle"], 6);
		animation.add("move", data.animations["move"], 6);
		animation.add("hit", data.animations["hit"], 6, false);
		animation.add("die", data.animations["die"], 6, false);

		animation.finishCallback = name ->
		{
			if (name == "die")
			{
				kill();
			}
		}

		animation.play("move");

		exp = data.exp;
		health = data.health;
		speed = data.speed;
		velocity.x = -speed;

		hitTimer = 0;
		isHit = false;
	}

	public function dealDamage(damage:Int)
	{
		health -= damage;
		velocity.x = 0;
		animation.play("hit");
		x += 3;
		isHit = true;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (isHit)
		{
			hitTimer += elapsed;
		}

		if (hitTimer >= FLICH_TIME)
		{
			hitTimer = 0;
			isHit = false;
			animation.play("move");
			velocity.x = -speed;
		}

		if (health <= 0)
		{
			animation.play("die");
			velocity.x = 0;
		}
	}
}
