package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class Assets {
		public function Assets() {
			throw new Error("ERROR in Assets constructor: Cannot create an Assets instance");
		}
		
		//  Background Fill
		[Embed(source="../lib/placeholderart/backgroundFill.png")]
		private static const BackgroundFillClass:Class;
		public static function backgroundFill():Bitmap {  return new BackgroundFillClass(); }
		
		//  Background Border
		[Embed(source = "../lib/placeholderart/backgroundBorder.png")]
		private static const BackgroundBorderClass:Class;
		public static function backgroundBorder():Bitmap {  return new BackgroundBorderClass(); }
		
		//  Sub Menu
		[Embed(source = "../lib/placeholderart/subMenu.png")]
		private static const SubMenuClass:Class;
		public static function subMenu():Bitmap {  return new SubMenuClass(); }
		
		//  Credits
		[Embed(source = "../lib/placeholderart/Credits.png")]
		private static const CreditsClass:Class;
		public static function credits():Bitmap {  return new CreditsClass(); }
		
		//  Instructions
		[Embed(source = "../lib/placeholderart/Controls.png")]
		private static const ControlsClass:Class;
		public static function controls():Bitmap {  return new ControlsClass(); }
		
		//  Title
		[Embed(source = "../lib/placeholderart/Title.png")]
		private static const TitleMenuClass:Class;
		public static function titleMenu():Bitmap {  return new TitleMenuClass(); }
		
		//  Butterscotch (for now the Player)
		[Embed(source = "../lib/placeholderart/Butterscotch40px.png")]
		private static const ButterscotchClass:Class;
		public static function butterscotch():Bitmap {  return new ButterscotchClass(); }
		public static function butterscotchWidth():Number {  return 21; }
		public static function butterscotchHeight():Number {  return 40; }
		
		//  Gumball
		[Embed(source = "../lib/placeholderart/Gumball40px.png")]
		private static const GumballClass:Class;
		public static function gumball():Bitmap {  return new GumballClass(); }
		public static function gumballWidth():Number {  return 36; }
		public static function gumballHeight():Number {  return 40; }
		
		//  Candy Cane
		[Embed(source = "../lib/placeholderart/CandyCane40px.png")]
		private static const CandyCaneClass:Class;
		public static function candyCane():Bitmap {  return new CandyCaneClass(); }
		public static function candyCaneWidth():Number {  return 32; }
		public static function candyCaneHeight():Number { return 40; }
		
		//  Candy Corn
		[Embed(source="../lib/placeholderart/candycorn40px.png")]
		private static const CandyCornClass:Class;
		public static function candyCorn():Bitmap {  return new CandyCornClass(); }
		public static function candyCornWidth():Number {  return 22; }
		public static function candyCornHeight():Number { return 40; }
		
		//  Cotton Candy
		[Embed(source="../lib/placeholderart/CottonCandy40px.png")]
		private static const CottonCandyClass:Class;
		public static function cottonCandy():Bitmap {  return new CottonCandyClass(); }
		public static function cottonCandyWidth():Number {  return 35; }
		public static function cottonCandyHeight():Number { return 40; }
		
		//  Hard Candy
		[Embed(source="../lib/placeholderart/HardCandy40px.png")]
		private static const HardCandyClass:Class;
		public static function hardCandy():Bitmap {  return new HardCandyClass(); }
		public static function hardCandyWidth():Number {  return 14; }
		public static function hardCandyHeight():Number { return 40; }
		
		//  Jelly Belly
		[Embed(source="../lib/placeholderart/JellyBelly40px.png")]
		private static const JellyBellyClass:Class;
		public static function jellyBelly():Bitmap {  return new JellyBellyClass(); }
		public static function jellyBellyWidth():Number {  return 40; }
		public static function jellyBellyHeight():Number { return 28; }
		
		//  Jolly Rancher
		[Embed(source="../lib/placeholderart/JollyRancher40px.png")]
		private static const JollyRancherClass:Class;
		public static function jollyRancher():Bitmap {  return new JollyRancherClass(); }
		public static function jollyRancherWidth():Number {  return 21; }
		public static function jollyRancherHeight():Number { return 40; }
		
		//  Lollipop
		[Embed(source="../lib/placeholderart/Lollipop1_40px.png")]
		private static const LolliPopClass:Class;
		public static function lolliPop():Bitmap {  return new LolliPopClass(); }
		public static function lolliPopWidth():Number {  return 22; }
		public static function lolliPopHeight():Number { return 40; }
		
		//  Lollipop 2
		[Embed(source="../lib/placeholderart/Lollipop2_40px.png")]
		private static const LolliPop2Class:Class;
		public static function lolliPop2():Bitmap {  return new LolliPop2Class(); }
		public static function lolliPop2Width():Number {  return 18; }
		public static function lolliPop2Height():Number { return 40; }
		
		//  Star (The character)
		[Embed(source = "../lib/placeholderart/starMod.png")]
		private static const StarClass:Class;
		public static function star():Bitmap {  return new StarClass(); }
		public static function starWidth():Number {  return 32; }
		public static function starHeight():Number {  return 32; }
		
		//  Star Eyes (The character)
		[Embed(source="../lib/placeholderart/starEyes.png")]
		private static const StarEyesClass:Class;
		public static function starEyes():Bitmap {  return new StarEyesClass(); }
		public static function starEyesWidth():Number {  return 32; }
		public static function starEyesHeight():Number {  return 32; }
		
		//  Portal
		[Embed(source="../lib/placeholderart/portal.png")]
		private static const PortalClass:Class;
		public static function portal():Bitmap {  return new PortalClass(); }
		public static function portalWidth():Number {  return 32; }
		public static function portalHeight():Number {  return 32; }
		
		//  Portal Swirls
		[Embed(source="../lib/placeholderart/portalSwirls.png")]
		private static const PortalSwirlsClass:Class;
		public static function portalSwirls():Bitmap {  return new PortalSwirlsClass(); }
		public static function portalSwirlsWidth():Number {  return 32; }
		public static function portalSwirlsHeight():Number {  return 32; }
		
		//  Star Life
		[Embed(source="../lib/placeholderart/starLife.png")]
		private static const StarLifeClass:Class;
		public static function starLife():Bitmap {  return new StarLifeClass(); }
		public static function starLifeWidth():Number {  return 16; }
		public static function starLifeHeight():Number {  return 16; }
	}
}