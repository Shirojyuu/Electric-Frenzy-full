package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.flixel.FlxGame;
	import flash.display.*;
	import org.flixel.FlxG;
	import org.flixel.FlxCamera;
	
	/**
	 * ...
	 * @author Alec Day
	 */
	public class Main extends FlxGame 
	{
		public function Main():void
		{
		super(640, 480, SplashScreen, 1, 60, 60, true);
		forceDebugger = true;
		FlxG.stage.align = StageAlign.TOP_LEFT;
			
			
	       toggle_fullscreen(StageDisplayState.FULL_SCREEN);
 
            // Create a listener for when the window is resized
            // This is needed for when the user changes the Flash window size without
            // clicking our button (for example by pressing escape on the keyboard instead)
            FlxG.stage.addEventListener(Event.RESIZE, window_resized);
 
        }
 
        /*
         * !!!!!
         *
         * The code in the next 2 functions will make your window go fullscreen in 4 easy steps
         *
         * !!!!!
        */
 
        // This is called when the user clicks the button.
        // By default, it will go to fullscreen if windowed, and windowed if fullscreen
        // Use the Force parameter to force it to go to a specific mode
        private function toggle_fullscreen(ForceDisplayState:String=null):void {
 
            // 1. Change the size of the Flash window to fullscreen/windowed
            //    This is easily done by checking stage.displayState and then setting it accordingly
            if (ForceDisplayState) {
                FlxG.stage.displayState = ForceDisplayState;
            } else {
                if (FlxG.stage.displayState == StageDisplayState.NORMAL) {
                    FlxG.stage.displayState = StageDisplayState.FULL_SCREEN;
                } else {
                    FlxG.stage.displayState = StageDisplayState.NORMAL;
                }
            }
 
            // The next function contains steps 2-4
            window_resized();
        }
 
        // This is called every time the window is resized
        // It's a separate function than toggle_fullscreen because we want to call it when the window
        // size changed even if the user didn't click the fullscreen button (eg by pressing escape to exit fullscreen mode)
        private function window_resized(e:Event = null):void 
		{
 
            // 2. Change the size of the Flixel game window
            //    We already changed the size of the Flash window, so now we need to update Flixel.
            //    Just update the FlxG dimensions to match the new stage dimensions from step 1
            FlxG.width = FlxG.stage.stageWidth / FlxCamera.defaultZoom;
            FlxG.height = FlxG.stage.stageHeight / FlxCamera.defaultZoom;
			FlxG.stage.scaleMode = StageScaleMode.EXACT_FIT;
 
        }
	}
}