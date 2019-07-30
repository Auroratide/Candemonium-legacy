package com.ardeol.fue {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	public class Spritesheet extends Bitmap {
		private var _partialWidth:int;
		private var _partialHeight:int;
		private var _totalPartials:int;
		
		/*  Constructor
		=========================================*/
		public function Spritesheet(bmd:BitmapData, pW:int, pH:int, tP:int = -1) {
			super(bmd);
			partialWidth = pW;
			partialHeight = pH;
			if(tP >= 0)
				totalPartials = tP;
			else
				totalPartials = (this.width / _partialWidth) * (this.height / _partialHeight);
		}
		
		/*  Access Methods
		=========================================*/
		public function get partialWidth():int {    return _partialWidth; }
		public function get partialHeight():int {    return _partialHeight; }
		public function get totalPartials():int {    return _totalPartials; }
		
		public function set partialWidth(w:int):void {
			if (w < 0) w = 0;
			else if (w > this.width) w = this.width;
			_partialWidth = w;
		}
		public function set partialHeight(h:int):void {
			if (h < 0) h = 0;
			else if (h > this.height) h = this.height;
			_partialHeight = h;
		}
		public function set totalPartials(v:int):void {
			if (v < 0) v = 0;
			else if (v > (this.width / _partialWidth) * (this.height / _partialHeight)) v = (this.width / _partialWidth) * (this.height / _partialHeight);
			_totalPartials = v;
		}
		
		override public function set width(value:Number):void {
			trace("Cannot resize Spritesheet objects; resize SpritesheetSprite instead");
		}
		override public function set height(value:Number):void {
			trace("Cannot resize Spritesheet objects; resize SpritesheetSprite instead");
		}
		
		/*  Operators
		=========================================*/
		public function clone():Spritesheet {
			return new Spritesheet(this.bitmapData, _partialWidth, _partialHeight, _totalPartials);
		}
	}
}