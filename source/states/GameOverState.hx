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

		add(Globals.createBitmapText(FlxG.width / 2, FlxG.height / 2, "Score: " + score, 2));
		add(Globals.createBitmapText(FlxG.width / 2, FlxG.height / 2 + 20, "Accuracy: " + accuracy + "%", 2));
		add(Globals.createBitmapText(FlxG.width / 2, FlxG.height / 2 + 40, "Repel: " + repel + "%", 2));
		add(Globals.createBitmapText(FlxG.width / 2, FlxG.height / 2 + 60, "Total: " + points, 2));
	}
}
