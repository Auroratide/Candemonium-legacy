package com.ardeol.fue {
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.IGraphicsData;
	import flash.display.GraphicsStroke;
	import flash.display.GraphicsSolidFill;
	import flash.display.GraphicsPath;
	import flash.display.GraphicsPathCommand;
	import flash.display.JointStyle;
	import flash.events.Event;
	
	public class Window extends Sprite implements IWindow {
		private var _elements:Object; // Contains all refs to DisplayObjects attached to the Window; an associative array, basically
		private var _title:String;
		private var _resizeable:Boolean;
		private var _windowWidth:Number;
		private var _windowHeight:Number;
		
		private var windowMask:Sprite;
		
		// Border Data
		private var borders:Sprite;
		private var borderStroke:GraphicsStroke;
		
		
		/*  Constructor
		============================================*/
		public function Window(t:String = "", xx:Number = 0, yy:Number = 0, resize:Boolean = true, w:Number = -1, h:Number = -1) {
			_title = t;
			this.x = xx;
			this.y = yy;
			_resizeable = resize;
			_windowWidth = w;
			_windowHeight = h;
			_elements = new Object();
			
			windowMask = new Sprite();
			borders = new Sprite();
			borderStroke = new GraphicsStroke(NaN);
			borderStroke.fill = new GraphicsSolidFill(0x000000);
			this.addChild(borders);
			this.addChild(windowMask);
			if(w < 0 && h < 0){
				if (stage) setDefaultDimensions();
				else this.addEventListener(Event.ADDED_TO_STAGE, setDefaultDimensions);
			}
			else if (w >= 0 && h < 0) _windowHeight = 0;
			else if (w < 0 && h >= 0) _windowWidth = 0;
			
			resetBorders();
			resetMask();
		}
		
		/*  Access Methods
		============================================*/
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
			resetBorders();
			resetMask();
		}
		public function set windowHeight(h:Number):void {
			if (!_resizeable)
				throw new WindowError("ERROR in Window set windowWidth: " + WindowError.NOT_RESIZEABLE);
			if (h < 0) _windowHeight = 0;
			else _windowHeight = h;
			resetBorders();
			resetMask();
		}
		
		/*  Public Methods
		============================================*/
		// Put the object into the elements list
		public function addElement(obj:DisplayObject, id:String):void {
			if (_elements.hasOwnProperty(id))
				throw new WindowError("ERROR in Window addElement: " + WindowError.ELEMENT_EXISTENT);
			_elements[id] = obj;
			this.addChild(_elements[id]);
			this.setChildIndex(borders, this.numChildren - 1);
		}
		// Remove the object from the elements list
		public function removeElement(id:String):void {
			if (!_elements.hasOwnProperty(id))
				throw new WindowError("ERROR in Window removeElement: " + WindowError.ELEMENT_NONEXISTENT);
			this.removeChild(_elements[id]);
			delete _elements[id];
		}
		public function getElement(id:String):* {
			if (!_elements.hasOwnProperty(id))
				throw new WindowError("ERROR in Window getElement: " + WindowError.ELEMENT_NONEXISTENT);
			return _elements[id];
		}
		
		public function hide():void {
			this.visible = false;
		}
		public function show():void {
			this.visible = true;
		}
		
		public function close():void {
			clearElements();
			parent.removeChild(this);
		}
		public function clearElements():void {
			for each(var obj:DisplayObject in _elements)
				this.removeChild(obj);
			_elements = new Object();
		}
		
		public function setBorderStyle(thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = "none", joints:String = "round", miterLimit:Number = 3.0):void {
			borderStroke = new GraphicsStroke(thickness, pixelHinting, scaleMode, caps, joints, miterLimit);
			borderStroke.fill = new GraphicsSolidFill(color, alpha);
			resetBorders();
			resetMask();
		}
		
		override public function toString():String {
			return "[" + _title + " Window]";
		}
		
		/*  Private Methods
		============================================*/
		/*  The mask allows the window to actually have boundaries like the stage
		 *  Objects can exist outside of the window, but they wil not be displayed
		 * */
		private function resetMask():void {
			windowMask.graphics.clear();
			windowMask.graphics.beginFill(0xFF0000);
			if (borderStroke.joints == JointStyle.MITER || isNaN(borderStroke.thickness))
				windowMask.graphics.drawRect(0, 0, _windowWidth, _windowHeight);
			else
				windowMask.graphics.drawRoundRect(0, 0, _windowWidth, _windowHeight, borderStroke.thickness);
			windowMask.graphics.endFill();
			this.mask = windowMask;
		}
		private function resetBorders():void {
			borders.graphics.clear();
			var path:GraphicsPath = new GraphicsPath(new Vector.<int>(), new Vector.<Number>());
			path.commands.push(GraphicsPathCommand.MOVE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO, GraphicsPathCommand.LINE_TO);
			var widthAdjustment:Number;
			if (isNaN(borderStroke.thickness))
				widthAdjustment = 0;
			else
				widthAdjustment = borderStroke.thickness / 2.0;
			path.data.push(0 + widthAdjustment,0 + widthAdjustment, _windowWidth-widthAdjustment,0+widthAdjustment, _windowWidth-widthAdjustment,_windowHeight-widthAdjustment, 0+widthAdjustment,_windowHeight-widthAdjustment, 0+widthAdjustment,0+widthAdjustment);
			borders.graphics.drawGraphicsData(Vector.<IGraphicsData>([borderStroke, path]));
		}
		
		private function setDefaultDimensions(e:Event = null):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, setDefaultDimensions);
			_windowWidth = stage.stageWidth;
			_windowHeight = stage.stageHeight;
			resetMask();
			resetBorders();
		}
	}
}