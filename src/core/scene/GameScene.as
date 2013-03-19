package core.scene 
{
	import core.Common;
	import core.game.Game;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class GameScene extends Scene
	{
		private var _game:Game;
		
		public function GameScene(type:uint) 
		{
			if (Common.IS_DEBUG) trace('create GameScene');
			
			_game = new Game(type);
			addChild(_game);
		}
	}
}