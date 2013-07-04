package core.utils 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class Tools 
	{
		
		public function Tools() {}
		
		public static function random(min:int, max:int):int
		{
			return Math.round(Math.random() * (max - min + 1) + (min - .5))
		}
		
		public static function pointOnCirclePerimeter(center:Point, angle:Number, radius:Number):Point
		{
			var p:Point = new Point();
			
			radius	= Math.abs(radius);
			angle	= convertDegreesToRadians(angle);
			
			p.x = center.x + radius * Math.cos	(angle);
			p.y = center.y + radius * Math.sin	(angle);
			
			return p;
		}
		
		public static function convertDegreesToRadians(d:Number):Number
		{
			return d * Math.PI / 180;
		}
		
		public static function convertRadiansToDegrees(r:Number):Number
		{
			return r * 180 / Math.PI;
		}
		
		public static function convertTimeToLabel(t:uint):String
		{
			var h	:uint = int(t / 3600);
			var m	:uint = int((t - h * 3600) / 60);
			var s		:uint = t - m * 60;
			
			return h > 0? h + 'h ' + m + 'min ' + s + 's': (m > 0? m + 'min ' + s + 's': s + 's');
		}
	}
}