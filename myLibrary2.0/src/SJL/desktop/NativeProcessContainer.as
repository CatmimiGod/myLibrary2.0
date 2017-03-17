package SJL.desktop 
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.filesystem.File;
	/**
	 * ...
	 * @author ...CatmimiGod
	 */
	public class NativeProcessContainer 
	{
		/**进程*/
		private var _process:NativeProcess;
		/**进程流程*/
		private var _processInfo:NativeProcessStartupInfo;
		
		public function NativeProcessContainer() 
		{
			_process = new NativeProcess();
		}
		
		/**
		 * 创建进程
		 * @param	file
		 * @param	vector
		 */
		public function buildProcess(file:File , vector:Vector.<String> = null):void
		{
			if (!file.exists)
			{
				trace("file路径错误")
				return;
			}
			
			_processInfo = new NativeProcessStartupInfo();
			_processInfo.executable = file;
			_processInfo.arguments = vector;
		}
		
		/**
		 * 启动进程
		 */
		public function startProcess():void
		{
			if (_process != null && !_process.running)
			{
				_process.start(_processInfo);
			}
		}
		
		/**
		 * 退出进程
		 */
		public function exitProcess():void
		{
			if (_process != null || _process.running)
			{
				_process.exit();
			}
		}
	}

}