package core.scene 
{
	/**
	 * Scene interface
	 * @author desweb
	 */
	public interface iScene 
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