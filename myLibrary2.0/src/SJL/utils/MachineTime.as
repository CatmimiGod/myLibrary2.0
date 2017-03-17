package SJL.utils 
{
	/**
	 * ...
	 * @author ...CatmimiGod
	 */
	public class MachineTime 
	{
		
		private static var _date:Date = new Date();
		
		private static const vCN:Vector.<String> = new < String > ["上午", "下午"];
		private static const vEN:Vector.<String> = new <String>["AM","PM"];
		
		public function MachineTime() 
		{
			
		}
		
		/**
		 * 获取手机格式的时间
		 * @param	time
		 * @param	lang
		 * @return
		 */
		public static function getMobileLocaleTime(timeFormat:int = 24 , lang:String = "en"):String
		{
			var time:String;
			switch(timeFormat)
			{
				case 24:
					time = addZeroToString(hours) + ":" + addZeroToString(minutes);
					break;
				case 12:
					if (hours > 12)
					{
						time = addZeroToString(hours - 12) + ":" + addZeroToString(minutes) + " " + addAmOrPm(lang,"pm");
					}
					else if(hours < 12)
					{
						time = addZeroToString(hours) + ":" + addZeroToString(minutes) + " " + addAmOrPm(lang,"am");
					}
					else
					{
						time = addZeroToString(hours) + ":" + addZeroToString(minutes) + " " + addAmOrPm(lang,"pm");
					}
					break;
			}
			return time;
		}
		
		/*************************************************************************************/
		
		/**
		 * 在数字前面加零
		 * @param	num
		 * @return
		 */
		public static function addZeroToString(num:Number):String
		{
			var time:String;
			if (num < 10)
			{
				time = "0" + num.toString();
			}
			else
			{
				time = num.toString();
			}
			return time;
		}
		
		/**
		 * 添加上午或者下午
		 * @param	lang
		 * @param	am_pm
		 * @return
		 */
		private static function addAmOrPm(lang:String = "en", am_pm:String = "am"):String
		{
			var index:int = am_pm == "am" ? 0 : 1;
			switch(lang)
			{
				case "en":
					return vEN[index];
					break;
				case "cn":
					return vCN[index];
					break;
				default:
					return vEN[index];
			}
		}
		
		/*************************************************************************************/
		
		/**
		 * 获取date对象
		 */
		public static function get date():Date
		{
			return _date;
		}
		
		/**
		 * 当前年
		 */
		public static function get year():Number
		{
			return date.getFullYear();
		}
		
		/**
		 * 当前月
		 */
		public static function get month():Number
		{
			return date.month + 1;
		}
		
		/**
		 * 当前日
		 */
		public static function get day():Number
		{
			return date.date;
		}
		
		/**
		 * 当前星期
		 */
		public static function get week():Number
		{
			return date.day;
		}
		
		/**
		 * 当前小时
		 */
		public static function get hours():Number
		{
			return date.hours;
		}
		
		/**
		 * 当前分钟
		 */
		public static function get minutes():Number
		{
			return date.minutes;
		}
		
		/**
		 * 当前秒钟
		 */
		public static function get seconds():Number
		{
			return date.seconds;
		}
	}

}

class DateMath 
{
    public static function addWeeks(date:Date, weeks:Number):Date {
        return addDays(date, weeks*7);
    }

    public static function addDays(date:Date, days:Number):Date {
        return addHours(date, days*24);
    }

    public static function addHours(date:Date, hrs:Number):Date {
        return addMinutes(date, hrs*60);
    }

    public static function addMinutes(date:Date, mins:Number):Date {
        return addSeconds(date, mins*60);
    }

    public static function addSeconds(date:Date, secs:Number):Date {
        var mSecs:Number = secs * 1000;
        var sum:Number = mSecs + date.getTime();
        return new Date(sum);
    }
}