package com.leonardsouza.demos.flexerific.views.components.base
{
	import com.leonardsouza.demos.flexerific.views.components.WheelSection;
	
	import mx.events.FlexEvent;
	
	import spark.components.Group;
	
	public class WheelBase extends Group
	{
		
		import mx.events.FlexEvent;
		
		protected var _percentage:Number = 1;
		private var _color:uint = 0xFFFFFF;
		
		/*
		** Getters / Setters
		*/
		
		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{
			_color = value;
		}

		public function get percentage():Number
		{
			return _percentage;
		}
		
		public function set percentage(value:Number):void
		{
			_percentage = value;
			updateWheel();
		}
		
		public function WheelBase()
		{
			super();
		}
		
		/*
		** Overrides
		*/
		
		override protected function createChildren():void
		{
			super.createChildren();
			for (var x:int = 0; x <= 140; x++)
			{
				var section:WheelSection = new WheelSection();
				section.color = color;
				
				addElement(section);
			}
			updateWheel();
		}
		
		/*
		** Methods
		*/
		
		protected function updateWheel():void
		{
			var range:int = numElements * percentage;
			for (var x:int = 0; x < numElements; x++)
			{
				if (x < range)
					getElementAt(x).alpha = 1;
				else
					getElementAt(x).alpha = 0;
			}				
		}
	}
}