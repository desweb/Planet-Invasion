package core.scene 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import com.scroll.ScrollManager;
	
	import core.API;
	import core.Common;
	import core.GameState;
	
	/**
	 * General ranking & ranking of adventure, survival & duo mode
	 * @author desweb
	 */
	public class RankScene extends Scene
	{
		private var _loaderRank					:URLLoader;
		private var _loaderRankAdventure	:URLLoader;
		private var _loaderRankSurvival		:URLLoader;
		private var _loaderRankDuo			:URLLoader;
		
		private var _tabRank					:Sprite;
		private var _tabRankAdventure	:Sprite;
		private var _tabRankSurvival		:Sprite;
		private var _tabRankDuo			:Sprite;
		
		private var _contentRank				:Sprite;
		private var _contentRankAdventure	:Sprite;
		private var _contentRankSurvival	:Sprite;
		private var _contentRankDuo			:Sprite;
		
		private var _scrollRank					:ScrollManager;
		private var _scrollRankAdventure	:ScrollManager;
		private var _scrollRankSurvival		:ScrollManager;
		private var _scrollRankDuo				:ScrollManager;
		
		private var _scrollFormat:TextFormat;
		
		public function RankScene() 
		{
			if (Common.IS_DEBUG) trace('create RankScene');
			
			/**
			 * Initialization
			 */
			
			generateBg();
			generateBtnReturn();
			
			// Tab bar
			_tabRank = generateTab('General');
			_tabRank.x = GameState.stageWidth * .1;
			_tabRank.y = GameState.stageHeight * .15;
			
			_tabRankAdventure = generateTab('Adventure');
			_tabRankAdventure.x = _tabRank.x + _tabRank.width;
			_tabRankAdventure.y = _tabRank.y;
			
			_tabRankSurvival = generateTab('Survival');
			_tabRankSurvival.x = _tabRankAdventure.x + _tabRankAdventure.width;
			_tabRankSurvival.y = _tabRank.y;
			
			_tabRankDuo = generateTab('Duo');
			_tabRankDuo.x = _tabRankSurvival.x + _tabRankSurvival.width;
			_tabRankDuo.y = _tabRank.y;
			
			_tabRank				.addEventListener(MouseEvent.CLICK, clickTabRank);
			_tabRankAdventure.addEventListener(MouseEvent.CLICK, clickTabRankAdventure);
			_tabRankSurvival	.addEventListener(MouseEvent.CLICK, clickTabRankSurvival);
			_tabRankDuo			.addEventListener(MouseEvent.CLICK, clickTabRankDuo);
			
			// scroll
			_scrollFormat = Common.getPolicy('Arial', 0x00ffff, 15);
			
			// webservice
			_loaderRank = new URLLoader();
			_loaderRank.addEventListener(Event.COMPLETE, completeResponseRank);
			_loaderRank.load(API.get_rank(1, 50));
			
			_loaderRankAdventure = new URLLoader();
			_loaderRankAdventure.addEventListener(Event.COMPLETE, completeResponseRankAdventure);
			_loaderRankAdventure.load(API.get_rankAdventure(1, 50));
			
			_loaderRankSurvival = new URLLoader();
			_loaderRankSurvival.addEventListener(Event.COMPLETE, completeResponseRankSurvival);
			_loaderRankSurvival.load(API.get_rankSurvival(1, 50));
			
			_loaderRankDuo = new URLLoader();
			_loaderRankDuo.addEventListener(Event.COMPLETE, completeResponseRankDuo);
			_loaderRankDuo.load(API.get_rankDuo(1, 50));
		}
		
		/**
		 * Events
		 */
		
		private function clickTabRank(e:Event):void
		{
			if (!_scrollRank || !_scrollRankAdventure || !_scrollRankSurvival || !_scrollRankDuo || _scrollRank.visible) return;
			
			_scrollRank				.visible = true;
			_scrollRankAdventure	.visible = false;
			_scrollRankSurvival	.visible = false;
			_scrollRankDuo			.visible = false;
		}
		
		private function clickTabRankAdventure(e:Event):void
		{
			if (!_scrollRank || !_scrollRankAdventure || !_scrollRankSurvival || !_scrollRankDuo || _scrollRankAdventure.visible) return;
			
			_scrollRank				.visible = false;
			_scrollRankAdventure	.visible = true;
			_scrollRankSurvival	.visible = false;
			_scrollRankDuo			.visible = false;
		}
		
		private function clickTabRankSurvival(e:Event):void
		{
			if (!_scrollRank || !_scrollRankAdventure || !_scrollRankSurvival || !_scrollRankDuo || _scrollRankSurvival.visible) return;
			
			_scrollRank				.visible = false;
			_scrollRankAdventure	.visible = false;
			_scrollRankSurvival	.visible = true;
			_scrollRankDuo			.visible = false;
		}
		
		private function clickTabRankDuo(e:Event):void
		{
			if (!_scrollRank || !_scrollRankAdventure || !_scrollRankSurvival || !_scrollRankDuo || _scrollRankDuo.visible) return;
			
			_scrollRank				.visible = false;
			_scrollRankAdventure	.visible = false;
			_scrollRankSurvival	.visible = false;
			_scrollRankDuo			.visible = true;
		}
		
		/**
		 * Webservice
		 */
		
		private function completeResponseRank(e:Event):void
		{
			_loaderRank.removeEventListener(Event.COMPLETE, completeResponseRank);
			
			var loader:URLLoader = URLLoader(e.target);
			
			var users_rank:XML = new XML(loader.data);
			
			if (Common.IS_DEBUG) trace('completeResponseRank : ' + users_rank);
			
			_contentRank = new Sprite();
			
			var i:int = 0;
			for each (var user:XML in users_rank.users.user)
			{
				_contentRank.addChild(generateLine(user, i));
				
				i++;
			}
			
			_scrollRank = new ScrollManager(_contentRank);
			addChild(_scrollRank);
		}
		
		private function completeResponseRankAdventure(e:Event):void
		{
			_loaderRank.removeEventListener(Event.COMPLETE, completeResponseRankAdventure);
			
			var loader:URLLoader = URLLoader(e.target);
			
			var users_rank:XML = new XML(loader.data);
			
			if (Common.IS_DEBUG) trace('completeResponseRankAdventure : ' + users_rank);
			
			_contentRankAdventure = new Sprite();
			
			var i:int = 0;
			for each (var user:XML in users_rank.users.user)
			{
				_contentRankAdventure.addChild(generateLine(user, i));
				
				i++;
			}
			
			_scrollRankAdventure = new ScrollManager(_contentRankAdventure);
			_scrollRankAdventure.visible = false;
			addChild(_scrollRankAdventure);
		}
		
		private function completeResponseRankSurvival(e:Event):void
		{
			_loaderRank.removeEventListener(Event.COMPLETE, completeResponseRankSurvival);
			
			var loader:URLLoader = URLLoader(e.target);
			
			var users_rank:XML = new XML(loader.data);
			
			if (Common.IS_DEBUG) trace('completeResponseRankSurvival : ' + users_rank);
			
			_contentRankSurvival = new Sprite();
			
			var i:int = 0;
			for each (var user:XML in users_rank.users.user)
			{
				_contentRankSurvival.addChild(generateLine(user, i));
				
				i++;
			}
			
			_scrollRankSurvival = new ScrollManager(_contentRankSurvival);
			_scrollRankSurvival.visible = false;
			addChild(_scrollRankSurvival);
		}
		
		private function completeResponseRankDuo(e:Event):void
		{
			_loaderRank.removeEventListener(Event.COMPLETE, completeResponseRankDuo);
			
			var loader:URLLoader = URLLoader(e.target);
			
			var users_rank:XML = new XML(loader.data);
			
			if (Common.IS_DEBUG) trace('completeResponseRankDuo : ' + users_rank);
			
			_contentRankDuo = new Sprite();
			
			var i:int = 0;
			for each (var user:XML in users_rank.users.user)
			{
				_contentRankDuo.addChild(generateLine(user, i));
				
				i++;
			}
			
			_scrollRankDuo = new ScrollManager(_contentRankDuo);
			_scrollRankDuo.visible = false;
			addChild(_scrollRankDuo);
		}
		
		/**
		 * Interface
		 */
		
		private function generateLine(user:XML, i:int):Sprite
		{
			// Rank line
			var lineSprite:Sprite = new Sprite();
			lineSprite.y		= 25 * i;
			lineSprite.alpha	= 0.75;
			
			lineSprite.graphics.beginFill(0x000000);
			lineSprite.graphics.drawRect(0, 0, GameState.stageWidth * 0.9, GameState.stageHeight * 0.05);
			lineSprite.graphics.endFill();
			
			// Medal
			if (i < 3)
			{
				var medalSprite:Sprite = new Sprite();
				medalSprite.x = GameState.stageWidth * 0.05;
				medalSprite.y = GameState.stageHeight * 0.025;
				
				if		(i == 0) medalSprite.graphics.beginFill(0xFFD700); // Gold
				else if	(i == 1) medalSprite.graphics.beginFill(0xCECECE); // Argent
				else if	(i == 2) medalSprite.graphics.beginFill(0x614E1A); // Bronze
				
				medalSprite.graphics.drawCircle(0, 0, GameState.stageHeight * 0.01);
				medalSprite.graphics.endFill();
				
				lineSprite.addChild(medalSprite);
			}
			
			// Rank number
			var rankLabel:TextField = new TextField();
			rankLabel.x = GameState.stageWidth*0.1;
			rankLabel.defaultTextFormat = _scrollFormat;
			rankLabel.text = user.rank;
			lineSprite.addChild(rankLabel);
			
			// Username
			var usernameLabel:TextField = new TextField();
			usernameLabel.x = GameState.stageWidth*0.3;
			usernameLabel.defaultTextFormat = _scrollFormat;
			usernameLabel.text = user.username;
			lineSprite.addChild(usernameLabel);
			
			// Points
			var pointsLabel:TextField = new TextField();
			pointsLabel.x = GameState.stageWidth*0.7;
			pointsLabel.defaultTextFormat = _scrollFormat;
			pointsLabel.text = user.score + ' pts';
			lineSprite.addChild(pointsLabel);
			
			return lineSprite;
		}
	}
}