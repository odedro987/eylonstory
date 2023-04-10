package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class GameOverState extends FlxState
{
	var points:Int;
	var score:Float;
	var accuracy:Float;
	var repel:Float;

	public function new(score:Float, accuracy:Float, repel:Float)
	{
		super();
		this.score = score;
		this.accuracy = accuracy;
		this.repel = repel;
		this.points = Math.round(((score * accuracy) * repel) * 0.001);
	}

	override public function create()
	{
		super.create();

		add(new FlxText(FlxG.width / 2, FlxG.height / 2, 300, "Score: " + score, 16));
		add(new FlxText(FlxG.width / 2, FlxG.height / 2 + 30, 300, "Accuracy: " + accuracy + "%", 16));
		add(new FlxText(FlxG.width / 2, FlxG.height / 2 + 60, 300, "Repel: " + repel + "%", 16));
		add(new FlxText(FlxG.width / 2, FlxG.height / 2 + 90, 300, "Total: " + points, 16));
	}
}
