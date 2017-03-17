package SJL.utils 
{
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author ...CatmimiGod
	 */
	public class ConfigXML extends BaseXML
	{
		
		/**单例对象*/
		private static var instance:ConfigXML = new ConfigXML();
		
		public function ConfigXML()
		{
			
		}
		
		/**
		 * 获取单例对象
		 * @return
		 */
		public static function getInstance():ConfigXML
		{
			return instance;
		}
		
		/**
		 * 语言
		 */
		public function get language():String
		{
			return config.language;
		}
		
		/**
		 * 语言
		 */
		public function set language(value:String):void
		{
			config.language = value.toLowerCase();
		}
		
		/**
		 * 获取socketXML
		 * @return
		 */
		public function getSocket():XML
		{
			return config.socket[0];
		}
		
		/**
		 * 获取socketserverXML
		 * @return
		 */
		public function getSocketServer():XML
		{
			return config.socketserver[0];
		}
		
		/**
		 * 设置舞台属性
		 */
		public function setStageDisplay(stage:Stage):void
		{
			if (config.hasOwnProperty("stage"))
			{
				if (config.stage.hasOwnProperty("@x"))
				{
					stage.nativeWindow.x = Number(config.stage.@x);
				}
				
				if (config.stage.hasOwnProperty("@y"))
				{
					stage.nativeWindow.y = Number(config.stage.@y);
				}
				for each(var node:XML in config.stage.children())
				{
					var prop:String = node.localName();
					stage[prop] = config.stage[prop];
				}
			}
		}
		
		/**
		 * 获取对象路径
		 * @param	index
		 * @return
		 */
		public function getParamsUrl(index:Array, keyName:String = "params"):String
		{
			var url:String = "";
			var tempXML:XML = config.content.(@language == language)[0];
			for (var i:int; i < index.length; i++)
			{
				if (tempXML.hasOwnProperty(keyName))
				{
					tempXML = tempXML[keyName].(@id == index[i])[0];
					if (tempXML != null && tempXML.hasOwnProperty("@url"))
					{
						url = tempXML.@url;
					}
					else
					{
						url = null;
					}
				}
			}
			return url;
		}
		
		/**
		 * 获取对象路径的长度个数
		 * @param	index
		 * @return
		 */
		public function getParamsLenght(index:Array, keyName:String = "params"):int
		{
			var len:int = 0;
			var tempXML:XML = config.content.(@language == language)[0];
			for (var i:int; i < index.length; i++)
			{
				if (tempXML.hasOwnProperty(keyName))
				{
					tempXML = tempXML[keyName].(@id == index[i])[0];
					len = tempXML.parent().params.length();
				}
			}
			return len;
		}
		
		/**
		 * 获取对象参数
		 * @param	index
		 * @return
		 */
		public function getParamsArgs(index:Array, keyName:String = "params"):Object
		{
			var obj:Object = null;
			var tempXML:XML = config.content.(@language == language)[0];
			for (var i:int; i < index.length; i++)
			{
				if (tempXML.hasOwnProperty(keyName))
				{
					tempXML = tempXML[keyName].(@id == index[i])[0];
					if (tempXML == null)
					{
						return null;
					}
					
					if (tempXML.hasOwnProperty("@func"))
					{
						obj = {func:tempXML.@func};
						if(tempXML.hasOwnProperty("@args"))
						{
							obj = {func:tempXML.@func , args:tempXML.@args};
						}
					}
				}
			}
			return obj;
		}
		
		/**
		 * 获取主页索引
		 * @return
		 */
		public function getHomeParamsArr():Array
		{
			var tempXML:XML = config.content.(@language == language)[0];
			var arr:Array = tempXML.@home.split(",");
			return arr;
		}
		
		/**
		 * 获取默认页数索引
		 * @return
		 */
		public function getDefaultParamsArr():Array
		{
			var tempXML:XML = config.content.(@language == language)[0];
			var arr:Array = tempXML["@default"].split(",");
			return arr;
		}
	}

}