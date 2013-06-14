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
		private static var _menu_alien_hit		:Sound;
		private static var _menu_alien_dead	:Sound;
		
		private var _menu_button_channel			:SoundChannel;
		private var _menu_button_close_channel	:SoundChannel;
		private var _menu_button_error_channel	:SoundChannel;
		private var _menu_alien_channel			:SoundChannel;
		private var _menu_alien_hit_channel		:SoundChannel;
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
			
			_menu_alien_hit = new Sound();
			_menu_alien_hit.load(new URLRequest(Common.PATH_ASSETS + 'sound/menu-alien-hit.wav'));
			
			_menu_alien_dead = new Sound();
			_menu_alien_dead.load(new URLRequest(Common.PATH_ASSETS + 'sound/menu-alien-dead.mp3'));
		}
		
		public function playMenuButton():void
		{
			_menu_button_channel = _menu_button.play();
			_menu_button_channel.addEventListener(Event.SOUND_COMPLETE, completeMenuButton);
		}
		
		public function playMenuButtonClose():void
		{
			_menu_button_close_channel = _menu_button_close.play();
			_menu_button_close_channel.addEventListener(Event.SOUND_COMPLETE, completeMenuButtonClose);
		}
		
		public function playMenuButtonError():void
		{
			_menu_button_error_channel = _menu_button_error.play();
			_menu_button_error_channel.addEventListener(Event.SOUND_COMPLETE, completeMenuButtonError);
		}
		
		public function playMenuAlien():void
		{
			_menu_alien_channel = _menu_alien.play();
			_menu_alien_channel.addEventListener(Event.SOUND_COMPLETE, completeMenuAlien);
		}
		
		public function playMenuAlienHit():void
		{
			_menu_alien_hit_channel = _menu_alien_hit.play();
			_menu_alien_hit_channel.addEventListener(Event.SOUND_COMPLETE, completeMenuAlienHit);
		}
		
		public function playMenuAlienDead():void
		{
			_menu_alien_dead_channel = _menu_alien_dead.play();
			_menu_alien_dead_channel.addEventListener(Event.SOUND_COMPLETE, completeMenuAlienDead);
		}
		
		/**
		 * Events
		 */
		
		private function completeMenuButton(e:Event):void
		{
			if (!_menu_button_channel) return;
			
			_menu_button_channel.removeEventListener(Event.SOUND_COMPLETE, completeMenuButton);
			_menu_button_channel = null;
		}
		
		private function completeMenuButtonClose(e:Event):void
		{
			if (!_menu_button_close_channel) return;
			
			_menu_button_close_channel.removeEventListener(Event.SOUND_COMPLETE, completeMenuButtonClose);
			_menu_button_close_channel = null;
		}
		
		private function completeMenuButtonError(e:Event):void
		{
			if (!_menu_button_error_channel) return;
			
			_menu_button_error_channel.removeEventListener(Event.SOUND_COMPLETE, completeMenuButtonError);
			_menu_button_error_channel = null;
		}
		
		private function completeMenuAlien(e:Event):void
		{
			if (!_menu_alien_channel) return;
			
			_menu_alien_channel.removeEventListener(Event.SOUND_COMPLETE, completeMenuAlien);
			_menu_alien_channel = null;
		}
		
		private function completeMenuAlienHit(e:Event):void
		{
			if (!_menu_alien_hit_channel) return;
			
			_menu_alien_hit_channel.removeEventListener(Event.SOUND_COMPLETE, completeMenuAlienHit);
			_menu_alien_hit_channel = null;
		}
		
		private function completeMenuAlienDead(e:Event):void
		{
			if (!_menu_alien_dead_channel) return;
			
			_menu_alien_dead_channel.removeEventListener(Event.SOUND_COMPLETE, completeMenuAlienDead);
			_menu_alien_dead_channel = null;
		}
		
		/**
		 * Getters
		 */
		
		public function get menu				():Sound { return _menu; }
		public function get menu_button	():Sound { return _menu_button; }
	}
}