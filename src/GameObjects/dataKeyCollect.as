package GameObjects 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxParticle;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class dataKeyCollect extends FlxSprite
	{
		[Embed(source = "gameSprites/dataKeySheet.png")] public var sprGFX:Class;
		
		
		public function dataKeyCollect(x:uint, y:uint) 
		{
			super(x, y);
			
			loadGraphic(sprGFX, true, false, 15, 15);
			addAnimation("idle", [0, 1 , 2 , 3, 2, 1], 30, true);
			
		}
		
		override public function update():void
		{
			play("idle");
			
		}
		
		
	}

}