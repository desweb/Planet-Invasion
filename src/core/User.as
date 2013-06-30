package core 
{
	import flash.net.URLLoader;
	
	/**
	 * Manage user
	 * @author desweb
	 */
	public class User 
	{
		private var _accessToken				:String;
		private var _accessTokenExpiredAt	:int;
		
		private var _key					:String;
		private var _username			:String;
		private var _email					:String;
		private var _score					:int;
		private var _level_adventure	:int;
		private var _metal					:int;
		private var _crystal				:int;
		private var _money				:int;
		
		private	var _improvements:Array;
		private	var _achievements	:Array;
		public	var games				:Array;
		
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
			_metal					= 150;
			_crystal					= 150;
			_money				= 150;
			
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
			
			_achievements = new Array();
			createAchievement(Common.ACHIEVEMENT_METAL);
			createAchievement(Common.ACHIEVEMENT_CRYSTAL);
			createAchievement(Common.ACHIEVEMENT_MONEY);
			createAchievement(Common.ACHIEVEMENT_SERIAL_KILLER);
			createAchievement(Common.ACHIEVEMENT_NATURAL_DEATH);
			createAchievement(Common.ACHIEVEMENT_ROADHOG);
			createAchievement(Common.ACHIEVEMENT_CONQUEROR);
			createAchievement(Common.ACHIEVEMENT_COOPERATION);
			createAchievement(Common.ACHIEVEMENT_SURVIVAL);
			createAchievement(Common.ACHIEVEMENT_MISTER_BOOSTER);
			createAchievement(Common.ACHIEVEMENT_CURIOSITY);
			createAchievement(Common.ACHIEVEMENT_ALIEN_BLAST);
			
			games = new Array();
			games[Common.GAME_ADVENTURE_KEY]	= new Array();
			games[Common.GAME_SURVIVAL_KEY]		= new Array();
			games[Common.GAME_DUO_KEY]				= new Array();
			
			for each (var game:Array in games)
			{
				game['total_metal']					= 0;
				game['total_crystal']					= 0;
				game['total_money']					= 0;
				game['score']							= 0;
				game['total_time']						= 0;
				game['best_time']						= 0;
				game['total_boost_attack']			= 0;
				game['total_boost_speed']			= 0;
				game['total_boost_resistance']	= 0;
			}
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
		
		private function createAchievement(key:String):void
		{
			_achievements[key] = new Array();
			_achievements[key]['score']		= 0;
			_achievements[key]['is_unlock']	= false;
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
		public function set score							(value:int)		:void	{ _score							= value; }
		public function set level_adventure			(value:int)		:void { _level_adventure			= value; }
		public function set metal							(value:int)		:void { _metal							= value; }
		public function set crystal						(value:int)		:void { _crystal							= value; }
		public function set money						(value:int)		:void { _money							= value; }
		
	}
}