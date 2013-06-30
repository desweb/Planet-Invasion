package core.utils 
{
	/**
	 * ...
	 * @author desweb
	 */
	public class Security 
	{
		public function Security() {}
		
		public static function isValidEmail(email:String):Boolean
		{
			var regex:RegExp = /([a-z0-9._-]+?)@([a-z0-9.-]+)\.([a-z]{2,4})/;
			
			return regex.test(email);
		}
	}
}