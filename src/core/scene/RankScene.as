package core.scene 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.scroll.ScrollManager;
	
	import core.API;
	import core.Common;
	import core.GameState;
	import core.SoundManager;
	
	/**
	 * General ranking & ranking of adventure, survival & duo mode
	 * @author desweb
	 */
	public class RankScene extends Scene
	{
		private var _tabRank					:BtnLeftFlash;
		private var _tabRankAdventure	:Sprite;
		private var _tabRankSurvival		:Sprite;
		private var _tabRankDuo			:BtnRightFlash;
		
		private var _title_label:TextField;
		
		private var _loader:LoaderFlash;
		
		private var _contentRank				:Sprite;
		private var _contentRankAdventure	:Sprite;
		private var _contentRankSurvival	:Sprite;
		private var _contentRankDuo			:Sprite;
		
		private var _userRank				:RankUserBgFlash;
		private var _userRankAdventure	:RankUserBgFlash;
		private var _userRankSurvival	:RankUserBgFlash;
		private var _userRankDuo			:RankUserBgFlash;
		
		private var _scrollRank				:ScrollManager;
		private var _scrollRankAdventure:ScrollManager;
		private var _scrollRankSurvival	:ScrollManager;
		private var _scrollRankDuo			:ScrollManager;
		
		private var _scroll_format				:TextFormat;
		private var _scroll_format_bold		:TextFormat;
		private var _scroll_format_pts			:TextFormat;
		private var _scroll_format_bold_pts	:TextFormat;
		private var _scroll_format_user		:TextFormat;
		private var _scroll_format_user_pts	:TextFormat;
		
		public function RankScene()
		{
			var scroll_height:int = GameState.user.isLog? GameState.stageHeight * .65: GameState.stageHeight * .75;
			
			/**
			 * Initialization
			 */
			
			generateBg();
			generateBtnReturn();
			
			// Format
			_scroll_format						= Common.getPolicy('Arial', 0x00FFFF, 15);
			_scroll_format_bold				= Common.getPolicy('Arial', 0x00FF00, 15);
			_scroll_format_bold.bold			= true;
			_scroll_format_pts					= Common.getPolicy('Arial', 0x00FFFF, 15);
			_scroll_format_pts.align			= 'right';
			_scroll_format_bold_pts			= Common.getPolicy('Arial', 0x00FF00, 15);
			_scroll_format_bold_pts.align	= 'right';
			_scroll_format_bold_pts.bold	= true;
			_scroll_format_user				= Common.getPolicy('Arial', 0x00FFFF, 15);
			_scroll_format_user.bold		= true;
			_scroll_format_user_pts			= Common.getPolicy('Arial', 0x00FFFF, 15);
			_scroll_format_user_pts.align	= 'right';
			_scroll_format_user_pts.bold	= true;
			
			// Tab bar
			_tabRank = generateBtnLeft('General');
			_tabRank.x = GameState.stageWidth * .1;
			_tabRank.y = GameState.stageHeight * .05;
			
			_tabRankAdventure = generateTab('Adventure');
			_tabRankAdventure.x = _tabRank.x + _tabRank.width;
			_tabRankAdventure.y = _tabRank.y;
			
			_tabRankSurvival = generateTab('Survival');
			_tabRankSurvival.x = _tabRankAdventure.x + _tabRankAdventure.width - 1;
			_tabRankSurvival.y = _tabRank.y;
			
			_tabRankDuo = generateBtnRight('Duo');
			_tabRankDuo.x = _tabRankSurvival.x + _tabRankSurvival.width;
			_tabRankDuo.y = _tabRank.y;
			
			_tabRank				.addEventListener(MouseEvent.CLICK, clickTabRank);
			_tabRankAdventure.addEventListener(MouseEvent.CLICK, clickTabRankAdventure);
			_tabRankSurvival	.addEventListener(MouseEvent.CLICK, clickTabRankSurvival);
			_tabRankDuo			.addEventListener(MouseEvent.CLICK, clickTabRankDuo);
			
			// Title
			var format_title:TextFormat = Common.getPolicy('Arial', 0x00ffff, 20);
			format_title.bold = true;
			
			_title_label = new TextField();
			_title_label.x							= GameState.stageWidth	* .25;
			_title_label.y							= GameState.stageHeight	* .15;
			_title_label.width					= GameState.stageWidth	* .5;
			_title_label.height					= GameState.stageHeight	* .5;
			_title_label.defaultTextFormat	= format_title;
			_title_label.text						= 'General ranking';
			_title_label.selectable				= false;
			addChild(_title_label);
			
			// Loader
			_loader = new LoaderFlash();
			_loader.x = GameState.stageWidth / 2;
			_loader.y = GameState.stageHeight / 2;
			addChild(_loader);
			
			addEventListener(Event.ENTER_FRAME, updateLoader);
			
			// webservice
			API.get_rank(1, 50,
			function(response:XML):void
			{
				removeEventListener(Event.ENTER_FRAME, updateLoader);
				removeChild(_loader);
				_loader = null;
				
				_contentRank = new Sprite();
				
				var i:int = 0;
				for each (var user:XML in response.users.user)
				{
					_contentRank.addChild(generateLine(user, i));
					
					i++;
				}
				
				_scrollRank = new ScrollManager(_contentRank, GameState.stageWidth * .9, scroll_height);
				_scrollRank.y = GameState.stageHeight * .225;
				addChild(_scrollRank);
			});
			
			API.get_rankAdventure(1, 50,
			function(response:XML):void
			{
				_contentRankAdventure = new Sprite();
				
				var i:int = 0;
				for each (var user:XML in response.users.user)
				{
					_contentRankAdventure.addChild(generateLine(user, i));
					
					i++;
				}
				
				_scrollRankAdventure = new ScrollManager(_contentRankAdventure, GameState.stageWidth * .9, scroll_height);
				_scrollRankAdventure.y = GameState.stageHeight * .225;
				_scrollRankAdventure.visible = false;
				addChild(_scrollRankAdventure);
			});
			
			API.get_rankSurvival(1, 50,
			function(response:XML):void
			{
				_contentRankSurvival = new Sprite();
				
				var i:int = 0;
				for each (var user:XML in response.users.user)
				{
					_contentRankSurvival.addChild(generateLine(user, i));
					
					i++;
				}
				
				_scrollRankSurvival = new ScrollManager(_contentRankSurvival, GameState.stageWidth * .9, scroll_height);
				_scrollRankSurvival.y = GameState.stageHeight * .225;
				_scrollRankSurvival.visible = false;
				addChild(_scrollRankSurvival);
			});
			
			API.get_rankDuo(1, 50,
			function(response:XML):void
			{
				_contentRankDuo = new Sprite();
				
				var i:int = 0;
				for each (var user:XML in response.users.user)
				{
					_contentRankDuo.addChild(generateLine(user, i));
					
					i++;
				}
				
				_scrollRankDuo = new ScrollManager(_contentRankDuo, GameState.stageWidth * .9, scroll_height);
				_scrollRankDuo.y = GameState.stageHeight * .225;
				_scrollRankDuo.visible = false;
				addChild(_scrollRankDuo);
			});
			
			if (GameState.user.isLog)
			{
				API.get_userRank(function(response:XML):void
				{
					_userRank					= generateLineUser(response.general);
					_userRankAdventure	= generateLineUser(response.adventure);
					_userRankSurvival		= generateLineUser(response.survival);
					_userRankDuo			= generateLineUser(response.duo);
					
					addChild(_userRank);
					addChild(_userRankAdventure);
					addChild(_userRankSurvival);
					addChild(_userRankDuo);
					
					_userRank.visible = true;
				});
			}
		}
		
		/**
		 * Events
		 */
		
		private function clickTabRank(e:Event):void
		{
			if (!_scrollRank || !_scrollRankAdventure || !_scrollRankSurvival || !_scrollRankDuo || _scrollRank.visible) return;
			
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			
			_title_label.text = 'General ranking';
			
			_scrollRank				.visible = true;
			_scrollRankAdventure	.visible = false;
			_scrollRankSurvival	.visible = false;
			_scrollRankDuo			.visible = false;
			
			if (GameState.user.isLog)
			{
				_userRank					.visible = true;
				_userRankAdventure	.visible = false;
				_userRankSurvival		.visible = false;
				_userRankDuo			.visible = false;
			}
		}
		
		private function clickTabRankAdventure(e:Event):void
		{
			if (!_scrollRank || !_scrollRankAdventure || !_scrollRankSurvival || !_scrollRankDuo || _scrollRankAdventure.visible) return;
			
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			
			_title_label.text = 'Adventure ranking';
			
			_scrollRank				.visible = false;
			_scrollRankAdventure	.visible = true;
			_scrollRankSurvival	.visible = false;
			_scrollRankDuo			.visible = false;
			
			if (GameState.user.isLog)
			{
				_userRank					.visible = false;
				_userRankAdventure	.visible = true;
				_userRankSurvival		.visible = false;
				_userRankDuo			.visible = false;
			}
		}
		
		private function clickTabRankSurvival(e:Event):void
		{
			if (!_scrollRank || !_scrollRankAdventure || !_scrollRankSurvival || !_scrollRankDuo || _scrollRankSurvival.visible) return;
			
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			
			_title_label.text = 'Survival ranking';
			
			_scrollRank				.visible = false;
			_scrollRankAdventure	.visible = false;
			_scrollRankSurvival	.visible = true;
			_scrollRankDuo			.visible = false;
			
			if (GameState.user.isLog)
			{
				_userRank					.visible = false;
				_userRankAdventure	.visible = false;
				_userRankSurvival		.visible = true;
				_userRankDuo			.visible = false;
			}
		}
		
		private function clickTabRankDuo(e:Event):void
		{
			if (!_scrollRank || !_scrollRankAdventure || !_scrollRankSurvival || !_scrollRankDuo || _scrollRankDuo.visible) return;
			
			SoundManager.getInstance().play(SoundManager.MENU_BUTTON);
			
			_title_label.text = 'Duo ranking';
			
			_scrollRank				.visible = false;
			_scrollRankAdventure	.visible = false;
			_scrollRankSurvival	.visible = false;
			_scrollRankDuo			.visible = true;
			
			if (GameState.user.isLog)
			{
				_userRank					.visible = false;
				_userRankAdventure	.visible = false;
				_userRankSurvival		.visible = false;
				_userRankDuo			.visible = true;
			}
		}
		
		/**
		 * Interface
		 */
		
		private function generateLine(user:XML, i:uint):Sprite
		{
			var line_height:uint = GameState.stageHeight * .06;
			
			// Rank line
			var lineSprite:Sprite = new Sprite();
			lineSprite.y = line_height * i;
			
			lineSprite.graphics.drawRect(0, 0, GameState.stageWidth * .9, line_height);
			lineSprite.graphics.endFill();
			
			// Separator
			var separatorSprite:Sprite = new Sprite();
			separatorSprite.y = lineSprite.height - 1;
			separatorSprite.graphics.beginFill(0xFFFFFF);
			separatorSprite.graphics.drawRect(0, 0, GameState.stageWidth * .9, 1);
			separatorSprite.graphics.endFill();
			lineSprite.addChild(separatorSprite);
			
			// Medal
			if (i < 3)
			{
				var medalSprite:MedalFlash = new MedalFlash();
				medalSprite.x = GameState.stageWidth * .025;
				medalSprite.y = 3;
				medalSprite.scaleX	=
				medalSprite.scaleY		= .5;
				
				medalSprite.gotoAndStop(i+1);
				
				lineSprite.addChild(medalSprite);
			}
			
			// Rank number
			var rankLabel:TextField = new TextField();
			rankLabel.x = GameState.stageWidth * .1;
			rankLabel.y = 3;
			rankLabel.defaultTextFormat = user.username == GameState.user.username? _scroll_format_bold: _scroll_format;
			rankLabel.text = user.rank;
			rankLabel.selectable = false;
			lineSprite.addChild(rankLabel);
			
			// Username
			var usernameLabel:TextField = new TextField();
			usernameLabel.x = GameState.stageWidth * .3;
			usernameLabel.y = rankLabel.y;
			usernameLabel.width = GameState.stageWidth * .3;
			usernameLabel.defaultTextFormat = user.username == GameState.user.username? _scroll_format_bold: _scroll_format;
			usernameLabel.text = user.username;
			usernameLabel.selectable = false;
			lineSprite.addChild(usernameLabel);
			
			// Points
			var pointsLabel:TextField = new TextField();
			pointsLabel.x = GameState.stageWidth * .7;
			pointsLabel.y = rankLabel.y;
			pointsLabel.defaultTextFormat = user.username == GameState.user.username? _scroll_format_bold_pts: _scroll_format_pts;
			pointsLabel.text = user.score + ' pts';
			pointsLabel.selectable = false;
			lineSprite.addChild(pointsLabel);
			
			return lineSprite;
		}
		
		private function generateLineUser(game:XMLList):RankUserBgFlash
		{
			var user_rank:RankUserBgFlash = new RankUserBgFlash();
			user_rank.x = GameState.stageWidth * .05;
			user_rank.y = GameState.stageHeight * .9;
			user_rank.visible = false;
			
			// Rank number
			var rankLabel:TextField = new TextField();
			rankLabel.x = GameState.stageWidth * .1;
			rankLabel.y = 2;
			rankLabel.defaultTextFormat = _scroll_format_user;
			rankLabel.text = game.rank;
			user_rank.addChild(rankLabel);
			
			// Username
			var usernameLabel:TextField = new TextField();
			usernameLabel.x = GameState.stageWidth * .3;
			usernameLabel.y = rankLabel.y;
			usernameLabel.width = GameState.stageWidth * .3;
			usernameLabel.defaultTextFormat = _scroll_format_user;
			usernameLabel.text = GameState.user.username;
			user_rank.addChild(usernameLabel);
			
			// Points
			var pointsLabel:TextField = new TextField();
			pointsLabel.x = GameState.stageWidth * .7;
			pointsLabel.y = rankLabel.y;
			pointsLabel.defaultTextFormat = _scroll_format_user_pts;
			pointsLabel.text = game.score + ' pts';
			user_rank.addChild(pointsLabel);
			
			return user_rank;
		}
		
		private function updateLoader(e:Event):void
		{
			_loader.rotation += 10;
		}
	}
}