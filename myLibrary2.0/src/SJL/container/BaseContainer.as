package  SJL.container
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author CatmimiGod
	 */
	public class BaseContainer extends Sprite
	{
		
		public function BaseContainer() 
		{
			if (stage)
			{
				init();
			}
			else
			{
				this.addEventListener(Event.ADDED_TO_STAGE , init);
			}
		}
		
		/**
		 * 添加到舞台
		 * @param	e
		 */
		protected function init(e:Event = null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE , init);
		}
	}

}