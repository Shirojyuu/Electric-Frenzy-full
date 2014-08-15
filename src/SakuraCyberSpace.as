package  
{
	import adobe.utils.CustomActions;
	import flash.accessibility.Accessibility;
	import flash.events.TimerEvent;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	import GameObjects.*;
	import GameObjects.dataKeyCollect;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	import org.flixel.plugin.photonstorm.FX.GlitchFX
	import flash.utils.Timer;
	import XML;
	/**
	 * ...
	 * @author Alec Day
	 */
	
	
	public class SakuraCyberSpace extends FlxState
	{
		[Embed(source = "sprites/scsBG.png")] private var scsBG:Class;
		[Embed(source = "music/TRK_SAK2.mp3")] private var music:Class;
		
		//Booleans
		private var gameStarted:Boolean = false;
		private var stageClear:Boolean = false;
		
		//Active Objects
		private var player:Player = new Player(15, 300);
		private var enemies:Array = new Array();
		private var enemySpawnTimer:FlxTimer = new FlxTimer();
		private var lifeTimer:Timer = new Timer(1000, 0);
		private var titleCardTimer:Timer = new Timer(1000, 3);
		private var levelClearTimer:Timer = new Timer(1000, 3);
		private var frenzyTimer:Timer = new Timer(50, 0);
		private var refillTimer:Timer = new Timer(5, 200);
		private var dataKeys:Array = new Array();
		private var dKC:dataKeyCollect;
		private var exitPortal:Portal;
		
		public var frenSnd:FlxSound;
		
		//Enemy Counts
		private var stageCorruption:int = 0;
		//Groups
		private var allEnemies:FlxGroup = new FlxGroup();
		private var allKeys:FlxGroup = new FlxGroup();
		private var totalKeysInStage:int;
		
		//Objects
		
		public var srcXML:FlxXML = new FlxXML();
		public var dstXML2:XML;
		public var xmlTest:XMLDocument;
		[Embed(source = "XMLUtilities/Level_SCSFinal.xml", mimeType = "application/octet-stream")] public var levelXML:Class;
		
		//Beauty Objects
		private var levelBG:FlxSprite = new FlxSprite(0, 0, scsBG);
		private var stars:FlxSprite = new FlxSprite(0, 0);
		private var starField:StarfieldFX; 
		

		
		//HUD
		private var hudLayer:FlxGroup = new FlxGroup();
		private var healthBar:FlxBar = new FlxBar(0, 30, 1, 210, 10, null, null, 0, 100, true);
		private var specialBar:FlxBar = new FlxBar(0, 42, 1, 200, 8, null, null, 0, 50, true);
		private var titleCard:TitleCard = new TitleCard(Registry.TitleCard_SCS);
		Registry.statusHUD = new StatusHUD(220, 30, 0);
		
		public function SakuraCyberSpace() 
		{
			
		}
		
		override public function create():void
		{
			dstXML2 = srcXML.loadEmbedded(levelXML);
			xmlTest = new XMLDocument();
			xmlTest.ignoreWhite = true;
			xmlTest.parseXML(dstXML2.toXMLString());
			
			FlxG.playMusic(music);
			levelBG.scrollFactor.x = 0;
			levelBG.scrollFactor.y = 0;
			add(levelBG);
			Registry.level = new FlxTilemap();
			Registry.level.loadMap(new Registry.LvlSak, Registry.Tileset, 45, 45);
			

			//Special FX
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			
			var bkg:FlxSprite = stars.makeGraphic(7000, 480, 0x00000000);
			
			starField = FlxSpecialFX.starfield();

			
			starField.create(0, 0, Registry.level.width, Registry.level.height, 900, 1, 20 );
			starField.sprite = bkg;
			bkg.blend = "add";
			
			starField.setStarSpeed( -0.5, 0 );
			starField.setBackgroundColor(0x00);
			
			
			//end Special FX
			
			add(player.exhaust);
			
			var startingPosition:XMLNode = xmlTest.lastChild.lastChild.lastChild;
			player.x = startingPosition.attributes.x;
			player.y = startingPosition.attributes.y;
			player.controlRestriction = true;
			add(player);
			add(Registry.level);
			
			var endingPosition:XMLNode = xmlTest.lastChild.lastChild.firstChild;
			exitPortal = new Portal(endingPosition.attributes.x, endingPosition.attributes.y);
			exitPortal.immovable = true;
			add(exitPortal);
			
			dstXML2 = srcXML.loadEmbedded(levelXML);
			xmlTest = new XMLDocument();
			xmlTest.ignoreWhite = true;
			xmlTest.parseXML(dstXML2.toXMLString());
			
			allKeys = parseKeys(xmlTest.firstChild.firstChild);
			totalKeysInStage = xmlTest.firstChild.firstChild.childNodes.length;
			
			var enemiesNodePath:XMLNode = xmlTest.firstChild.childNodes[1];
			allEnemies = parseEnemies(enemiesNodePath);
			
			add(allKeys);
			add(allEnemies);
			add(starField.sprite);
			
			healthBar.scrollFactor.x = 0;
			healthBar.scrollFactor.y = 0;
			healthBar.color = 0xff00ff00;
			
			specialBar.currentValue = 50;
			specialBar.scrollFactor.x = 0;
			specialBar.scrollFactor.y = 0;
			specialBar.color = 0x0088ff;
			
			frenSnd = new FlxSound()
			frenSnd.loadEmbedded(Registry.FrenzySound);
			Registry.percentageTxt.scale.x = 2;
			Registry.percentageTxt.scale.y = 2;
			Registry.percentageTxt.scrollFactor.x = 0;
			Registry.percentageTxt.scrollFactor.y = 0;
			Registry.percentageTxt.shadow = 3;
			Registry.statusHUD.scrollFactor.x = 0;
			Registry.statusHUD.scrollFactor.y = 0;
			titleCard.scrollFactor.x = 0;
			titleCard.scrollFactor.y = 0;
			hudLayer.add(Registry.percentageTxt);
			hudLayer.add(Registry.enerTxt);
			hudLayer.add(Registry.pureTxt);
			hudLayer.add(Registry.statusHUD);
			hudLayer.add(healthBar);
			hudLayer.add(specialBar);
			hudLayer.add(titleCard);
			add(hudLayer);
			

			titleCardTimer.addEventListener(TimerEvent.TIMER_COMPLETE, gameStart);
			lifeTimer.addEventListener(TimerEvent.TIMER, drainLife);
			levelClearTimer.addEventListener(TimerEvent.TIMER_COMPLETE, switchToThanks);
			frenzyTimer.addEventListener(TimerEvent.TIMER, frenzyDrainLife);
			refillTimer.addEventListener(TimerEvent.TIMER, frenzyRefill);
			titleCardTimer.start();
		}
		
		public function parseKeys(node:XMLNode):FlxGroup
		{
			var keys:FlxGroup = new FlxGroup();

			var kids:Array = node.childNodes;
			for each(var item:XMLNode in kids)
			{
				parseKey(item, keys);
			}
			
            return keys;
		}
		
		public function parseKey(node:XMLNode, keys:FlxGroup):void
		{
			var item:dataKeyCollect = new dataKeyCollect(0, 0);
            item.x = node.attributes.x;
            item.y = node.attributes.y;
            keys.add(item);
		}
		
		public function parseEnemies(node:XMLNode):FlxGroup
		{
			var enemies:FlxGroup = new FlxGroup();

			var kids:Array = node.childNodes;
			for each(var item:XMLNode in kids)
			{
				parseEnemy(item, enemies);
			}
			
            return enemies;
		}
		
		
		public function parseEnemy(node:XMLNode, enemies:FlxGroup):void
		{
			if (node.attributes.type == "malware")
			{
				var item:EnemyMalware = new EnemyMalware(0, 0);
				item.x = node.attributes.x;
				item.y = node.attributes.y;
				trace(item.x);
				
			}
				enemies.add(item);
				//item.moveToTarget(player);
		}
		
		override public function update():void
		{
			FlxG.camera.setBounds(0, 0, Registry.level.width, Registry.level.height, true);
			
			FlxG.camera.follow(player, FlxCamera.STYLE_LOCKON);
			
			healthBar.currentValue = player.health;
			Registry.percentage = (Registry.collectedKeys / totalKeysInStage)*100 - stageCorruption;
			Registry.percentageTxt.text = Registry.percentage.toString() + "%";
			
			super.update();
			
			
			if(gameStarted)
			{
			
			if (FlxG.keys.justPressed("F") && specialBar.currentValue > 0)
			{
				FlxG.flash(0xffffff, 0.3);
				player.playerState = "frenzy";
				frenzyTimer.start();
				frenSnd.play();
				
			}
			
			if (FlxG.keys.justPressed("R") && specialBar.currentValue == 0)
			{
				refillTimer.start();
				
			}

			
			if (specialBar.currentValue == 0)
			{
				frenSnd.stop();
				frenzyTimer.stop();
				player.resetPhysics();
				player.playerState = "idle";
			}
			
			Registry.statusHUD.statusID = player.playerStatus;

			//Collision and Overlaps
			FlxG.overlap(player, allKeys, obtainDataKey);
			FlxG.collide(player, Registry.level, buzz);
			FlxG.collide(player, allEnemies, damageCheck);
			FlxG.collide(player, exitPortal, touchPortal);

			}
			
			if (Registry.collectedKeys == totalKeysInStage && !stageClear)
			{
				FlxG.flash(0xffffff, 1, endLevelAsClear, false);
				stageClear = true;
			}
		}
		
		public function obtainDataKey(plr:Player, key:FlxBasic):void
		{
			FlxG.play(Registry.GetSound);
			Registry.explosion = new ExplodeFX(plr.x, plr.y);
			var explosion:ExplodeFX = Registry.explosion;
			add(explosion);
			key.kill();
			Registry.collectedKeys += 1;
			
			if(player.health < 100)
				player.health += 1;
		}
		
		public function damageCheck(obj:Player, enem:EnemyMalware):void
		{
			if (!player.attacking)
			{
			FlxG.play(Registry.DamagedSound);
			enem.kill();
			player.velocity.x = -140;
			player.health -= 10;
			FlxG.camera.shake(0.01, 1);
			stageCorruption += 3;
			}
			
			if (player.attacking)
			{
			FlxG.play(Registry.KillSound);
			enem.kill();
			stageCorruption -= 1;
			player.attacking = false;
			}
		}
		public function buzz(obj:Player, enem:FlxTilemap):void
		{
			FlxG.camera.shake(0.01, 0.01);
		}

		override public function destroy():void
		{
			//	Important! Clear out the plugin, otherwise resources will get messed right up after a while
			FlxSpecialFX.clear();
			
			super.recycle();
		}
		
		private function drainLife(event:TimerEvent):void
		{
			if (player.playerState != "frenzy")
				player.health-= 2;
		}
		
		private function frenzyDrainLife(event:TimerEvent):void
		{
				this.specialBar.currentValue -= 1;
				player.health -= 1;
		}
		
		private function frenzyRefill(event:TimerEvent):void
		{
				this.specialBar.currentValue++;
		}
		
		
		private function gameStart(event:TimerEvent):void
		{
			titleCard.kill();
			lifeTimer.start();
			player.controlRestriction = false;
			gameStarted = true;
			
		}
		
		private function switchToThanks(event:TimerEvent):void
		{
			FlxG.music.kill();
			this.destroy();
			FlxG.switchState(new ThanksForPlaying);
			
		}
		
		private function touchPortal(a:Player, b:Portal):void
		{
			a.visible = false;
			FlxG.play(Registry.PortalSound);
			FlxG.music.stop();
			endLevelAsClear();
		}
		
		private function endLevelAsClear():void
		{
			var levelCT:FlxSprite = new FlxSprite(0, 240, Registry.LevelClearText);
			levelCT.scrollFactor.x = 0;
			levelCT.scrollFactor.y = 0;
			player.controlRestriction = true;
			levelClearTimer.start();
			add(levelCT);
			
		}
		
	}

	
}