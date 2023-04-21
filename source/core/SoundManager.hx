package core;

import flixel.FlxG;

class SoundManager
{
	static final GAME_MUSIC:Map<String, String> = [
		AssetPaths.login_screen__ogg => "login_menu",
		AssetPaths.cash_shop__ogg => "cash_shop"
	];

	static var currentMusic:String;
	static var isPlaying:Bool;

	public static function play(music:String)
	{
		stop();
		FlxG.sound.playMusic(music);
		currentMusic = GAME_MUSIC[music];
		isPlaying = true;
	}

	public static function playOrContinue(music:String)
	{
		if (isPlaying && currentMusic == GAME_MUSIC[music])
			return;

		stop();
		FlxG.sound.playMusic(music);
		currentMusic = GAME_MUSIC[music];
		isPlaying = true;
	}

	public static function stop()
	{
		FlxG.sound.pause();
		currentMusic = "";
		isPlaying = false;
	}

	public static function getCurrentMusic()
	{
		return currentMusic;
	}

	public static function getIsPlaying()
	{
		return isPlaying;
	}
}
