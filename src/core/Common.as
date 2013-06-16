package core 
{
	import flash.text.Font;
	import flash.text.TextFormat;
	
	/**
	 * Manage general const of the application
	 * @author desweb
	 */
	
	public class Common
	{
		/**
		 * Const variables
		 */
		
		// Debug
		public static const IS_DEBUG:Boolean = true;
		
		// Assets
		public static const PATH_ASSETS:String = '../assets/';
		
		// Sound
		public static const SOUND_ON	:uint = 1;
		public static const SOUND_OFF:uint = 2;
		
		// Scene id
		public static const SCENE_ACHIEVEMENT			:uint = 1;
		public static const SCENE_CREDIT					:uint = 2;
		public static const SCENE_DIALOG					:uint = 3;
		public static const SCENE_FINAL						:uint = 4;
		public static const SCENE_GAME_ADVENTURE	:uint = 5;
		public static const SCENE_GAME_SURVIVAL		:uint = 6;
		public static const SCENE_GAME_DUO				:uint = 7;
		public static const SCENE_GAME_MODE			:uint = 8;
		public static const SCENE_IMPROVEMENT			:uint = 9;
		public static const SCENE_MENU						:uint = 10;
		public static const SCENE_RANK						:uint = 11;
		public static const SCENE_RESEARCH_DUO		:uint = 12;
		public static const SCENE_SELECT_LEVEL			:uint = 13;
		
		// Frame
		public static const FRAME_SOUND_ON	:uint = 1;
		public static const FRAME_SOUND_OFF	:uint = 2;
		
		public static const FRAME_BTN_DEFAULT	:uint = 1;
		public static const FRAME_BTN_LOCK		:uint = 2;
		
		public static const FRAME_ENTITY_DEFAULT	:uint = 1;
		public static const FRAME_ENTITY_SMOKE	:uint = 2;
		public static const FRAME_ENTITY_FIRE		:uint = 3;
		public static const FRAME_ENTITY_DEAD		:uint = 4;
		
		public static const FRAME_WEAPON_DEFAULT	:uint = 1;
		public static const FRAME_WEAPON_DEAD		:uint = 2;
		
		// Timer
		public static const TIMER_ANIMATION_DEAD:uint = 2000;
		
		// Game security key
		public static const GAME_ADVENTURE_KEY	:String = '172ae58a586c65c8c4487062c695fe7f';
		public static const GAME_SURVIVAL_KEY		:String = 'c6acb7315b55571d750dc8fb08c9aa3d';
		public static const GAME_DUO_KEY				:String = '4f6ef9504774efbcced5d562fec7ac68';
		
		// Game identifier
		public static const GAME_1				:uint = 1;
		public static const GAME_2				:uint = 2;
		public static const GAME_3				:uint = 3;
		public static const GAME_4				:uint = 4;
		public static const GAME_5				:uint = 5;
		public static const GAME_SURVIVAL	:uint = 6;
		public static const GAME_DUO			:uint = 7;
		
		// Achievement security key
		public static const ACHIEVEMENT_METAL						:String = '74108a89672c573afee1fae6de8e4e0b';
		public static const ACHIEVEMENT_CRYSTAL					:String = '37fdc56efd7bfd2cf16bf2a7dbef8495';
		public static const ACHIEVEMENT_MONEY						:String = '2bc794c2d9a28e52d1dd66d95e37d485';
		public static const ACHIEVEMENT_SERIAL_KILLER			:String = 'a1a81f6d043cf40fe0ea1c1d07fa4d3f';
		public static const ACHIEVEMENT_NATURAL_DEATH		:String = '402bc1524b373aad36935e32e7851067';
		public static const ACHIEVEMENT_ROADHOG				:String = 'ff0d3cc199efd1f1dc0fcd9c5fd06f1d';
		public static const ACHIEVEMENT_CONQUEROR			:String = 'ff9b37e07e1867298deab404ab7493e4';
		public static const ACHIEVEMENT_COOPERATION			:String = 'cf763e62b76f3204560a61308d4abe14';
		public static const ACHIEVEMENT_SURVIVAL				:String = '1089b25a43df6bce533f9729d6640317';
		public static const ACHIEVEMENT_MISTER_BOOSTER	:String = '8ae60dba400079c7f2e90ef2b4c78ed8';
		public static const ACHIEVEMENT_CURIOSITY				:String = 'fe7be631cc8b993abb4d5744a2823df9';
		public static const ACHIEVEMENT_ALIEN_BLAST			:String = '7f68b5e65b4291ee230cddf520510be0';
		
		// Improvement security key
		public static const IMPROVEMENT_ARMOR_RESIST					:String = '3d1e64652d2c138239e5be8963619e7b';
		public static const IMPROVEMENT_SHIELD_RESIST					:String = 'd8050a6d8d84ef7d966b5ba9d27f5adb';
		public static const IMPROVEMENT_SHIELD_REGEN						:String = 'ebbd411e69a14acc459793679efcea2a';
		public static const IMPROVEMENT_SHIELD_REPOP						:String = '5a9989db8c9ea8a23148be4785e263e0';
		public static const IMPROVEMENT_GUN_DAMAGE						:String = '437183a2ee10b05dd04a2373e30f9fbb';
		public static const IMPROVEMENT_GUN_CADENCE						:String = '61f6b113ec3336c9e349d312632a1664';
		public static const IMPROVEMENT_GUN_DOUBLE						:String = 'ab1871bb297a789494d09377fc73bfa0';
		public static const IMPROVEMENT_LASER_DAMAGE					:String = '5e3c66b27ba478f86b6510416cb28038';
		public static const IMPROVEMENT_MISSILE_DAMAGE					:String = '248c4590493a692fdeb9903c04285769';
		public static const IMPROVEMENT_MISSILE_CADENCE				:String = '8490fe33d7fc1e86d937ccbf4a26e18b';
		public static const IMPROVEMENT_MISSILE_DOUBLE					:String = 'cc492f01a9cb594905eea4c138435a75';
		public static const IMPROVEMENT_MISSILE_SEARCH_DAMAGE	:String = '1ed5c5286c45ce10df21e331df89a181';
		public static const IMPROVEMENT_MISSILE_SEARCH_NUMBER	:String = '9daad4e928d69daff5880869bbe236f9';
		public static const IMPROVEMENT_TRI_FORCE							:String = 'a5726bd41d81bb4b7935b1eb53a87b87';
		public static const IMPROVEMENT_IEM										:String = 'b6b339db8ab74472839d7eb2eb73847e';
		public static const IMPROVEMENT_BOMB									:String = '1b7417bf9151374d7b062a64abd29425';
		public static const IMPROVEMENT_REINFORCE							:String = 'd724842bf8d7855b964c4018b0484d7d';
		
		// Item
		public static const ITEM_ATTACK		:uint = 1;
		public static const ITEM_CRYSTAL	:uint = 2;
		public static const ITEM_DEFENSE	:uint = 3;
		public static const ITEM_GOLD			:uint = 4;
		public static const ITEM_METAL		:uint = 5;
		public static const ITEM_SPEED		:uint = 6;
		
		// Owner
		public static const OWNER_HERO	:uint = 1;
		public static const OWNER_ENEMY:uint = 2;
		
		// Fire
		public static const FIRE_TOP_DEFAULT			:uint = 1;
		public static const FIRE_TOP_LEFT				:uint = 2;
		public static const FIRE_TOP_RIGHT				:uint = 3;
		public static const FIRE_MIDDLE_DEFAULT	:uint = 4;
		public static const FIRE_MIDDLE_LEFT			:uint = 5;
		public static const FIRE_MIDDLE_RIGHT		:uint = 6;
		public static const FIRE_BOTTOM_DEFAULT	:uint = 7;
		public static const FIRE_BOTTOM_LEFT			:uint = 8;
		public static const FIRE_BOTTOM_RIGHT		:uint = 9;
		
		public function Common() {}
		
		/**
		 * Fonts
		 */
		
		public static function generatePolicy(policy:String = 'Arial', color:int = 0xffffff, size:int = 24, align:String = 'center'):TextFormat
		{
			var font:Font;
			
			//if (policy == 'Arial')	font = new Arial();
			//else					font = new MyArialPolicy();
			
			font = new MyArialPolicy();
			
			var format:TextFormat = new TextFormat();
			format.color = color;
			format.size = size;
			format.align = align;
			format.font = font.fontName;
			
			return format;
		}
		
		public static function getPolicy(policy:String, color:int, size:int, align:String = 'center'):TextFormat
		{
			return generatePolicy(policy, color, size, align);
		}
		
		public static function getPolicyArialWhite24():TextFormat
		{
			return generatePolicy('Arial', 0xffffff, 24);
		}
	}
}