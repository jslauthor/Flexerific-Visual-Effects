package com.leonardsouza.filters.base
{
	import flash.display.Shader;
	import flash.display.ShaderInput;
	import flash.display.ShaderParameter;
	import flash.display.ShaderParameterType;
	import flash.filters.BitmapFilter;
	
	import spark.filters.ShaderFilter;

	
	public class ShaderFilterBase extends ShaderFilter
	{
		public function ShaderFilterBase(shader:Object=null)
		{
			super(shader);
		}
		
		/*
		** Copied this over from spark.filters.ShaderFilter
		*/
		
		protected function applyProperty(property:String, value:*):void
		{
			if (value == null) 
				return;
			
			var suffixPattern:RegExp = /_.$/;
			var match:Array = property.match(suffixPattern);
			
			// If this property name contains a suffix, attempt to push the value
			// to the specified component of a multi-dimensional property.
			if (match && match[0] && !(value is Array))
			{
				var suffix:String = match[0];
				var name:String = property.substr(0, property.length - suffix.length);
				var dimension:String = suffix.substr(suffix.length-1, 1);
				
				var propertyInfo:ShaderParameter = shader.data[name];
				if (propertyInfo)
				{
					var index:int = indexForDimension(propertyInfo.type, dimension);
					if (index != -1)
					{
						var currentValue:Array = propertyInfo.value ? propertyInfo.value : new Array();
						currentValue[index] = value;
						propertyInfo.value = currentValue;
						return;
					}
				}
			}
			
			// Otherwise if the target property is a ShaderInput instance or
			// array property, set the value.
			if (shader.data[property] is ShaderInput)
				shader.data[property].input = value;
			else
				shader.data[property].value = (value is Array) ? value : [value];
		} 
		
		protected function indexForDimension(type:String, dimension:String):int
		{
			var index:int = 0;
			
			if (type == ShaderParameterType.MATRIX2X2 ||
				type == ShaderParameterType.MATRIX3X3 ||
				type == ShaderParameterType.MATRIX4X4)
			{
				// "abcdefghijklmnop" convenience access to:
				//   MATRIX 2x2, MATRIX3x3, or MATRIX4x4
				index = dimension.charCodeAt(0) - 0x61; // 'a' 
			}
			else if (Number(type.charAt(type.length - 1)) > 0)
			{
				// "rgba", "xyzw", or "stpq" convenience access to:
				//  BOOL2, BOOL3, BOOL4, FLOAT2, FLOAT3, FLOAT4, 
				//  INT2, INT3, or INT4
				index = "rgba".indexOf(dimension);
				index = (index == -1) ? "xyzw".indexOf(dimension) : index;
				index = (index == -1) ? "stpq".indexOf(dimension) : index;
			}
			
			return index;
		}
		
	}
}