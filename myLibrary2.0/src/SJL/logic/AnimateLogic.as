package SJL.logic 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author ...CatmimiGod
	 */
	public class AnimateLogic extends EventDispatcher
	{
		
		private var _view:DisplayObjectContainer;
		
		public function AnimateLogic(view:DisplayObjectContainer) 
		{
			_view = view;
			_view.addEventListener(MouseEvent.CLICK , onClickHandler);
		}
		
		/**
		 * 鼠标点击事件
		 * @param	e
		 */
		protected function onClickHandler(e:MouseEvent):void
		{  
			var btnName:String = e.target.name;
			var mc:MovieClip = new MovieClip;
			switch(btnName)
			{
				case "go":
					if (e.target.parent is MovieClip)
					{
						mc = e.target.parent as MovieClip;
						mc.play();
					}
					break;
				case "goPrev":
					if (e.target.parent is MovieClip)
					{
						mc = e.target.parent as MovieClip;
						mc.prevFrame();
					}
					break;
				case "goNext":
					if (e.target.parent is MovieClip)
					{
						mc = e.target.parent as MovieClip;
						mc.nextFrame();
					}
					break;
				case "playStop":
					if (e.target.parent is MovieClip)
					{
						mc = e.target.parent as MovieClip;
						mc.isPlaying ? mc.stop() : mc.play();
					}
					break;
				default:
					if (btnName.indexOf("goPage_") == 0)
					{
						if (e.target.parent is MovieClip)
						{
							mc = e.target.parent as MovieClip;
							mc.gotoAndPlay(btnName.replace("goPage_", ""));
						}
					}
					else if (btnName.indexOf("stopPage_") == 0)
					{
						if (e.target.parent is MovieClip)
						{
							mc = e.target.parent as MovieClip;
							mc.gotoAndStop(btnName.replace("stopPage_", ""));
						}
					}
			}
			
		}
		
	}

}