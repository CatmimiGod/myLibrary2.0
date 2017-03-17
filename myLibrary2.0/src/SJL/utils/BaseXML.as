package SJL.utils 
{
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	
	/**
	 * ...
	 * @author ... CatmimiGod
	 */
	public class BaseXML extends EventDispatcher
	{
		/**file读取类*/
		protected var fileXML:FileXML = new FileXML();
		/**单例对象*/
		private static var instance:BaseXML = new BaseXML();
		
		public function BaseXML() 
		{
			//if (instance)
			//{
				//throw new Error("Single.getInstance()获取实例");
			//}
		}
		
		/**
		 * 获取单例对象
		 * @return
		 */
		public static function getInstance():BaseXML
		{
			return instance;
		}
		
		/**
		 * 读取xml
		 * @param	url
		 * @return
		 */
		public function readXML(file:File):Boolean
		{
			return fileXML.readXML(file);
		}
		
		/**
		 * 写入XML覆盖当前路径
		 */
		public function writeXML(file:File = null,config:XML = null):void
		{
			fileXML.writeXML(file, config);
		}
		
		/**
		 * 获取XML
		 */
		public function get config():XML
		{
			return fileXML.config;
		}
		
		/**
		 * 设置
		 */
		public function set config(value:XML):void
		{
			fileXML.config = value;
		}
	}

}