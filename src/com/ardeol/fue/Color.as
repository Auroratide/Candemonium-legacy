package com.ardeol.fue{
	public class Color extends Object {
		/*  Class Constants
		========================================*/
		public static const AQUA:uint = 0x00FFFF;
		public static const BLACK:uint = 0x000000;
		public static const BLUE:uint = 0x0000FF;
		public static const CYAN:uint = 0x00FFFF;
		public static const FUCHSIA:uint = 0xFF00FF;
		public static const GRAY:uint = 0x808080;
		public static const GREEN:uint = 0x008000;
		public static const LIME:uint = 0x00FF00;
		public static const MAGENTA:uint = 0xFF00FF;
		public static const MAROON:uint = 0x800000;
		public static const NAVY:uint = 0x000080;
		public static const OLIVE:uint = 0x808000;
		public static const ORANGE:uint = 0xFFA500;
		public static const PURPLE:uint = 0x800080;
		public static const RED:uint = 0xFF0000;
		public static const SILVER:uint = 0xC0C0C0;
		public static const TEAL:uint = 0x008080;
		public static const WHITE:uint = 0xFFFFFF;
		public static const YELLOW:uint = 0xFFFF00;
		
		/*  Data Members
		========================================*/
		private var _color:uint;
		
		/*  Constructor
		========================================*/
		public function Color(c:uint = BLACK) {
			_color = c;
			validateColor();
		}
		
		/*  Properties
		========================================*/
		public function get color():uint {    return _color; }
		public function get r():uint {	return hexToRGB(_color)[0]; }
		public function get g():uint {	return hexToRGB(_color)[1]; }
		public function get b():uint {	return hexToRGB(_color)[2]; }
		public function get h():uint {   return hexToHSV(_color)[0]; }
		public function get s():uint {   return hexToHSV(_color)[1]; }
		public function get v():uint {   return hexToHSV(_color)[2]; }
		public function get colorString():String {    return hexToString(_color); }
		
		public function set color(c:uint):void {
			_color = c;
			validateColor();
		}
		
		/*  Public Methods
		========================================*/
		public function getRGB():Vector.<uint> {
			return hexToRGB(_color);
		}
		public function setRGB(_r:uint, _g:uint, _b:uint):void {
			_color = rgbToHex(_r, _g, _b);
		}
		public function getHSV():Vector.<uint> {
			return hexToHSV(_color);
		}
		public function setHSV(_h:uint, _s:uint, _v:uint):void {
			_color = hsvToHex(_h, _s, _v);
		}
		
		public function increment(amount:Number = 1, c:uint = WHITE):Color {
			amount = Math.round(amount); // ensure integer number
			if (c == RED || c == FUCHSIA || c == MAGENTA || c == YELLOW || c == WHITE)
				_color += amount << 16;
			if (c == GREEN || c == LIME || c == YELLOW || c == CYAN || c == AQUA || c == WHITE)
				_color += amount << 8;
			if (c == BLUE || c == CYAN || c == AQUA || c == FUCHSIA || c == MAGENTA || c == WHITE)
				_color += amount;
			validateColor();
			return this;
		}
		
		public function decrement(amount:Number = 1, c:uint = WHITE):Color {
			return increment( -amount, c);
		}
		
		public function postIncrement(amount:Number = 1, c:uint = WHITE):Color {
			var prev:Color = this.clone();
			increment(amount, c);
			return prev;
		}
		
		public function postDecrement(amount:Number = 1, c:uint = WHITE):Color {
			var prev:Color = this.clone();
			decrement(amount, c);
			return prev;
		}
		
		public function brighten(a:Number = 1):Color {
			if (a <= 0) return this;
			var standard:Number = Number(standardCandle());
			var deltaS:Number = 4*a;
			var deltaV:Number = 4*a;
			if (standard > 50)
				deltaS = 4*a*standard / (100 - standard);
			else
				deltaV = 4*a*(100 - standard) / standard;
			var _s:uint = this.s;
			var _v:uint = this.v;
			_s = deltaS < _s ? Math.round(_s - deltaS) : 0;
			_v = _v + deltaV < 100 ? Math.round(_v + deltaV) : 100;
			setHSV(this.h, _s, _v);
			return this;
		}
		
		public function darken(a:Number = 1):Color {
			if (a <= 0) return this;
			var standard:Number = Number(standardCandle());
			var deltaS:Number = 4*a;
			var deltaV:Number = 4*a;
			if (standard < 50)
				deltaS = 4*a*standard / (100 - standard);
			else
				deltaV = 4*a*(100 - standard) / standard;
			var _s:uint = this.s;
			var _v:uint = this.v;
			_v = deltaV < _v ? Math.round(_v - deltaV) : 0;
			_s = _s + deltaS < 100 ? Math.round(_s + deltaS) : 100;
			setHSV(this.h, _s, _v);
			return this;
		}
		
		/*  Class Methods
		========================================*/
		public static function verifyColor(c:uint):Number {
			if ((c >> 0) < BLACK) return -1;
			else if (c > WHITE) return 1;
			return 0;
		}
		public static function verifyRGB(_r:uint, _g:uint, _b:uint):Boolean {
			if (_r > 255 || _g > 255 || _b > 255)
				return false;
			return true;
		}
		public static function verifyHSV(_h:uint, _s:uint, _v:uint):Boolean {
			if (_h > 359 || _s > 100 || _v > 100)
				return false;
			return true;
		}
		public static function verifyString(str:String):Boolean {
			return / ^ [a - fA - F0 - 9] { 6 } $ / .test(str);
		}
		
		public static function hexToString(c:uint):String {
			if (verifyColor(c) != 0)
				throw new ColorError("ERROR in Color hexToString: " + ColorError.INVALID_ARGUMENT);
			var str:String = "";
			var cl:uint = c;
			for (var p:int = 5; p >= 0; --p) {
				var n:int = Math.floor(cl / Math.pow(16, p));
				cl -= n * Math.pow(16, p);
				str += "0123456789ABCDEF".charAt(n);
			}
			return str;
		}
		public static function stringToHex(str:String):uint {
			str = consolidateShorthandHex(str);
			if (!verifyString(str))
				throw new ColorError("ERROR in Color stringToHex: " + ColorError.INVALID_ARGUMENT);
			var hex:uint = 0;
			for (var i:int = 0; i < 6; ++i)
				hex += "0123456789ABCDEF".indexOf(str.charAt(i)) * Math.pow(16, 5 - i);
			return hex;
		}
		public static function hexToRGB(c:uint):Vector.<uint> {
			if (verifyColor(c) != 0)
				throw new ColorError("ERROR in Color hexToRGB: " + ColorError.INVALID_ARGUMENT);
			var rgb:Vector.<uint> = new Vector.<uint>(3);
			rgb[0] = c >> 16;
			rgb[1] = (c - 65536 * rgb[0]) >> 8;
			rgb[2] = (c - 65536 * rgb[0] - 256 * rgb[1]);
			return rgb;
		}
		
		public static function rgbToHex(_r:uint, _g:uint, _b:uint):uint {
			if (!verifyRGB(_r, _g, _b))
				throw new ColorError("ERROR in Color rgbToHex: " + ColorError.INVALID_ARGUMENT);
			return (_r << 16) | (_g << 8) | _b;
		}
		
		// HSV Conversion algorithms thanks to Wikipedia
		public static function hexToHSV(c:uint):Vector.<uint> {
			if (verifyColor(c) != 0)
				throw new ColorError("ERROR in Color hexToHSV: " + ColorError.INVALID_ARGUMENT);
			var rgb:Vector.<uint> = hexToRGB(c);
			var hsv:Vector.<uint> = new Vector.<uint>(3);
			var rS:Number = rgb[0] / 255.0;
			var gS:Number = rgb[1] / 255.0;
			var bS:Number = rgb[2] / 255.0;
			
			var max:Number = Math.max(rS, gS, bS);
			var min:Number = Math.min(rS, gS, bS);
			
			if (max == min) hsv[0] = 0;
			else {
				switch(max) {
					case rS: hsv[0] = Math.floor((60 * (gS - bS) / (max - min) + 360) % 360); break;
					case gS: hsv[0] = Math.floor(60 * (bS - rS) / (max - min) + 120); break;
					default: hsv[0] = Math.floor(60 * (rS - gS) / (max - min) + 240); break;
				}
			}
			hsv[2] = Math.floor(100*max);
			if (max == 0) hsv[1] = 0;
			else hsv[1] = Math.floor(100*(max - min) / max);
			
			return hsv;
		}
		
		public static function hsvToHex(_h:uint, _s:uint, _v:uint):uint {
			if (!verifyHSV(_h, _s, _v))
				throw new ColorError("ERROR in Color hsvToHex: " + ColorError.INVALID_ARGUMENT);
			var hS:Number = _h / 60.0;
			var sS:Number = _s / 100.0;
			var vS:Number = _v / 100.0;
			var c:Number = sS * vS;
			
			var rS:Number = 0;
			var gS:Number = 0;
			var bS:Number = 0;
			var x:Number = c * (1 - Math.abs((hS % 2) - 1));
			if (_h > 0) {
				if (hS < 1) { rS = c; gS = x; bS = 0; }
				else if (hS < 2) { rS = x; gS = c; bS = 0; }
				else if (hS < 3) { rS = 0; gS = c; bS = x; }
				else if (hS < 4) { rS = 0; gS = x; bS = c; }
				else if (hS < 5) { rS = x; gS = 0; bS = c; }
				else { rS = c; gS = 0; bS = x; }
			}
			var m:Number = vS - c;
			return rgbToHex(Math.floor(255*(rS + m)), Math.floor(255*(gS + m)), Math.floor(255*(bS + m)));
		}
		
		/*  Operators
		========================================*/
		public function toString():String {
			return "#" + hexToString(_color);
		}
		
		public function valueOf():Object {
			return _color;
		}
		
		public function clone():Color {
			return new Color(_color);
		}
		
		/*  Private Methods
		========================================*/
		// Forces validation
		private function validateColor():void {
			if (verifyColor(_color) < 0) _color = BLACK;
			else if (verifyColor(_color) > 0) _color = WHITE;
		}
		private static function consolidateShorthandHex(hex:String):String {
			if (hex.length != 3) return hex;
			var s:Array = hex.split("");
			var newHex:String = "";
			for each(var value:String in s)
				newHex += value + value;
			return newHex;
		}
		private function standardCandle():int {
			return Math.floor((this.s + this.v) / 2);
		}
	}
}