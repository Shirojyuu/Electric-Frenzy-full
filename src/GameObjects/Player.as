package GameObjects 
{

	import org.flixel.*;
	/**
	 * ...
	 * @author Alec Day
	 */
	import GameObjects.Registry;
	public class Player extends FlxSprite
	{
		[Embed(source = "gameSprites/Plug SS6.png")] public var playerGFX:Class;
		[Embed(source = "gameSprites/trail.png")] private static var Part:Class;
		
		public var exhaust:FlxEmitter;
		public var numParticles:int = 10;
		
		public var surfSpeed:int;
		public var speedCap:FlxPoint;
		private var states:Array;
		public var playerState:String = new String();
		public var playerStatus:int;
		public var controlRestriction:Boolean = false;
		
		public static const STAT_OK:int = 0;
		public static const STAT_POI:int = 1;
		public static const STAT_PAR:int = 2;
		public static const STAT_SLO:int = 3;
		
		public function Player(x:uint, y:uint) 
		{
			super(x, y);
			
			loadGraphic(playerGFX, true, false, 90, 90, true);
			
			initStates();
			initAnimations();
			initParams();
			initPhysics();

			exhaust = new FlxEmitter(x, y, numParticles);
			exhaust.setSize(20, 20);
			exhaust.setXSpeed(-3, 3);
			exhaust.setYSpeed(0, 0);
			exhaust.lifespan = 0.1;
			
			for (var b:int = 0; b < numParticles; b++)
			{	
				var particle:FlxParticle = new FlxParticle()
				particle.loadGraphic(Part);
				particle.blend = "add";
				exhaust.add(particle);
			}	
			exhaust.start(false, 1.5, 0.1, 0);
			
		}
		
		private function initPhysics():void 
		{
			drag.x = 1500;
			drag.y = 1500;
			surfSpeed = 35;
			speedCap = new FlxPoint(800, 800);
		}
		
		private function initParams():void 
		{

			health = 100;
			playerStatus = STAT_OK;
		}
		
		private function initAnimations():void 
		{
			addAnimation("idle", [0,0,0,0,1,1,1,2,2,1,1,1,1,], 40, true);
			addAnimation("goUp", [8], 40, false);
			addAnimation("goDn", [9], 40, false);
			addAnimation("brake", [10], 40, false);
			addAnimation("surf", [3,3,3,3,3,3,4,4,5,5,5,5,5,5,5,5,4,4,4,4,4], 40, false);
			addAnimation("hack", [6, 7, 6, 7, 6, 7 , 6 , 7], 60, true);
			
		}
		
		private function initStates():void
		{
			//States:
			//idle: doing nothing
			//attack: using frenzy
			//hack: using hack
			//teleport: using teleport
			states = new Array();
			states.push("idle");
			states.push("attack");
			states.push("hack");
			states.push("teleport");
			states.push("move");
			
			playerState = "idle";
		}
		
		override public function update():void
		{
			if(facing == RIGHT)
				exhaust.x = x;
				
			if (facing == LEFT)
				exhaust.x = x + 90;
				
			exhaust.y = y + 45;
			
			
			if (!controlRestriction)
			{
			if (velocity.x == 0 && !FlxG.keys.any())
			{
				playerState = "idle";
			}
			
			if (FlxG.keys.justPressed("ENTER"))
			{
				play("hack");
			}
			//Player Movement
			if (FlxG.keys.RIGHT)
			{
				velocity.x += surfSpeed;
				play("surf");
				playerState = "move";
			}
			
			if (FlxG.keys.LEFT)
			{
				if (x > 0)
				{
				velocity.x -= surfSpeed;
				play("brake");
				playerState = "move";
				}
			}
			
			if (FlxG.keys.UP)
			{
				velocity.y -= surfSpeed;
				play("goUp");
				playerState = "move";
			}	
				
			if (FlxG.keys.DOWN)
			{

				velocity.y += surfSpeed;
				play("goDn");
				playerState = "move";
			}
			}
			
			if(playerState == "idle")
			{
				play("idle");
			}
			
			if(playerState == "hack")
			{
				play("hack");
			}
		}
		
	}

}