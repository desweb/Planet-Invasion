package core.scene 
{
	/**
	 * Achievements list of the user
	 * @author desweb
	 */
	public class AchievementScene extends Scene
	{
		
		public function AchievementScene()
		{
			if (Common.IS_DEBUG) trace('create AchievementScene');
			
			/**
			 * Initialization
			 */
			
			generateBg();
			generateBtnReturn();
		}
	}
}