package core 
{
	import com.greensock.TweenLite;
	
	/**
	 * Manage user
	 * @author desweb
	 */
	public class User 
	{
		private var _accessToken:String;
		private var _accessTokenExpiredAt:int;
		
		private var _key:String;
		private var _username:String;
		private var _email:String;
		private var _levelAdventure:int;
		private var _metal:int;
		private var _crystal:int;
		private var _money:int;
		
		private var _improvements	:Array;
		private var _achievements	:Array;
		
		public var isLog:Boolean;
		
		private var _loaderAccessToken:Loader;
		
		private var _tweenAccessToken:TweenLite;
		
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
			
			_levelAdventure = 0;
			
			_improvements = new Array();
			_improvements[Common.IMPROVEMENT_ARMOR_RESIST]					=
			_improvements[Common.IMPROVEMENT_SHIELD_RESIST]					=
			_improvements[Common.IMPROVEMENT_SHIELD_REGEN]					=
			_improvements[Common.IMPROVEMENT_SHIELD_REPOP]					=
			_improvements[Common.IMPROVEMENT_GUN_DAMAGE]						=
			_improvements[Common.IMPROVEMENT_GUN_CADENCE]					=
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
			
			_tweenAccessToken = new TweenLite();
			_tweenAccessToken.delayedCall(25, refreshAccessToken);
		}
		
		public function logout():void
		{
			_tweenAccessToken.pause();
			_tweenAccessToken.kill();
			_tweenAccessToken = null;
			
			init();
		}
		
		/**
		 * Webservices
		 */
		
		private function refreshAccessToken():void
		{
			_loaderAccessToken = new URLLoader();
			_loaderAccessToken.addEventListener(Event.COMPLETE, completeRrefreshAccessToken);
			_loaderAccessToken.load(API.get_auth(_key));
			
			_tweenAccessToken.pause();
			_tweenAccessToken.kill();
			
			_tweenAccessToken = new TweenLite();
			_tweenAccessToken.delayedCall(25, refreshAccessToken);
		}
		
		private function completeRrefreshAccessToken():void
		{
			_loaderAccessToken.removeEventListener(Event.COMPLETE, completeResponse);
			_loaderAccessToken = null;
			
			var xml:XML;
			xml = new XML(loader.data);
			
			if (xml.error.length() > 0)
			{
				refreshAccessToken();
				return;
			}
			
			_accessToken				= xml.access_token;
			_accessTokenExpiredAt	= xml.expired_at;
		}
		
		/**
		 * Getters
		 */
		
		/**
		 * Setters
		 */
	}
}