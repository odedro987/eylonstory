package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class GameOverState extends FlxState
{
	var points:Int;
	var accuracy:Float;
	var repel:Float;

	public function new(points:Int, accuracy:Float, repel:Float)
	{
		super();
		this.points = points;
		this.accuracy = accuracy;
		this.repel = repel;
	}

	override public function create()
	{
		super.create();

		add(new FlxText(FlxG.width / 2, FlxG.height / 2, 300, "Points: " + points, 16));
		add(new FlxText(FlxG.width / 2, FlxG.height / 2 + 30, 300, "Accuracy: " + accuracy + "%", 16));
		add(new FlxText(FlxG.width / 2, FlxG.height / 2 + 60, 300, "Repel: " + repel + "%", 16));
	}
}
