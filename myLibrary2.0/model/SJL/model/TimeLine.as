package SJL.model 
{
	import SJL.events.TimeLineEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	
	[Event(name = "time_line_change", type = "com.events.TimeLineEvent")]
	[Event(name = "sound_change", type = "com.events.TimeLineEvent")]
	
	/**
	 * ...
	 * @author CatmimiGod
	 */
	public class TimeLine extends Sprite
	{
		/**进度条小点*/
		public var pointButton:MovieClip = new MovieClip;
		/**颜色进度条*/
		public var colorLine:MovieClip = new MovieClip;
		/**背景进度条*/
		public var backGroundLine:MovieClip = new MovieClip;
		/**是否在拖动小点*/
		protected var _isDrag:Boolean = false;
		/**当前时间*/
		protected var _currentTime:Number = 0;
		/**总时间*/
		protected var _totalTime:Number = 0;
		/**播放头时间*/
		protected var _seekTime:Number = 0;
		
		public function TimeLine():void
		{
			//if (stage)
				//init()
			//else
				//this.addEventListener(Event.ADDED_TO_STAGE , init);
				
			init();
		}
		
		/**
		 * 初始化
		 * @param	e
		 */
		private function init(e:Event = null):void
		{
			//this.removeEventListener(Event.ADDED_TO_STAGE , init);
			
			initTimeLineUI();
			initSoundUI();
			initButtonUI();
		}
		
		/**************************************************************************************************/
		
		/**进度条小点*/
		public var playStopButton:MovieClip = new MovieClip;
		
		/**
		 * 初始化按钮UI
		 */
		private function initButtonUI():void
		{
			if (this.hasOwnProperty("mc_playstop"))
			{
				playStopButton = this["mc_playstop"];
			}
			
			playStopButton.addEventListener(MouseEvent.CLICK , onClickPlayStopButtonHandler);
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function onClickPlayStopButtonHandler(e:MouseEvent):void
		{
			if (Object(this.parent).hasOwnProperty("playStop"))
			{
				Object(this.parent).playStop();
			}
		}
		
		/**
		 * 设置播放按钮状态
		 */
		public function set playStop(boo:Boolean):void
		{
			if (boo)
			{
				playStopButton.gotoAndStop(1);
			}
			else
			{
				playStopButton.gotoAndStop(2);
			}
		}
		
		/**************************************************************************************************/
		
		/**
		 * 初始化进度条UI
		 */
		public function initTimeLineUI():void
		{
			if (this.hasOwnProperty("mc_point"))
			{
				pointButton = this["mc_point"];
			}
			if (this.hasOwnProperty("mc_colorLine"))
			{
				colorLine = this["mc_colorLine"];
			}
			if (this.hasOwnProperty("mc_backGroundLine"))
			{
				backGroundLine = this["mc_backGroundLine"];
			}
			
			colorLine.mouseEnabled = false;
			pointButton.addEventListener(MouseEvent.MOUSE_DOWN, onDownPointHandler);
			backGroundLine.addEventListener(MouseEvent.CLICK , onClickBackGroundLineHandler);
		}
		
		/**
		 * 点击小点触发
		 * @param	e
		 */
		protected function onDownPointHandler(e:MouseEvent):void
		{
			_isDrag = true;
			pointButton.startDrag(false, new Rectangle(backGroundLine.x, backGroundLine.y, backGroundLine.width, 0));
			pointButton.stage.addEventListener(MouseEvent.MOUSE_UP, onUpPointHandler);
			pointButton.stage.addEventListener(MouseEvent.MOUSE_MOVE , onMovePointHandler);
		}
		
		/**
		 * 鼠标移动
		 * @param	e
		 */
		private function onMovePointHandler(e:MouseEvent = null):void
		{
			colorLine.scaleX = (pointButton.x - backGroundLine.x) / backGroundLine.width;
		}
		
		/**
		 * 松开小点
		 * @param	e
		 */
		protected function onUpPointHandler(e:MouseEvent):void
		{
			_isDrag = false;
			pointButton.stage.removeEventListener(MouseEvent.MOUSE_UP, onUpPointHandler);
			pointButton.stage.removeEventListener(MouseEvent.MOUSE_MOVE , onMovePointHandler);
			pointButton.stopDrag();
			_seekTime = (pointButton.x - backGroundLine.x) / backGroundLine.width * _totalTime;
			this.dispatchEvent(new TimeLineEvent(TimeLineEvent.TIME_LINE_CHANGE));
		}
		
		/**
		 * 点击背景进度条发生
		 * @param	e
		 */
		protected function onClickBackGroundLineHandler(e:MouseEvent):void
		{
			_seekTime = (e.target.mouseX) / backGroundLine.width * _totalTime;
			this.dispatchEvent(new TimeLineEvent(TimeLineEvent.TIME_LINE_CHANGE));
		}
		
		/**
		 * 更新数据,外部调用使用
		 * @param	currentTime
		 * @param	totalTime
		 */
		public function upData(currentTime:Number, totalTime:Number):void
		{
			_currentTime = currentTime;
			_totalTime = totalTime;
			if (!_isDrag)
			{
				pointButton.x = _currentTime / _totalTime * backGroundLine.width + backGroundLine.x;
			}
			colorLine.width = pointButton.x - backGroundLine.x;
		}
		
		/**
		 * 当前时间
		 */
		public function get currentTime():Number
		{
			return _currentTime;
		}
		
		/**
		 * 总时间
		 */
		public function get totalTime():Number
		{
			return _totalTime;
		}
		
		/**
		 * 跳跃时间
		 */
		public function get seekTime():Number
		{
			return _seekTime;
		}
		
		
		/****************************************声音*********************************************/
		
		/**声音开关*/
		public var soundSwitch:MovieClip = new MovieClip;
		/**进度条小点*/
		public var soundPointButton:MovieClip = new MovieClip;
		/**颜色进度条*/
		public var soundColorLine:MovieClip = new MovieClip;
		/**背景进度条*/
		public var soundBackGroundLine:MovieClip = new MovieClip;
		/**是否在拖动小点*/
		protected var _isSoundDrag:Boolean = false;
		
		/**
		 * 初始化声音
		 */
		private function initSoundUI():void
		{
			if (this.hasOwnProperty("mc_sound"))
			{
				soundSwitch = this["mc_sound"];
			}
			if (this.hasOwnProperty("mc_sound_point"))
			{
				soundPointButton = this["mc_sound_point"];
			}
			if (this.hasOwnProperty("mc_sound_colorLine"))
			{
				soundColorLine = this["mc_sound_colorLine"];
			}
			if (this.hasOwnProperty("mc_sound_backGroundLine"))
			{
				soundBackGroundLine = this["mc_sound_backGroundLine"];
			}
			
			soundColorLine.mouseEnabled = false;
			onMoveSoundPointHandler();
			soundSwitch.addEventListener(MouseEvent.CLICK , onClickSwitchHandler);
			soundPointButton.addEventListener(MouseEvent.MOUSE_DOWN, onDownSoundPointHandler);
			soundBackGroundLine.addEventListener(MouseEvent.CLICK , onClickSoundBackGroundLineHandler);
		}
		
		/**
		 * 点击声音小点触发
		 * @param	e
		 */
		protected function onDownSoundPointHandler(e:MouseEvent):void
		{
			_isSoundDrag = true;
			soundPointButton.startDrag(false, new Rectangle(soundBackGroundLine.x, soundBackGroundLine.y, soundBackGroundLine.width, 0));
			soundPointButton.stage.addEventListener(MouseEvent.MOUSE_UP, onUpSoundPointHandler);
			soundPointButton.stage.addEventListener(MouseEvent.MOUSE_MOVE , onMoveSoundPointHandler);
		}
		
		/**
		 * 松开声音小点
		 * @param	e
		 */
		protected function onUpSoundPointHandler(e:MouseEvent):void
		{
			_isSoundDrag = false;
			soundPointButton.stage.removeEventListener(MouseEvent.MOUSE_UP, onUpSoundPointHandler);
			soundPointButton.stopDrag();
			this.dispatchEvent(new TimeLineEvent(TimeLineEvent.SOUND_CHANGE));
		}
		
		/**
		 * 声音鼠标移动
		 * @param	e
		 */
		private function onMoveSoundPointHandler(e:MouseEvent = null):void
		{
			soundColorLine.scaleX = (soundPointButton.x - soundBackGroundLine.x) / soundBackGroundLine.width;
			checkSwitch();
		}
		
		/**
		 * 点击声音背景进度条发生
		 * @param	e
		 */
		protected function onClickSoundBackGroundLineHandler(e:MouseEvent):void
		{
			volume = (e.target.mouseX) / soundBackGroundLine.width;
			this.dispatchEvent(new TimeLineEvent(TimeLineEvent.SOUND_CHANGE));
			checkSwitch();
		}
		
		/**
		 * 鼠标点击声音按钮
		 * @param	e
		 */
		private function onClickSwitchHandler(e:MouseEvent):void
		{
			volume = soundSwitch.currentFrame == 1 ? 0 : 1;
			this.dispatchEvent(new TimeLineEvent(TimeLineEvent.SOUND_CHANGE));
		}
		
		/**
		 * 检查当前按钮
		 */
		private function checkSwitch():void
		{
			if (soundPointButton.x == soundBackGroundLine.x)
			{
				soundSwitch.gotoAndStop(2);
			}
			else
			{
				soundSwitch.gotoAndStop(1);
			}
		}
		
		/**
		 * 获取当前刻度下的声音 0-1
		 */
		public function get volume():Number
		{
			return (soundPointButton.x - soundBackGroundLine.x) / soundBackGroundLine.width;
		}
		
		/**
		 * 设置当前声音  0-1
		 */
		public function set volume(num:Number):void
		{
			soundPointButton.x = num * soundBackGroundLine.width + soundBackGroundLine.x;
			onMoveSoundPointHandler();
		}
	}

}