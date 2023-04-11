package entities;

import GameData.MobData;
import flixel.FlxG;
import flixel.FlxSprite;

class Mob extends FlxSprite
{
	public var mobData:MobData;

	var hitTimer:Float;
	var isHit:Bool;
	var speed:Float;

	public var isDying:Bool;

	public function new()
	{
		super();
	}

	public function loadData(data:MobData)
	{
		mobData = data;

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

		health = data.health;
		speed = data.speed;
		velocity.x = -speed;

		hitTimer = 0;
		isHit = false;
		isDying = false;
	}

	public function dealDamage(damage:Int)
	{
		health -= damage;
		if (damage >= mobData.knockbackThreshold)
		{
			velocity.x = 0;
			animation.play("hit");
			x += 3;
			isHit = true;
		}

		return health < 0;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (isDying)
			return;

		if (isHit)
		{
			hitTimer += elapsed;
		}

		if (hitTimer >= Globals.FLICH_TIME)
		{
			hitTimer = 0;
			isHit = false;
			animation.play("move");
			velocity.x = -speed;
		}

		if (health <= 0)
		{
			isDying = true;
			animation.play("die");
			velocity.x = 0;
		}
	}
}
