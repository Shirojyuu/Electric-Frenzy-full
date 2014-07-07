package GameObjects 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class energyHUD extends FlxSprite
	{
		[Embed(source = "hudSprites/energyHUD.png")] private var Embed:Class
		public function energyHUD() 
		{
			super(0, 0, Embed);
			scrollFactor.x = 0;
			scrollFactor.y = 0;
		}
		
	}

}