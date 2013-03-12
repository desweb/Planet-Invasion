package core.popup 
{
	import flash.display.Sprite;
	
	import core.Common;
	
	/**
	 * ...
	 * @author desweb
	 */
	public class LoginPopup extends Popup
	{
		private var _content:Sprite;
		
		public function LoginPopup() 
		{
			if (Common.IS_DEBUG) trace('create LoginPopup');
			
			generatePopup();
		}
		
	}
}