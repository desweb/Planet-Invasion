package core 
{
	/**
	 * Manage user
	 * @author desweb
	 */
	public class User 
	{
		private var _accessToken:String;
		private var _accessTokenExpiredAt:Date;
		
		private var _key:String;
		private var _username:String;
		private var _email:String;
		private var _levelAdventure:int;
		private var _metal:int;
		private var _crystal:int;
		private var _money:int;
		
		public var isLog:Boolean;
		
		public function User() 
		{
			_levelAdventure = 1;
			
			isLog = false;
		}
		
		/**
		 * Webservice
		 */
		
		/**
		 * Getters
		 */
		
		/**
		 * Setters
		 */
	}
}