package GameObjects 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import GameObjects.Registry;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class RankImage extends FlxSprite
	{
		[Embed(source = "../sprites/RankImages.png")] private var imageSrc:Class;
		public function RankImage(x:uint, y:uint, rankNumber:uint) 
		{
			super(x, y);
			loadGraphic(imageSrc, true, false, 226, 38);
			
			addAnimation("D", [4], 0, true);
			addAnimation("C", [3], 0, true);
			addAnimation("B", [2], 0, true);
			addAnimation("A", [1], 0, true);
			addAnimation("S", [0], 0, true);
			
			switch(rankNumber)
			{
				case 0:
					play("D");
					break;
				
				case 1:
					play("C");
					break;
					
				case 2:
					play("B");
					break;
					
				case 3:
					play("A");
					break;
					
				case 4:
					play("S");
					break;
					
				
			}
		}
		
	}

}