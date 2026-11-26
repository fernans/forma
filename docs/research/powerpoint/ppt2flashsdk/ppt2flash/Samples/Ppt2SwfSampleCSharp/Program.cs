
using System;
using System.Windows.Forms;

using Ppt2SwfSampleCSharpNS;

namespace SDKForm
{

	internal static class Program
	{

		[STAThread]
		private static void Main()
		{
			Application.EnableVisualStyles();
			Application.SetCompatibleTextRenderingDefault(false);
			Application.Run(new MainForm());
		}

	}

}