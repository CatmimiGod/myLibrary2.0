package SJL.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...CatmimiGod
	 */
	public class VideoContainerEvent extends Event 
	{
		/**视频播放完成*/
		public static var VIDEO_COMPLETE:String = "Video_Complete";

		public function VideoContainerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		/**
		 * 克隆
		 * @return
		 */
		public override function clone():Event 
		{ 
			return new VideoContainerEvent(type, bubbles, cancelable);
		} 
		
		/**
		 * 转化为字符串
		 * @return
		 */
		public override function toString():String 
		{ 
			return formatToString("VideoContainerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}