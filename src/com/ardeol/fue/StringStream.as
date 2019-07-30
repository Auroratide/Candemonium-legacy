package com.ardeol.fue {
	public class StringStream extends Object {
		protected var _string:String;
		protected var _position:int;
		
		private var buffer:String;
		
		/*  Constructor
		======================================*/
		public function StringStream(s:String = "") {
			_string = s;
			_position = 0;
			buffer = "";
		}
		
		/*  Access Methods
		======================================*/
		public function get string():String {    return _string; }
		public function get length():int {    return _string.length; }
		public function get charsAvailable():int {    return _string.length - _position; }
		public function get position():int {    return _position; }
		
		
		public function set position(n:int):void {
			clearBuffer(); // Otherwise putBack() can do bad things
			_position = n;
			if (!verifyPosition() || _position < 0)
				throw new StreamError("ERROR in StringStream set position: Invalid position");
		}
		
		/*  Public Methods
		======================================*/
		public function readChar():String {
			clearBuffer();
			if (!verifyPosition())
				throw new StreamError(StreamError.END_OF_STREAM);
			buffer = getNextChar();
			return buffer;
		}
		public function readChars(n:int = 1):String {
			clearBuffer();
			for (var i:int = 0; i < n; ++i) {
				if (!verifyPosition())
					throw new StreamError(StreamError.END_OF_STREAM);
				buffer += getNextChar();
			}
			return buffer;
		}
		
		public function putBack():void {
			_position -= buffer.length;
			clearBuffer();
		}
		
		/*  Operators
		======================================*/
		public function toString():String {
			return _string;
		}
		public function valueOf():String {
			return _string;
		}
		public function clone():StringStream {
			var ss:StringStream = new StringStream(_string);
			ss._position = _position;
			ss.buffer = buffer;
			return ss;
		}
		
		/*  Private Methods
		======================================*/
		private function clearBuffer():void {
			buffer = "";
		}
		private function verifyPosition():Boolean {
			return _position <= _string.length - 1;
		}
		// Updates the position and returns the character; DOES NOT MODIFY BUFFER
		private function getNextChar():String {
			return _string.charAt(_position++);
		}
	}
}