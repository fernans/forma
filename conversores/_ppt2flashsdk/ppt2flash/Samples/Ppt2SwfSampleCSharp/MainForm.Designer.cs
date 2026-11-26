namespace Ppt2SwfSampleCSharpNS
{
	partial class MainForm
	{
		/// <summary>
		/// Required designer variable.
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing)
		{
			if (disposing && (components != null))
			{
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		public bool checkFileExt(string fileName, string fileExt)
		{
			string[] fileParts = fileName.Split('.');
			return fileParts[fileParts.Length-1].ToLower() == fileExt;
		}

		#region Windows Form Designer generated code

		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{
			System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
			this.PowerPointPresentationLabel = new System.Windows.Forms.Label();
			this.PowerPointFileTextBox = new System.Windows.Forms.TextBox();
			this.PresentationOpenFileDialog = new System.Windows.Forms.OpenFileDialog();
			this.SelectPresentationButton = new System.Windows.Forms.Button();
			this.SaveSwfFolderBrowserDialog = new System.Windows.Forms.FolderBrowserDialog();
			this.ConvertToDirectoryLabel = new System.Windows.Forms.Label();
			this.ConvertToDirectoryTextBox = new System.Windows.Forms.TextBox();
			this.OutputDirectoryButton = new System.Windows.Forms.Button();
			this.Ppt2SwfSdkLabel = new System.Windows.Forms.LinkLabel();
			this.HelpLabel = new System.Windows.Forms.LinkLabel();
			this.BaseConvertionOptionsGroupBox = new System.Windows.Forms.GroupBox();
			this.ImageQualityGroupBox = new System.Windows.Forms.GroupBox();
			this.BestQualityLabel = new System.Windows.Forms.Label();
			this.WorstQualityLabel = new System.Windows.Forms.Label();
			this.DefaultImageQualityCheckBox = new System.Windows.Forms.CheckBox();
			this.ImageQualityTrackBar = new System.Windows.Forms.TrackBar();
			this.GenerateThumbnailSlidesButton = new System.Windows.Forms.Button();
			this.BaseOptionRangeConvertCheckBox = new System.Windows.Forms.CheckBox();
			this.SpecifiedSlidesGroupBox = new System.Windows.Forms.GroupBox();
			this.BaseStartSlideLabel = new System.Windows.Forms.Label();
			this.BaseStartSlideTextBox = new System.Windows.Forms.TextBox();
			this.BaseEndSlideLabel = new System.Windows.Forms.Label();
			this.BaseEndSlideTextBox = new System.Windows.Forms.TextBox();
			this.ScaleYNumericUpdown = new System.Windows.Forms.NumericUpDown();
			this.ScaleYLabel = new System.Windows.Forms.Label();
			this.ScaleXNumericUpdown = new System.Windows.Forms.NumericUpDown();
			this.ScaleXLabel = new System.Windows.Forms.Label();
			this.EachSlideIntoSeparateSwfCheckBox = new System.Windows.Forms.CheckBox();
			this.SwfOutputFilenameTextBox = new System.Windows.Forms.TextBox();
			this.SwfOutputFilenameLabel = new System.Windows.Forms.Label();
			this.ConvertPpt2SwfButton = new System.Windows.Forms.Button();
			this.ThumbnailsGroupBox = new System.Windows.Forms.GroupBox();
			this.ThumbailsRangeOnlyCheckBox = new System.Windows.Forms.CheckBox();
			this.ThumbnailsSpecifiedSlidesGroupBox = new System.Windows.Forms.GroupBox();
			this.ThumbnailsStartSlideLabel = new System.Windows.Forms.Label();
			this.ThumbnailsStartSlideTextBox = new System.Windows.Forms.TextBox();
			this.ThumbnailsEndSlideLabel = new System.Windows.Forms.Label();
			this.ThumbnailsEndSlideTextBox = new System.Windows.Forms.TextBox();
			this.ThumbnailSlidesHtmlTextBox = new System.Windows.Forms.TextBox();
			this.ThumbnailStartFileTextBox = new System.Windows.Forms.TextBox();
			this.ThumbnailsStartFileLabel = new System.Windows.Forms.Label();
			this.ThumbailFormatComboBox = new System.Windows.Forms.ComboBox();
			this.ImageFormatLabel = new System.Windows.Forms.Label();
			this.SlidesWrapperNameLabel = new System.Windows.Forms.Label();
			this.ConvertThumbnailsButton = new System.Windows.Forms.Button();
			this.AdditionalSettingsGroupBox = new System.Windows.Forms.GroupBox();
			this.QuickPreviewCheckBox = new System.Windows.Forms.CheckBox();
			this.ConvertToExeCheckBox = new System.Windows.Forms.CheckBox();
			this.CloseStatusWindowCloseCheckBox = new System.Windows.Forms.CheckBox();
			this.GenerateXmlCheckBox = new System.Windows.Forms.CheckBox();
			this.EffectOnClickCheckBox = new System.Windows.Forms.CheckBox();
			this.LoopCheckBox = new System.Windows.Forms.CheckBox();
			this.SlideToSlideModeCheckBox = new System.Windows.Forms.CheckBox();
			this.ConvertAnimationCheckBox = new System.Windows.Forms.CheckBox();
			this.ConvertTransitionsCheckBox = new System.Windows.Forms.CheckBox();
			this.PreviewGroupBox = new System.Windows.Forms.GroupBox();
			this.InternetExplorerButton = new System.Windows.Forms.Button();
			this.DefaultHandlerButton = new System.Windows.Forms.Button();
			this.DefaultBrowserButton = new System.Windows.Forms.Button();
			this.AnimationGroupBox = new System.Windows.Forms.GroupBox();
			this.MinimumDelayLabel = new System.Windows.Forms.Label();
			this.AutomatedAnimationDelayNumericUpDown = new System.Windows.Forms.NumericUpDown();
			this.AutomateAnimationCheckBox = new System.Windows.Forms.CheckBox();
			this.PlayNonStopSettingsGroupBox = new System.Windows.Forms.GroupBox();
			this.SlideToSlidePauseUpDown = new System.Windows.Forms.NumericUpDown();
			this.SlidePauseLabel = new System.Windows.Forms.Label();
			this.BaseConvertionOptionsGroupBox.SuspendLayout();
			this.ImageQualityGroupBox.SuspendLayout();
			((System.ComponentModel.ISupportInitialize) (this.ImageQualityTrackBar)).BeginInit();
			this.SpecifiedSlidesGroupBox.SuspendLayout();
			((System.ComponentModel.ISupportInitialize) (this.ScaleYNumericUpdown)).BeginInit();
			((System.ComponentModel.ISupportInitialize) (this.ScaleXNumericUpdown)).BeginInit();
			this.ThumbnailsGroupBox.SuspendLayout();
			this.ThumbnailsSpecifiedSlidesGroupBox.SuspendLayout();
			this.AdditionalSettingsGroupBox.SuspendLayout();
			this.PreviewGroupBox.SuspendLayout();
			this.AnimationGroupBox.SuspendLayout();
			((System.ComponentModel.ISupportInitialize) (this.AutomatedAnimationDelayNumericUpDown)).BeginInit();
			this.PlayNonStopSettingsGroupBox.SuspendLayout();
			((System.ComponentModel.ISupportInitialize) (this.SlideToSlidePauseUpDown)).BeginInit();
			this.SuspendLayout();
			// 
			// PowerPointPresentationLabel
			// 
			this.PowerPointPresentationLabel.AutoSize = true;
			this.PowerPointPresentationLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte) (204)));
			this.PowerPointPresentationLabel.Location = new System.Drawing.Point(12, 23);
			this.PowerPointPresentationLabel.Name = "PowerPointPresentationLabel";
			this.PowerPointPresentationLabel.Size = new System.Drawing.Size(120, 13);
			this.PowerPointPresentationLabel.TabIndex = 0;
			this.PowerPointPresentationLabel.Text = "Presentation to convert:";
			// 
			// PowerPointFileTextBox
			// 
			this.PowerPointFileTextBox.BackColor = System.Drawing.SystemColors.Window;
			this.PowerPointFileTextBox.Location = new System.Drawing.Point(136, 22);
			this.PowerPointFileTextBox.Name = "PowerPointFileTextBox";
			this.PowerPointFileTextBox.Size = new System.Drawing.Size(240, 20);
			this.PowerPointFileTextBox.TabIndex = 1;
			this.PowerPointFileTextBox.TextChanged += new System.EventHandler(this.pptOpenFilePathTextBox_TextChanged);
			// 
			// PresentationOpenFileDialog
			// 
			this.PresentationOpenFileDialog.Filter = "PowerPoint Files(*.ppt; *.pptx;)|*.ppt; *.pptx;";
			this.PresentationOpenFileDialog.RestoreDirectory = true;
			this.PresentationOpenFileDialog.Title = "Pick a PowerPoint file";
			// 
			// SelectPresentationButton
			// 
			this.SelectPresentationButton.Location = new System.Drawing.Point(382, 19);
			this.SelectPresentationButton.Name = "SelectPresentationButton";
			this.SelectPresentationButton.Size = new System.Drawing.Size(40, 23);
			this.SelectPresentationButton.TabIndex = 2;
			this.SelectPresentationButton.Text = "...";
			this.SelectPresentationButton.UseVisualStyleBackColor = true;
			this.SelectPresentationButton.Click += new System.EventHandler(this.SelectPresentationButton_Click);
			// 
			// ConvertToDirectoryLabel
			// 
			this.ConvertToDirectoryLabel.AutoSize = true;
			this.ConvertToDirectoryLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte) (204)));
			this.ConvertToDirectoryLabel.Location = new System.Drawing.Point(12, 53);
			this.ConvertToDirectoryLabel.Name = "ConvertToDirectoryLabel";
			this.ConvertToDirectoryLabel.Size = new System.Drawing.Size(102, 13);
			this.ConvertToDirectoryLabel.TabIndex = 3;
			this.ConvertToDirectoryLabel.Text = "Convert to directory:";
			// 
			// ConvertToDirectoryTextBox
			// 
			this.ConvertToDirectoryTextBox.BackColor = System.Drawing.SystemColors.Window;
			this.ConvertToDirectoryTextBox.Location = new System.Drawing.Point(136, 52);
			this.ConvertToDirectoryTextBox.Name = "ConvertToDirectoryTextBox";
			this.ConvertToDirectoryTextBox.Size = new System.Drawing.Size(240, 20);
			this.ConvertToDirectoryTextBox.TabIndex = 4;
			this.ConvertToDirectoryTextBox.TextChanged += new System.EventHandler(this.SwfSaveFilePathTextBox_TextChanged);
			// 
			// OutputDirectoryButton
			// 
			this.OutputDirectoryButton.Location = new System.Drawing.Point(382, 50);
			this.OutputDirectoryButton.Name = "OutputDirectoryButton";
			this.OutputDirectoryButton.Size = new System.Drawing.Size(40, 23);
			this.OutputDirectoryButton.TabIndex = 5;
			this.OutputDirectoryButton.Text = "...";
			this.OutputDirectoryButton.UseVisualStyleBackColor = true;
			this.OutputDirectoryButton.Click += new System.EventHandler(this.selectSaveSwfFolderButton_Click_1);
			// 
			// Ppt2SwfSdkLabel
			// 
			this.Ppt2SwfSdkLabel.AutoSize = true;
			this.Ppt2SwfSdkLabel.Location = new System.Drawing.Point(13, 648);
			this.Ppt2SwfSdkLabel.Name = "Ppt2SwfSdkLabel";
			this.Ppt2SwfSdkLabel.Size = new System.Drawing.Size(147, 13);
			this.Ppt2SwfSdkLabel.TabIndex = 11;
			this.Ppt2SwfSdkLabel.TabStop = true;
			this.Ppt2SwfSdkLabel.Text = "http://www.Ppt2FlashSdk.com";
			this.Ppt2SwfSdkLabel.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.linkLabel1_LinkClicked);
			// 
			// HelpLabel
			// 
			this.HelpLabel.AutoSize = true;
			this.HelpLabel.Location = new System.Drawing.Point(398, 648);
			this.HelpLabel.Name = "HelpLabel";
			this.HelpLabel.Size = new System.Drawing.Size(29, 13);
			this.HelpLabel.TabIndex = 12;
			this.HelpLabel.TabStop = true;
			this.HelpLabel.Text = "Help";
			this.HelpLabel.LinkClicked += new System.Windows.Forms.LinkLabelLinkClickedEventHandler(this.linkLabel2_LinkClicked);
			// 
			// BaseConvertionOptionsGroupBox
			// 
			this.BaseConvertionOptionsGroupBox.Controls.Add(this.ImageQualityGroupBox);
			this.BaseConvertionOptionsGroupBox.Controls.Add(this.GenerateThumbnailSlidesButton);
			this.BaseConvertionOptionsGroupBox.Controls.Add(this.BaseOptionRangeConvertCheckBox);
			this.BaseConvertionOptionsGroupBox.Controls.Add(this.SpecifiedSlidesGroupBox);
			this.BaseConvertionOptionsGroupBox.Controls.Add(this.ScaleYNumericUpdown);
			this.BaseConvertionOptionsGroupBox.Controls.Add(this.ScaleYLabel);
			this.BaseConvertionOptionsGroupBox.Controls.Add(this.ScaleXNumericUpdown);
			this.BaseConvertionOptionsGroupBox.Controls.Add(this.ScaleXLabel);
			this.BaseConvertionOptionsGroupBox.Controls.Add(this.EachSlideIntoSeparateSwfCheckBox);
			this.BaseConvertionOptionsGroupBox.Controls.Add(this.SwfOutputFilenameTextBox);
			this.BaseConvertionOptionsGroupBox.Controls.Add(this.SwfOutputFilenameLabel);
			this.BaseConvertionOptionsGroupBox.Controls.Add(this.ConvertPpt2SwfButton);
			this.BaseConvertionOptionsGroupBox.Location = new System.Drawing.Point(12, 138);
			this.BaseConvertionOptionsGroupBox.Name = "BaseConvertionOptionsGroupBox";
			this.BaseConvertionOptionsGroupBox.Size = new System.Drawing.Size(415, 168);
			this.BaseConvertionOptionsGroupBox.TabIndex = 7;
			this.BaseConvertionOptionsGroupBox.TabStop = false;
			this.BaseConvertionOptionsGroupBox.Text = "New movie basic options";
			// 
			// ImageQualityGroupBox
			// 
			this.ImageQualityGroupBox.Controls.Add(this.BestQualityLabel);
			this.ImageQualityGroupBox.Controls.Add(this.WorstQualityLabel);
			this.ImageQualityGroupBox.Controls.Add(this.DefaultImageQualityCheckBox);
			this.ImageQualityGroupBox.Controls.Add(this.ImageQualityTrackBar);
			this.ImageQualityGroupBox.Enabled = false;
			this.ImageQualityGroupBox.Location = new System.Drawing.Point(192, 88);
			this.ImageQualityGroupBox.Name = "ImageQualityGroupBox";
			this.ImageQualityGroupBox.Size = new System.Drawing.Size(216, 72);
			this.ImageQualityGroupBox.TabIndex = 14;
			this.ImageQualityGroupBox.TabStop = false;
			this.ImageQualityGroupBox.Text = "Image quality";
			// 
			// BestQualityLabel
			// 
			this.BestQualityLabel.AutoSize = true;
			this.BestQualityLabel.Location = new System.Drawing.Point(176, 8);
			this.BestQualityLabel.Name = "BestQualityLabel";
			this.BestQualityLabel.Size = new System.Drawing.Size(33, 13);
			this.BestQualityLabel.TabIndex = 15;
			this.BestQualityLabel.Text = "100%";
			// 
			// WorstQualityLabel
			// 
			this.WorstQualityLabel.AutoSize = true;
			this.WorstQualityLabel.Location = new System.Drawing.Point(112, 8);
			this.WorstQualityLabel.Name = "WorstQualityLabel";
			this.WorstQualityLabel.Size = new System.Drawing.Size(27, 13);
			this.WorstQualityLabel.TabIndex = 14;
			this.WorstQualityLabel.Text = "25%";
			// 
			// DefaultImageQualityCheckBox
			// 
			this.DefaultImageQualityCheckBox.Location = new System.Drawing.Point(8, 16);
			this.DefaultImageQualityCheckBox.Name = "DefaultImageQualityCheckBox";
			this.DefaultImageQualityCheckBox.Size = new System.Drawing.Size(104, 48);
			this.DefaultImageQualityCheckBox.TabIndex = 13;
			this.DefaultImageQualityCheckBox.Text = "Default converted images quality";
			this.DefaultImageQualityCheckBox.UseVisualStyleBackColor = true;
			this.DefaultImageQualityCheckBox.CheckedChanged += new System.EventHandler(this.DefaultImageQualityCheckBox_CheckedChanged);
			// 
			// ImageQualityTrackBar
			// 
			this.ImageQualityTrackBar.LargeChange = 1;
			this.ImageQualityTrackBar.Location = new System.Drawing.Point(112, 24);
			this.ImageQualityTrackBar.Maximum = 4;
			this.ImageQualityTrackBar.Minimum = 1;
			this.ImageQualityTrackBar.Name = "ImageQualityTrackBar";
			this.ImageQualityTrackBar.Size = new System.Drawing.Size(96, 45);
			this.ImageQualityTrackBar.TabIndex = 12;
			this.ImageQualityTrackBar.TickStyle = System.Windows.Forms.TickStyle.TopLeft;
			this.ImageQualityTrackBar.Value = 1;
			// 
			// GenerateThumbnailSlidesButton
			// 
			this.GenerateThumbnailSlidesButton.Enabled = false;
			this.GenerateThumbnailSlidesButton.Location = new System.Drawing.Point(312, 48);
			this.GenerateThumbnailSlidesButton.Name = "GenerateThumbnailSlidesButton";
			this.GenerateThumbnailSlidesButton.Size = new System.Drawing.Size(100, 23);
			this.GenerateThumbnailSlidesButton.TabIndex = 10;
			this.GenerateThumbnailSlidesButton.Text = "Generate preview";
			this.GenerateThumbnailSlidesButton.UseVisualStyleBackColor = true;
			this.GenerateThumbnailSlidesButton.Visible = false;
			this.GenerateThumbnailSlidesButton.Click += new System.EventHandler(this.GenerateThumbnailSlidesButton_Click);
			// 
			// BaseOptionRangeConvertCheckBox
			// 
			this.BaseOptionRangeConvertCheckBox.AutoSize = true;
			this.BaseOptionRangeConvertCheckBox.Enabled = false;
			this.BaseOptionRangeConvertCheckBox.Location = new System.Drawing.Point(8, 66);
			this.BaseOptionRangeConvertCheckBox.Margin = new System.Windows.Forms.Padding(2);
			this.BaseOptionRangeConvertCheckBox.Name = "BaseOptionRangeConvertCheckBox";
			this.BaseOptionRangeConvertCheckBox.Size = new System.Drawing.Size(157, 17);
			this.BaseOptionRangeConvertCheckBox.TabIndex = 3;
			this.BaseOptionRangeConvertCheckBox.Text = "Convert the following slides:";
			this.BaseOptionRangeConvertCheckBox.UseVisualStyleBackColor = true;
			this.BaseOptionRangeConvertCheckBox.CheckedChanged += new System.EventHandler(this.chkSpecSlides_CheckedChanged);
			// 
			// SpecifiedSlidesGroupBox
			// 
			this.SpecifiedSlidesGroupBox.Controls.Add(this.BaseStartSlideLabel);
			this.SpecifiedSlidesGroupBox.Controls.Add(this.BaseStartSlideTextBox);
			this.SpecifiedSlidesGroupBox.Controls.Add(this.BaseEndSlideLabel);
			this.SpecifiedSlidesGroupBox.Controls.Add(this.BaseEndSlideTextBox);
			this.SpecifiedSlidesGroupBox.Enabled = false;
			this.SpecifiedSlidesGroupBox.Location = new System.Drawing.Point(8, 88);
			this.SpecifiedSlidesGroupBox.Name = "SpecifiedSlidesGroupBox";
			this.SpecifiedSlidesGroupBox.Size = new System.Drawing.Size(176, 73);
			this.SpecifiedSlidesGroupBox.TabIndex = 8;
			this.SpecifiedSlidesGroupBox.TabStop = false;
			this.SpecifiedSlidesGroupBox.Text = "Slide range";
			// 
			// BaseStartSlideLabel
			// 
			this.BaseStartSlideLabel.AutoSize = true;
			this.BaseStartSlideLabel.Location = new System.Drawing.Point(6, 22);
			this.BaseStartSlideLabel.Name = "BaseStartSlideLabel";
			this.BaseStartSlideLabel.Size = new System.Drawing.Size(56, 13);
			this.BaseStartSlideLabel.TabIndex = 0;
			this.BaseStartSlideLabel.Text = "Start slide:";
			// 
			// BaseStartSlideTextBox
			// 
			this.BaseStartSlideTextBox.Location = new System.Drawing.Point(71, 19);
			this.BaseStartSlideTextBox.Name = "BaseStartSlideTextBox";
			this.BaseStartSlideTextBox.Size = new System.Drawing.Size(97, 20);
			this.BaseStartSlideTextBox.TabIndex = 2;
			this.BaseStartSlideTextBox.Text = "1";
			// 
			// BaseEndSlideLabel
			// 
			this.BaseEndSlideLabel.AutoSize = true;
			this.BaseEndSlideLabel.Location = new System.Drawing.Point(6, 47);
			this.BaseEndSlideLabel.Name = "BaseEndSlideLabel";
			this.BaseEndSlideLabel.Size = new System.Drawing.Size(53, 13);
			this.BaseEndSlideLabel.TabIndex = 1;
			this.BaseEndSlideLabel.Text = "End slide:";
			// 
			// BaseEndSlideTextBox
			// 
			this.BaseEndSlideTextBox.Location = new System.Drawing.Point(71, 44);
			this.BaseEndSlideTextBox.Name = "BaseEndSlideTextBox";
			this.BaseEndSlideTextBox.Size = new System.Drawing.Size(97, 20);
			this.BaseEndSlideTextBox.TabIndex = 3;
			this.BaseEndSlideTextBox.Text = "2";
			// 
			// ScaleYNumericUpdown
			// 
			this.ScaleYNumericUpdown.Enabled = false;
			this.ScaleYNumericUpdown.Increment = new decimal(new int[] {
            5,
            0,
            0,
            0});
			this.ScaleYNumericUpdown.Location = new System.Drawing.Point(251, 64);
			this.ScaleYNumericUpdown.Maximum = new decimal(new int[] {
            200,
            0,
            0,
            0});
			this.ScaleYNumericUpdown.Minimum = new decimal(new int[] {
            5,
            0,
            0,
            0});
			this.ScaleYNumericUpdown.Name = "ScaleYNumericUpdown";
			this.ScaleYNumericUpdown.Size = new System.Drawing.Size(44, 20);
			this.ScaleYNumericUpdown.TabIndex = 7;
			this.ScaleYNumericUpdown.Value = new decimal(new int[] {
            100,
            0,
            0,
            0});
			// 
			// ScaleYLabel
			// 
			this.ScaleYLabel.AutoSize = true;
			this.ScaleYLabel.Location = new System.Drawing.Point(199, 65);
			this.ScaleYLabel.Name = "ScaleYLabel";
			this.ScaleYLabel.Size = new System.Drawing.Size(47, 13);
			this.ScaleYLabel.TabIndex = 5;
			this.ScaleYLabel.Text = "Scale Y:";
			// 
			// ScaleXNumericUpdown
			// 
			this.ScaleXNumericUpdown.Enabled = false;
			this.ScaleXNumericUpdown.Increment = new decimal(new int[] {
            5,
            0,
            0,
            0});
			this.ScaleXNumericUpdown.Location = new System.Drawing.Point(252, 41);
			this.ScaleXNumericUpdown.Maximum = new decimal(new int[] {
            200,
            0,
            0,
            0});
			this.ScaleXNumericUpdown.Minimum = new decimal(new int[] {
            5,
            0,
            0,
            0});
			this.ScaleXNumericUpdown.Name = "ScaleXNumericUpdown";
			this.ScaleXNumericUpdown.Size = new System.Drawing.Size(43, 20);
			this.ScaleXNumericUpdown.TabIndex = 6;
			this.ScaleXNumericUpdown.Value = new decimal(new int[] {
            100,
            0,
            0,
            0});
			// 
			// ScaleXLabel
			// 
			this.ScaleXLabel.AutoSize = true;
			this.ScaleXLabel.Location = new System.Drawing.Point(199, 45);
			this.ScaleXLabel.Name = "ScaleXLabel";
			this.ScaleXLabel.Size = new System.Drawing.Size(47, 13);
			this.ScaleXLabel.TabIndex = 4;
			this.ScaleXLabel.Text = "Scale X:";
			// 
			// EachSlideIntoSeparateSwfCheckBox
			// 
			this.EachSlideIntoSeparateSwfCheckBox.AutoSize = true;
			this.EachSlideIntoSeparateSwfCheckBox.Enabled = false;
			this.EachSlideIntoSeparateSwfCheckBox.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte) (204)));
			this.EachSlideIntoSeparateSwfCheckBox.Location = new System.Drawing.Point(8, 42);
			this.EachSlideIntoSeparateSwfCheckBox.Name = "EachSlideIntoSeparateSwfCheckBox";
			this.EachSlideIntoSeparateSwfCheckBox.Size = new System.Drawing.Size(181, 17);
			this.EachSlideIntoSeparateSwfCheckBox.TabIndex = 2;
			this.EachSlideIntoSeparateSwfCheckBox.Text = "Split slides into separated movies";
			this.EachSlideIntoSeparateSwfCheckBox.UseVisualStyleBackColor = true;
			// 
			// SwfOutputFilenameTextBox
			// 
			this.SwfOutputFilenameTextBox.Enabled = false;
			this.SwfOutputFilenameTextBox.Location = new System.Drawing.Point(114, 16);
			this.SwfOutputFilenameTextBox.Name = "SwfOutputFilenameTextBox";
			this.SwfOutputFilenameTextBox.Size = new System.Drawing.Size(182, 20);
			this.SwfOutputFilenameTextBox.TabIndex = 1;
			this.SwfOutputFilenameTextBox.Text = "file.swf";
			this.SwfOutputFilenameTextBox.TextChanged += new System.EventHandler(this.SwfFileNameTextBox_TextChanged);
			// 
			// SwfOutputFilenameLabel
			// 
			this.SwfOutputFilenameLabel.AutoSize = true;
			this.SwfOutputFilenameLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte) (204)));
			this.SwfOutputFilenameLabel.Location = new System.Drawing.Point(5, 19);
			this.SwfOutputFilenameLabel.Name = "SwfOutputFilenameLabel";
			this.SwfOutputFilenameLabel.Size = new System.Drawing.Size(105, 13);
			this.SwfOutputFilenameLabel.TabIndex = 0;
			this.SwfOutputFilenameLabel.Text = "New movie filename:";
			// 
			// ConvertPpt2SwfButton
			// 
			this.ConvertPpt2SwfButton.Anchor = ((System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.ConvertPpt2SwfButton.Enabled = false;
			this.ConvertPpt2SwfButton.Location = new System.Drawing.Point(312, 16);
			this.ConvertPpt2SwfButton.Name = "ConvertPpt2SwfButton";
			this.ConvertPpt2SwfButton.Size = new System.Drawing.Size(98, 23);
			this.ConvertPpt2SwfButton.TabIndex = 9;
			this.ConvertPpt2SwfButton.Text = "&Convert";
			this.ConvertPpt2SwfButton.UseVisualStyleBackColor = true;
			this.ConvertPpt2SwfButton.Click += new System.EventHandler(this.convertSwfButton_Click);
			// 
			// ThumbnailsGroupBox
			// 
			this.ThumbnailsGroupBox.Controls.Add(this.ThumbailsRangeOnlyCheckBox);
			this.ThumbnailsGroupBox.Controls.Add(this.ThumbnailsSpecifiedSlidesGroupBox);
			this.ThumbnailsGroupBox.Controls.Add(this.ThumbnailSlidesHtmlTextBox);
			this.ThumbnailsGroupBox.Controls.Add(this.ThumbnailStartFileTextBox);
			this.ThumbnailsGroupBox.Controls.Add(this.ThumbnailsStartFileLabel);
			this.ThumbnailsGroupBox.Controls.Add(this.ThumbailFormatComboBox);
			this.ThumbnailsGroupBox.Controls.Add(this.ImageFormatLabel);
			this.ThumbnailsGroupBox.Controls.Add(this.SlidesWrapperNameLabel);
			this.ThumbnailsGroupBox.Controls.Add(this.ConvertThumbnailsButton);
			this.ThumbnailsGroupBox.Location = new System.Drawing.Point(12, 488);
			this.ThumbnailsGroupBox.Name = "ThumbnailsGroupBox";
			this.ThumbnailsGroupBox.Size = new System.Drawing.Size(415, 152);
			this.ThumbnailsGroupBox.TabIndex = 10;
			this.ThumbnailsGroupBox.TabStop = false;
			this.ThumbnailsGroupBox.Text = "Thumbnails";
			// 
			// ThumbailsRangeOnlyCheckBox
			// 
			this.ThumbailsRangeOnlyCheckBox.AutoSize = true;
			this.ThumbailsRangeOnlyCheckBox.Enabled = false;
			this.ThumbailsRangeOnlyCheckBox.Location = new System.Drawing.Point(11, 48);
			this.ThumbailsRangeOnlyCheckBox.Margin = new System.Windows.Forms.Padding(2);
			this.ThumbailsRangeOnlyCheckBox.Name = "ThumbailsRangeOnlyCheckBox";
			this.ThumbailsRangeOnlyCheckBox.Size = new System.Drawing.Size(125, 17);
			this.ThumbailsRangeOnlyCheckBox.TabIndex = 3;
			this.ThumbailsRangeOnlyCheckBox.Text = "Specified range only:";
			this.ThumbailsRangeOnlyCheckBox.UseVisualStyleBackColor = true;
			this.ThumbailsRangeOnlyCheckBox.CheckedChanged += new System.EventHandler(this.chkThumbsFromTo_CheckedChanged);
			// 
			// ThumbnailsSpecifiedSlidesGroupBox
			// 
			this.ThumbnailsSpecifiedSlidesGroupBox.Controls.Add(this.ThumbnailsStartSlideLabel);
			this.ThumbnailsSpecifiedSlidesGroupBox.Controls.Add(this.ThumbnailsStartSlideTextBox);
			this.ThumbnailsSpecifiedSlidesGroupBox.Controls.Add(this.ThumbnailsEndSlideLabel);
			this.ThumbnailsSpecifiedSlidesGroupBox.Controls.Add(this.ThumbnailsEndSlideTextBox);
			this.ThumbnailsSpecifiedSlidesGroupBox.Enabled = false;
			this.ThumbnailsSpecifiedSlidesGroupBox.Location = new System.Drawing.Point(8, 70);
			this.ThumbnailsSpecifiedSlidesGroupBox.Name = "ThumbnailsSpecifiedSlidesGroupBox";
			this.ThumbnailsSpecifiedSlidesGroupBox.Size = new System.Drawing.Size(192, 73);
			this.ThumbnailsSpecifiedSlidesGroupBox.TabIndex = 7;
			this.ThumbnailsSpecifiedSlidesGroupBox.TabStop = false;
			this.ThumbnailsSpecifiedSlidesGroupBox.Text = "Slide range";
			// 
			// ThumbnailsStartSlideLabel
			// 
			this.ThumbnailsStartSlideLabel.AutoSize = true;
			this.ThumbnailsStartSlideLabel.Location = new System.Drawing.Point(6, 22);
			this.ThumbnailsStartSlideLabel.Name = "ThumbnailsStartSlideLabel";
			this.ThumbnailsStartSlideLabel.Size = new System.Drawing.Size(56, 13);
			this.ThumbnailsStartSlideLabel.TabIndex = 0;
			this.ThumbnailsStartSlideLabel.Text = "Start slide:";
			// 
			// ThumbnailsStartSlideTextBox
			// 
			this.ThumbnailsStartSlideTextBox.Location = new System.Drawing.Point(71, 19);
			this.ThumbnailsStartSlideTextBox.Name = "ThumbnailsStartSlideTextBox";
			this.ThumbnailsStartSlideTextBox.Size = new System.Drawing.Size(105, 20);
			this.ThumbnailsStartSlideTextBox.TabIndex = 2;
			this.ThumbnailsStartSlideTextBox.Text = "1";
			// 
			// ThumbnailsEndSlideLabel
			// 
			this.ThumbnailsEndSlideLabel.AutoSize = true;
			this.ThumbnailsEndSlideLabel.Location = new System.Drawing.Point(6, 47);
			this.ThumbnailsEndSlideLabel.Name = "ThumbnailsEndSlideLabel";
			this.ThumbnailsEndSlideLabel.Size = new System.Drawing.Size(53, 13);
			this.ThumbnailsEndSlideLabel.TabIndex = 1;
			this.ThumbnailsEndSlideLabel.Text = "End slide:";
			// 
			// ThumbnailsEndSlideTextBox
			// 
			this.ThumbnailsEndSlideTextBox.Location = new System.Drawing.Point(71, 44);
			this.ThumbnailsEndSlideTextBox.Name = "ThumbnailsEndSlideTextBox";
			this.ThumbnailsEndSlideTextBox.Size = new System.Drawing.Size(105, 20);
			this.ThumbnailsEndSlideTextBox.TabIndex = 3;
			this.ThumbnailsEndSlideTextBox.Text = "2";
			// 
			// ThumbnailSlidesHtmlTextBox
			// 
			this.ThumbnailSlidesHtmlTextBox.Enabled = false;
			this.ThumbnailSlidesHtmlTextBox.Location = new System.Drawing.Point(288, 42);
			this.ThumbnailSlidesHtmlTextBox.Name = "ThumbnailSlidesHtmlTextBox";
			this.ThumbnailSlidesHtmlTextBox.Size = new System.Drawing.Size(119, 20);
			this.ThumbnailSlidesHtmlTextBox.TabIndex = 6;
			this.ThumbnailSlidesHtmlTextBox.Text = "Slides.html";
			// 
			// ThumbnailStartFileTextBox
			// 
			this.ThumbnailStartFileTextBox.Enabled = false;
			this.ThumbnailStartFileTextBox.Location = new System.Drawing.Point(288, 16);
			this.ThumbnailStartFileTextBox.Name = "ThumbnailStartFileTextBox";
			this.ThumbnailStartFileTextBox.Size = new System.Drawing.Size(119, 20);
			this.ThumbnailStartFileTextBox.TabIndex = 5;
			this.ThumbnailStartFileTextBox.Text = "index.html";
			// 
			// ThumbnailsStartFileLabel
			// 
			this.ThumbnailsStartFileLabel.AutoSize = true;
			this.ThumbnailsStartFileLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte) (204)));
			this.ThumbnailsStartFileLabel.Location = new System.Drawing.Point(200, 23);
			this.ThumbnailsStartFileLabel.Name = "ThumbnailsStartFileLabel";
			this.ThumbnailsStartFileLabel.Size = new System.Drawing.Size(74, 13);
			this.ThumbnailsStartFileLabel.TabIndex = 1;
			this.ThumbnailsStartFileLabel.Text = "Start filename:";
			// 
			// ThumbailFormatComboBox
			// 
			this.ThumbailFormatComboBox.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
			this.ThumbailFormatComboBox.Enabled = false;
			this.ThumbailFormatComboBox.Items.AddRange(new object[] {
            "JPG",
            "BMP",
            "GIF"});
			this.ThumbailFormatComboBox.Location = new System.Drawing.Point(108, 19);
			this.ThumbailFormatComboBox.Name = "ThumbailFormatComboBox";
			this.ThumbailFormatComboBox.Size = new System.Drawing.Size(50, 21);
			this.ThumbailFormatComboBox.TabIndex = 4;
			// 
			// ImageFormatLabel
			// 
			this.ImageFormatLabel.AutoSize = true;
			this.ImageFormatLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte) (204)));
			this.ImageFormatLabel.Location = new System.Drawing.Point(8, 27);
			this.ImageFormatLabel.Name = "ImageFormatLabel";
			this.ImageFormatLabel.Size = new System.Drawing.Size(71, 13);
			this.ImageFormatLabel.TabIndex = 0;
			this.ImageFormatLabel.Text = "Image format:";
			// 
			// SlidesWrapperNameLabel
			// 
			this.SlidesWrapperNameLabel.AutoSize = true;
			this.SlidesWrapperNameLabel.Font = new System.Drawing.Font("Microsoft Sans Serif", 8.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte) (204)));
			this.SlidesWrapperNameLabel.Location = new System.Drawing.Point(200, 45);
			this.SlidesWrapperNameLabel.Name = "SlidesWrapperNameLabel";
			this.SlidesWrapperNameLabel.Size = new System.Drawing.Size(80, 13);
			this.SlidesWrapperNameLabel.TabIndex = 2;
			this.SlidesWrapperNameLabel.Text = "Slides filename:";
			// 
			// ConvertThumbnailsButton
			// 
			this.ConvertThumbnailsButton.Anchor = ((System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.ConvertThumbnailsButton.Enabled = false;
			this.ConvertThumbnailsButton.Location = new System.Drawing.Point(287, 120);
			this.ConvertThumbnailsButton.Name = "ConvertThumbnailsButton";
			this.ConvertThumbnailsButton.Size = new System.Drawing.Size(117, 23);
			this.ConvertThumbnailsButton.TabIndex = 8;
			this.ConvertThumbnailsButton.Text = "Generate thumbnails";
			this.ConvertThumbnailsButton.UseVisualStyleBackColor = true;
			this.ConvertThumbnailsButton.Click += new System.EventHandler(this.button2_Click);
			// 
			// AdditionalSettingsGroupBox
			// 
			this.AdditionalSettingsGroupBox.Controls.Add(this.QuickPreviewCheckBox);
			this.AdditionalSettingsGroupBox.Controls.Add(this.ConvertToExeCheckBox);
			this.AdditionalSettingsGroupBox.Controls.Add(this.CloseStatusWindowCloseCheckBox);
			this.AdditionalSettingsGroupBox.Controls.Add(this.GenerateXmlCheckBox);
			this.AdditionalSettingsGroupBox.Location = new System.Drawing.Point(12, 422);
			this.AdditionalSettingsGroupBox.Name = "AdditionalSettingsGroupBox";
			this.AdditionalSettingsGroupBox.Size = new System.Drawing.Size(415, 64);
			this.AdditionalSettingsGroupBox.TabIndex = 9;
			this.AdditionalSettingsGroupBox.TabStop = false;
			this.AdditionalSettingsGroupBox.Text = "Additional settings";
			// 
			// QuickPreviewCheckBox
			// 
			this.QuickPreviewCheckBox.AutoSize = true;
			this.QuickPreviewCheckBox.Location = new System.Drawing.Point(162, 19);
			this.QuickPreviewCheckBox.Name = "QuickPreviewCheckBox";
			this.QuickPreviewCheckBox.Size = new System.Drawing.Size(94, 17);
			this.QuickPreviewCheckBox.TabIndex = 2;
			this.QuickPreviewCheckBox.Text = "Quick preview";
			this.QuickPreviewCheckBox.UseVisualStyleBackColor = true;
			this.QuickPreviewCheckBox.Visible = false;
			// 
			// ConvertToExeCheckBox
			// 
			this.ConvertToExeCheckBox.AutoSize = true;
			this.ConvertToExeCheckBox.Enabled = false;
			this.ConvertToExeCheckBox.Location = new System.Drawing.Point(8, 42);
			this.ConvertToExeCheckBox.Name = "ConvertToExeCheckBox";
			this.ConvertToExeCheckBox.Size = new System.Drawing.Size(102, 17);
			this.ConvertToExeCheckBox.TabIndex = 1;
			this.ConvertToExeCheckBox.Text = "Convert to .EXE";
			this.ConvertToExeCheckBox.UseVisualStyleBackColor = true;
			// 
			// CloseStatusWindowCloseCheckBox
			// 
			this.CloseStatusWindowCloseCheckBox.AutoSize = true;
			this.CloseStatusWindowCloseCheckBox.Enabled = false;
			this.CloseStatusWindowCloseCheckBox.Location = new System.Drawing.Point(288, 19);
			this.CloseStatusWindowCloseCheckBox.Name = "CloseStatusWindowCloseCheckBox";
			this.CloseStatusWindowCloseCheckBox.Size = new System.Drawing.Size(122, 17);
			this.CloseStatusWindowCloseCheckBox.TabIndex = 3;
			this.CloseStatusWindowCloseCheckBox.Text = "Close status window";
			this.CloseStatusWindowCloseCheckBox.UseVisualStyleBackColor = true;
			// 
			// GenerateXmlCheckBox
			// 
			this.GenerateXmlCheckBox.AutoSize = true;
			this.GenerateXmlCheckBox.Enabled = false;
			this.GenerateXmlCheckBox.Location = new System.Drawing.Point(8, 19);
			this.GenerateXmlCheckBox.Name = "GenerateXmlCheckBox";
			this.GenerateXmlCheckBox.Size = new System.Drawing.Size(95, 17);
			this.GenerateXmlCheckBox.TabIndex = 0;
			this.GenerateXmlCheckBox.Text = "Generate XML";
			this.GenerateXmlCheckBox.UseVisualStyleBackColor = true;
			// 
			// EffectOnClickCheckBox
			// 
			this.EffectOnClickCheckBox.AutoSize = true;
			this.EffectOnClickCheckBox.Checked = true;
			this.EffectOnClickCheckBox.CheckState = System.Windows.Forms.CheckState.Checked;
			this.EffectOnClickCheckBox.Enabled = false;
			this.EffectOnClickCheckBox.Location = new System.Drawing.Point(164, 42);
			this.EffectOnClickCheckBox.Name = "EffectOnClickCheckBox";
			this.EffectOnClickCheckBox.Size = new System.Drawing.Size(63, 17);
			this.EffectOnClickCheckBox.TabIndex = 5;
			this.EffectOnClickCheckBox.Text = "By click";
			this.EffectOnClickCheckBox.UseVisualStyleBackColor = true;
			// 
			// LoopCheckBox
			// 
			this.LoopCheckBox.AutoSize = true;
			this.LoopCheckBox.Enabled = false;
			this.LoopCheckBox.Location = new System.Drawing.Point(164, 19);
			this.LoopCheckBox.Name = "LoopCheckBox";
			this.LoopCheckBox.Size = new System.Drawing.Size(50, 17);
			this.LoopCheckBox.TabIndex = 4;
			this.LoopCheckBox.Text = "Loop";
			this.LoopCheckBox.UseVisualStyleBackColor = true;
			// 
			// SlideToSlideModeCheckBox
			// 
			this.SlideToSlideModeCheckBox.AutoSize = true;
			this.SlideToSlideModeCheckBox.Enabled = false;
			this.SlideToSlideModeCheckBox.Location = new System.Drawing.Point(8, 19);
			this.SlideToSlideModeCheckBox.Name = "SlideToSlideModeCheckBox";
			this.SlideToSlideModeCheckBox.Size = new System.Drawing.Size(113, 17);
			this.SlideToSlideModeCheckBox.TabIndex = 0;
			this.SlideToSlideModeCheckBox.Text = "Play none stop On";
			this.SlideToSlideModeCheckBox.UseVisualStyleBackColor = true;
			this.SlideToSlideModeCheckBox.CheckedChanged += new System.EventHandler(this.SlideToSlideModeCheckBox_CheckedChanged);
			// 
			// ConvertAnimationCheckBox
			// 
			this.ConvertAnimationCheckBox.AutoSize = true;
			this.ConvertAnimationCheckBox.Checked = true;
			this.ConvertAnimationCheckBox.CheckState = System.Windows.Forms.CheckState.Checked;
			this.ConvertAnimationCheckBox.Enabled = false;
			this.ConvertAnimationCheckBox.Location = new System.Drawing.Point(9, 42);
			this.ConvertAnimationCheckBox.Name = "ConvertAnimationCheckBox";
			this.ConvertAnimationCheckBox.Size = new System.Drawing.Size(148, 17);
			this.ConvertAnimationCheckBox.TabIndex = 1;
			this.ConvertAnimationCheckBox.Text = "Convert custom animation";
			this.ConvertAnimationCheckBox.UseVisualStyleBackColor = true;
			// 
			// ConvertTransitionsCheckBox
			// 
			this.ConvertTransitionsCheckBox.AutoSize = true;
			this.ConvertTransitionsCheckBox.Checked = true;
			this.ConvertTransitionsCheckBox.CheckState = System.Windows.Forms.CheckState.Checked;
			this.ConvertTransitionsCheckBox.Enabled = false;
			this.ConvertTransitionsCheckBox.Location = new System.Drawing.Point(9, 19);
			this.ConvertTransitionsCheckBox.Name = "ConvertTransitionsCheckBox";
			this.ConvertTransitionsCheckBox.Size = new System.Drawing.Size(137, 17);
			this.ConvertTransitionsCheckBox.TabIndex = 0;
			this.ConvertTransitionsCheckBox.Text = "Convert slide transitions";
			this.ConvertTransitionsCheckBox.UseVisualStyleBackColor = true;
			// 
			// PreviewGroupBox
			// 
			this.PreviewGroupBox.Controls.Add(this.InternetExplorerButton);
			this.PreviewGroupBox.Controls.Add(this.DefaultHandlerButton);
			this.PreviewGroupBox.Controls.Add(this.DefaultBrowserButton);
			this.PreviewGroupBox.Location = new System.Drawing.Point(12, 81);
			this.PreviewGroupBox.Name = "PreviewGroupBox";
			this.PreviewGroupBox.Size = new System.Drawing.Size(415, 51);
			this.PreviewGroupBox.TabIndex = 6;
			this.PreviewGroupBox.TabStop = false;
			this.PreviewGroupBox.Text = "Preview";
			// 
			// InternetExplorerButton
			// 
			this.InternetExplorerButton.Anchor = ((System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.InternetExplorerButton.Enabled = false;
			this.InternetExplorerButton.Location = new System.Drawing.Point(276, 19);
			this.InternetExplorerButton.Name = "InternetExplorerButton";
			this.InternetExplorerButton.Size = new System.Drawing.Size(118, 23);
			this.InternetExplorerButton.TabIndex = 2;
			this.InternetExplorerButton.Text = "Internet Explorer";
			this.InternetExplorerButton.UseVisualStyleBackColor = true;
			this.InternetExplorerButton.Click += new System.EventHandler(this.previewIEButton_Click);
			// 
			// DefaultHandlerButton
			// 
			this.DefaultHandlerButton.Anchor = ((System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.DefaultHandlerButton.Enabled = false;
			this.DefaultHandlerButton.Location = new System.Drawing.Point(17, 19);
			this.DefaultHandlerButton.Name = "DefaultHandlerButton";
			this.DefaultHandlerButton.Size = new System.Drawing.Size(118, 23);
			this.DefaultHandlerButton.TabIndex = 0;
			this.DefaultHandlerButton.Text = "Default handler";
			this.DefaultHandlerButton.UseVisualStyleBackColor = true;
			this.DefaultHandlerButton.Click += new System.EventHandler(this.DefaultHandlerButton_Click);
			// 
			// DefaultBrowserButton
			// 
			this.DefaultBrowserButton.Anchor = ((System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.DefaultBrowserButton.Enabled = false;
			this.DefaultBrowserButton.Location = new System.Drawing.Point(146, 19);
			this.DefaultBrowserButton.Name = "DefaultBrowserButton";
			this.DefaultBrowserButton.Size = new System.Drawing.Size(118, 23);
			this.DefaultBrowserButton.TabIndex = 1;
			this.DefaultBrowserButton.Text = "Default browser";
			this.DefaultBrowserButton.UseVisualStyleBackColor = true;
			this.DefaultBrowserButton.Click += new System.EventHandler(this.previewButton_Click);
			// 
			// AnimationGroupBox
			// 
			this.AnimationGroupBox.Controls.Add(this.MinimumDelayLabel);
			this.AnimationGroupBox.Controls.Add(this.AutomatedAnimationDelayNumericUpDown);
			this.AnimationGroupBox.Controls.Add(this.AutomateAnimationCheckBox);
			this.AnimationGroupBox.Controls.Add(this.PlayNonStopSettingsGroupBox);
			this.AnimationGroupBox.Controls.Add(this.ConvertTransitionsCheckBox);
			this.AnimationGroupBox.Controls.Add(this.EffectOnClickCheckBox);
			this.AnimationGroupBox.Controls.Add(this.ConvertAnimationCheckBox);
			this.AnimationGroupBox.Controls.Add(this.LoopCheckBox);
			this.AnimationGroupBox.Location = new System.Drawing.Point(10, 308);
			this.AnimationGroupBox.Name = "AnimationGroupBox";
			this.AnimationGroupBox.Size = new System.Drawing.Size(415, 108);
			this.AnimationGroupBox.TabIndex = 8;
			this.AnimationGroupBox.TabStop = false;
			this.AnimationGroupBox.Text = "Animation settings";
			// 
			// MinimumDelayLabel
			// 
			this.MinimumDelayLabel.Location = new System.Drawing.Point(208, 59);
			this.MinimumDelayLabel.Name = "MinimumDelayLabel";
			this.MinimumDelayLabel.Size = new System.Drawing.Size(55, 27);
			this.MinimumDelayLabel.TabIndex = 7;
			this.MinimumDelayLabel.Text = "Minimum delay, sec";
			// 
			// AutomatedAnimationDelayNumericUpDown
			// 
			this.AutomatedAnimationDelayNumericUpDown.Enabled = false;
			this.AutomatedAnimationDelayNumericUpDown.Location = new System.Drawing.Point(163, 65);
			this.AutomatedAnimationDelayNumericUpDown.Name = "AutomatedAnimationDelayNumericUpDown";
			this.AutomatedAnimationDelayNumericUpDown.Size = new System.Drawing.Size(45, 20);
			this.AutomatedAnimationDelayNumericUpDown.TabIndex = 6;
			// 
			// AutomateAnimationCheckBox
			// 
			this.AutomateAnimationCheckBox.AutoSize = true;
			this.AutomateAnimationCheckBox.Enabled = false;
			this.AutomateAnimationCheckBox.Location = new System.Drawing.Point(9, 66);
			this.AutomateAnimationCheckBox.Name = "AutomateAnimationCheckBox";
			this.AutomateAnimationCheckBox.Size = new System.Drawing.Size(119, 17);
			this.AutomateAnimationCheckBox.TabIndex = 2;
			this.AutomateAnimationCheckBox.Text = "Automate animation";
			this.AutomateAnimationCheckBox.UseVisualStyleBackColor = true;
			this.AutomateAnimationCheckBox.CheckedChanged += new System.EventHandler(this.AutomateAnimationCheckBox_CheckedChanged);
			// 
			// PlayNonStopSettingsGroupBox
			// 
			this.PlayNonStopSettingsGroupBox.Controls.Add(this.SlideToSlidePauseUpDown);
			this.PlayNonStopSettingsGroupBox.Controls.Add(this.SlidePauseLabel);
			this.PlayNonStopSettingsGroupBox.Controls.Add(this.SlideToSlideModeCheckBox);
			this.PlayNonStopSettingsGroupBox.Location = new System.Drawing.Point(264, 16);
			this.PlayNonStopSettingsGroupBox.Name = "PlayNonStopSettingsGroupBox";
			this.PlayNonStopSettingsGroupBox.Size = new System.Drawing.Size(145, 80);
			this.PlayNonStopSettingsGroupBox.TabIndex = 8;
			this.PlayNonStopSettingsGroupBox.TabStop = false;
			this.PlayNonStopSettingsGroupBox.Text = "Play none stop settings";
			// 
			// SlideToSlidePauseUpDown
			// 
			this.SlideToSlidePauseUpDown.Enabled = false;
			this.SlideToSlidePauseUpDown.Increment = new decimal(new int[] {
            5,
            0,
            0,
            0});
			this.SlideToSlidePauseUpDown.Location = new System.Drawing.Point(100, 46);
			this.SlideToSlidePauseUpDown.Maximum = new decimal(new int[] {
            20,
            0,
            0,
            0});
			this.SlideToSlidePauseUpDown.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
			this.SlideToSlidePauseUpDown.Name = "SlideToSlidePauseUpDown";
			this.SlideToSlidePauseUpDown.Size = new System.Drawing.Size(37, 20);
			this.SlideToSlidePauseUpDown.TabIndex = 2;
			this.SlideToSlidePauseUpDown.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
			// 
			// SlidePauseLabel
			// 
			this.SlidePauseLabel.AutoSize = true;
			this.SlidePauseLabel.Location = new System.Drawing.Point(6, 48);
			this.SlidePauseLabel.Name = "SlidePauseLabel";
			this.SlidePauseLabel.Size = new System.Drawing.Size(85, 13);
			this.SlidePauseLabel.TabIndex = 1;
			this.SlidePauseLabel.Text = "Slide pause, sec";
			// 
			// MainForm
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(435, 671);
			this.Controls.Add(this.AnimationGroupBox);
			this.Controls.Add(this.PreviewGroupBox);
			this.Controls.Add(this.AdditionalSettingsGroupBox);
			this.Controls.Add(this.ThumbnailsGroupBox);
			this.Controls.Add(this.BaseConvertionOptionsGroupBox);
			this.Controls.Add(this.HelpLabel);
			this.Controls.Add(this.Ppt2SwfSdkLabel);
			this.Controls.Add(this.OutputDirectoryButton);
			this.Controls.Add(this.ConvertToDirectoryTextBox);
			this.Controls.Add(this.ConvertToDirectoryLabel);
			this.Controls.Add(this.SelectPresentationButton);
			this.Controls.Add(this.PowerPointFileTextBox);
			this.Controls.Add(this.PowerPointPresentationLabel);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.Icon = ((System.Drawing.Icon) (resources.GetObject("$this.Icon")));
			this.MaximizeBox = false;
			this.MinimizeBox = false;
			this.Name = "MainForm";
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
			this.Text = "Ppt2SwfSDK - Sample Convertor";
			this.Load += new System.EventHandler(this.Form1_Load);
			this.BaseConvertionOptionsGroupBox.ResumeLayout(false);
			this.BaseConvertionOptionsGroupBox.PerformLayout();
			this.ImageQualityGroupBox.ResumeLayout(false);
			this.ImageQualityGroupBox.PerformLayout();
			((System.ComponentModel.ISupportInitialize) (this.ImageQualityTrackBar)).EndInit();
			this.SpecifiedSlidesGroupBox.ResumeLayout(false);
			this.SpecifiedSlidesGroupBox.PerformLayout();
			((System.ComponentModel.ISupportInitialize) (this.ScaleYNumericUpdown)).EndInit();
			((System.ComponentModel.ISupportInitialize) (this.ScaleXNumericUpdown)).EndInit();
			this.ThumbnailsGroupBox.ResumeLayout(false);
			this.ThumbnailsGroupBox.PerformLayout();
			this.ThumbnailsSpecifiedSlidesGroupBox.ResumeLayout(false);
			this.ThumbnailsSpecifiedSlidesGroupBox.PerformLayout();
			this.AdditionalSettingsGroupBox.ResumeLayout(false);
			this.AdditionalSettingsGroupBox.PerformLayout();
			this.PreviewGroupBox.ResumeLayout(false);
			this.AnimationGroupBox.ResumeLayout(false);
			this.AnimationGroupBox.PerformLayout();
			((System.ComponentModel.ISupportInitialize) (this.AutomatedAnimationDelayNumericUpDown)).EndInit();
			this.PlayNonStopSettingsGroupBox.ResumeLayout(false);
			this.PlayNonStopSettingsGroupBox.PerformLayout();
			((System.ComponentModel.ISupportInitialize) (this.SlideToSlidePauseUpDown)).EndInit();
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.Label PowerPointPresentationLabel;
		private System.Windows.Forms.TextBox PowerPointFileTextBox;
		private System.Windows.Forms.OpenFileDialog PresentationOpenFileDialog;
		private System.Windows.Forms.Button SelectPresentationButton;
		private System.Windows.Forms.FolderBrowserDialog SaveSwfFolderBrowserDialog;
		private System.Windows.Forms.Label ConvertToDirectoryLabel;
		private System.Windows.Forms.TextBox ConvertToDirectoryTextBox;
		private System.Windows.Forms.Button OutputDirectoryButton;
		private System.Windows.Forms.LinkLabel Ppt2SwfSdkLabel;
		private System.Windows.Forms.LinkLabel HelpLabel;
		private System.Windows.Forms.GroupBox BaseConvertionOptionsGroupBox;
		private System.Windows.Forms.NumericUpDown ScaleYNumericUpdown;
		private System.Windows.Forms.Label ScaleYLabel;
		private System.Windows.Forms.NumericUpDown ScaleXNumericUpdown;
		private System.Windows.Forms.Label ScaleXLabel;
		private System.Windows.Forms.CheckBox EachSlideIntoSeparateSwfCheckBox;
		private System.Windows.Forms.TextBox SwfOutputFilenameTextBox;
		private System.Windows.Forms.Label SwfOutputFilenameLabel;
		private System.Windows.Forms.Button ConvertPpt2SwfButton;
		private System.Windows.Forms.GroupBox ThumbnailsGroupBox;
		private System.Windows.Forms.TextBox ThumbnailSlidesHtmlTextBox;
		private System.Windows.Forms.TextBox ThumbnailStartFileTextBox;
		private System.Windows.Forms.Label ThumbnailsStartFileLabel;
		private System.Windows.Forms.ComboBox ThumbailFormatComboBox;
		private System.Windows.Forms.Label ImageFormatLabel;
		private System.Windows.Forms.Label SlidesWrapperNameLabel;
		private System.Windows.Forms.Button ConvertThumbnailsButton;
		private System.Windows.Forms.GroupBox AdditionalSettingsGroupBox;
		private System.Windows.Forms.CheckBox ConvertTransitionsCheckBox;
		private System.Windows.Forms.CheckBox ConvertAnimationCheckBox;
		private System.Windows.Forms.CheckBox SlideToSlideModeCheckBox;
		private System.Windows.Forms.CheckBox BaseOptionRangeConvertCheckBox;
		private System.Windows.Forms.GroupBox SpecifiedSlidesGroupBox;
		private System.Windows.Forms.Label BaseStartSlideLabel;
		private System.Windows.Forms.TextBox BaseStartSlideTextBox;
		private System.Windows.Forms.Label BaseEndSlideLabel;
		private System.Windows.Forms.TextBox BaseEndSlideTextBox;
		private System.Windows.Forms.CheckBox ThumbailsRangeOnlyCheckBox;
		private System.Windows.Forms.GroupBox ThumbnailsSpecifiedSlidesGroupBox;
		private System.Windows.Forms.Label ThumbnailsStartSlideLabel;
		private System.Windows.Forms.TextBox ThumbnailsStartSlideTextBox;
		private System.Windows.Forms.Label ThumbnailsEndSlideLabel;
		private System.Windows.Forms.TextBox ThumbnailsEndSlideTextBox;
		private System.Windows.Forms.GroupBox PreviewGroupBox;
		private System.Windows.Forms.Button InternetExplorerButton;
		private System.Windows.Forms.Button DefaultBrowserButton;
		private System.Windows.Forms.CheckBox GenerateXmlCheckBox;
		private System.Windows.Forms.CheckBox CloseStatusWindowCloseCheckBox;
		private System.Windows.Forms.CheckBox LoopCheckBox;
		private System.Windows.Forms.CheckBox ConvertToExeCheckBox;
		private System.Windows.Forms.CheckBox EffectOnClickCheckBox;
		private System.Windows.Forms.Button DefaultHandlerButton;
		private System.Windows.Forms.CheckBox QuickPreviewCheckBox;
		private System.Windows.Forms.Button GenerateThumbnailSlidesButton;
		private System.Windows.Forms.GroupBox AnimationGroupBox;
		private System.Windows.Forms.GroupBox PlayNonStopSettingsGroupBox;
		private System.Windows.Forms.Label SlidePauseLabel;
		private System.Windows.Forms.NumericUpDown SlideToSlidePauseUpDown;
		private System.Windows.Forms.CheckBox AutomateAnimationCheckBox;
		private System.Windows.Forms.NumericUpDown AutomatedAnimationDelayNumericUpDown;
		private System.Windows.Forms.Label MinimumDelayLabel;
		private System.Windows.Forms.TrackBar ImageQualityTrackBar;
		private System.Windows.Forms.CheckBox DefaultImageQualityCheckBox;
		private System.Windows.Forms.GroupBox ImageQualityGroupBox;
		private System.Windows.Forms.Label WorstQualityLabel;
		private System.Windows.Forms.Label BestQualityLabel;
	}
}