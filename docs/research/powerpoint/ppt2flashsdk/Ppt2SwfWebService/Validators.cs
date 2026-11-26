
using System;
using System.IO;

namespace Ppt2SwfWebService
{

	internal static class Validators
	{

		public static void ValidateSingleFilename(string filename)
		{
			if ( filename.Trim() == String.Empty || filename.IndexOfAny(Path.GetInvalidFileNameChars()) != -1 )
			{
				throw new Exception(filename + " is not a valid filename");
			}
		}

		public static void ValidateDirectoryPresence(string directoryName)
		{
			if ( !Directory.Exists(directoryName) )
			{
				throw new Exception(directoryName + " does not exist");
			}
		}

	}

}
