package com.ardeol.fue {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	public class BitmapElement extends Object {
		private var _bitmap:Bitmap;
		private var _location:Point;
		private var _imageArea:Rectangle;
		
		public function BitmapElement(original:Bitmap) {
			// super(original.width, original.height);
			_bitmap = new Bitmap(original.bitmapData);
			_location = new Point(0, 0);
			_imageArea = new Rectangle(0, 0, original.width, original.height);
		}
		
		public function get bitmapData():BitmapData{    return _bitmap.bitmapData; }
		public function get imageArea():Rectangle {    return _imageArea.clone(); }
		public function get location():Point {    return _location.clone(); }
	}
}