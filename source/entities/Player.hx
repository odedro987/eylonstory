package entities;

import core.Formulas;
import core.GameStorage;
import core.Globals;
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
	var bow:Bow;

	public function new(data:PlayerInfo)
	{
		super(3);
		player = new FlxSprite(30, 310);
		player.loadGraphic(AssetPaths.player__png, true, 70, 90);
		add(player);

		player.animation.add("idle", [0, 1, 2, 1], 3);
		player.animation.add("charge", [3, 4], 6, false);
		player.animation.add("release", [3], 6, false);
		player.animation.callback = (name, frameNumber, frameIndex) ->
		{
			if (name == "idle")
				bow.animation.frameIndex = 0;
			else
				bow.animation.frameIndex = frameIndex - 2;
			bow.setPosition(30 + Globals.HAND_POSITIONS[frameIndex][0], 310 + Globals.HAND_POSITIONS[frameIndex][1]);
		}
		player.animation.finishCallback = name ->
		{
			switch name
			{
				case "release":
					player.animation.play("idle");
			}
		}

		bow = new Bow(30, 310, GameData.BOW_DATA[GameStorage.store.ownedBows[GameStorage.store.playerCurrentBow].bowIndex]);
		add(bow);

		arrows = new FlxTypedGroup<Arrow>();
		add(arrows);

		playerInfo = data;
		shootForce = Globals.MIN_FORCE;
		chargeSpeed = 300;

		player.animation.play("idle");
	}

	function shootArrow()
	{
		player.animation.play("release");
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
			if (player.animation.curAnim.name != "charge")
			{
				player.animation.play("charge");
			}
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
