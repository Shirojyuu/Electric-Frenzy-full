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
		
		[Embed(source = "../sprites/mapCSV_Group1_Map1.csv", mimeType = "application/octet-stream")] public static var LvlSak:Class;
		[Embed(source = "../sprites/SCS tiles.png")] public static var Tileset:Class;
		[Embed(source = "../sprites/levelClearText.png")] public static var LevelClearText:Class;
		[Embed(source = "gameSprites/explodeparticle.png")] public static var ExPart:Class;
		[Embed(source = "../fx/collectKey.mp3")] public static var GetSound:Class;
		
		//Title Cards
		[Embed(source = "../sprites/SCS Title Card.png")] public static var TitleCard_SCS:Class;
		
		public static var enerTxt:energyHUD = new energyHUD();
		public static var pureTxt:pureHUD = new pureHUD();
		public static var percentage:int = 0;
		public static var collectedKeys:int = 0;
		public static var percentageTxt:FlxText = new FlxText(560, 0, 40, "", false);
		public static var explosion:ExplodeFX;
		public static var level:FlxTilemap;
		public static var statusHUD:StatusHUD;
		private static var singleton:Registry = null;
		public function Registry() 
		{
		}
		
	}

}