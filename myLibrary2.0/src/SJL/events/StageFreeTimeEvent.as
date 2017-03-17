package SJL.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author CatmimiGod
	 */
	public class StageFreeTimeEvent extends Event 
	{
		
		public static const TIMER_COMPLETE:String = "time_complete";
		
		public function StageFreeTimeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new StageFreeTimeEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("StageFreeTime", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}