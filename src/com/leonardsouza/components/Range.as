package com.leonardsouza.components
{
	import spark.components.supportClasses.Range;
	
	public class Range extends spark.components.supportClasses.Range
	{
		public function Range(minimum:Number = 0, maximum:Number = 0)
		{
			super();
			super.minimum = minimum;
			super.maximum = maximum;
		}
	}
}