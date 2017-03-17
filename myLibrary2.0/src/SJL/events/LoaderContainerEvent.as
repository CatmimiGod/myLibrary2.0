package SJL.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author CatmimiGod
	 */
	public class LoaderContainerEvent extends Event 
	{
		
		public static const UP_DATA_FLASH:String = "up_data_flash";
		public static const UP_DATA_IMG:String = "up_data_img";
		
		public function LoaderContainerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new LoaderContainerEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("LoaderContainerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}