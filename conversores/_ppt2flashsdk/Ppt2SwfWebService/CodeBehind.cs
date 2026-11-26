
using System;
using System.Linq;
using System.IO;
using System.Text.RegularExpressions;

namespace Ppt2SwfWebService
{

	internal class CodeBehind
	{

		private static readonly Regex SwfSlideFilenamesRegex = new Regex(@"^slide[0-9]+\.swf$", RegexOptions.IgnoreCase);

		private Options _options;

		public CodeBehind()
		{
			_options = new Options();
		}

		public string SendToQueue(string filename, byte[] data, string notifyUrl, string notifyEmail,
			string licenseUsername, string licenseKey)
		{
			Validators.ValidateSingleFilename(filename);
			var extension = Path.GetExtension(filename);
			var newFilename = Guid.NewGuid().ToString();
			var pptNewFilename = newFilename + extension;
			var uploadFilename = Path.Combine(_options.UploadDirectory, pptNewFilename);
			var incomingFilename = Path.Combine(_options.IncomingDirectory, pptNewFilename);
			using ( var writer = File.CreateText(Path.Combine(_options.OutgoingDirectory, pptNewFilename) + ".txt") )
			{
				writer.WriteLine(filename);
				writer.WriteLine(notifyUrl ?? String.Empty);
				writer.WriteLine(notifyEmail ?? String.Empty);
				writer.WriteLine(licenseUsername ?? String.Empty);
				writer.WriteLine(licenseKey ?? String.Empty);
			}
			using ( var memoryStream = new MemoryStream(data) )
			{
				using ( var fileStream = new FileStream(uploadFilename, FileMode.Create) )
				{
					memoryStream.WriteTo(fileStream);
				}
			}
			new FileInfo(uploadFilename).MoveTo(incomingFilename);
			Log.Write("{0} successfully uploaded as {1} and sent to the queue in {2}", filename,
				pptNewFilename, _options.IncomingDirectory);
			return pptNewFilename;
		}

    public string SendToQueueNew(string filename, string key, byte[] data, string notifyUrl, string notifyEmail,
      string licenseUsername, string licenseKey)
    {
      Validators.ValidateSingleFilename(filename);
      //var extension = Path.GetExtension(filename);
      var newFilename = key;
      var pptNewFilename = newFilename;// +extension;
      int status = GetFileStatus(pptNewFilename);
      if (status != 0)
      {
        return "File status: " + status.ToString();
      }
      var uploadFilename = Path.Combine(_options.UploadDirectory, pptNewFilename);
      var incomingFilename = Path.Combine(_options.IncomingDirectory, pptNewFilename);
      using (var memoryStream = new MemoryStream(data))
      {
        using (var fileStream = new FileStream(uploadFilename, FileMode.CreateNew))
        {
          memoryStream.WriteTo(fileStream);
        }
      }
      using (var writer = File.CreateText(Path.Combine(_options.OutgoingDirectory, pptNewFilename) + ".txt"))
      {
        writer.WriteLine(filename);
        writer.WriteLine(notifyUrl ?? String.Empty);
        writer.WriteLine(notifyEmail ?? String.Empty);
        writer.WriteLine(licenseUsername ?? String.Empty);
        writer.WriteLine(licenseKey ?? String.Empty);
      }
      new FileInfo(uploadFilename).MoveTo(incomingFilename);
      Log.Write("{0} successfully uploaded as {1} and sent to the queue in {2}", filename,
        pptNewFilename, _options.IncomingDirectory);
      return filename;
    }

		public byte[][] DownloadConvertedSwf(string key)
		{
			Validators.ValidateSingleFilename(key);
			var swfDirectoryName = Path.Combine(_options.OutputDirectory, key);
			var slideFilenames = (from f in new DirectoryInfo(swfDirectoryName).GetFiles()
								 where SwfSlideFilenamesRegex.IsMatch(f.Name)
								 select f).ToList();
			var result = new byte[slideFilenames.Count][];
			int slideIndex = 0;
			Log.Write("Downloading {0}...", key);
			slideFilenames.ForEach(file =>
			{
				using ( var stream = new FileStream(file.FullName, FileMode.Open, FileAccess.Read) )
				{
					using ( var reader = new BinaryReader(stream) )
					{
						var fileInfo = new FileInfo(file.FullName);
						result[slideIndex++] = reader.ReadBytes(Convert.ToInt32(fileInfo.Length));
					}
				}
			});
			Log.Write("{0} read", key);
			return result;
		}

		public bool IsConverted(string key)
		{
			Validators.ValidateSingleFilename(key);
			var fileToCheck = Path.Combine((Path.Combine(_options.OutputDirectory, key)), "done");
			Log.Write("Checking for {0}", fileToCheck);
			return File.Exists(fileToCheck);
		}

    public int GetFileStatus(string key)
    {
      if (File.Exists(Path.Combine(_options.IncomingDirectory, key)) || File.Exists(Path.Combine(_options.UploadDirectory, key)))
      {
        return 2;//file converting
      }
      if (!File.Exists(Path.Combine((Path.Combine(_options.OutputDirectory, key)), "done")) && File.Exists(Path.Combine(_options.OutgoingDirectory, key)))
      {
        return 2;//file converting
      }
      if (File.Exists(Path.Combine((Path.Combine(_options.OutputDirectory, key)), "done")))
      {
        return 1;//file converted
      }
      return 0;//no uploaded file
    }
	}

}
