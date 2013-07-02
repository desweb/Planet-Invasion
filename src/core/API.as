package core 
{
	import flash.events.IOErrorEvent;
	import flash.events.Event;
	import flash.net.NetConnection;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
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
			
			// Event URL Loader
			loader.addEventListener(Event.COMPLETE, completeLoader);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorLoader);
			
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
			
			/**
			 * Loader events
			 */
			
			function completeLoader(e:Event):void
			{
				loader.removeEventListener(Event.COMPLETE, completeLoader);
				loader.removeEventListener(IOErrorEvent.IO_ERROR, errorLoader);
				
				var loader_response:URLLoader = URLLoader(e.target);
				
				complete(new XML(loader_response.data));
			}
			
			function errorLoader(e:IOErrorEvent):void
			{
				loader.removeEventListener(Event.COMPLETE, completeLoader);
				loader.removeEventListener(IOErrorEvent.IO_ERROR, errorLoader);
				
				complete(new XML('<?xml version="1.0" encoding="ISO-8859-1"?><planet_invasion><error><description>An error occurred</description></error></planet_invasion>'));
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
							get_game(function(responseGame:XML):void
							{
								complete(response);
							});
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
				GameState.user.score				= response.score;
				
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
		public static function post_achievementKey(key:String, complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			vars.score			= GameState.user.achievements[key]['score'];
			vars.is_unlock	= GameState.user.achievements[key]['is_unlock']? 1: 0;
			
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
					GameState.user.improvements[improvement.key] = int(improvement.level);
				
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
				for each(var game:XML in response.games.game)
				{
					GameState.user.games[game.key]['total_metal']					= int(game.total_metal);
					GameState.user.games[game.key]['total_crystal']				= int(game.total_crystal);
					GameState.user.games[game.key]['total_money']				= int(game.total_money);
					GameState.user.games[game.key]['score']							= int(game.score);
					GameState.user.games[game.key]['total_time']					= int(game.total_time);
					GameState.user.games[game.key]['best_time']					= int(game.best_time);
					GameState.user.games[game.key]['total_boost_attack']		= int(game.total_boost_attack);
					GameState.user.games[game.key]['total_boost_speed']		= int(game.total_boost_speed);
					GameState.user.games[game.key]['total_boost_resistance']	= int(game.total_boost_resistance);
				}
				
				complete(response);
			});
		}
		
		// POST game/key
		public static function post_gameKey(key:String, complete:Function):void
		{
			// Params
			var vars:URLVariables = new URLVariables();
			vars.total_metal					= GameState.user.games[key]['total_metal'];
			vars.total_crystal				= GameState.user.games[key]['total_crystal'];
			vars.total_money				= GameState.user.games[key]['total_money'];
			vars.score							= GameState.user.games[key]['score'];
			vars.total_time					= GameState.user.games[key]['total_time'];
			vars.best_time					= GameState.user.games[key]['best_time'];
			vars.total_boost_attack		= GameState.user.games[key]['total_boost_attack'];
			vars.total_boost_speed		= GameState.user.games[key]['total_boost_speed'];
			vars.total_boost_resistance	= GameState.user.games[key]['total_boost_resistance'];
			
			// Request
			basicHTTPRequest(URLRequestMethod.POST, 'game/' + key, vars, true,
			function(response:XML):void
			{
				complete(response);
			});
		}
		
		 /**
		  * Level
		  */
		 
		// GET level
		public static function get_level(complete:Function):void
		{
			// Request
			basicHTTPRequest(URLRequestMethod.GET, 'level', new URLVariables(), false,
			function(response:XML):void
			{
				var i:uint = 0;
				
				for each(var level:XML in response.levels.level)
				{
					GameState.user.levels[i] = new Array();
					GameState.user.levels[i]['key']							= i;
					GameState.user.levels[i]['name']						= level.name;
					GameState.user.levels[i]['total_wave']					= int(level.total_wave);
					GameState.user.levels[i]['time_between_wave']	= int(level.time_between_wave);
					GameState.user.levels[i]['alien']							= int(level.alien);
					GameState.user.levels[i]['asteroid']						= int(level.asteroid);
					GameState.user.levels[i]['cruiser']						= int(level.cruiser);
					GameState.user.levels[i]['destroyer']					= int(level.destroyer);
					GameState.user.levels[i]['heavy_fighter']			= int(level.heavy_fighter);
					GameState.user.levels[i]['kamikaze']					= int(level.kamikaze);
					GameState.user.levels[i]['light_fighter']				= int(level.light_fighter);
					GameState.user.levels[i]['mine']							= int(level.mine);
					GameState.user.levels[i]['transporter']				= int(level.transporter);
					GameState.user.levels[i]['turret']						= int(level.turret);
					
					i++;
				}
				
				complete(response);
			});
		}
	}
}