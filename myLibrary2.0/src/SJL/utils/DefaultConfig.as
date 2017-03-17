package SJL.utils 
{
	/**
	 * ...
	 * @author ...CatmimiGod
	 */
	public class DefaultConfig 
	{
		
		private static var _xml:XML = null;
		
		public function DefaultConfig() 
		{
			
		}
		
		protected static function getDefault():XML
		{
			var xml:XML = 
			<data>
				<stage x="0" y="0">
					<!--,exactFit ,noBorder , noScale, showAll,-->
					<scaleMode>exactFit</scaleMode>
					<!--,fullScreen,fullScreenInteractive,normal,-->
					<displayState>fullScreenInteractive</displayState>
				</stage>
				
				<socket Enable="false">
					<ip>192.168.30.227</ip>
					<port>2000</port>
				</socket>
				<socketserver Enable="false">
					<port>2000</port>
				</socketserver>
				
				<language>cn</language>
				
				<content language="cn" home="0">
					<params id="0" url="assets/cn/主页.swf">
						<params id="0" url="assets/cn/电力2级界面.swf"></params>
					</params>
				</content>
				<content language="en"  home="0">
					<params id="0" url="assets/en/主页.swf">
						<params id="0" url="assets/en/电力2级界面.swf"></params>
					</params>
				</content>
			</data>
			;
			return xml;
		}
		
		/**
		 * 获取数据
		 */
		public static function get data():XML
		{
			if (_xml == null)
			{
				_xml = getDefault();
			}
			return _xml;
		}
		
		/**
		 * 设置数据
		 */
		public static function set data(value:XML):void
		{
			_xml = value;
		}
		
	}

}