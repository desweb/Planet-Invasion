package core 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	
	import core.Common;
	
	/**
	 * Manage sounds & musics
	 * @author desweb
	 */
	public class SoundManager 
	{
		private static var _instance:SoundManager;
		
		private static var _menu						:Sound;
		private static var _menu_button			:Sound;
		private static var _menu_button_close	:Sound;
		private static var _menu_button_error	:Sound;
		private static var _menu_alien			:Sound;
		private static var _menu_alien_dead	:Sound;
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
		
		public function playMenuButton():void
		{
			_menu_button_channel = _menu_button.play();
			
			if (!_menu_button_channel) return;
			
			_menu_button_channel.addEventListener(Event.SOUND_COMPLETE, completeMenuButton);
		}
		
		public function playMenuButtonClose():void
		{
			_menu_button_close_channel = _menu_button_close.play();
			
			if (!_menu_button_close_channel) return;
			
			_menu_button_close_channel.addEventListener(Event.SOUND_COMPLETE, completeMenuButtonClose);
		}
		
		public function playMenuButtonError():void
		{
			_menu_button_error_channel = _menu_button_error.play();
			
			if (!_menu_button_error_channel) return;
			
			_menu_button_error_channel.addEventListener(Event.SOUND_COMPLETE, completeMenuButtonError);
		}
		
		public function playMenuAlien():void
		{
			_menu_alien_channel = _menu_alien.play();
			
			if (!_menu_alien_channel) return;
			
			_menu_alien_channel.addEventListener(Event.SOUND_COMPLETE, completeMenuAlien);
		}
		
		public function playMenuAlienDead():void
		{
			_menu_alien_dead_channel = _menu_alien_dead.play();
			
			if (!_menu_alien_dead_channel) return;
			
			_menu_alien_dead_channel.addEventListener(Event.SOUND_COMPLETE, completeMenuAlienDead);
		}
		
		public function play(title:String):void
		{
			var channel:SoundChannel;
			
			switch (title)
			{
				case 'explosion'		: channel = _explosion		.play(); break;
				case 'game-over'	: channel = _game_over	.play(); break;
				case 'gun'				: channel = _gun				.play(); break;
				case 'item'				: channel = _item				.play(); break;
				case 'laser'			: channel = _laser				.play(); break;
				case 'missile'			: channel = _missile			.play(); break;
				case 'propellant'		: channel = _propellant		.play(); break;
				case 'win'				: channel = _win				.play(); break;
				default: return;
			}
			
			if (!channel) return;
			
			channel.addEventListener(Event.SOUND_COMPLETE,
			function completeChannel(e:Event):void
			{
				channel.removeEventListener(Event.SOUND_COMPLETE, completeChannel);
				channel.stop();
				channel = null;
			});
		}
		
		/**
		 * Events
		 */
		
		private function completeMenuButton(e:Event):void
		{
			if (!_menu_button_channel) return;
			
			_menu_button_channel.removeEventListener(Event.SOUND_COMPLETE, completeMenuButton);
		}
		
		private function completeMenuButtonClose(e:Event):void
		{
			if (!_menu_button_close_channel) return;
			
			_menu_button_close_channel.removeEventListener(Event.SOUND_COMPLETE, completeMenuButtonClose);
		}
		
		private function completeMenuButtonError(e:Event):void
		{
			if (!_menu_button_error_channel) return;
			
			_menu_button_error_channel.removeEventListener(Event.SOUND_COMPLETE, completeMenuButtonError);
		}
		
		private function completeMenuAlien(e:Event):void
		{
			if (!_menu_alien_channel) return;
			
			_menu_alien_channel.removeEventListener(Event.SOUND_COMPLETE, completeMenuAlien);
		}
		
		private function completeMenuAlienDead(e:Event):void
		{
			if (!_menu_alien_dead_channel) return;
			
			_menu_alien_dead_channel.removeEventListener(Event.SOUND_COMPLETE, completeMenuAlienDead);
		}
		
		/**
		 * Getters
		 */
		
		public function get menu				():Sound { return _menu; }
		public function get menu_button	():Sound { return _menu_button; }
	}
}