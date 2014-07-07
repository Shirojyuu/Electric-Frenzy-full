package GameObjects 
{
	import adobe.utils.CustomActions;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class Enemy1 extends FlxSprite
	{
		[Embed(source = "gameSprites/enemProto.png")] public var enemGFX:Class;
		
		public const maxSpeedY:Number = 800;
		
		public function Enemy1(x:uint, y:uint) 
		{
			super(x, y, enemGFX);
		}
		
		
		override public function update():void
		{
			acceleration.x = -40;
			var targetHeight:Number = 250;
			
			if (this.y > targetHeight)
			{
			  acceleration.y = -maxSpeedY;
			} 
			
			else if (this.y < targetHeight) 
			{
			  acceleration.y = maxSpeedY;
			}
			
		}
	}

}