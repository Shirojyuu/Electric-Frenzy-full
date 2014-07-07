package GameObjects 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class pureHUD extends FlxSprite
	{
		[Embed(source = "hudSprites/pureHUD.png")] private var Embed:Class
		public function pureHUD() 
		{
			super(580, 35, Embed);
			scrollFactor.x = 0;
			scrollFactor.y = 0;
		}
		
	}

}