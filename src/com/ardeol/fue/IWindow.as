package com.ardeol.fue {
	public interface IWindow {
		function get title():String;
		function set title(s:String):void;
		
		function get resizeable():Boolean;
		
		function get windowWidth():Number;
		function set windowWidth(w:Number):void;
		
		function get windowHeight():Number;
		function set windowHeight(h:Number):void;
		
		function hide():void;
		function show():void;
		function close():void;
	}
}