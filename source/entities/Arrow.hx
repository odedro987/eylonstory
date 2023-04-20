package entities;

import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;

class Arrow extends FlxSprite
{
	var airFrames:Float;
	var isConsumed:Bool;
	var lastPos:FlxPoint;

	public function new(x:Float, y:Float)
	{
		super(x, y, AssetPaths.arrow_normal__png);
		lastPos = FlxPoint.get(x, y);
	}

	public function deploy(pos:FlxPoint, force:Float, angle:Float)
	{
		setPosition(pos.x, pos.y);
		lastPos.set(pos.x, pos.y);
		velocity.set(force, 0);
		velocity.pivotDegrees(FlxPoint.get(0, 0), angle);
		this.angle = angle;
		isConsumed = false;
	}

	public function setIsConsumed(flag:Bool)
	{
		isConsumed = flag;
	}

	public function getIsConsumed()
	{
		return isConsumed;
	}

	public function getAirFrames()
	{
		return airFrames;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		velocity.y += 500 * elapsed;

		airFrames += 1;

		angle = getPosition().degreesFrom(lastPos);
		lastPos.set(x, y);
	}
}
