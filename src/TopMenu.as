package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxMouseControl;
	import org.flixel.plugin.photonstorm.FlxExtendedSprite;
	import flash.system.System;
	import GameObjects.Registry;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class TopMenu extends FlxState
	{
		[Embed(source = "sprites/MainMenu.png")] public static var MenuPic:Class;
		[Embed(source = "sprites/MenuItems.png")] public static var MenuItems:Class;
		[Embed(source = "sprites/HelpScreen.png")] public static var HelpScreen:Class;
		[Embed(source = "music/TRK_CFS.mp3")] public static var MenuMusic:Class;
		[Embed(source = "fx/select.mp3")] public static var Select:Class;
		[Embed(source = "fx/scrollMenu.mp3")] public static var Scroll:Class;
		
		private var playGameButton:FlxExtendedSprite;
		private var optionsButton:FlxExtendedSprite;
		private var exitButton:FlxExtendedSprite;
		private var helpDisplay:FlxSprite = new FlxSprite(120, 80, HelpScreen);
		private var creatorNameText:FlxText = new FlxText(0, 0, 200, "2014 Alec Day");
		private var nowPlayingText:FlxText = new FlxText(0, 30, 800, "Now Playing: Cyber Folk Song - Stage Select Theme - Alec Day");
		private var menuCounter:int = 0;
		public function TopMenu() 
		{
			var bg:FlxSprite = new FlxSprite(0, 0, MenuPic);
			
			if (FlxG.getPlugin(FlxMouseControl) == null)
			{
				FlxG.addPlugin(new FlxMouseControl);
				
			}
			
		
			
			playGameButton = new FlxExtendedSprite(208, 330);
			playGameButton.loadGraphic(MenuItems, true, false, 272, 40);
			playGameButton.addAnimation("selected", [0], 0);
			playGameButton.addAnimation("deselected", [1], 0);
			playGameButton.play("selected");
			
			optionsButton = new FlxExtendedSprite(208, 380);
			optionsButton.loadGraphic(MenuItems, true, false, 272, 40);
			optionsButton.addAnimation("selected", [2], 0);
			optionsButton.addAnimation("deselected", [3], 0);
			optionsButton.play("deselected");
			
			exitButton = new FlxExtendedSprite(208, 430);
			exitButton.loadGraphic(MenuItems, true, false, 272, 40);
			exitButton.addAnimation("selected", [4], 0);
			exitButton.addAnimation("deselected", [5], 0);
			exitButton.play("deselected");
			
			playGameButton.enableMouseClicks(true, false, 255);
			optionsButton.enableMouseClicks(true, false, 255);
			exitButton.enableMouseClicks(true, false, 255);
			
			playGameButton.mouseReleasedCallback = gameStart;
			exitButton.mouseReleasedCallback = exit;
			optionsButton.mouseReleasedCallback = help;
			
			add(bg);
			add(playGameButton);
			add(optionsButton);
			add(exitButton);
			
			creatorNameText.size = 20;
			add(creatorNameText);
			add(nowPlayingText);
			
			helpDisplay.visible = false;
			add(helpDisplay);
			
			
		}
		
		override public function create():void
		{
			FlxG.playMusic(MenuMusic);
		}
		override public function update():void
		{
			super.update();
			
			if (playGameButton.mouseOver || menuCounter == 0)
				playGameButton.play("selected");
			else
				playGameButton.play("deselected");
			
				
			if (optionsButton.mouseOver || menuCounter == 1)
				optionsButton.play("selected");
			else
				optionsButton.play("deselected");
				
			if (exitButton.mouseOver || menuCounter == 2)
				exitButton.play("selected");
			else
				exitButton.play("deselected");
				
			if (FlxG.keys.justPressed("UP"))
			{
				FlxG.play(Scroll);
				menuCounter--;
			}
			
			if (FlxG.keys.justPressed("DOWN"))
			{
				FlxG.play(Scroll);
				menuCounter++;
			}
			
			if (menuCounter == -1)
			{
				menuCounter = 2;
			}
			
			if (menuCounter == 3)
			{
				menuCounter = 0;
			}
			
			if (FlxG.keys.justPressed("ENTER"))
			{
				FlxG.play(Select);
				switch(menuCounter)
				{
					case 0:
						gameStart(null, 0, 0);
						break;
						
					case 1:
						help(null, 0, 0);
						break;
						
					case 2:
						exit(null, 0, 0);
						break;
				}
			}
			
			if (helpDisplay.visible && FlxG.keys.justPressed("CONTROL"))
			{
				helpDisplay.visible = false;
			}
		}
		
		public function gameStart(a:FlxExtendedSprite,b:uint,c:uint):void
		{
			
			FlxG.fade(0xff000000, 1, levelStart);
			
			
		}
		
		public function help(a:FlxExtendedSprite, b:uint, c:uint):void
		{
			helpDisplay.visible = true;
		}
		
		public function exit(a:FlxExtendedSprite,b:uint,c:uint):void
		{
			FlxG.fade(0xff000000, 1);
			
			System.exit(0);
		}
		
		public function levelStart():void
		{
			FlxG.switchState(new SakuraCyberSpace);
		}
	}

}