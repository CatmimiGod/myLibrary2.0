package SJL.display 
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.utils.setTimeout;
	
	import flash.standard.IDemoApplication;
	import flash.controller.NetworkClientController;
	import flash.controller.NetworkServerController;
	
	import SJL.container.LoaderContainer;
	import SJL.single.MovieClipBaseSingle;
	import SJL.utils.DefaultConfig;
	import SJL.utils.ConfigXML;
	
	/**
	 * ...2016/8/8 18:06
	 * @author ...CatmimiGod
	 */
	public class MovieClipBase extends MovieClip implements IDemoApplication
	{
		/**加载模块*/
		protected function get loaderContainer():LoaderContainer
		{
			return MovieSingle.loaderContainer;
		}
		
		/**当前索引数组*/
		protected function get currentIndexArr():Array
		{
			return MovieSingle.currentIndexArr;
		}
		protected function set currentIndexArr(index:Array):void
		{
			MovieSingle.currentIndexArr = index;
		}
		
		/**
		 * socket客户端
		 */
		protected function get netClient():NetworkClientController
		{
			return MovieSingle.netClient;
		}
		protected function set netClient(value:NetworkClientController):void
		{
			MovieSingle.netClient = value;
		}
		
		/**
		 * socket服务端
		 */
		protected function get netServer():NetworkServerController
		{
			return MovieSingle.netServer;
		}
		protected function set netServer(value:NetworkServerController):void
		{
			MovieSingle.netServer = value;
		}
		
		/**
		 * 获取影片剪辑单例
		 */
		protected function get MovieSingle():*
		{
			return MovieClipBaseSingle.getInstance();
		}
		
		/**
		 * 获取配置单例
		 */
		protected function get ConfigSingle():*
		{
			return ConfigXML.getInstance();
		}
		
		/**默认XML,用于没有外部config的时候读取内部的，并且写入外部*/
		protected var defaultConfig:XML = DefaultConfig.data;
		/**XML路径*/
		protected var defaultConfigFile:File = File.applicationDirectory.resolvePath("assets/config.xml");
		
		/**
		 *            initConfig
		 * 				  |
		 * 				  |
		 * 				init
		 * 				  |
		 * 			      |
		 * 				home
		 */
		public function MovieClipBase() 
		{
			if (stage)
			{
				initConfig();
			}
			else
			{
				this.addEventListener(Event.ADDED_TO_STAGE , initConfig);
			}
		}
		
		/**
		 * 初始化config
		 * @param	e
		 */
		protected function initConfig(e:Event = null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE , initConfig);
			if (ConfigSingle.readXML(defaultConfigFile))
			{
				init();
			}
			else
			{
				ConfigSingle.writeXML(defaultConfigFile, defaultConfig);
				setTimeout(initConfig, 500);
			}
		}
		
		/**
		 * 初始化
		 * @param	e
		 */
		protected function init():void
		{
			ConfigSingle.setStageDisplay(stage);
			upDataSocket();
			upDataSocketServer();
			MovieSingle.setParams(this);
			this.addChildAt(loaderContainer,0);
			this.addEventListener(MouseEvent.CLICK , onClickHandler);
			defaultPage();
		}
		
		/**
		 * 鼠标点击
		 * @param	e
		 */
		protected function onClickHandler(e:MouseEvent):void
		{
			var btnName:String = e.target.name;
			switch(btnName)
			{
				case "gohome":
					home();
					break;
				case "goback":
					back();
					break;
				case "changeLanguage":
					setLanguage();
					break;
				default:
					if (btnName.indexOf("playIndex_") == 0)
					{
						mouseClickPlayIndex(btnName.replace("playIndex_", ""));
					}
			}
		}
		
		/**
		 * 设置语言
		 * @param	lang
		 */
		public function setLanguage(lang:String = null):void
		{
			if (lang != null)
			{
				lang = lang.toLowerCase();
			}
			
			if (lang == "cn" || lang == "en")
			{
				language = lang;
			}
			else
			{
				language = language == "cn" ? "en" : "cn";
			}
			reflash();
		}
		
		/**
		 * 设置语言
		 */
		public function set language(value:String):void
		{
			ConfigSingle.language = value;
		}
		
		/**
		 * 获取语言
		 */
		public function get language():String
		{
			return ConfigSingle.language;
		}
		
		/**
		 * 更新socket
		 */
		public function upDataSocket():void
		{
			if (netClient && netClient.connected)
			{
				netClient.close();
			}
			var list:XML = ConfigSingle.getSocket();
			if (list == null || list == "")
				return;
			if (list.hasOwnProperty("@Enable") && list.@Enable == "true")
			{
				netClient = new NetworkClientController(this, list.ip, list.port);
			}
		}
		
		/**
		 * 更新socketserver
		 */
		public function upDataSocketServer():void
		{
			if (netServer)
			{
				netServer.dispose();
			}
			
			var list:XML = ConfigSingle.getSocketServer();
			if (list == null || list == "")
				return;
			if (list.hasOwnProperty("@Enable") && list.@Enable == "true")
			{
				netServer = new NetworkServerController(this, list.port);
				netServer.enabledBroadcast = true;
			}
		}
		
		/**
		 * 默认页面
		 */
		public function defaultPage():void
		{
			playIndex(ConfigSingle.getDefaultParamsArr());
		}
		
		/**
		 * 主页
		 */
		public function home():void
		{
			playIndex(ConfigSingle.getHomeParamsArr());
		}
		
		/**
		 * 返回
		 */
		public function back():void
		{
			if (currentIndexArr.length > 1)
			{
				currentIndexArr.pop();
				playIndex(currentIndexArr);
			}
			else
			{
				if (currentIndexArr != ConfigSingle.getHomeParamsArr())
				{
					home();
				}
			}
		}
		
		/**
		 * 刷新
		 */
		public function reflash():void
		{
			playIndex(currentIndexArr);
		}
		
		/**
		 * 鼠标点击事件
		 * @param	name
		 */
		protected function mouseClickPlayIndex(name:String):void
		{
			playIndex(name.split("_"));
		}
		
		/**
		 * 播放索引
		 * @param	index
		 */
		public function playIndex(index:Array , obj:Object = null):void
		{
			currentIndexArr = index;
			if (obj == null || obj == "")
			{
				loaderContainer.load(ConfigSingle.getParamsUrl(index),ConfigSingle.getParamsArgs(index));
			}
			else
			{
				loaderContainer.load(ConfigSingle.getParamsUrl(index),obj);
			}
		}
	}

}