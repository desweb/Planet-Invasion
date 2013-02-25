package core 
{
	/**
	 * General singleton of the application
	 * @author desweb
	 */
	public class GameState 
	{
		private static var _instance:GameState;
		private static var _main:Main;
		
		public function GameState() 
		{
			_instance = this;
		}
		
		/**
		 * Singleton
		 */	
		public static function getInstance():GameState
		{
			if (_instance == null) _instance = new GameState();
			
			return _instance;
		}
		
		static public function set main(value:Main):void
		{ 
			if (_main == null)
				_main = value;
		}
		
		static public function get main():Main
		{ 
			return _main;
		}
	}

}