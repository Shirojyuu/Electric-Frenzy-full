package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.FlxGame;
	
	/**
	 * ...
	 * @author Alec Day
	 */
	public class Main extends FlxGame 
	{
		public function Main():void
		{
		super(640, 480, TopMenu, 1, 60, 60, true);
		forceDebugger = true;
		}
	}
	
}