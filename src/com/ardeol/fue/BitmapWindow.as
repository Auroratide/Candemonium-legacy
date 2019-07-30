package com.ardeol.fue {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.events.Event;
	
	public class BitmapWindow extends Bitmap implements IWindow {
		private var _title:String;
		private var _resizeable:Boolean;
		private var _windowWidth:Number;
		private var _windowHeight:Number;
		
		private var bmd:BitmapData;
		private var bitmapElements:Vector.<BitmapElement>;
		
		public function BitmapWindow(t:String = "") {
			_title = t;
			bmd = new BitmapData(800, 600, true, 0);
			bitmapElements = new Vector.<BitmapElement>();
			super(bmd);
		}
		
		/*  Access Methods
		===========================================*/
		public function get title():String {    return _title; }
		public function get resizeable():Boolean {    return _resizeable; }
		public function get windowWidth():Number {    return _windowWidth; }
		public function get windowHeight():Number {    return _windowHeight; }
		
		public function set title(s:String):void {    _title = s; }
		public function set windowWidth(w:Number):void {
			if (!_resizeable)
				throw new WindowError("ERROR in Window set windowWidth: " + WindowError.NOT_RESIZEABLE);
			if (w < 0) _windowWidth = 0;
			else _windowWidth = w;
			//resetBorders();
			//resetMask();
		}
		public function set windowHeight(h:Number):void {
			if (!_resizeable)
				throw new WindowError("ERROR in Window set windowWidth: " + WindowError.NOT_RESIZEABLE);
			if (h < 0) _windowHeight = 0;
			else _windowHeight = h;
			//resetBorders();
			//resetMask();
		}
		
		/*  Implemented Methods
		===========================================*/
		public function hide():void { }
		public function show():void { }
		public function close():void { }
		
		/*  Public Methods
		===========================================*/
		public function addElement(bmElem:BitmapElement):void {
			bitmapElements.push(bmElem);
		}
		
		/*  Private Methods
		===========================================*/
		public function render(e:Event = null):void {
			bmd = new BitmapData(800, 600, true, 0);
			for each(var bmElem:BitmapElement in bitmapElements) {
				bmd.copyPixels(bmElem.bitmapData, bmElem.imageArea, bmElem.location);
				trace("?!");
			}
		}
	}
}