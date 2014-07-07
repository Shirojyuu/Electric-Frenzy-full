package GameObjects 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Alec Day
	 */
	
	
	public class Portal extends FlxSprite
	{
		[Embed(source = "gameSprites/Portal.png")] private var PortalSheet:Class
		
		public function Portal(x:uint, y:uint) 
		{
			super(x, y);
			loadGraphic(PortalSheet, true, false, 90, 135, true);
			addAnimation("idle", [0, 1, 2, 3, 4], 10, true);
			play("idle");
		}
		
	}

}