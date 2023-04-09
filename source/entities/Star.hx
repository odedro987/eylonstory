package entities;

import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Star extends FlxSprite
{
	var airFrames:Float;

	public function new(x:Float, y:Float)
	{
		super(x, y, AssetPaths.star_subi__png);
	}

	public function deploy(pos:FlxPoint, force:Float, angle:Float)
	{
		setPosition(pos.x, pos.y);
		velocity.set(force, 0);
		velocity.pivotDegrees(FlxPoint.get(0, 0), angle);
	}

	public function getAirFrames()
	{
		return airFrames;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		velocity.y += 500 * elapsed;

		angle += 600 * elapsed;

		airFrames += 1;
	}
}
