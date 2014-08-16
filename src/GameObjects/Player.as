package GameObjects 
{

	import flash.events.TimerEvent;
	import org.flixel.*;
	/**
	 * ...
	 * @author Alec Day
	 */
	import GameObjects.Registry;
	import flash.utils.Timer;
	public class Player extends FlxSprite
	{
		[Embed(source = "gameSprites/Plug SS6.png")] public var playerGFX:Class;
		[Embed(source = "gameSprites/trail.png")] private static var Part:Class;
		public var hackTimer:Timer = new Timer(500, 2);
		
		public var exhaust:FlxEmitter;
		public var explosion:FlxEmitter;
		public var numParticles:int = 10;
		
		public var surfSpeed:int;
		public var speedCap:FlxPoint;
		private var states:Array;
		public var playerState:String = new String();
		public var playerStatus:int;
		public var controlRestriction:Boolean = false;
		public var attacking:Boolean = false;
		private var hackPath:FlxPath;
		public var deathFlag:Boolean = false;
		public var playerDead:Boolean = false;
		
		
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
			resetPhysics();

			exhaust = new FlxEmitter(x, y, numParticles);
			explosion = new FlxEmitter(x, y, 100);
			explosion.visible = false;
			exhaust.setSize(20, 20);
			exhaust.setXSpeed(-3, 3);
			exhaust.setYSpeed(0, 0);
			exhaust.lifespan = 0.1;
			
			
			for (var c:int = 0; c < 100; c++)
			{	
				var explo_particle:FlxParticle = new FlxParticle()
				explo_particle.loadGraphic(Part);
				explo_particle.blend = "add";
				explosion.add(explo_particle);
			}
			
			for (var b:int = 0; b < numParticles; b++)
			{	
				var particle:FlxParticle = new FlxParticle()
				particle.loadGraphic(Part);
				particle.blend = "add";
				exhaust.add(particle);
			}	
			exhaust.start(false, 1.5, 0.1, 0);
			
		}
		
		public function resetPhysics():void 
		{
			drag.x = 1100;
			drag.y = 1200;
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
			addAnimation("idle", [0,0,0,0,1,1,1,2,2,1,1,1,1,], 40, false);
			addAnimation("goUp", [8], 40, false);
			addAnimation("goDn", [9], 40, false);
			addAnimation("brake", [10], 40, false);
			addAnimation("surf", [3,3,3,3,3,3,4,4,5,5,5,5,5,5,5,5,4,4,4,4,4], 40, false);
			addAnimation("hack", [6, 7, 6, 7, 6, 7 , 6 , 7], 60, true);
			addAnimation("frenzy", [11,12,13], 60, true);
			
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
			states.push("frenzy");
			
			playerState = "idle";
			hackTimer.addEventListener(TimerEvent.TIMER_COMPLETE,attackFlagReset);
			
			
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
			
			if (FlxG.keys.justPressed("X"))
			{
				playerState = "hack";
				hackAttack();
			}
			
			if (velocity.x == 0 && !FlxG.keys.any())
			{
				
				if (playerState != "frenzy" || playerState != "hack")
				{
					playerState = "idle";
				}
				
				else if (playerState == "frenzy")
				{
					play("frenzy");
				}
			}
			}
			
			if (FlxG.keys.justPressed("ENTER"))
			{
				play("hack");
			}
			
			//Player Movement
			if (FlxG.keys.RIGHT)
			{
				velocity.x += surfSpeed;
				
				if (playerState != "frenzy" || playerState != "hack")
				{
					playerState = "move"
					play("surf");
				}
				
				else if (playerState == "frenzy")
				{
					play("frenzy");
				}
			}
			
			if (FlxG.keys.LEFT)
			{
				if (x > 0)
				{
				velocity.x -= surfSpeed;
				
				if (playerState != "frenzy" || playerState != "hack")
				{
					playerState = "move"
					play("brake");
				}
				
				else if (playerState == "frenzy")
				{
					play("frenzy");
				}
				}
			}
			
			if (FlxG.keys.UP)
			{
				velocity.y -= surfSpeed;
				
				if (playerState != "frenzy" || playerState != "hack")
				{
					playerState = "move"
					play("goUp");
				}
				
				else if (playerState == "frenzy")
				{
					play("frenzy");
				}
			}	
				
			if (FlxG.keys.DOWN)
			{
				
				velocity.y += surfSpeed;
				
				if (playerState != "frenzy" || playerState != "hack" )
				{
					playerState = "move"
					play("goDn");
				}
				
				else if (playerState == "frenzy")
				{
					play("frenzy");
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
			
			if (playerState == "frenzy")
			{
				play("frenzy");
			
			attacking = true;
			drag.x = 900;
			drag.y = 900;
			surfSpeed = 90;
			speedCap = new FlxPoint(850, 850);
			}
			
			if (health <= 0 && !deathFlag)
			{
				FlxG.music.stop();
				FlxG.play(Registry.KillSound);
				deathFlag = true;
				kill();
			}
		}
		
		public function hackAttack():void
		{
			hackTimer.start();
			FlxG.play(Registry.HackSound);
			attacking = true;
			play("hack", true);
			hackPath = new FlxPath();
			hackPath.addPoint(new FlxPoint(x, y), false);
			hackPath.addPoint(new FlxPoint(x + 30, y), false);
			followPath(hackPath, 800, PATH_HORIZONTAL_ONLY, false);
			
		}
		
		public function attackFlagReset(e:TimerEvent):void
		{
			attacking = false;
			playerState = "idle";
		}
		
		override public function kill():void
		{
			exhaust.visible = false;
			explosion.x = x;
			explosion.y = y;
			explosion.setXSpeed(-400, 400);
			explosion.setYSpeed(-400, 400);
			explosion.start(true, 2, 0.1, 0);
			
			FlxG.flash(0xffffffff, 3, deathScenarioEnd);
			alive = false;
			exists = false;
		}
		
		public function deathScenarioEnd():void
		{
			playerDead = true;
		}
	}

}