package SJL.container 
{
	import fl.video.VideoPlayer;
	import fl.video.VideoEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import SJL.events.VideoContainerEvent;
	import flash.geom.Rectangle;
	
	[Event(name = "Video_Complete" , type = "SJL.events.VideoContainerEvent")]
	
	/**
	 * ...
	 * @author ...CatmimiGod
	 */
	public class VideoContainer extends BaseContainer
	{
		/**视频播放容器*/
		protected var _video:VideoPlayer;
		/**播放状态*/
		protected var _playing:Boolean = false;
		/**图片*/
		protected var _bitmap:Bitmap;
		
		public function VideoContainer() 
		{
			initVideoPlay();
		}
		
		/**
		 * 初始化视频对象
		 * @param	width
		 * @param	height
		 */
		public function initVideoPlay(width:Number = 1920, height:Number = 1080):void
		{
			_bitmap = new Bitmap(new BitmapData(width, height, true, 0), "auto", true);
			this.addChild(_bitmap);
			
			_video = new VideoPlayer(width, height);
			_video.smoothing = true;
			_video.addEventListener(VideoEvent.COMPLETE , onCompletePlayVideo);
			this.addChild(_video);
		}
		
		/**
		 * 播放
		 * @param	url
		 */
		public function play(url:String = null):void
		{
			_bitmap.bitmapData.fillRect(new Rectangle(0, 0, _video.width, _video.height),0);
			if (_video.source == url)
			{
				replay();
			}
			else
			{
				_video.play(url);
			}
			_playing = true;
			this.visible = true;
		}
		
		/**
		 * 停止
		 */
		public function stop():void
		{
			if (_video)
			{
				if (_playing)
				{
					_video.stop();
				}
				_video.clear();
				
			}
			_playing = false;
		}
		
		/**
		 * 跳转
		 * @param	time
		 */
		public function seek(time:Number = 0):void
		{
			_video.seek(time);
		}
		
		/**
		 * 重播
		 */
		public function replay():void
		{
			_video.seek(0);
			_video.play();
		}
		
		/**
		 * 视频完成播放
		 * @param	e
		 */
		protected function onCompletePlayVideo(e:VideoEvent):void
		{
			_bitmap.bitmapData.draw(_video);
			_video.play();
			this.dispatchEvent(new VideoContainerEvent(VideoContainerEvent.VIDEO_COMPLETE));
		}
		
	}

}