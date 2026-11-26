
using System;
using System.Threading;
using System.Windows.Forms;
using Ppt2SwfSdk.Converters;

namespace Ppt2SwfSampleCSharpNS
{
	public partial class StatusWindow : Form
	{
		#region Constructors
		public StatusWindow()
		{
			InitializeComponent();
		}

		public StatusWindow(Ppt2SwfConverter ppt2SwfConverter, Thread convertionThread, bool closeFlag)
		{
			InitializeComponent();
			this.ppt2SwfConverter = ppt2SwfConverter;
			this.convertionThread = convertionThread;
			this.closeFlag = closeFlag;
			richTextBox1.AppendText("Initializing...\r\n");
			ppt2SwfConverter.SlideTransitionRender += new Ppt2SwfConverter.SlideTransitionHandler(OnShowSlideTransitionRenderStatus);
			ppt2SwfConverter.SlideRender += new Ppt2SwfConverter.SlideRenderHandler(OnShowSlideRenderStatus);
			ppt2SwfConverter.ShapeRender += new Ppt2SwfConverter.ShapeRenderHandler(OnShowShapeRenderStatus);
			ppt2SwfConverter.ShapeEffectRender += new Ppt2SwfConverter.ShapeEffectRenderHandler(OnShowShapeEffectRenderStatus);
			ppt2SwfConverter.TextRender += new Ppt2SwfConverter.TextRenderHandler(OnShowTextRenderStatus);
			ppt2SwfConverter.RenderDone += new Ppt2SwfConverter.RenderDoneHandler(OnRenderDone);
			ppt2SwfConverter.SlidesPreparationDone += new Ppt2SwfConverter.SlidesPreparationDoneHandler(delegate
			{
				this.Invoke(new Ppt2SwfConverter.SlidesPreparationDoneHandler(SlidesPreparationDone));
			});
		}

		#endregion

		#region Properties

		private Ppt2SwfConverter ppt2SwfConverter;
		private Thread convertionThread;
		private bool closeFlag;

		#endregion

		#region Methods

		private void ShowSlideRenderStatus(int currentSlide, int totalSlides)
		{
			progressBar1.Value = currentSlide * 100 / totalSlides;
			lSlide.Text = currentSlide.ToString() + "/" + totalSlides.ToString();
			richTextBox1.AppendText("\r\n" + "Slide # " + currentSlide.ToString() + "\r\n");
		}

		private void RenderDone()
		{
			this.stopConvertionButton.Text = "Close";
			this.Text = "Converting successfully done!";
			if ( closeFlag )
			{
				this.Close();
			}
		}

		private void SlidesPreparationDone()
		{
			this.Text = "Saving the Flash file...";
		}

		private void ShowShapeRenderStatus(int shapeIndex, int shapesCount, string shapeInfo)
		{
			ShapesProgressBar.Value = shapeIndex * 100 / shapesCount;
			lShape.Text = shapeIndex.ToString() + "/" + shapesCount.ToString();
			richTextBox1.AppendText("Shape # " + shapeIndex.ToString() + ": " + shapeInfo + "\r\n");
		}

		private void ShowTextRenderStatus(string textInfo)
		{
			richTextBox2.AppendText("Text # " + textInfo + "\r\n");
		}

		private void ShowSlideTransitionRenderStatus(string transitionInfo)
		{
			richTextBox1.AppendText(transitionInfo + "\r\n");
		}

		private void ShowShapeEffectRenderStatus(string effectInfo)
		{
			richTextBox1.AppendText(effectInfo + "\r\n");
		}

		private void OnShowSlideTransitionRenderStatus(string transitionInfo)
		{
			if ( this.IsHandleCreated )
			{
				this.Invoke(new SlideTransitionRenderStatusHandler(ShowSlideTransitionRenderStatus), new object[] { transitionInfo });
			}
		}

		internal void OnShowSlideRenderStatus(int currentSlide, int totalSlides)
		{
			if ( this.IsHandleCreated )
			{
				this.Invoke(new SlideRenderStatusHandler(ShowSlideRenderStatus), new object[] { currentSlide, totalSlides });
			}
		}

		internal void OnRenderDone()
		{
			if ( this.IsHandleCreated )
			{
				this.Invoke(new RenderDoneHandler(RenderDone));
			}
		}

		private void OnShowShapeRenderStatus(int currentShape, int totalShapes, string shapeInfo)
		{
			if ( this.IsHandleCreated )
			{
				this.Invoke(new ShapeRenderStatusHandler(ShowShapeRenderStatus), new object[] { currentShape, totalShapes, shapeInfo });
			}
		}

		private void OnShowTextRenderStatus(string textInfo)
		{
			if ( this.IsHandleCreated )
			{
				this.Invoke(new TextRenderStatusHandler(ShowTextRenderStatus), new object[] { textInfo });
			}
		}

		private void OnShowShapeEffectRenderStatus(string effectInfo)
		{
			if ( this.IsHandleCreated )
			{
				this.Invoke(new ShapeEffectRenderStatusHandler(ShowShapeEffectRenderStatus), new object[] { effectInfo });
			}
		}

		#endregion

		#region events

		private delegate void SlideTransitionRenderStatusHandler(string transitionInfo);
		private delegate void SlideRenderStatusHandler(int slideIndex, int slidesCount);
		private delegate void ShapeRenderStatusHandler(int shapeIndex, int shapesCount, string shapeInfo);
		private delegate void TextRenderStatusHandler(string textInfo);
		private delegate void ShapeEffectRenderStatusHandler(string effectInfo);
		private delegate void RenderDoneHandler();

		#endregion

		private void stopConvertionButton_Click(object sender, EventArgs e)
		{
			try
			{
				if ( convertionThread != null )
				{
					convertionThread.Abort();
				}
				if ( closeFlag )
				{
					this.Close();
				}
			}
			catch
			{
			}
		}

	}

}