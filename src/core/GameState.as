package core 
{
	import flash.display.Stage;
	
	import core.game.Game;
	
	/**
	 * General singleton of the application
	 * @author desweb
	 */
	public class GameState 
	{
		private static var _instance:GameState;
		private static var _main:Main;
		private static var _game:Game;
		
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
			if (_main == null) _main = value;
		}
		
		static public function get main():Main
		{ 
			return _main;
		}
		
		static public function get user():User
		{ 
			return _main.user;
		}
		
		static public function set game(value:Game):void
		{ 
			_game = value;
		}
		
		static public function get game():Game
		{ 
			return _game;
		}
		
		/**
		 * Tools functions
		 */
		
		static public function get stage():Stage
		{
			return _main.stage;
		}
		
		static public function get stageWidth():int
		{
			return _main.stage.stageWidth;
		}

		static public function get stageHeight():int
		{
			return _main.stage.stageHeight;
		}
	}
}