
using System.Configuration;

namespace Ppt2SwfWebService
{

	internal class Options
	{

		private const string UPLOAD_DIRECTORY_KEY = "UploadDirectory";
		private const string INCOMING_DIRECTORY_KEY = "IncomingDirectory";
		private const string OUTPUT_DIRECTORY_KEY = "OutputDirectory";
		private const string OUTGOING_DIRECTORY_KEY = "OutgoingDirectory";

		private string _uploadDirectory;
		private string _incomingDirectory;
		private string _outputDirectory;
		private string _outgoingDirectory;		

		public Options()
		{
			_uploadDirectory = ConfigurationManager.AppSettings[UPLOAD_DIRECTORY_KEY];
			_incomingDirectory = ConfigurationManager.AppSettings[INCOMING_DIRECTORY_KEY];
			_outputDirectory = ConfigurationManager.AppSettings[OUTPUT_DIRECTORY_KEY];
			_outgoingDirectory = ConfigurationManager.AppSettings[OUTGOING_DIRECTORY_KEY];
			Validators.ValidateDirectoryPresence(_incomingDirectory);
			Validators.ValidateDirectoryPresence(_incomingDirectory);
			Validators.ValidateDirectoryPresence(_outputDirectory);
			Validators.ValidateDirectoryPresence(_outgoingDirectory);
		}

		public string UploadDirectory
		{
			get
			{
				return _uploadDirectory;
			}
		}

		public string IncomingDirectory
		{
			get
			{
				return _incomingDirectory;
			}
		}

		public string OutgoingDirectory
		{
			get
			{
				return _outgoingDirectory;
			}
		}

		public string OutputDirectory
		{
			get
			{
				return _outputDirectory;
			}
		}

	}

}
