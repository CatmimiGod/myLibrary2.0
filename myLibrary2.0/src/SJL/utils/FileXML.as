package SJL.utils 
{
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	/**
	 * ...
	 * @author CatmimiGod
	 */
	public class FileXML 
	{
		/**静态路径*/
		private static var _fileStatic:File = File.applicationDirectory;
		/**静态配置文件*/
		private static var _configStatic:XML;
		
		/**动态路径*/
		private var _file:File = File.applicationDirectory;
		/**动态配置*/
		private var _config:XML;
		
		
		public function FileXML() 
		{
			
		}
		
		/***************************************************动态方法***************************************************/
		
		/**
		 * 读取XML
		 * @param	url
		 * @return
		 */
		public function readXML(file:File):Boolean
		{
			_file = file;
			
			if (!_file.exists)
				return false;
				
			var fileSteam:FileStream = new FileStream();
			fileSteam.open(_file, FileMode.READ);
			try
			{
				_config = XML(fileSteam.readUTFBytes(fileSteam.bytesAvailable));
			}
			catch (e:Error)
			{
				fileSteam.close();
				return false;
			}
			fileSteam.close();
			return true;
		}
		
		/**
		 * 写入XML覆盖当前路径
		 */
		public function writeXML(file:File = null,config:XML = null):void
		{
			var fileSteam:FileStream = new FileStream();
			if (file == null)
			{
				fileSteam.open(new File(_file.nativePath), FileMode.WRITE);
			}
			else
			{
				fileSteam.open(new File(file.nativePath), FileMode.WRITE);
			}
			
			if (config == null)
			{
				fileSteam.writeUTFBytes(_config.toString());
			}
			else
			{
				fileSteam.writeUTFBytes(config.toString());
			}
			fileSteam.close();
		}
		
		/**
		 * 获取XML
		 */
		public function get config():XML
		{
			return _config;
		}
		
		public function set config(value:XML):void
		{
			_config = value;
		}
		
		/***************************************************静态方法***************************************************/
		
		/**
		 * 读取XML
		 * @param	url
		 * @return
		 */
		public static function readXML(fileStatic:File):Boolean
		{
			_fileStatic = fileStatic;
			
			if (!_fileStatic.exists)
				return false;
				
			var fileSteam:FileStream = new FileStream();
			fileSteam.open(_fileStatic, FileMode.READ);
			try
			{
				_configStatic = XML(fileSteam.readUTFBytes(fileSteam.bytesAvailable));
			}
			catch (e:Error)
			{
				fileSteam.close();
				return false;
			}
			fileSteam.close();
			return true;
		}
		
		/**
		 * 写入XML覆盖当前路径
		 */
		public static function writeXML(fileStatic:File = null,configStatic:XML = null):void
		{
			var fileSteam:FileStream = new FileStream();
			if (fileStatic == null)
			{
				fileSteam.open(_fileStatic, FileMode.WRITE);
			}
			else
			{
				fileSteam.open(fileStatic, FileMode.WRITE);
			}
			if (configStatic == null)
			{
				fileSteam.writeUTFBytes(_configStatic.toString());
			}
			else
			{
				fileSteam.writeUTFBytes(configStatic.toString());
			}
			fileSteam.close();
		}
		
		/**
		 * 获取XML
		 */
		public static function get config():XML
		{
			return _configStatic;
		}
		
		/**
		 * 获取XML
		 */
		public static function set config(value:XML):void
		{
			_configStatic = value;
		}
	}

}