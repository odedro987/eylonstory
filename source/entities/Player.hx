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
	public var arrows:FlxTypedGroup<Arrow>;
	public var playerInfo:PlayerInfo;

	public var shootForce:Float;
	public var chargeSpeed:Float;

	var player:FlxSprite;

	public function new(data:PlayerInfo)
	{
		super(2);
		player = new FlxSprite(30, 310);
		player.loadGraphic(AssetPaths.player__png, true, 55, 70);
		add(player);

		arrows = new FlxTypedGroup<Arrow>();
		add(arrows);

		playerInfo = data;
		shootForce = Globals.MIN_FORCE;
		chargeSpeed = 300;
	}

	function shootArrow()
	{
		var arrow = arrows.recycle(Arrow);
		var midPoint = player.getMidpoint();
		var angle = midPoint.degreesTo(FlxG.mouse.getPosition());
		arrow.deploy(midPoint, shootForce, angle);

		shootForce = Globals.MIN_FORCE;
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

		if (FlxG.mouse.pressed && shootForce < Globals.MAX_FORCE)
		{
			shootForce += chargeSpeed * elapsed;
			if (shootForce > Globals.MAX_FORCE)
				shootForce = Globals.MAX_FORCE;
		}

		if (FlxG.mouse.justReleased)
		{
			shootArrow();
		}
	}
}
