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
		private var playGameButton:FlxExtendedSprite;
		private var optionsButton:FlxExtendedSprite;
		private var exitButton:FlxExtendedSprite;
		
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
			playGameButton.play("deselected");
			
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
			
			if (playGameButton.mouseOver)
				playGameButton.play("selected");
			else
				playGameButton.play("deselected");
			
				
			if (optionsButton.mouseOver)
				optionsButton.play("selected");
			else
				optionsButton.play("deselected");
				
			if (exitButton.mouseOver)
				exitButton.play("selected");
			else
				exitButton.play("deselected");

		}
		
		public function gameStart(a:FlxExtendedSprite,b:uint,c:uint):void
		{
			FlxG.switchState(new SakuraCyberSpace);
		}
		
		public function exit(a:FlxExtendedSprite,b:uint,c:uint):void
		{
			System.exit(0);
		}
	}

}