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
		[Embed(source = "fx/select.mp3")] public static var Select:Class;
		[Embed(source = "fx/scrollMenu.mp3")] public static var Scroll:Class;
		
		private var playGameButton:FlxExtendedSprite;
		private var optionsButton:FlxExtendedSprite;
		private var exitButton:FlxExtendedSprite;
		
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
			optionsButton.mouseReleasedCallback = null;
			
			add(bg);
			add(playGameButton);
			add(optionsButton);
			add(exitButton);
			
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
						
					case 2:
						exit(null, 0, 0);
						break;
				}
			}
		}
		
		public function gameStart(a:FlxExtendedSprite,b:uint,c:uint):void
		{
			
			FlxG.fade(0xff000000, 1);
			
			FlxG.switchState(new SakuraCyberSpace);
		}
		
		public function exit(a:FlxExtendedSprite,b:uint,c:uint):void
		{
			FlxG.fade(0xff000000, 1);
			
			System.exit(0);
		}
	}

}