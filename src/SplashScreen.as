package  
{
	import adobe.utils.CustomActions;
	import flash.events.TimerEvent;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.FloodFillFX;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class SplashScreen extends FlxState
	{
		[Embed(source = "fx/dragonroar.mp3")] private static var Roar:Class;
		[Embed(source = "sprites/Logo.png")] private static var Logo:Class;
		private static var timer:Timer = new Timer(45, 140);
		
		private var flood:FloodFillFX;
		private var dE_logo:FlxSprite;
		
		public function SplashScreen() 
		{
			
		}
		
		override public function create():void
		{
			FlxG.bgColor = FlxG.WHITE;
			
			
			//	Test specific
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			
			var pic:FlxSprite = new FlxSprite(0, 0, Logo);
			
			flood = FlxSpecialFX.floodFill();
			
			dE_logo = flood.create(pic, 15, 180, pic.width, pic.height);
			
			add(dE_logo);
			flood.start(0);
			
			timer.start();
		}
		
		override public function update():void
		{
			super.update();
			if (timer.currentCount == 94) FlxG.play(Roar);
			
			if (timer.currentCount == 140) 
			{
				FlxG.fade(FlxG.WHITE, 1, switcher);
			}
		}
		
		public function switcher():void
		{
			FlxG.switchState(new TopMenu);
		}
		override public function destroy():void
		{
			//	Important! Clear out the plugin, otherwise resources will get messed right up after a while
			FlxSpecialFX.clear();
			
			super.destroy();
		}
	}

}