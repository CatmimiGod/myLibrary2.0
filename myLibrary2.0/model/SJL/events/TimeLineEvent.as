package SJL.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author CatmimiGod
	 */
	public class TimeLineEvent extends Event 
	{
		/**进度条时间发生改变*/
		public static const TIME_LINE_CHANGE:String = "time_line_change";
		/**声音发生了改变*/
		public static const SOUND_CHANGE:String = "sound_change";
		
		public function TimeLineEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new TimeLineEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TimeLineEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}