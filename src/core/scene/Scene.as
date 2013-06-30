package core.scene 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	import core.Achievement;
	import core.API;
	import core.Common;
	import core.GameState;
	import core.Interface;
	import core.SoundManager;
	import core.popup.AchievementPopup;
	import core.popup.ErrorPopup;
	import core.popup.LoginPopup;
	import core.popup.RegisterPopup;
	import core.scene.IScene;
	import core.scene.SceneManager;
	
	/**
	 * Base of scenes
	 * @author desweb
	 */
	public class Scene extends Interface implements IScene
	{
		// Time
		private var _t:int;
		protected var _dt:Number;
		
		private var _bg:BgFlash;
		
		private var _alien_plan:Sprite;
		
		private var _return_btn	:BtnReturnFlash;
		private var _sound_btn	:BtnSoundFlash;
		private var _login_btn	:BtnLeftFlash;
		private var _register_btn:BtnRightFlash;
		private var _logout_btn	:BtnDisconnectFlash;
		
		private var _username_icon:ProfileFlash;
		
		private var _txtUsername:TextField;
		
		protected var _return_scene_uid:uint;
		
		public var is_alien_menu:Boolean = false;
		private var _alien_create_time	:Number;
		private var _alien_create_timer	:Number = 10;
		
		public function Scene()
		{
			_alien_create_time = _alien_create_timer;
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		/**
		 * Generation
		 */
		
		// Background
		protected function generateBg():void
		{
			_bg = new BgFlash();
			_bg.gotoAndStop(2);
			addChild(_bg);
			
			if (!is_alien_menu) return;
			
			_alien_plan = new Sprite();
			addChild(_alien_plan);
		}
		
		// Return button
		protected function generateBtnReturn():void
		{
			_return_btn = new BtnReturnFlash();
			_return_btn.x = Common.IS_DEBUG? GameState.stageWidth * .15: GameState.stageWidth * .02;
			_return_btn.y = GameState.stageHeight * .055;
			addChild(_return_btn);
			
			_return_btn.addEventListener(MouseEvent.MOUSE_OVER,	over);
			_return_btn.addEventListener(MouseEvent.MOUSE_OUT,	out);
			_return_btn.addEventListener(MouseEvent.CLICK,			clickReturn);
		}
		
		// Sound button
		protected function generateBtnSound():void
		{
			_sound_btn = new BtnSoundFlash();
			_sound_btn.x = Common.IS_DEBUG? GameState.stageWidth * .2: GameState.stageWidth * .1;
			_sound_btn.y = GameState.stageHeight * .05;
			addChild(_sound_btn);
			
			_sound_btn.gotoAndStop(SoundManager.getInstance().available == Common.SOUND_ON? 1: 2);
			
			_sound_btn.addEventListener(MouseEvent.MOUSE_OVER,	over);
			_sound_btn.addEventListener(MouseEvent.MOUSE_OUT,	out);
			_sound_btn.addEventListener(MouseEvent.CLICK,			clickSound);
		}
		
		// Login area
		protected function generateLogin():void
		{
			if (GameState.user.isLog)
			{
				var username_format:TextFormat = Common.getPolicy('Arial', 0x00ffff, 20);
				username_format.bold	= true;
				username_format.align	= 'right';
				
				var username_label:TextField			= new TextField();
				username_label.x							= GameState.stageWidth	* .45;
				username_label.y							= GameState.stageHeight	* .025;
				username_label.width						= GameState.stageWidth	* .4;
				username_label.height					= GameState.stageHeight	* .1;
				username_label.defaultTextFormat	= username_format;
				username_label.text						= GameState.user.username;
				username_label.selectable				= false;
				addChild(username_label);
				
				_username_icon = new ProfileFlash();
				_username_icon.x	= GameState.stageWidth	* .875;
				_username_icon.y	= GameState.stageHeight	* .025;
				addChild(_username_icon);
				
				_logout_btn = new BtnDisconnectFlash();
				_logout_btn.x = GameState.stageWidth	* .925;
				_logout_btn.y = GameState.stageHeight	* .03;
				addChild(_logout_btn);
				
				_username_icon	.addEventListener(MouseEvent.MOUSE_OVER,	over);
				_username_icon	.addEventListener(MouseEvent.MOUSE_OUT,	out);
				_username_icon	.addEventListener(MouseEvent.CLICK,				clickProfile);
				_logout_btn			.addEventListener(MouseEvent.MOUSE_OVER,	over);
				_logout_btn			.addEventListener(MouseEvent.MOUSE_OUT,	out);
				_logout_btn			.addEventListener(MouseEvent.CLICK,				clickLogout);
			}
			else
			{
				_login_btn = generateBtnLeft('Login');
				_login_btn.x = GameState.stageWidth		* .55;
				_login_btn.y = GameState.stageHeight	* .05;
				
				_register_btn = generateBtnRight('Register');
				_register_btn.x = _login_btn.x + _login_btn.width;
				_register_btn.y = _login_btn.y;
				
				_login_btn		.addEventListener(MouseEvent.CLICK, clickLogin);
				_register_btn	.addEventListener(MouseEvent.CLICK, clickRegister);
			}
		}
		
		public function displayErrorPopup (message:String):void
		{
			var error_popup:ErrorPopup = new ErrorPopup();
			error_popup.setText(message);
			
			SceneManager.getInstance().scene.addChild(error_popup);
			
			error_popup.display();
		}
		
		public function checkAchievement(key:String, value:int):Boolean
		{
			var achievement_user:Array = GameState.user.achievements[key];
			
			if (achievement_user['is_unlock'] == 1) return false;
			
			var achievement:Achievement = new Achievement(key);
			
			achievement_user['score'] += value;
			
			if (achievement.score <= achievement_user['score'])
			{
				achievement_user['score']			= achievement.score;
				achievement_user['is_unlock']	= true;
				
				if (GameState.user.isLog) API.post_achievementKey(key, function(response:XML):void {});
				
				var achievement_popup:AchievementPopup = new AchievementPopup(key);
				
				addChild(achievement_popup);
				
				achievement_popup.display();
			}
			
			return true;
		}
		
		/**
		 * Events
		 */
		
		private function update(e:Event):void
		{
			var t:int = getTimer();
			_dt = (t - _t) * 0.001;
			_t = t;
			
			if (is_alien_menu)
			{
				_alien_create_time -= _dt;
				
				if (_alien_create_time <= 0)
				{
					_alien_plan.addChild(new AlienMenu());
					
					_alien_create_time = _alien_create_timer;
				}
			}
		}
		
		private function clickReturn(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			SceneManager.getInstance().setCurrentScene(_return_scene_uid? _return_scene_uid: SceneManager.getInstance().old_scene_uid);
		}
		
		private function clickSound(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			
			if (SoundManager.getInstance().available == Common.SOUND_ON)
			{
				_sound_btn.gotoAndStop(Common.FRAME_SOUND_OFF);
				SceneManager.getInstance().stopSound();
			}
			else
			{
				_sound_btn.gotoAndStop(Common.FRAME_SOUND_ON);
				SceneManager.getInstance().playSound();
			}
		}
		
		private function clickLogin(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			
			var loginPopup:LoginPopup = new LoginPopup();
			addChild(loginPopup);
			loginPopup.display();
		}
		
		private function clickProfile(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			SceneManager.getInstance().setCurrentScene(Common.SCENE_PROFILE);
		}
		
		private function clickLogout(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			
			GameState.user.logout();
			
			SceneManager.getInstance().setCurrentScene(SceneManager.getInstance().current_scene_id);
		}
		
		private function clickRegister(e:MouseEvent):void
		{
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			
			var registerPopup:RegisterPopup = new RegisterPopup();
			addChild(registerPopup);
			registerPopup.display();
		}
		
		/**
		 * Removes
		 */
		
		public function destroy():void
		{
			removeEventListener(Event.ENTER_FRAME, update);
			
			if (_return_btn)
			{
				_return_btn.removeEventListener(MouseEvent.MOUSE_OVER,	over);
				_return_btn.removeEventListener(MouseEvent.MOUSE_OUT,		out);
				_return_btn.removeEventListener(MouseEvent.CLICK,				clickReturn);
			}
			
			if (_sound_btn)
			{
				_sound_btn.removeEventListener(MouseEvent.MOUSE_OVER,	over);
				_sound_btn.removeEventListener(MouseEvent.MOUSE_OUT,		out);
				_sound_btn.removeEventListener(MouseEvent.CLICK,				clickSound);
			}
			
			if (_login_btn) _login_btn.removeEventListener(MouseEvent.CLICK, clickLogin);
			
			if (_username_icon)
			{
				_username_icon.removeEventListener(MouseEvent.MOUSE_OVER,	over);
				_username_icon.removeEventListener(MouseEvent.MOUSE_OUT,	out);
				_username_icon.removeEventListener(MouseEvent.CLICK,			clickProfile);
			}
			
			if (_logout_btn)
			{
				_logout_btn.removeEventListener(MouseEvent.MOUSE_OVER,	over);
				_logout_btn.removeEventListener(MouseEvent.MOUSE_OUT,		out);
				_logout_btn.removeEventListener(MouseEvent.CLICK,				clickLogout);
			}
			
			if (_register_btn) _register_btn.removeEventListener(MouseEvent.CLICK, clickRegister);
			
			parent.removeChild(this);
		}
	}
}