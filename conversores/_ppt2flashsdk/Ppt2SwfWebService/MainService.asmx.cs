
using System;
using System.ComponentModel;
using System.ServiceProcess;
using System.Web.Services;

namespace Ppt2SwfWebService
{

	[WebService]
	[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
	[ToolboxItem(false)]
	public class MainService : WebService
	{

		private const string ServiceName = "Ppt 2 Swf Converter Service";

		private static bool _IsWindowsServiceRunning()
		{
			try
			{
				var controller = new ServiceController(ServiceName);
				return controller.Status == ServiceControllerStatus.Running;
			}
			catch
			{
				return false;
			}
		}

		[WebMethod]
		public string SendToQueue(string filename, byte[] data, string notifyUrl, string notifyEmail)
		{
			return SendToQueueWithLicenseData(filename, data, notifyUrl, notifyEmail, null, null);
		}

		[WebMethod]
		public string SendToQueueWithLicenseData(string filename, byte[] data, string notifyUrl, string notifyEmail,
			string licenseUsername, string licenseKey)
		{
			try
			{
				if ( !_IsWindowsServiceRunning() )
				{
					return null;
				}
				return new CodeBehind().SendToQueue(filename, data, notifyUrl, notifyEmail, licenseUsername, licenseKey);
			}
			catch ( Exception ex )
			{
				Log.Write(ex);
#if DEBUG
				throw;
#else
				throw new Exception("Could not upload " + filename);
#endif
			}
		}

    [WebMethod]
    public string SendToQueueWithLicenseDataNew(string filename, string key, byte[] data, string notifyUrl, string notifyEmail,
      string licenseUsername, string licenseKey)
    {
      try
      {
        if (!_IsWindowsServiceRunning())
        {
          return null;
        }
        return new CodeBehind().SendToQueueNew(filename, key, data, notifyUrl, notifyEmail, licenseUsername, licenseKey);
      }
      catch (Exception ex)
      {
        Log.Write(ex);
#if DEBUG
				throw;
#else
        throw new Exception("Could not upload " + filename);
#endif
      }
    }

		[WebMethod]
		public byte[][] DownloadConvertedSwf(string key)
		{
			try
			{
				if ( !_IsWindowsServiceRunning() )
				{
					return null;
				}
				return new CodeBehind().DownloadConvertedSwf(key);
			}
			catch ( Exception ex )
			{
				Log.Write(ex);
#if DEBUG
				throw;
#else
				throw new Exception("Internal error occurred while processing key " + key);
#endif
			}
		}

		[WebMethod]
		public bool IsConverted(string key)
		{
			try
			{
				return new CodeBehind().IsConverted(key);
			}
			catch ( Exception ex )
			{
				Log.Write(ex);
#if DEBUG
				throw;
#else
				throw new Exception("Internal error occurred while processing key " + key);
#endif
			}
		}

    [WebMethod]
    public string RequestUniqueKey(string filename)
    {
      return Guid.NewGuid().ToString();
    }

    [WebMethod]
    public int GetFileStatus(string key)
    {
      return new CodeBehind().GetFileStatus(key);
    }
	}

}
