package core 
{
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import core.utils.MD5;
	
	/**
	 * Manage api client to save datas with the web service
	 * @author desweb
	 */
	public class API 
	{
		private static const URL:String = 'http://api.planet-invasion.desweb-creation.fr/';
		
		private static const  ACCESS_TOKEN_MARGIN_ERROR:int = 5*60*1000; // 5 minutes
		
		public function API() {}
		
		/**
		 * Tools
		 */
		
		static private function generateURL(str:String):URLRequest
		{
			var url:String = URL + str;
			
			return new URLRequest(url);
		}
		
		static private function checkAccessToken(complete:Function):void
		{
			var now:Date = new Date();
			
			if (!GameState.user.accessToken || !GameState.user.accessTokenExpiredAt || (now.getTime() > GameState.user.accessTokenExpiredAt * 1000 - ACCESS_TOKEN_MARGIN_ERROR))
			{
				get_auth(function(response:XML):void
				{
					complete();
				});
			}
			else complete();
		}
		
		static private function basicHTTPRequest(httpHeader:String, url:String, vars:URLVariables, isAccessToken:Boolean, complete:Function):void
		{
			// Request
			var request:URLRequest = API.generateURL(url);
			
			request.method = httpHeader;
			
			// URL Loader
			var loader:URLLoader = new URLLoader();
			
			// Complete URL Loader
			loader.addEventListener(Event.COMPLETE,
			function(e:Event):void
			{
				var loader_response:URLLoader = URLLoader(e.target);
				
				if (Common.IS_DEBUG) trace(httpHeader + ' : ' + url + ' => ' + loader_response.data);
				
				var xml:XML;
				xml = new XML(loader_response.data);
				
				complete(xml);
			});
			
			
			loader.addEventListener(IOErrorEvent.IO_ERROR,
			function(e:IOErrorEvent):void
			{
				complete(new XML('<?xml version="1.0" encoding="ISO-8859-1"?><planet_invasion><error><description>No internet connection</description></error></planet_invasion>'));
			});
			
			// Launch URL Loader
			if (isAccessToken)
			{
				checkAccessToken(function():void
				{
					vars.access_token = GameState.user.accessToken;
					
					request.data = vars;
					
					loader.load(request);
				});
			}
			else
			{
				request.data = vars;
				
				loader.load(request);
			}
		}
		
		static private function hashCreateUser(str:String):String
		{
			return MD5.encrypt(str);
		}
		
		/**
		 *************************
		 * Webservice
		 *************************
		 */
		
		 /**
		  * Auth
		  */
		 
		// GET auth
		public static function get_auth(complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			vars.user_key = GameState.user.key;
			
			// Request
			basicHTTPRequest(URLRequestMethod.GET, 'auth/access_token', vars, false,
			function(response:XML):void
			{
				if (response.error.length() > 0) return;
				
				GameState.user.login(response.access_token, response.expired_at);
			});
		}
		
		// POST auth
		public static function post_auth(username:String, password:String, complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			vars.username	= username;
			vars.password	= MD5.encrypt(password);
			
			// Request
			basicHTTPRequest(URLRequestMethod.POST, 'auth', vars, false,
			function(response:XML):void
			{
				if (response.error.length() > 0)
				{
					complete(response);
					return;
				}
				
				GameState.user.login(response.access_token, response.expired_at);
				
				get_user(function(responseUser:XML):void
				{
					get_achievement(function(responseAchievement:XML):void
					{
						get_improvement(function(responseImprovement:XML):void
						{
							complete(response);
						});
					});
				});
			});
		}
		
		// DELETE auth
		public static function delete_auth(complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			
			// Request
			basicHTTPRequest(URLRequestMethod.GET, '/auth/access_token/delete', vars, true,
			function(response:XML):void
			{
				complete(response);
			});
		}
		
		 /**
		  * User
		  */
		 
		// GET user
		public static function get_user(complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			
			// Request
			basicHTTPRequest(URLRequestMethod.GET, 'user', vars, true,
			function(response:XML):void
			{
				if (response.error.length() > 0)
				{
					complete(response);
					return;
				}
				
				GameState.user.key					= response.user_key;
				GameState.user.username			= response.username;
				GameState.user.email				= response.email;
				GameState.user.level_adventure	= response.level_adventure;
				GameState.user.metal				= response.metal;
				GameState.user.crystal				= response.crystal;
				GameState.user.money				= response.money;
				
				complete(response);
			});
		}
		
		// GET user/rank
		public static function get_userRank(complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			
			// Request
			basicHTTPRequest(URLRequestMethod.GET, 'user/rank', vars, true,
			function(response:XML):void
			{
				complete(response);
			});
		}
		
		// POST user
		public static function post_user(username:String, email:String, complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			vars.username	= username;
			vars.email			= email;
			
			// Request
			basicHTTPRequest(URLRequestMethod.POST, 'user', vars, true,
			function(response:XML):void
			{
				complete(response);
			});
		}
		
		// POST user/password
		public static function post_userPassword(old_password:String, new_password:String, complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			vars.old_password		= old_password;
			vars.new_password	= new_password;
			
			// Request
			basicHTTPRequest(URLRequestMethod.POST, 'user/password', vars, true,
			function(response:XML):void
			{
				complete(response);
			});
		}
		
		// POST user/stat
		public static function post_userStat(complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			vars.metal					= GameState.user.metal;
			vars.crystal				= GameState.user.crystal;
			vars.money				= GameState.user.money;
			vars.score					= GameState.user.score;
			vars.level_adventure	= GameState.user.level_adventure;
			
			// Request
			basicHTTPRequest(URLRequestMethod.POST, 'user/stat', vars, true,
			function(response:XML):void
			{
				complete(response);
			});
		}
		
		// PUT user
		public static function put_user(username:String, email:String, password:String, complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			vars.username	= username;
			vars.email			= email;
			vars.password	= MD5.encrypt(password);
			vars.hash			= hashCreateUser(MD5.encrypt(password));
			
			// Request
			basicHTTPRequest(URLRequestMethod.POST, 'user/create', vars, false,
			function(response:XML):void
			{
				if (response.error.length() > 0)
				{
					complete(response);
					return;
				}
				
				GameState.user.login(response.access_token, response.expired_at);
				
				API.get_user(function(responseUser:XML):void
				{
					complete(response);
				});
			});
		}
		
		 /**
		  * Rank
		  */
		 
		// GET rank
		public static function get_rank(page:int, offset:int, complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			vars.page	= page;
			vars.offset	= offset;
			
			// Request
			basicHTTPRequest(URLRequestMethod.GET, 'rank', vars, false,
			function(response:XML):void
			{
				complete(response);
			});
		}
		
		// GET rank/adventure
		public static function get_rankAdventure(page:int, offset:int, complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			vars.page	= page;
			vars.offset	= offset;
			
			// Request
			basicHTTPRequest(URLRequestMethod.GET, 'rank/adventure', vars, false,
			function(response:XML):void
			{
				complete(response);
			});
		}
		
		// GET rank/survival
		public static function get_rankSurvival(page:int, offset:int, complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			vars.page	= page;
			vars.offset	= offset;
			
			// Request
			basicHTTPRequest(URLRequestMethod.GET, 'rank/survival', vars, false,
			function(response:XML):void
			{
				complete(response);
			});
		}
		
		// GET rank/duo
		public static function get_rankDuo(page:int, offset:int, complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			vars.page	= page;
			vars.offset	= offset;
			
			// Request
			basicHTTPRequest(URLRequestMethod.GET, 'rank/duo', vars, false,
			function(response:XML):void
			{
				complete(response);
			});
		}
		
		 /**
		  * Achievement
		  */
		 
		// GET achievement
		public static function get_achievement(complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			
			// Request
			basicHTTPRequest(URLRequestMethod.GET, 'achievement', vars, true,
			function(response:XML):void
			{
				for each (var achievement:XML in response.achievements.achievement)
				{
					GameState.user.achievements[achievement.key]['score']			= achievement.score;
					GameState.user.achievements[achievement.key]['is_unlock']	= achievement.is_unlock;
				}
				
				complete(response);
			});
		}
		
		// POST achievement/key
		public static function post_achievementKey(key:int, score:int, is_unlock:Boolean, complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			vars.score			= score;
			vars.is_unlock	= is_unlock;
			
			// Request
			basicHTTPRequest(URLRequestMethod.POST, 'achievement/' + key, vars, true,
			function(response:XML):void
			{
				complete(response);
			});
		}
		
		 /**
		  * Improvement
		  */
		 
		// GET improvement
		public static function get_improvement(complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			
			// Request
			basicHTTPRequest(URLRequestMethod.GET, 'improvement', vars, true,
			function(response:XML):void
			{
				for each (var improvement:XML in response.improvements.improvement)
					GameState.user.improvements[improvement.key] = improvement.level;
				
				complete(response);
			});
		}
		
		// POST improvement/key
		public static function post_improvementKey(key:String, level:int, complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			vars.level = level;
			
			// Request
			basicHTTPRequest(URLRequestMethod.POST, 'improvement/' + key, vars, true,
			function(response:XML):void
			{
				complete(response);
			});
		}
		
		// POST improvement/initialize
		public static function post_improvementInititalize(complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			
			// Request
			basicHTTPRequest(URLRequestMethod.POST, 'improvement/initialize', vars, true,
			function(response:XML):void
			{
				complete(response);
			});
		}
		
		 /**
		  * Game
		  */
		 
		// GET game
		public static function get_game(complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			
			// Request
			basicHTTPRequest(URLRequestMethod.GET, 'game', vars, true,
			function(response:XML):void
			{
				complete(response);
			});
		}
		
		// POST game/key
		public static function post_gameKey(key:String, total_metal:int, total_crystal:int, total_money:int, score:int, total_time:int, best_time:int, total_boost_attack:int, total_boost_speed:int, total_boost_resistance:int, complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			vars.total_metal					= total_metal;
			vars.total_crystal				= total_crystal;
			vars.total_money				= total_money;
			vars.score							= score;
			vars.total_time					= total_time;
			vars.best_time					= best_time;
			vars.total_boost_attack		= total_boost_attack;
			vars.total_boost_speed		= total_boost_speed;
			vars.total_boost_resistance	= total_boost_resistance;
			
			// Request
			basicHTTPRequest(URLRequestMethod.POST, 'game/' + key, vars, true,
			function(response:XML):void
			{
				complete(response);
			});
		}
	}
}