package core.utils 
{
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
	}
}