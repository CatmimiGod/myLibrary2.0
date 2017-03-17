package SJL.display 
{
	import fl.video.VideoPlayer;
	import fl.video.VideoEvent;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author CatmimiGod
	 */
	public class ScreenVideo extends MovieClip
	{
		/**视频*/
		protected var _video:VideoPlayer;
		/**计时器*/
		protected var _timer:Timer;
		/**路径*/
		protected var _url:String = "";
		
		public function ScreenVideo(width:Number = 1920,height:Number = 1080,time:Number = 120,url:String = null) 
		{
			_url = url;
			_video = new VideoPlayer(width, height);
			this.addChild(_video);
			_video.addEventListener(VideoEvent.COMPLETE , onCompleteVideoPlayHandler);
			_timer = new Timer(1000,time);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE , onTimerCompleteHalder);
		}
		
		
		/**
		 * 激活屏保视频
		 * @param	play    是否立即播放视频
		 */
		public function activeScreenVideo(play:Boolean = true):void
		{
			
		}
		
		/**
		 * 隐藏屏保视频
		 */
		public function hideScreenVideo():void
		{
			
		}
		
		/**
		 * 完成视频播放
		 * @param	e
		 */
		private function onCompleteVideoPlayHandler(e:VideoEvent):void
		{
			
		}
		
		/**
		 * 计时器到时间
		 * @param	e
		 */
		private function onTimerCompleteHalder(e:TimerEvent):void
		{
			
		}
		
	}

}