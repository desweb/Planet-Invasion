package core 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	/**
	 * Manage sounds & musics
	 * @author desweb
	 */
	public class SoundManager 
	{
		private static var _instance:SoundManager;
		
		public static const ACHIEVEMENT					:uint = 1;
		public static const BUY								:uint = 2;
		public static const EXPLOSION						:uint = 3;
		public static const GAME_OVER					:uint = 4;
		public static const GUN								:uint = 5;
		public static const ITEM								:uint = 6;
		public static const LASER							:uint = 7;
		public static const MENU_ALIEN					:uint = 8;
		public static const MENU_ALIEN_DEAD			:uint = 9;
		public static const MENU_BUTTON				:uint = 10;
		public static const MENU_BUTTON_CLOSE		:uint = 11;
		public static const MENU_BUTTON_ERROR	:uint = 12;
		public static const MISSILE							:uint = 13;
		public static const PROPELLANT					:uint = 14;
		public static const WIN								:uint = 15;
		
		private static var _menu						:Sound;
		private static var _menu_button			:Sound;
		private static var _menu_button_close	:Sound;
		private static var _menu_button_error	:Sound;
		private static var _menu_alien			:Sound;
		private static var _menu_alien_dead	:Sound;
		private static var _achievement			:Sound;
		private static var _buy						:Sound;
		private static var _explosion				:Sound;
		private static var _game_over				:Sound;
		private static var _gun						:Sound;
		private static var _item						:Sound;
		private static var _laser						:Sound;
		private static var _missile					:Sound;
		private static var _propellant				:Sound;
		private static var _win						:Sound;
		
		private var _menu_button_channel			:SoundChannel;
		private var _menu_button_close_channel	:SoundChannel;
		private var _menu_button_error_channel	:SoundChannel;
		private var _menu_alien_channel			:SoundChannel;
		private var _menu_alien_dead_channel	:SoundChannel;
		
		public var available:int;
		
		public function SoundManager() 
		{
			_instance	= this;
			available	= Common.SOUND_ON;
		}
		
		/**
		 * Instance
		 */
		
		static public function getInstance():SoundManager
		{
			if (_instance == null) _instance = new SoundManager();
			
			return _instance;
		}
		
		/**
		 * Functions
		 */
		
		public function load():void
		{
			_menu = new Sound();
			_menu.load(new URLRequest(Common.PATH_ASSETS + 'sound/menu.mp3'));
			
			_menu_button = new Sound();
			_menu_button.load(new URLRequest(Common.PATH_ASSETS + 'sound/menu-button.mp3'));
			
			_menu_button_close = new Sound();
			_menu_button_close.load(new URLRequest(Common.PATH_ASSETS + 'sound/menu-button-close.mp3'));
			
			_menu_button_error = new Sound();
			_menu_button_error.load(new URLRequest(Common.PATH_ASSETS + 'sound/menu-button-error.mp3'));
			
			_menu_alien = new Sound();
			_menu_alien.load(new URLRequest(Common.PATH_ASSETS + 'sound/menu-alien.mp3'));
			
			_menu_alien_dead = new Sound();
			_menu_alien_dead.load(new URLRequest(Common.PATH_ASSETS + 'sound/menu-alien-dead.mp3'));
			
			_achievement = new Sound();
			_achievement.load(new URLRequest(Common.PATH_ASSETS + 'sound/achievement.mp3'));
			
			_buy = new Sound();
			_buy.load(new URLRequest(Common.PATH_ASSETS + 'sound/buy.mp3'));
			
			_explosion = new Sound();
			_explosion.load(new URLRequest(Common.PATH_ASSETS + 'sound/explosion.mp3'));
			
			_game_over = new Sound();
			_game_over.load(new URLRequest(Common.PATH_ASSETS + 'sound/game-over.mp3'));
			
			_gun = new Sound();
			_gun.load(new URLRequest(Common.PATH_ASSETS + 'sound/gun.mp3'));
			
			_item = new Sound();
			_item.load(new URLRequest(Common.PATH_ASSETS + 'sound/item.mp3'));
			
			_laser = new Sound();
			_laser.load(new URLRequest(Common.PATH_ASSETS + 'sound/laser.mp3'));
			
			_missile = new Sound();
			_missile.load(new URLRequest(Common.PATH_ASSETS + 'sound/missile.mp3'));
			
			_propellant = new Sound();
			_propellant.load(new URLRequest(Common.PATH_ASSETS + 'sound/propellant.mp3'));
			
			_win = new Sound();
			_win.load(new URLRequest(Common.PATH_ASSETS + 'sound/win.mp3'));
		}
		
		public function play(sound_uid:uint):void
		{
			var s:Sound;
			
			switch (sound_uid)
			{
				case ACHIEVEMENT				: s = _achievement;			break;
				case BUY								: s = _buy;						break;
				case EXPLOSION					: s = _explosion;				break;
				case GAME_OVER					: s = _game_over;				break;
				case GUN								: s = _gun;						break;
				case ITEM								: s = _item;						break;
				case LASER							: s = _laser;						break;
				case MENU_ALIEN					: s = _menu_alien;			break;
				case MENU_ALIEN_DEAD		: s = _menu_alien_dead;	break;
				case MENU_BUTTON				: s = _menu_button;			break;
				case MENU_BUTTON_CLOSE	: s = _menu_button_close;	break;
				case MENU_BUTTON_ERROR	: s = _menu_button_error;	break;
				case MISSILE						: s = _missile;					break;
				case PROPELLANT					: s = _propellant;				break;
				case WIN								: s = _win;						break;
				default: return;
			}
			
			var c:SoundChannel = s.play();
			
			if (!c) return;
			
			c.addEventListener(Event.SOUND_COMPLETE,
			function completeChannel(e:Event):void
			{
				c.removeEventListener(Event.SOUND_COMPLETE, completeChannel);
				c.stop();
				c = null;
			});
		}
		
		/**
		 * Getters
		 */
		
		public function get menu():Sound { return _menu; }
	}
}