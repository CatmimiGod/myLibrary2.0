package SJL.single
{
	import flash.events.EventDispatcher;
	
	import SJL.container.LoaderContainer;
	
	import flash.controller.NetworkClientController;
	import flash.controller.NetworkServerController;
	
	/**
	 * ...
	 * @author CatmimiGod
	 */
	public class  MovieClipBaseSingle extends EventDispatcher
	{
		
		/**抽象模型*/
		protected var _params:Object = new Object;
		/**单例*/
		private static var instance:MovieClipBaseSingle = new MovieClipBaseSingle();
		/**当前索引数组*/
		public var currentIndexArr:Array;
		/**加载容器*/
		public var loaderContainer:LoaderContainer = new LoaderContainer();
		/**socket客户端*/
		public var netClient:NetworkClientController;
		/**socket服务端*/
		public var netServer:NetworkServerController;
		
		public var backGroundVideo:*;
		
		public function MovieClipBaseSingle():void
		{
			//if (instance)
			//{
				//throw new Error("Single.getInstance()获取实例");
			//}
		}
		
		/**
		 * 获取单例
		 * @return
		 */
		public static function getInstance():MovieClipBaseSingle
		{
			return instance;
		}
		
		/**
		 * 设置模型焦点
		 * @param	params
		 */
		public function setParams(params:Object):void
		{
			_params = params;
		}
		
		/**
		 * 播放索引
		 * @param	...arg
		 */
		public function playIndex(index:Array , obj:Object = null):void
		{
			if (_params.hasOwnProperty("playIndex"))
			{
				_params.playIndex(index , obj);
			}
		}
	}
	
}