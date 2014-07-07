package GameObjects 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class StatusHUD extends FlxSprite
	{
		[Embed(source = "hudSprites/StatusIcons.png")] private var Graphics:Class;
		public var statusID:int;
		public function StatusHUD(x:uint, y:uint, initStatusID:int) 
		{
			super(x, y);
			statusID = initStatusID;
			loadGraphic(Graphics, true, false, 50, 32, true);
			
			addAnimation("OK", [0], 0, true);
			addAnimation("POI", [1], 0, true);
			addAnimation("PAR", [2], 0, true);
			addAnimation("SLO", [3], 0, true);
		}
		
		override public function update():void
		{
			switch(statusID)
			{
				case 0:
					play("OK");
					break;
				case 1:
					play("POI");
					break;
				case 2:
					play("PAR");
					break;
				case 3:
					play("SLO");
					break;
			}
			
			super.update();
		}
		
	}

}