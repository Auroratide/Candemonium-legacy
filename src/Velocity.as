package {
	/** Velocity Class
	 *  Timothy Foster
	 ** A Velocity is a vector with magnitude and direction
	 *  representing the rate at which something moves.
	 * *****************************************************/
	public class Velocity extends Object {
		public static const LEFT:Number = Math.PI;
		public static const RIGHT:Number = 0;
		public static const UP:Number = Math.PI / 2;
		public static const DOWN:Number = 3*Math.PI/2
		
		private var _magnitude:Number;
		private var _direction:Number;
		
		/*  Constructor
		==============================================*/
		public function Velocity(mag:Number = 0, dir:Number = 0) {
			direction = dir;
			magnitude = mag;
		}
		
		/*  Access Methods
		==============================================*/
		public function get magnitude():Number {  return _magnitude; }
		public function get direction():Number {  return _direction; }
		
		public function set magnitude(value:Number):void {
			if (value < 0) {
				direction += Math.PI;
				value *= -1;
			}
			_magnitude = value;
		}
		public function set direction(value:Number):void {
			_direction = value % (2 * Math.PI);
		}
		
		/*  Public Methods
		==============================================*/
		public function deltaX():Number {
			return _magnitude * Math.cos(_direction);
		}
		public function deltaY():Number {
			return -_magnitude * Math.sin(_direction);
		}
		
		/*  Operators
		==============================================*/
		public function clone():Velocity {
			return new Velocity(_magnitude, _direction);
		}
		public function toString():String {
			return "[" + _magnitude + ", " + _direction + "]";
		}
	}
}