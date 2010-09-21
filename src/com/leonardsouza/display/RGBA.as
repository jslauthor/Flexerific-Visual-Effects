package com.leonardsouza.display
{
	public class RGBA extends Object
	{
		
		private var _red:Number;
		private var _blue:Number;
		private var _green:Number;
		private var _alpha:Number;		
		
		public function RGBA(red:Number = 1, green:Number = 1, blue:Number = 1, alpha:Number = 1)
		{
			this.red = red;
			this.green = green;
			this.blue = blue;
			this.alpha = alpha;
		}
		
		public function get alpha():Number
		{
			return _alpha;
		}

		public function set alpha(value:Number):void
		{
			_alpha = value;
		}

		public function get green():Number
		{
			return _green;
		}

		public function set green(value:Number):void
		{
			_green = value;
		}

		public function get blue():Number
		{
			return _blue;
		}

		public function set blue(value:Number):void
		{
			_blue = value;
		}

		public function get red():Number
		{
			return _red;
		}

		public function set red(value:Number):void
		{
			_red = value;
		}
		
		public function toString():String
		{
			return ("Red: " + _red + " Green: " + _green  + " Blue: " + _blue);  
		}

	}
}