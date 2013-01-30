package core 
{
	/**
	 * Manage api client to save datas with the web service
	 * @author desweb
	 */
	public class API 
	{
		private static const URL:String = 'http://api.planet-invasion.desweb-creation.fr/';
		
		public function API() 
		{
			
		}
		
		// Auth
		public static function get_auth(user_key:String)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'auth/access_token');
			request.method = URLRequestMethod.GET;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.user_key = user_key;
			request.data = vars;
			
			return request;
		}
		
		public static function post_auth(username:String, password:String)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'auth');
			request.method = URLRequestMethod.POST;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.username = username;
			vars.password = password;
			request.data = vars;
			
			return request;
		}
		
		public static function delete_auth(access_token:String)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'auth/access_token');
			request.method = URLRequestMethod.DELETE;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.username = username;
			vars.password = password;
			request.data = vars;
			
			return request;
		}
		
		// User
		public static function get_user(access_token:String)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'user');
			request.method = URLRequestMethod.GET;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.access_token = access_token;
			request.data = vars;
			
			return request;
		}
		
		public static function get_userRank(access_token:String)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'user/rank');
			request.method = URLRequestMethod.GET;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.access_token = access_token;
			request.data = vars;
			
			return request;
		}
		
		public static function post_user(access_token:String, username:String, email:String)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'user');
			request.method = URLRequestMethod.POST;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.access_token	= access_token;
			vars.username		= username;
			vars.email			= email;
			request.data = vars;
			
			return request;
		}
		
		public static function post_userPassword(access_token:String, old_password:String, new_password:String)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'user/password');
			request.method = URLRequestMethod.POST;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.access_token = access_token;
			vars.old_password = old_password;
			vars.new_password = new_password;
			request.data = vars;
			
			return request;
		}
		
		public static function post_userStat(access_token:String, metal:int, crystal:int, money:int, score:int, level_adventure:int)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'user/stat');
			request.method = URLRequestMethod.POST;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.access_token		= access_token;
			vars.metal				= metal;
			vars.crystal			= crystal;
			vars.money				= money;
			vars.score				= score;
			vars.level_adventure	= level_adventure;
			request.data = vars;
			
			return request;
		}
		
		public static function put_user(username:String, email:String, password:String)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'user');
			request.method = URLRequestMethod.PUT;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.username	= username;
			vars.email		= email;
			vars.password	= password;
			request.data = vars;
			
			return request;
		}
		
		// Rank
		public static function get_rank(access_token:String, page:int, offset:int)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'rank');
			request.method = URLRequestMethod.GET;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.access_token	= access_token;
			vars.page			= page;
			vars.offset			= offset;
			request.data = vars;
			
			return request;
		}
		
		public static function get_rankAdventure(access_token:String, page:int, offset:int)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'rank/adventure');
			request.method = URLRequestMethod.GET;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.access_token	= access_token;
			vars.page			= page;
			vars.offset			= offset;
			request.data = vars;
			
			return request;
		}
		
		public static function get_rankSurvival(access_token:String, page:int, offset:int)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'rank/survival');
			request.method = URLRequestMethod.GET;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.access_token	= access_token;
			vars.page			= page;
			vars.offset			= offset;
			request.data = vars;
			
			return request;
		}
		
		public static function get_rankDuo(access_token:String, page:int, offset:int)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'rank/duo');
			request.method = URLRequestMethod.GET;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.access_token	= access_token;
			vars.page			= page;
			vars.offset			= offset;
			request.data = vars;
			
			return request;
		}
		
		// Achievement
		public static function get_achievement(access_token:String)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'achievement');
			request.method = URLRequestMethod.GET;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.access_token = access_token;
			request.data = vars;
			
			return request;
		}
		
		public static function post_achievementKey(access_token:String, key:int, score:int, is_unlock:Boolean)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'achievement/' + key);
			request.method = URLRequestMethod.POST;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.access_token	= access_token;
			vars.score			= score;
			vars.is_unlock		= is_unlock;
			request.data = vars;
			
			return request;
		}
		
		// Improvement
		public static function get_improvement(access_token:String)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'improvement');
			request.method = URLRequestMethod.GET;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.access_token = access_token;
			request.data = vars;
			
			return request;
		}
		
		public static function post_improvementKey(access_token:String, key:int, level:int)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'improvement/' + key);
			request.method = URLRequestMethod.POST;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.access_token	= access_token;
			vars.level			= level;
			request.data = vars;
			
			return request;
		}
		
		public static function post_improvementInititalize(access_token:String)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'improvement/initialize');
			request.method = URLRequestMethod.POST;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.access_token = access_token;
			request.data = vars;
			
			return request;
		}
		
		// Game
		public static function get_game(access_token:String)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'game');
			request.method = URLRequestMethod.GET;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.access_token = access_token;
			request.data = vars;
			
			return request;
		}
		
		public static function post_gameKey(access_token:String, key:String, total_metal:int, total_crystal:int, total_money:int, score:int, total_time:int, best_time:int, total_boost_attack:int, total_boost_speed:int, total_boost_resistance:int)
		{
			// Request
			var request:URLRequest = new URLRequest(self.URL + 'game/' + key);
			request.method = URLRequestMethod.POST;
			
			// Params
			var vars:URLVariables = new URLVariables();
			vars.access_token			= access_token;
			vars.total_metal			= total_metal;
			vars.total_crystal			= total_crystal;
			vars.total_money			= total_money;
			vars.score					= score;
			vars.total_time				= total_time;
			vars.best_time				= best_time;
			vars.total_boost_attack		= total_boost_attack;
			vars.total_boost_speed		= total_boost_speed;
			vars.total_boost_resistance	= total_boost_resistance;
			request.data = vars;
			
			return request;
		}
	}

}