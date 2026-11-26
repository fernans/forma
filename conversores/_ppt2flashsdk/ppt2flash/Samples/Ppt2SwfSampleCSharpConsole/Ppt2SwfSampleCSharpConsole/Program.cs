
using System;
using System.IO;
using System.Collections.Generic;
using System.Diagnostics;
using System.Reflection;
using Ppt2SwfSdk.Converters;

namespace Ppt2SwfSampleCSharpConsole
{

	internal static class Program
	{

		private static class Options
		{
			public static bool InteractiveMode = false;
			public static bool OpenExplorerWindow = false;
			public static string InputFilename = String.Empty;
			public static string OutputFilename = String.Empty;
		}

		private readonly static string[] helpStrings = new string[]
		{ 
			"Ppt2Swf SDK Console Sample",
			"\nUsage: " + Assembly.GetExecutingAssembly().GetName().Name + " [-e] {[-i] | input-file output-file}",
			"\nOptions: ",
			"\t-i - interactive mode (doesn't imply arguments usage)",
			"\t-e - open Explorer window after convertion",
			"\n\tNote: all unknown options will be ignored"
		};

		private static void showHelp()
		{
			foreach ( string m in helpStrings )
			{
				Console.WriteLine(m);
			}
		}

		private static List<string> getDistinctArguments(string[] args)
		{
			List<string> argumentsList = new List<string>();
			foreach ( string a in args )
			{
				if ( !argumentsList.Contains(a) )
				{
					argumentsList.Add(a);
				}
			}
			return argumentsList;
		}

		private static void parseArguments(List<string> arguments)
		{
			// process "open explorer" option
			if ( arguments.Contains("-e") )
			{
				Options.OpenExplorerWindow = true;
				arguments.Remove("-e");
			}
			// process "interactive mode" option
			if ( arguments.Contains("-i") )
			{
				Options.InteractiveMode = true;
				arguments.Remove("-i");
				do
				{
					Console.Write("PowerPoint presentation filename: ");
					Options.InputFilename = Console.ReadLine();
				} while ( !File.Exists(Options.InputFilename) );
			}
			else
			{
				arguments.Remove("-i");
				if ( arguments.Count == 0 )
				{
					throw new ArgumentException("Input file name is not specified");
				}
				if ( arguments.Count == 1 )
				{
					throw new ArgumentException("Output file name is not specified");
				}
				Options.InputFilename = arguments[0];
				Options.OutputFilename = arguments[1];
				if ( !File.Exists(Options.InputFilename) )
				{
					throw new ArgumentException("PowerPoint presentation file not found");
				}
				if ( !Directory.Exists(Path.GetDirectoryName(Options.OutputFilename)) )
				{
					throw new ArgumentException("SWF output directory does not exist");
				}
			}
		}

		private static void processPpt()
		{
			Ppt2SwfConverter ppt2SwfConverter = new Ppt2SwfConverter(null);
			ppt2SwfConverter.PresentationPath = Options.InputFilename;
			ppt2SwfConverter.OutputDirectory = Path.GetDirectoryName(Options.OutputFilename);
			ppt2SwfConverter.ConvertSlideAnimation = true;
			ppt2SwfConverter.ConvertSlideTransitions = true;
			ppt2SwfConverter.ConvertToExe = false;
			ppt2SwfConverter.EffectOnClick = true;
			ppt2SwfConverter.GenerateXml = true;
			Console.WriteLine("Presentation " + Path.GetFileName(Options.InputFilename) + " is now being converted. Please wait...");
			ppt2SwfConverter.Convert(Options.OutputFilename);
			if ( Options.OpenExplorerWindow )
			{
				Process.Start(Path.GetFullPath(Options.OutputFilename));
			}
			Console.WriteLine("Convertion successful");
		}

		private static void Main(string[] args)
		{
			if ( args.Length == 0 )
			{
				showHelp();
				return;
			}
			else
			{
				try
				{
					parseArguments(getDistinctArguments(args));
					processPpt();
				}
				catch ( Exception ex )
				{
					Console.WriteLine("Convertion FAILED: {0}", ex.Message);
				}
			}
		}

	}

}
