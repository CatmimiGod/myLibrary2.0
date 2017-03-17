package SJL.scene 
{
	import SJL.events.TimeLineEvent;
	import SJL.model.TimeLine;
	import fl.video.VideoPlayer;
	import fl.video.VideoEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.greensock.TweenLite;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	import flash.utils.clearTimeout;
	
	/**
	 * ...
	 * @author CatmimiGod
	 */
	public class SceneVideo extends MovieClip
	{
		/**video对象*/
		private var _video:VideoPlayer;
		/**导航条对象*/
		private var _timeLine:TimeLine;
		/**是否正在播放中*/
		private var _isPlaying:Boolean = false;
		/**id*/
		private var _id:uint;
		/**路径*/
		private var _url:String = null;
		/**遮罩层*/
		private var _mask:Sprite;
		/**宽*/
		private var _width:Number = 1920;
		/**高*/
		private var _height:Number = 1080;
		
		public function SceneVideo(url:String = null, width:Number = 1920, height:Number = 1080)
		{
			_url = url;
			_width = width;
			_height = height;
			if (stage)
				init();
			else
				this.addEventListener(Event.ADDED_TO_STAGE , init);
		}
		
		private function init(e:Event = null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE , init);
			_video = new VideoPlayer(_width, _height);
			_video.addEventListener(VideoEvent.COMPLETE , onCompletePlayVideo);
			
			_timeLine = new TimeLine();
			_timeLine.y = _video.height;
			_timeLine.volume = _video.volume;
			_timeLine.addEventListener(TimeLineEvent.SOUND_CHANGE , onSoundChange);
			_timeLine.addEventListener(TimeLineEvent.TIME_LINE_CHANGE , onTimeLineChange);
			var timelineScale:Number = _width / _timeLine.width;
			_timeLine.scaleX = _timeLine.scaleY = timelineScale;
			
			_mask = new Sprite();
			_mask.graphics.beginFill(0);
			_mask.graphics.drawRect(0, 0, _width, _height);
			_mask.graphics.endFill();
			_timeLine.mask = _mask;
			
			this.addChild(_video);
			this.addChild(_timeLine);
			this.addChild(_mask);
			this.addEventListener(Event.ENTER_FRAME , onFrameHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE , onRemoveFromStageHandler);
			this.addEventListener(MouseEvent.CLICK , onClickHandler);
			if (_url != null)
				playVideo(_url);
		}
		
		/**
		 * 播放
		 * @param	url
		 */
		public function playVideo(url:String):void
		{
			if (_video.source == url)
			{
				replay();
			}
			else
			{
				_isPlaying = true;
				_video.play(url);
			}
			_timeLine.y = this.stage.stageHeight;
			//_timeLine.upData(0, 1);
		}
		
		/**
		 * 播放暂停
		 * @return
		 */
		public function playStop():Boolean
		{
			if (_isPlaying)
			{
				_video.pause();
			}
			else
			{
				_video.play();
			}
			_isPlaying = !_isPlaying;
			_timeLine.playStop = _isPlaying;
			return _isPlaying;
		}
		
		/**
		 * 重播
		 */
		public function replay():void
		{
			_isPlaying = true;
			_video.seek(0);
			_video.play();
		}
		
		/**
		 * 完成播放视频
		 * @param	e
		 */
		private function  onCompletePlayVideo(e:VideoEvent):void
		{
			replay();
		}
		
		/**
		 * 帧侦听
		 * @param	e
		 */
		private function onFrameHandler(e:Event):void
		{
			if (_isPlaying)
			{
				_timeLine.upData(_video.playheadTime, _video.totalTime);
			}
		}
		
		/**
		 * 声音改变
		 * @param	e
		 */
		private function onSoundChange(e:TimeLineEvent):void
		{
			_video.volume = _timeLine.volume;
		}
		
		/**
		 * 进度条改变
		 * @param	e
		 */
		private function onTimeLineChange(e:TimeLineEvent):void
		{
			_video.seek(_timeLine.seekTime);
		}
		
		/**
		 * 显示进度条
		 */
		public function showTimeLine():void
		{
			TweenLite.to(_timeLine, 0.8, { y: _video.height - _timeLine.height} );
		}
		
		/**
		 * 隐藏进度条
		 */
		public function hideTimeLine():void
		{
			TweenLite.to(_timeLine, 0.8, { y: _video.height} );
		}
		
		/**
		 * 鼠标交互
		 * @param	e
		 */
		private function onClickHandler(e:MouseEvent):void
		{
			if (this.mouseY > _video.height - 2 * _timeLine.height)
			{
				clearTimeout(_id);
				showTimeLine();
				_id = setTimeout(hideTimeLine,5000);
			}
			else
			{
				playStop();
			}
		}
		
		/**
		 * 从舞台回收
		 * @param	e
		 */
		private function onRemoveFromStageHandler(e:Event):void
		{
			_timeLine.y = _video.height;
			_video.stop();
			_video.clear();
			_isPlaying = false;
			clearTimeout(_id);
			_timeLine.upData(0, 1);
		}
		
		/**
		 * 修改宽度
		 */
		override public function get width():Number 
		{
			return _width;
		}
		
		override public function set width(value:Number):void 
		{
			_video.width = value;
			_timeLine.width = value;
			_mask.width = value;
		}
		
		/**
		 * 修改高度
		 */
		override public function get height():Number 
		{
			return _height;
		}
		
		override public function set height(value:Number):void 
		{
			_video.height = value;
			//_timeLine.height = value;
			_mask.height = value;
			_timeLine.scaleX = _timeLine.scaleY = 1;
			var timelineScale:Number = _width / _timeLine.width;
			_timeLine.scaleX = _timeLine.scaleY = timelineScale;
		}
		
	}

}