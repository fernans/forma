namespace Ppt2SwfSampleCSharpNS
{
    partial class StatusWindow
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

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
			this.lShape = new System.Windows.Forms.Label();
			this.ShapesProgressBar = new System.Windows.Forms.ProgressBar();
			this.label4 = new System.Windows.Forms.Label();
			this.label3 = new System.Windows.Forms.Label();
			this.lSlide = new System.Windows.Forms.Label();
			this.progressBar1 = new System.Windows.Forms.ProgressBar();
			this.richTextBox1 = new System.Windows.Forms.RichTextBox();
			this.richTextBox2 = new System.Windows.Forms.RichTextBox();
			this.stopConvertionButton = new System.Windows.Forms.Button();
			this.SuspendLayout();
			// 
			// lShape
			// 
			this.lShape.AutoSize = true;
			this.lShape.Location = new System.Drawing.Point(192, 46);
			this.lShape.Name = "lShape";
			this.lShape.Size = new System.Drawing.Size(26, 13);
			this.lShape.TabIndex = 21;
			this.lShape.Text = "#/#";
			// 
			// ShapesProgressBar
			// 
			this.ShapesProgressBar.Location = new System.Drawing.Point(64, 46);
			this.ShapesProgressBar.Name = "ShapesProgressBar";
			this.ShapesProgressBar.Size = new System.Drawing.Size(123, 13);
			this.ShapesProgressBar.TabIndex = 20;
			// 
			// label4
			// 
			this.label4.AutoSize = true;
			this.label4.Location = new System.Drawing.Point(12, 46);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(46, 13);
			this.label4.TabIndex = 19;
			this.label4.Text = "Shapes:";
			// 
			// label3
			// 
			this.label3.AutoSize = true;
			this.label3.Location = new System.Drawing.Point(12, 19);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(38, 13);
			this.label3.TabIndex = 18;
			this.label3.Text = "Slides:";
			// 
			// lSlide
			// 
			this.lSlide.AutoSize = true;
			this.lSlide.Location = new System.Drawing.Point(193, 20);
			this.lSlide.Name = "lSlide";
			this.lSlide.Size = new System.Drawing.Size(26, 13);
			this.lSlide.TabIndex = 17;
			this.lSlide.Text = "#/#";
			// 
			// progressBar1
			// 
			this.progressBar1.Location = new System.Drawing.Point(64, 20);
			this.progressBar1.Margin = new System.Windows.Forms.Padding(2);
			this.progressBar1.Name = "progressBar1";
			this.progressBar1.Size = new System.Drawing.Size(124, 13);
			this.progressBar1.Step = 1;
			this.progressBar1.TabIndex = 16;
			// 
			// richTextBox1
			// 
			this.richTextBox1.Anchor = ((System.Windows.Forms.AnchorStyles) ((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
						| System.Windows.Forms.AnchorStyles.Left)
						| System.Windows.Forms.AnchorStyles.Right)));
			this.richTextBox1.AutoWordSelection = true;
			this.richTextBox1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.richTextBox1.Location = new System.Drawing.Point(12, 93);
			this.richTextBox1.Name = "richTextBox1";
			this.richTextBox1.ReadOnly = true;
			this.richTextBox1.Size = new System.Drawing.Size(356, 133);
			this.richTextBox1.TabIndex = 22;
			this.richTextBox1.Text = "";
			// 
			// richTextBox2
			// 
			this.richTextBox2.Anchor = ((System.Windows.Forms.AnchorStyles) ((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
						| System.Windows.Forms.AnchorStyles.Left)
						| System.Windows.Forms.AnchorStyles.Right)));
			this.richTextBox2.AutoWordSelection = true;
			this.richTextBox2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
			this.richTextBox2.Location = new System.Drawing.Point(12, 232);
			this.richTextBox2.Name = "richTextBox2";
			this.richTextBox2.ReadOnly = true;
			this.richTextBox2.Size = new System.Drawing.Size(356, 162);
			this.richTextBox2.TabIndex = 23;
			this.richTextBox2.Text = "";
			// 
			// stopConvertionButton
			// 
			this.stopConvertionButton.Anchor = ((System.Windows.Forms.AnchorStyles) ((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
			this.stopConvertionButton.DialogResult = System.Windows.Forms.DialogResult.Cancel;
			this.stopConvertionButton.Location = new System.Drawing.Point(250, 20);
			this.stopConvertionButton.Name = "stopConvertionButton";
			this.stopConvertionButton.Size = new System.Drawing.Size(118, 23);
			this.stopConvertionButton.TabIndex = 72;
			this.stopConvertionButton.Text = "Cancel";
			this.stopConvertionButton.UseVisualStyleBackColor = true;
			this.stopConvertionButton.Click += new System.EventHandler(this.stopConvertionButton_Click);
			// 
			// StatusWindow
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.CancelButton = this.stopConvertionButton;
			this.ClientSize = new System.Drawing.Size(380, 397);
			this.Controls.Add(this.stopConvertionButton);
			this.Controls.Add(this.richTextBox2);
			this.Controls.Add(this.richTextBox1);
			this.Controls.Add(this.lShape);
			this.Controls.Add(this.ShapesProgressBar);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.lSlide);
			this.Controls.Add(this.progressBar1);
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
			this.MaximizeBox = false;
			this.MinimizeBox = false;
			this.Name = "StatusWindow";
			this.ShowInTaskbar = false;
			this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
			this.Text = "Preparing slides...";
			this.ResumeLayout(false);
			this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label lShape;
        private System.Windows.Forms.ProgressBar ShapesProgressBar;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label lSlide;
        private System.Windows.Forms.ProgressBar progressBar1;
        private System.Windows.Forms.RichTextBox richTextBox1;
        private System.Windows.Forms.RichTextBox richTextBox2;
        private System.Windows.Forms.Button stopConvertionButton;

    }
}