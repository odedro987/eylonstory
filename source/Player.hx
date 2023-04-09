import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;

class Player extends FlxTypedGroup<FlxBasic>
{
	public var stars:FlxTypedGroup<Star>;

	var player:FlxSprite;

	var throwForce:Float;

	public function new()
	{
		super(2);
		player = new FlxSprite(30, 310);
		player.loadGraphic(AssetPaths.player__png, true, 55, 70);
		add(player);

		stars = new FlxTypedGroup<Star>();
		add(stars);

		throwForce = 300;
	}

	function throwStar()
	{
		var star = stars.recycle(Star);
		var midPoint = player.getMidpoint();
		var angle = midPoint.degreesTo(FlxG.mouse.getPosition());
		star.deploy(midPoint, throwForce, angle);

		throwForce = 300;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.pressed)
		{
			throwForce += 300 * elapsed;
		}

		if (FlxG.mouse.justReleased)
		{
			throwStar();
		}
	}
}
