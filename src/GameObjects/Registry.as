package GameObjects 
{
	/**
	 * ...
	 * @author Alec Day
	 */
	import org.flixel.*;
	public class Registry 
	{
		//Soundset
		
		[Embed(source = "../sprites/mapCSV_SAKCS_LVMap.csv", mimeType = "application/octet-stream")] public static var LvlSak:Class;
		[Embed(source = "../sprites/SCS tiles.png")] public static var Tileset:Class;
		[Embed(source = "../sprites/levelClearText.png")] public static var LevelClearText:Class;
		[Embed(source = "gameSprites/explodeparticle.png")] public static var ExPart:Class;
		[Embed(source = "../fx/collectKey.mp3")] public static var GetSound:Class;
		[Embed(source = "../fx/frenzy.mp3")] public static var FrenzySound:Class;
		[Embed(source = "../fx/damaged.mp3")] public static var DamagedSound:Class;
		[Embed(source = "../fx/hack.mp3")] public static var HackSound:Class;
		[Embed(source = "../fx/killEnemy.mp3")] public static var KillSound:Class;
		[Embed(source = "../fx/portal.mp3")] public static var PortalSound:Class;
		
		//Title Cards
		[Embed(source = "../sprites/SCS Title Card.png")] public static var TitleCard_SCS:Class;
		
		public static var enerTxt:energyHUD = new energyHUD();
		public static var pureTxt:pureHUD = new pureHUD();
		public static var percentage:int = 0;
		public static var collectedKeys:int = 0;
		public static var percentageTxt:FlxText = new FlxText(560, 0, 40, "", false);
		public static var explosion:ExplodeFX;
		public static var level:FlxTilemapExt;
		public static var statusHUD:StatusHUD;
		private static var singleton:Registry = null;
		private static var frenzySoundFX:FlxSound = new FlxSound();
		
		public static var levelRankNumber:uint = 0;
		public function Registry() 
		{
		}
		
	}

}