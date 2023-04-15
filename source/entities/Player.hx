package entities;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

typedef PlayerInfo =
{
	var level:Int;
	var currentExp:Int;
	var expGoal:Int;
	var mastery:Float;
	var critChance:Float;
	var critDamage:Float;
	var maxMp:Int;
}

class Player extends FlxTypedGroup<FlxBasic>
{
	public var stars:FlxTypedGroup<Star>;
	public var playerInfo:PlayerInfo;

	public var throwForce:Float;
	public var chargeSpeed:Float;

	var player:FlxSprite;

	public function new(data:PlayerInfo)
	{
		super(2);
		player = new FlxSprite(30, 310);
		player.loadGraphic(AssetPaths.player__png, true, 55, 70);
		add(player);

		stars = new FlxTypedGroup<Star>();
		add(stars);

		playerInfo = data;
		throwForce = Globals.MIN_FORCE;
		chargeSpeed = 300;
	}

	function throwStar()
	{
		var star = stars.recycle(Star);
		var midPoint = player.getMidpoint();
		var angle = midPoint.degreesTo(FlxG.mouse.getPosition());
		star.deploy(midPoint, throwForce, angle);

		throwForce = Globals.MIN_FORCE;
	}

	public function addExp(amount:Int)
	{
		playerInfo.currentExp += amount;
		if (playerInfo.currentExp >= playerInfo.expGoal)
		{
			playerInfo.currentExp -= playerInfo.expGoal;
			playerInfo.level++;
			playerInfo.expGoal = Formulas.calculateExpGoal(playerInfo.level + 1);
		}

		GameStorage.store.playerLevel = playerInfo.level;
		GameStorage.store.playerExp = playerInfo.currentExp;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.pressed && throwForce < Globals.MAX_FORCE)
		{
			throwForce += chargeSpeed * elapsed;
			if (throwForce > Globals.MAX_FORCE)
				throwForce = Globals.MAX_FORCE;
		}

		if (FlxG.mouse.justReleased)
		{
			throwStar();
		}
	}
}
