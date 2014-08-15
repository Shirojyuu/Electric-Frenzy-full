package GameObjects 
{
	import org.flixel.FlxSprite;
	import GameObjects.Registry;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class TitleCard extends FlxSprite
	{
		
		public function TitleCard(cardPic:Class) 
		{
			super(0, 0, cardPic);
		}
		
	}

}