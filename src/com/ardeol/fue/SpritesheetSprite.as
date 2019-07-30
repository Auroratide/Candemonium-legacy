package com.ardeol.fue {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class SpritesheetSprite extends Sprite {
		public var sheet:Spritesheet;
		private var bitmap:Bitmap;
		private var bmd:BitmapData;
		private var animFunction:Function;
		
		private var _index:int;
		private var _frameDelay:int;
		private var _frameDelayCount:int;
		private var _startX:int;
		private var _startY:int;
		private var _partialsPerRow:int;
		private var _numOfPartials:int;
		
		private var _isPlaying:Boolean;
		
		private var count:uint;
		
		/*  Constructor
		=========================================*/
		public function SpritesheetSprite(spritesheet:Spritesheet, partsPerRow:int = -1, numOfParts:int = -1, initIndex:int = 0, delay:int = 0) {
			sheet = spritesheet;
			if (partsPerRow < 1)
				_partialsPerRow = sheet.width / sheet.partialWidth;
			else
				partialsPerRow = partsPerRow;
			if (numOfParts < 1)
				_numOfPartials = sheet.totalPartials;
			else
				numOfPartials = numOfParts;
			index = initIndex;
			frameDelay = delay;
			_frameDelayCount = _frameDelay;
			_startX = 0;
			_startY = 0;
			count = 0;
			_isPlaying = true;
			animFunction = standardLoop;
			bmd = new BitmapData(sheet.partialWidth, sheet.partialHeight, true, 0);
			bitmap = new Bitmap(bmd);
			
			this.addChild(bitmap);
			this.addEventListener(Event.ENTER_FRAME, updateSprite);
		}
		
		/*  Access Methods
		=========================================*/
		public function get index():int {    return _index; }
		public function get frameDelay():int {    return _frameDelay; }
		public function get startX():int {    return _startX; }
		public function get startY():int {    return _startY; }
		public function get partialsPerRow():int {    return _partialsPerRow; }
		public function get numOfPartials():int {    return _numOfPartials; }
		public function get isPlaying():Boolean {    return _isPlaying; }
		
		public function set index(n:int):void {
			if (n < 0) n = 0;
			else if (n >= _numOfPartials) n = _numOfPartials - 1;
			_index = n;
		}
		public function set frameDelay(v:int):void {    _frameDelay = v; }
		public function set partialsPerRow(v:int):void {
			if (v < 1) v = 1;
			else if (v > (sheet.width - _startX) / sheet.partialWidth) v = (sheet.width - _startX) / sheet.partialWidth;
			_partialsPerRow = v;
		}
		public function set numOfPartials(v:int):void {
			if (v < 1) v = 1;
			else if (v > sheet.totalPartials) v = sheet.totalPartials;
			_numOfPartials = v;
		}
		
		/*  Public Methods
		=========================================*/
		public function drawSprite():void {
			var rect:Rectangle = new Rectangle(sheet.partialWidth * (_index % _partialsPerRow) + _startX, sheet.partialHeight * int(_index / _partialsPerRow) + _startY, sheet.partialWidth, sheet.partialHeight);
			bmd.copyPixels(sheet.bitmapData, rect, new Point(0, 0));
		}
		
		public function resetCount():void {
			count = 0;
		}
		public function stop():void {
			_isPlaying = false;
			drawSprite();
		}
		public function stopAt(i:int):void {
			index = i;
			stop();
		}
		public function play():void {
			_isPlaying = true;
		}
		public function playAt(i:int):void {
			index = i;
			play();
		}
		
		public function setAnimFunction(f:Function):void {
			animFunction = f;
		}
		public function setStartXPosition(p:Number):void {
			if (p * sheet.partialWidth > sheet.width)
				_startX = sheet.width - sheet.partialWidth;
			else if (p < 0) _startX = 0;
			else _startX = int(p * sheet.partialWidth);
			partialsPerRow = partialsPerRow; // Ensures dimensions still fit
			//resetCount();
		}
		public function setStartYPosition(p:Number):void {
			if (p * sheet.partialHeight > sheet.height)
				_startY = sheet.height - sheet.partialHeight;
			else if (p < 0) _startY = 0;
			else _startY = int(p * sheet.partialHeight);
			//resetCount();
		}
		
		/*  Static Functions
		=========================================*/
		public static function standardLoop(curIndex:int, curCount:int, maxIndex:int):int {
			if (curIndex >= maxIndex - 1)
				return -maxIndex;
			return 1;
		}
		public static function backAndForth(curIndex:int, curCount:int, maxIndex:int):int {
			return [1, -1][int(curCount / maxIndex) % 2];
		}
		
		/*  Private Functions
		=========================================*/
		private function updateSprite(e:Event = null):void {
			if (++_frameDelayCount > _frameDelay && _isPlaying) {
				if (count == uint.MAX_VALUE) resetCount();
				index += animFunction.call(null, index, ++count, _numOfPartials);
				drawSprite();
				_frameDelayCount = 0;
			}
		}
	}
}