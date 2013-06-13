package core 
{
	import flash.net.URLLoader;
	import flash.events.Event;
	
	//import com.greensock.TweenLite;
	
	/**
	 * Manage user
	 * @author desweb
	 */
	public class User 
	{
		private var _accessToken				:String;
		private var _accessTokenExpiredAt	:int;
		
		private var _key:String;
		private var _username:String;
		private var _email:String;
		private var _score:int;
		private var _level_adventure:int;
		private var _metal:int;
		private var _crystal:int;
		private var _money:int;
		
		private var _improvements	:Array;
		private var _achievements	:Array;
		
		public var isLog:Boolean;
		
		private var _loaderAccessToken:URLLoader;
		
		
		public function User() 
		{
			init();
		}
		
		/**
		 * Functions
		 */
		
		private function init():void
		{
			isLog = false;
			
			_score					= 0;
			_level_adventure	= 0;
			_metal					= 1000;
			_crystal					= 1000;
			_money				= 1000;
			
			_improvements = new Array();
			_improvements[Common.IMPROVEMENT_ARMOR_RESIST]	=
			_improvements[Common.IMPROVEMENT_GUN_DAMAGE]		=
			_improvements[Common.IMPROVEMENT_GUN_CADENCE]	= 1;
			
			_improvements[Common.IMPROVEMENT_GUN_DOUBLE]						=
			_improvements[Common.IMPROVEMENT_SHIELD_RESIST]					=
			_improvements[Common.IMPROVEMENT_SHIELD_REGEN]					=
			_improvements[Common.IMPROVEMENT_SHIELD_REPOP]					=
			_improvements[Common.IMPROVEMENT_LASER_DAMAGE]					=
			_improvements[Common.IMPROVEMENT_MISSILE_DAMAGE]				=
			_improvements[Common.IMPROVEMENT_MISSILE_CADENCE]				=
			_improvements[Common.IMPROVEMENT_MISSILE_DOUBLE]					=
			_improvements[Common.IMPROVEMENT_MISSILE_SEARCH_DAMAGE]	=
			_improvements[Common.IMPROVEMENT_MISSILE_SEARCH_NUMBER]	=
			_improvements[Common.IMPROVEMENT_TRI_FORCE]							=
			_improvements[Common.IMPROVEMENT_IEM]										=
			_improvements[Common.IMPROVEMENT_BOMB]									=
			_improvements[Common.IMPROVEMENT_REINFORCE]							= 0;
			
			var achievement:Array = new Array();
			achievement['score']			= 0;
			achievement['is_unlock']	= false;
			
			_achievements = new Array();
			_achievements[Common.ACHIEVEMENT_METAL]					=
			_achievements[Common.ACHIEVEMENT_CRYSTAL]				=
			_achievements[Common.ACHIEVEMENT_MONEY]					=
			_achievements[Common.ACHIEVEMENT_SERIAL_KILLER]		=
			_achievements[Common.ACHIEVEMENT_NATURAL_DEATH]	=
			_achievements[Common.ACHIEVEMENT_ROADHOG]			=
			_achievements[Common.ACHIEVEMENT_CONQUEROR]			=
			_achievements[Common.ACHIEVEMENT_COOPERATION]		=
			_achievements[Common.ACHIEVEMENT_SURVIVAL]				=
			_achievements[Common.ACHIEVEMENT_MISTER_BOOSTER]	=
			_achievements[Common.ACHIEVEMENT_CURIOSITY]			=
			_achievements[Common.ACHIEVEMENT_ALIEN_BLAST]		= achievement;
		}
		
		public function login(accessToken:String, expiredAt:int):void
		{
			_accessToken				= accessToken;
			_accessTokenExpiredAt	= expiredAt;
			
			isLog = true;
		}
		
		public function logout():void
		{
			init();
		}
		
		/**
		 * Webservices
		 */
		
		private function refreshAccessToken():void
		{
			API.get_auth(function(response:XML):void {});
		}
		
		/**
		 * Getters
		 */
		
		public function get accessToken				():String	{ return _accessToken; }
		public function get accessTokenExpiredAt	():int			{ return _accessTokenExpiredAt; }
		public function get key							():String	{ return _key; }
		public function get username					():String	{ return _username; }
		public function get metal							():int			{ return _metal; }
		public function get crystal						():int			{ return _crystal; }
		public function get money						():int			{ return _money; }
		public function get score							():int			{ return _score; }
		public function get level_adventure			():int			{ return _level_adventure; }
		public function get achievements				():Array	{ return _achievements; }
		public function get improvements			():Array	{ return _improvements; }
		
		/**
		 * Setters
		 */
		
		public function set accessToken				(value:String):void { _accessToken					= value; }
		public function set accessTokenExpiredAt	(value:int)		:void { _accessTokenExpiredAt	= value; }
		public function set key							(value:String):void	{ _key								= value; }
		public function set username					(value:String):void	{ _username						= value; }
		public function set email							(value:String):void	{ _email							= value; }
		public function set level_adventure			(value:int):void		{ _level_adventure			= value; }
		public function set metal							(value:int):void		{ _metal							= value; }
		public function set crystal						(value:int):void		{ _crystal							= value; }
		public function set money						(value:int):void		{ _money							= value; }
		
	}
}