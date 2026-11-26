
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics;
using System.IO;
using System.Threading;
using System.Windows.Forms;

using Ppt2SwfSdk.Converters;

namespace Ppt2SwfSampleCSharpNS
{

	using ThreadState = System.Threading.ThreadState;

	public partial class MainForm : Form
	{

		private Ppt2SwfConverter _converter;
		private Thread _convertionThread;
		private string _folderToOpen;
		private string _generatedSwfDirectoryName;
		private string _generatedSwfFileName;
		private int[] _slideFrameIndexes;
		private StatusWindow _statusWindow;

		public MainForm()
		{
			InitializeComponent();
			_ApplyAppConfig();
			ImageQualityTrackBar.Maximum = Ppt2SwfConverter.MaxImageQuality;
		}

		[Conditional("DEBUG")]
		private void _ApplyAppConfig()
		{
			try
			{
				var initialDirectory = ConfigurationManager.AppSettings["InitialDirectory"];
				var presentationToConvert = ConfigurationManager.AppSettings["PresentationToConvert"];
				var outputDirectory = ConfigurationManager.AppSettings["OutputDirectory"];
				var swfFilename = ConfigurationManager.AppSettings["SwfFilename"];
				PresentationOpenFileDialog.InitialDirectory = initialDirectory ?? Application.ExecutablePath;
				if ( presentationToConvert != null )
				{
					PowerPointFileTextBox.Text = presentationToConvert;
				}
				if ( outputDirectory != null )
				{
					ConvertToDirectoryTextBox.Text = outputDirectory;
				}
				if ( swfFilename != null )
				{
					SwfOutputFilenameTextBox.Text = swfFilename;
				}
				if ( initialDirectory != null && presentationToConvert != null
					 && outputDirectory != null && swfFilename != null )
				{
					EnableControls();
				}
			}
			catch
			{
			}
		}

