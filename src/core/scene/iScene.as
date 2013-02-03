package core.scene 
{
	/**
	 * Scene interface
	 * @author desweb
	 */
	public interface IScene 
	{
		/*
		 * Create
		 */
		function onEnter():void;
		
		/*
		 * Destroy
		 */
		function onExit():void;
	}

}