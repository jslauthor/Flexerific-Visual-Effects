package com.leonardsouza.demos.flexerific.views.components
{
	import com.leonardsouza.geom.VocalPoint;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.events.PropertyChangeEvent;
	
	import spark.primitives.Path;
	
	public class AnimatableCurve extends Path
	{
		
		private var _points:Vector.<VocalPoint>;
		
		public function AnimatableCurve() { super(); }

		/*
		** Getter / Setters
		*/
		
		public function get points():Vector.<VocalPoint>
		{
			return _points;
		}
		
		public function set points(value:Vector.<VocalPoint>):void
		{
			if (value == null) return;
			
			_points = value;
			drawCurves();
			
			for (var x:int = 0; x < _points.length; x++)
			{
				_points[x].addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, drawCurves);
			}
			
		}
		
		/*
		** Methods
		*/

		// A lot of this was taken from Grant Skinner's line to curve code, I just adapted it to use FXG path data
		
		public function drawCurves(event:PropertyChangeEvent = null):void
		{
			var prevMidpt:VocalPoint = null;		
			var curvesData:String = "";
			
			for (var i:Number = 1; i < points.length; i++) 
			{
				var pt1:VocalPoint = points[i-1];
				var pt2:VocalPoint = points[i];
				
				var midpt:VocalPoint = new VocalPoint(pt1.x+(pt2.x-pt1.x)/2, pt1.y+(pt2.y-pt1.y)/2);
				var a:Number = Math.atan2(pt2.y-pt1.y, pt2.x-pt1.x);
				
				/*
				// Debug lines 
				
				curvesData += "M " + pt1.x + " " + pt1.y + " ";
				curvesData += "L " + pt2.x + " " + pt2.y + " ";
				
				curvesData += "M " + (midpt.x+Math.cos(a+Math.PI/2)*8) + " " + (midpt.y+Math.sin(a+Math.PI/2)*8) + " ";
				curvesData += "L " + (midpt.x-Math.cos(a+Math.PI/2)*8) + " " + (midpt.y-Math.sin(a+Math.PI/2)*8) + " ";
				*/
				
				if (prevMidpt) 
				{
					curvesData += "M " + prevMidpt.x + " " + prevMidpt.y + " ";
					curvesData += "Q " + pt1.x + " " + pt1.y + " " + midpt.x + " " + midpt.y + " ";
				} 
				else
				{
					curvesData += "M " + pt1.x + " " + pt1.y + " ";
					curvesData += "T " + midpt.x + " " + midpt.y + " ";
				}
				prevMidpt = midpt;
			}
			
			if (pt2 != null) curvesData += "T " + pt2.x + " " + pt2.y + " ";
			
			data = curvesData;
		}
		
	}
}