		private void convertSwfButton_Click(object sender, EventArgs e)
		{
			if ( File.Exists(PowerPointFileTextBox.Text) )
			{
				if ( !checkFileExt(SwfOutputFilenameTextBox.Text, "swf") )
				{
					MessageBox.Show("Incorrect .swf filename !", "Name Entry Error",
									MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
					return;
				}
				if ( ConvertToDirectoryTextBox.Text == null )
				{
					MessageBox.Show("Incorrect folder path to save .swf file !", "Folder Path Error",
									MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
					return;
				}
				try
				{
					if ( !Directory.Exists(ConvertToDirectoryTextBox.Text) )
					{
						Directory.CreateDirectory(ConvertToDirectoryTextBox.Text);
					}
				}
				catch
				{
					Directory.CreateDirectory(Directory.GetCurrentDirectory() + @"\Converted");
					ConvertToDirectoryTextBox.Text = Directory.GetCurrentDirectory() + @"\Converted";
				}
				var converter = new Ppt2SwfConverter(String.Empty)
				{
					PresentationPath = PowerPointFileTextBox.Text,
					OutputDirectory = ConvertToDirectoryTextBox.Text,
					SlideToSlideMode = SlideToSlideModeCheckBox.Checked
				};
				if ( SlideToSlideModeCheckBox.Checked )
				{
					converter.SlideToSlidePause = Convert.ToInt32(SlideToSlidePauseUpDown.Value);
				}
				converter.ConvertSlideAnimation = ConvertAnimationCheckBox.Checked;
				converter.ConvertSlideTransitions = ConvertTransitionsCheckBox.Checked;
				converter.ConvertToExe = ConvertToExeCheckBox.Checked;
				converter.EffectOnClick = EffectOnClickCheckBox.Enabled ? EffectOnClickCheckBox.Checked : false;
				converter.GenerateXml = GenerateXmlCheckBox.Checked;
				converter.IsAnimationAutomated = AutomateAnimationCheckBox.Checked;
				converter.DefaultAnimationDelay = Convert.ToUInt16(AutomatedAnimationDelayNumericUpDown.Value);
				//converter.SplitAnimationToMovies = SplitAnimationToMoviesCheckBox.Checked;
				converter.ImageQuality = DefaultImageQualityCheckBox.Checked ? 0 : ImageQualityTrackBar.Value;
				if ( BaseOptionRangeConvertCheckBox.Checked )
				{
					int from;
					int to;
					if ( !(int.TryParse(BaseStartSlideTextBox.Text, out from)) || !(int.TryParse(BaseEndSlideTextBox.Text, out to)) )
					{
						MessageBox.Show("Converter slide indexes are not correctly input", "Converter slide indexes Error",
										MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
						return;
					}
					if ( from > to )
					{
						MessageBox.Show("Converter slide start index is more than end one", "Converter slide indexes Error",
										MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
						return;
					}
					converter.OnlyForNextSlides = true;
					converter.StartSlideIndex = from;
					converter.EndSlideIndex = to;
				}
				if ( !converter.PlayCircle )
				{
					converter.PlayCircle = LoopCheckBox.Checked;
				}
				if ( ScaleXNumericUpdown.Value > 0 && ScaleYNumericUpdown.Value > 0 )
				{
					converter.ScaleX = (float) ScaleXNumericUpdown.Value;
					converter.ScaleY = (float) ScaleYNumericUpdown.Value;
				}
				if ( EachSlideIntoSeparateSwfCheckBox.Checked )
				{
					converter.SeparateSlides = true;
				}
				try
				{
					_folderToOpen = ConvertToDirectoryTextBox.Text;
					_converter = converter;
					_convertionThread = new Thread(ConvertorEventHandler);
					_convertionThread.Start();
					SetPreviewButtons(false);
					DisableControls();
					_statusWindow = new StatusWindow(converter, _convertionThread, CloseStatusWindowCloseCheckBox.Checked);
					_statusWindow.FormClosed += delegate
					{
						SetPreviewButtons(_convertionThread.ThreadState != ThreadState.AbortRequested);
						EnableControls();
						_generatedSwfFileName = SwfOutputFilenameTextBox.Text;
						_generatedSwfDirectoryName = ConvertToDirectoryTextBox.Text;
						_slideFrameIndexes = converter.SlideFrameIndexes;
					};
					_statusWindow.ShowDialog();
				}
				catch
				{
					MessageBox.Show("Ppt2SwfConverter could not convert presentation: " + PowerPointFileTextBox.Text,
						"General convertion error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				}
			}
			else
			{
				MessageBox.Show("Please select valid PowerPoint file", "File not found",
					MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				return;
			}
		}

		private void ConvertorEventHandler()
		{
			try
			{
				_converter.Convert(Path.Combine(ConvertToDirectoryTextBox.Text, SwfOutputFilenameTextBox.Text));
				Process.Start(_folderToOpen);
			}
			catch ( PowerPointSupportFileExtException )
			{
				MessageBox.Show("Unsupported PPT file version", String.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error);
				_statusWindow.Close();
			}
			catch ( Exception ex )
			{
				if ( !(ex is ThreadAbortException) )
				{
#if DEBUG
					throw;
#else
					MessageBox.Show(ex.Message, "PPT 2 SWF SDK internal error occurred", MessageBoxButtons.OK, MessageBoxIcon.Error);
#endif
				}
				try
				{
					_statusWindow.Close();
				}
				catch
				{
				}
			}
		}

		private void SetPreviewButtons(bool show)
		{
			DefaultBrowserButton.Enabled = show;
			InternetExplorerButton.Enabled = show;
			DefaultHandlerButton.Enabled = show;
			GenerateThumbnailSlidesButton.Enabled = show;
		}

		private void EnableControls()
		{
			GenerateXmlCheckBox.Enabled = true;
			EffectOnClickCheckBox.Enabled = true;
			ConvertToExeCheckBox.Enabled = true;
			CloseStatusWindowCloseCheckBox.Enabled = true;
			LoopCheckBox.Enabled = true;
			SwfOutputFilenameTextBox.Enabled = true;
			EachSlideIntoSeparateSwfCheckBox.Enabled = true;
			ConvertThumbnailsButton.Enabled = true;
			BaseOptionRangeConvertCheckBox.Enabled = true;
			ConvertPpt2SwfButton.Enabled = true;
			ConvertTransitionsCheckBox.Enabled = true;
			ConvertAnimationCheckBox.Enabled = true;
			SlideToSlideModeCheckBox.Enabled = true;
			ThumbailFormatComboBox.Enabled = true;
			ThumbnailStartFileTextBox.Enabled = true;
			ThumbnailSlidesHtmlTextBox.Enabled = true;
			ThumbailsRangeOnlyCheckBox.Enabled = true;
			AutomateAnimationCheckBox.Enabled = true;
			ImageQualityGroupBox.Enabled = true;
			ImageQualityTrackBar.Enabled = !DefaultImageQualityCheckBox.Checked;
			AutomateAnimationCheckBox_CheckedChanged(null, null);
		}

		private void DisableControls()
		{
			EffectOnClickCheckBox.Enabled = false;
			GenerateXmlCheckBox.Enabled = false;
			ConvertToExeCheckBox.Enabled = false;
			CloseStatusWindowCloseCheckBox.Enabled = false;
			LoopCheckBox.Enabled = false;
			SwfOutputFilenameTextBox.Enabled = false;
			EachSlideIntoSeparateSwfCheckBox.Enabled = false;
			BaseOptionRangeConvertCheckBox.Enabled = false;
			ConvertThumbnailsButton.Enabled = false;
			ConvertPpt2SwfButton.Enabled = false;
			ConvertTransitionsCheckBox.Enabled = false;
			ConvertAnimationCheckBox.Enabled = false;
			SlideToSlideModeCheckBox.Enabled = false;
			ThumbailFormatComboBox.Enabled = false;
			ThumbnailStartFileTextBox.Enabled = false;
			ThumbnailSlidesHtmlTextBox.Enabled = false;
			ThumbailsRangeOnlyCheckBox.Enabled = false;
			AutomateAnimationCheckBox.Enabled = false;
			ImageQualityGroupBox.Enabled = false;
		}

		private void SelectPresentationButton_Click(object sender, EventArgs e)
		{
			if ( !Directory.Exists(PresentationOpenFileDialog.InitialDirectory) )
			{
				PresentationOpenFileDialog.InitialDirectory = Directory.GetCurrentDirectory();
			}
			if ( PresentationOpenFileDialog.ShowDialog() == DialogResult.OK )
			{
				PowerPointFileTextBox.Text = PresentationOpenFileDialog.FileName;
				EnableControls();
			}
		}

		private void selectSaveSwfFolderButton_Click_1(object sender, EventArgs e)
		{
			if ( SaveSwfFolderBrowserDialog.ShowDialog() == DialogResult.OK )
			{
				ConvertToDirectoryTextBox.Text = SaveSwfFolderBrowserDialog.SelectedPath;
			}
		}

		private void button2_Click(object sender, EventArgs e)
		{
			if ( !checkFileExt(ThumbnailStartFileTextBox.Text, "html") )
			{
				MessageBox.Show("Incorrect index .html  filename!", "Html  Filename Error",
					MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				return;
			}
			if ( !checkFileExt(ThumbnailSlidesHtmlTextBox.Text, "html") )
			{
				MessageBox.Show("Incorrect slides .html file name!", "Html  Filename Error",
					MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				return;
			}
			if ( ConvertToDirectoryTextBox.Text.Trim() == String.Empty )
			{
				MessageBox.Show("Incorrect folder path to save .swf file!", "Invalid path",
					MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
				return;
			}
			var thumbnailProducer = new ThumbnailProducer
			{
				PresentationPath = PowerPointFileTextBox.Text
			};
			var currentPath = String.Empty;
			try
			{
				if ( !Directory.Exists(ConvertToDirectoryTextBox.Text) )
				{
					Directory.CreateDirectory(ConvertToDirectoryTextBox.Text);
					currentPath = ConvertToDirectoryTextBox.Text;
				}
			}
			catch
			{
				currentPath = Directory.GetCurrentDirectory() + @"\Converted";
				Directory.CreateDirectory(currentPath);
				ConvertToDirectoryTextBox.Text = currentPath;
			}
			if ( !Directory.Exists(Path.Combine(currentPath, "thumbs")) )
			{
				Directory.CreateDirectory((Path.Combine(currentPath, "thumbs")));
			}
			thumbnailProducer.OutputDirectory = Path.Combine(ConvertToDirectoryTextBox.Text, "thumbs");
			thumbnailProducer.IndexHTMLName = ThumbnailStartFileTextBox.Text;
			if ( ThumbailFormatComboBox.SelectedIndex == -1 )
			{
				MessageBox.Show("File format not selected", "Select combobox item Error",
								MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
			thumbnailProducer.ImageFormat = ThumbailFormatComboBox.SelectedItem.ToString();
			thumbnailProducer.SlidesHTMLName = ThumbnailSlidesHtmlTextBox.Text;
			if ( ThumbailsRangeOnlyCheckBox.Checked )
			{
				int from;
				int to;
				if ( !(int.TryParse(ThumbnailsStartSlideTextBox.Text, out from)) || !(int.TryParse(ThumbnailsEndSlideTextBox.Text, out to)) )
				{
					MessageBox.Show("Thumbnail slide indexes are not correctly input", "Thumbnail slide indexes Error",
									MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
					return;
				}
				if ( from > to )
				{
					MessageBox.Show("Thumbnail slide start index is more than end one", "Thumbnail slide indexes Error",
									MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
					return;
				}
				thumbnailProducer.OnlyForNextSlides = true;
				thumbnailProducer.StartSlideIndex = from;
				thumbnailProducer.EndSlideIndex = to;
			}
			var cursor = Cursor;
			var anotherCursorControls = new Dictionary<Control, Cursor>();
			try
			{
				foreach ( Control control in Controls )
				{
					if ( control.Cursor != Cursors.WaitCursor )
					{
						anotherCursorControls.Add(control, control.Cursor);
						control.Cursor = Cursors.WaitCursor;
					}
				}
				Cursor = Cursors.WaitCursor;
				thumbnailProducer.Produce();
				Process.Start(ConvertToDirectoryTextBox.Text);
				var htmlFile = thumbnailProducer.OutputDirectory + @"\" + thumbnailProducer.SlidesHTMLName;
				if ( File.Exists(htmlFile) )
				{
					Process.Start("iexplore.exe", htmlFile);
				}
			}
			catch
			{
				MessageBox.Show("Power Point could not open current presentation: " + PowerPointFileTextBox.Text,
								"Supporting .pptx Error",
								MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
			finally
			{
				foreach ( Control control in anotherCursorControls.Keys )
				{
					control.Cursor = anotherCursorControls[control];
				}
				Cursor = cursor;
			}
		}

		private void _GenerateSlideBySlideHtml()
		{
			var producer = new ThumbnailProducer
			{
				PresentationPath = PowerPointFileTextBox.Text
			};
			var suffix = String.Empty;
			var currentPath = ConvertToDirectoryTextBox.Text + suffix;
			try
			{
				if ( !Directory.Exists(currentPath) )
				{
					Directory.CreateDirectory(currentPath);
				}
			}
			catch
			{
				currentPath = Directory.GetCurrentDirectory() + @"\Converted" + suffix;
				Directory.CreateDirectory(currentPath);
				ConvertToDirectoryTextBox.Text = currentPath;
			}
			var swfFilename = SwfOutputFilenameTextBox.Text;
			if ( !Directory.Exists(Path.Combine(currentPath, swfFilename + ".thumbs")) )
			{
				Directory.CreateDirectory((Path.Combine(currentPath, swfFilename + ".thumbs")));
			}
			producer.OutputDirectory = Path.Combine(currentPath, swfFilename + ".thumbs");
			// scarshock says, "i think this property must be completely deprecated"
			producer.IndexHTMLName = @"..\" + ThumbnailStartFileTextBox.Text;
			if ( ThumbailFormatComboBox.SelectedIndex == -1 )
			{
				MessageBox.Show("Thumbnails output format is not specified", String.Empty,
								MessageBoxButtons.OK, MessageBoxIcon.Error);
				return;
			}
			producer.ImageFormat = (string) (ThumbailFormatComboBox.Items[ThumbailFormatComboBox.SelectedIndex]);
			// I think this property must be completely deprecated
			producer.SlidesHTMLName = @"..\" + ThumbnailSlidesHtmlTextBox.Text;
			try
			{
				producer.Produce();
			}
			catch ( Exception ex )
			{
				MessageBox.Show(ex.Message, "Thumbnail producing error", MessageBoxButtons.OK, MessageBoxIcon.Error);
			}
			// BEGIN: the following block must be eliminated after the deprecated properties removed
			{
				var unnecessaryFile1 = Path.Combine(producer.OutputDirectory, producer.IndexHTMLName);
				var unnecessaryFile2 = Path.Combine(producer.OutputDirectory, producer.SlidesHTMLName);
				if ( File.Exists(unnecessaryFile1) )
				{
					File.Delete(unnecessaryFile1);
				}
				if ( File.Exists(unnecessaryFile2) )
				{
					File.Delete(unnecessaryFile2);
				}
			}
			// END
			try
			{
				WriteSlidesHtml(swfFilename, ThumbailFormatComboBox.SelectedItem.ToString(), _slideFrameIndexes);
				Process.Start(_folderToOpen);
			}
			catch
			{
				MessageBox.Show("Cannot generate slides HTML page", String.Empty, MessageBoxButtons.OK,
								MessageBoxIcon.Error);
			}
		}

		private void WriteSlidesHtml(string swfFilename, string format, int[] frames)
		{
			var htmlFilename = Path.Combine(_generatedSwfDirectoryName, swfFilename + ".html");
			using ( TextWriter writer = File.CreateText(htmlFilename) )
			{
				writer.WriteLine(Html.GetSlidesHtmlSkeleton(swfFilename, format, frames));
			}
		}

		private void pptOpenFilePathTextBox_TextChanged(object sender, EventArgs e)
		{
			var file = Path.GetFileNameWithoutExtension(PowerPointFileTextBox.Text);
			SwfOutputFilenameTextBox.Text = file + ".swf";
			try
			{
				ConvertToDirectoryTextBox.Text = Path.Combine(Path.GetDirectoryName(PowerPointFileTextBox.Text), "Converted");
			}
			catch
			{
				DefaultBrowserButton.Enabled = false;
				InternetExplorerButton.Enabled = false;
				DefaultHandlerButton.Enabled = false;
			}
			ValidateControls();
		}

		private void ValidateControls()
		{
			if ( PowerPointFileTextBox.Text.Length != 0 && ConvertToDirectoryTextBox.Text.Length != 0
				 && SwfOutputFilenameTextBox.Text.Length != 0 )
			{
				EnableControls();
			}
			else
			{
				DisableControls();
			}
		}

		private void Form1_Load(object sender, EventArgs e)
		{
			ThumbailFormatComboBox.SelectedIndex = 0;
		}

		private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
		{
			Process.Start(Ppt2SwfSdkLabel.Text);
		}

		private void linkLabel2_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
		{
			if ( File.Exists(Directory.GetCurrentDirectory() + "\\Ppt2SwfSDK.chm") )
			{
				Process.Start(Directory.GetCurrentDirectory() + "\\Ppt2SwfSDK.chm");
			}
			else
			{
				MessageBox.Show("File of documentation does not exists", "File exists error",
								MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
			}
		}

		private void previewButton_Click(object sender, EventArgs e)
		{
			var htmlFilename = WriteSwfHtmlHostFile();
			if ( File.Exists(htmlFilename) )
			{
				Process.Start(htmlFilename);
			}
		}

		private void previewIEButton_Click(object sender, EventArgs e)
		{
			var htmlFilename = WriteSwfHtmlHostFile();
			if ( File.Exists(htmlFilename) )
			{
				Process.Start("iexplore.exe", htmlFilename);
			}
		}

		private string WriteSwfHtmlHostFile()
		{
			var htmlFilename = Path.Combine(_generatedSwfDirectoryName, _generatedSwfFileName) + ".html";
			using ( var writer = File.CreateText(htmlFilename) )
			{
				writer.WriteLine(Html.GetHtmlSkeleton(_generatedSwfFileName));
			}
			return htmlFilename;
		}

		private void chkThumbsFromTo_CheckedChanged(object sender, EventArgs e)
		{
			ThumbnailsSpecifiedSlidesGroupBox.Enabled = !ThumbnailsSpecifiedSlidesGroupBox.Enabled;
		}

		private void chkSpecSlides_CheckedChanged(object sender, EventArgs e)
		{
			SpecifiedSlidesGroupBox.Enabled = !SpecifiedSlidesGroupBox.Enabled;
		}

		private void SwfSaveFilePathTextBox_TextChanged(object sender, EventArgs e)
		{
			ValidateControls();
		}

		private void SwfFileNameTextBox_TextChanged(object sender, EventArgs e)
		{
			ValidateControls();
			SwfOutputFilenameTextBox.Enabled = PowerPointFileTextBox.Text.Trim().Length != 0
											   && ConvertToDirectoryTextBox.Text.Trim().Length != 0;
		}

		private void DefaultHandlerButton_Click(object sender, EventArgs e)
		{
			var swfFile = ConvertToDirectoryTextBox.Text + @"\" + SwfOutputFilenameTextBox.Text;
			if ( File.Exists(swfFile) )
			{
				Process.Start(swfFile);
			}
			else
			{
				MessageBox.Show("The target file doesn't exist", String.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error);
			}
		}

		private void GenerateThumbnailSlidesButton_Click(object sender, EventArgs e)
		{
			_GenerateSlideBySlideHtml();
		}

		private void SlideToSlideModeCheckBox_CheckedChanged(object sender, EventArgs e)
		{
			if ( SlideToSlidePauseUpDown.Enabled )
			{
				SlideToSlidePauseUpDown.Enabled = false;
				SlidePauseLabel.Enabled = false;
			}
			else
			{
				SlideToSlidePauseUpDown.Enabled = true;
				SlidePauseLabel.Enabled = true;
			}
		}

		private void AutomateAnimationCheckBox_CheckedChanged(object sender, EventArgs e)
		{
			EffectOnClickCheckBox.Enabled = !AutomateAnimationCheckBox.Checked;
			AutomatedAnimationDelayNumericUpDown.Enabled = AutomateAnimationCheckBox.Checked;
		}

		private void DefaultImageQualityCheckBox_CheckedChanged(object sender, EventArgs e)
		{
			ImageQualityTrackBar.Enabled = !DefaultImageQualityCheckBox.Checked;
		}

	}
}
