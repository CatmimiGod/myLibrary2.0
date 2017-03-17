package SJL.utils 
{
	import SJL.events.StageFreeTimeEvent;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	/**在完成加载外部调用SWF的时候发生*/
	[Event(name = "time_complete" , type = "SJL.events.StageFreeTimeEvent")]
	/**
	 * ...
	 * @author CatmimiGod
	 */
	public class StageFreeTime extends EventDispatcher
	{
		/**计时器*/
		private var _timer:Timer;
		
		public function StageFreeTime(stage:Stage,time:Number = 1) 
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN , onMouseStageDownHandler);
			setTime(time);
		}
		
		/**
		 * 设置时间
		 * @param	time
		 */
		public function setTime(time:Number = 1):void
		{
			if (_timer)
			{
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE , onMouseStageDownHandler);
			}
			_timer = new Timer(1000, time);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE , onTimerCompleteHandler);
		}
		
		/**
		 * 重启计时
		 */
		public function reStart():void
		{
			if (_timer)
			{
				_timer.reset();
				_timer.start();
			}
		}
		
		/**
		 * 停止
		 */
		public function stop():void
		{
			if(_timer)
				_timer.stop();
		}
		
		/**
		 * 计时器到时间
		 * @param	e
		 */
		private function onTimerCompleteHandler(e:TimerEvent):void
		{
			stop();
			this.dispatchEvent(new StageFreeTimeEvent(StageFreeTimeEvent.TIMER_COMPLETE));
		}
		
		/**
		 * 鼠标按下事件
		 * @param	e
		 */
		private function onMouseStageDownHandler(e:MouseEvent):void
		{
			reStart();
		}
	}

}