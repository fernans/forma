
using System;
using System.Diagnostics;

namespace Ppt2SwfWebService
{

	internal static class Log
	{

		private const string LOG_SOURCE_NAME = "Ppt2SwfWebService";

		private static readonly EventLog _log = null;

		static Log()
		{
			_log = new EventLog()
			{
				Source = LOG_SOURCE_NAME
			};
		}

		public static void Write(string message)
		{
			if ( _log != null )
			{
				_log.WriteEntry(message);
			}
		}

		public static void Write(string format, params object[] data)
		{
			Write(String.Format(format, data));
		}

		public static void Write(Exception ex)
		{
			if ( _log != null )
			{
				var method = new StackTrace().GetFrames()[1].GetMethod();
				var caller = String.Format
				(
					"{0}.{1}.{2}()",
					method.ReflectedType.Namespace,
					method.ReflectedType.Name,
					method.Name
				);
				_log.WriteEntry(String.Format("{0}: {1}\r\n{2}", caller, ex.Message, ex.StackTrace),
					EventLogEntryType.Error);
			}
		}

	}

}
