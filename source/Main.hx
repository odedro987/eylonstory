package;

import flixel.FlxGame;
import openfl.display.Sprite;
import states.MenuState;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(840, 480, MenuState, 60, 60, true));
	}
}
