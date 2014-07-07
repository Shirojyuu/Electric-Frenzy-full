package GameObjects
{
	import org.flixel.FlxParticle;
	import org.flixel.FlxEmitter;
	/**
	 * ...
	 * @author ...
	 */
	public class ExplodeFX extends FlxEmitter
	{
		[Embed(source = "gameSprites/explodeparticle.png")] private static var Part:Class;
		public function ExplodeFX(x:uint, y:uint) 
		{
			super(x, y, 20);
		
			for (var c:int = 0; c < 20; c++)
			{	
				var explo_particle:FlxParticle = new FlxParticle()
				explo_particle.loadGraphic(Part);
				explo_particle.blend = "add";
				add(explo_particle);
			}
			
			setXSpeed( -400, 400);
			setYSpeed( -400, 400);
			start(true, 0.8, 0.1, 0);
		}
		
		
	}

}