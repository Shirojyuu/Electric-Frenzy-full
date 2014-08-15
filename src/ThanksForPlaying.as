package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class ThanksForPlaying extends FlxState
	{
		[Embed(source = "sprites/Thanks.png")] private var thanksPic:Class;
		public function ThanksForPlaying() 
		{
			
			var picture:FlxSprite = new FlxSprite(0, 0, thanksPic);
			add(picture);
		}
		
		override public function create():void
		{
			FlxG.flash(0x00000000, 2);
		}
		
		override public function update():void
		{
			if (FlxG.keys.justPressed("ENTER"))
			{
				FlxG.fade(0xff000000, 3, reset);
			}
		}
	
		public function reset():void
		{
			FlxG.resetGame();
		}
	}
}