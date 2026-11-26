
using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using System.Text;

namespace Ppt2SwfSampleCSharpNS
{

	internal static class Html
	{

		private const string HtmlSkeletonResourceName = "Ppt2SwfSampleCSharpNS.Skeleton.txt";
		private const string HtmlSlidesSkeletonResourceName = "Ppt2SwfSampleCSharpNS.SlidesSkeleton.txt";

		private static readonly string HtmlSkeleton = String.Empty;
		private static readonly string SlidesHtmlSkeleton = String.Empty;

		static Html()
		{
			try
			{
				Assembly assembly = Assembly.GetExecutingAssembly();
				Stream htmlStream = assembly.GetManifestResourceStream(HtmlSkeletonResourceName);
				using ( StreamReader htmlResourceReader = new StreamReader(htmlStream) )
				{
					HtmlSkeleton = htmlResourceReader.ReadToEnd();
					htmlResourceReader.Close();
				}
				Stream slidesHtmlStream = assembly.GetManifestResourceStream(HtmlSlidesSkeletonResourceName);
				using ( StreamReader slidesHtmlResourceReader = new StreamReader(slidesHtmlStream) )
				{
					SlidesHtmlSkeleton = slidesHtmlResourceReader.ReadToEnd();
					slidesHtmlResourceReader.Close();
				}
			}
			catch
			{
			}
		}

		internal static string GetHtmlSkeleton(string swfFilename)
		{
			return HtmlSkeleton.Replace("{$swfFilename}", swfFilename);
		}

		internal static string GetSlidesHtmlSkeleton(string swfFilename, string format,
			int [] slideFrames)
		{
			return SlidesHtmlSkeleton
				.Replace("{$swfFilename}", swfFilename)
				.Replace("{$format}", format)
				.Replace("{$slideFrames}", joinFrameIndexesByComma(slideFrames));
			;
		}

		private static string joinFrameIndexesByComma(int [] list)
		{
			StringBuilder text = new StringBuilder();
			if ( list != null )
			{
				for ( int i = 0; i < list.Length; i++ )
				{
					text.Append(list[i] + 1);
					if ( i < list.Length - 1 )
					{
						text.Append(',');
					}
				}
			}
			return text.ToString();
		}

	}

}
