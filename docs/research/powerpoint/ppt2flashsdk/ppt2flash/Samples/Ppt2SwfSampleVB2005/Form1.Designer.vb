<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Form1
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing AndAlso components IsNot Nothing Then
            components.Dispose()
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.swfTabPage = New System.Windows.Forms.TabPage
        Me.swfFileNameTextBox = New System.Windows.Forms.TextBox
        Me.swfFileNameLabel = New System.Windows.Forms.Label
        Me.convertSwfButton = New System.Windows.Forms.Button
        Me.slidesNameTextBox = New System.Windows.Forms.TextBox
        Me.indexHtmlTextBox = New System.Windows.Forms.TextBox
        Me.label2 = New System.Windows.Forms.Label
        Me.linkLabel2 = New System.Windows.Forms.LinkLabel
        Me.linkLabel1 = New System.Windows.Forms.LinkLabel
        Me.tabControl1 = New System.Windows.Forms.TabControl
        Me.htmlTabPage = New System.Windows.Forms.TabPage
        Me.formatsComboBox = New System.Windows.Forms.ComboBox
        Me.button2 = New System.Windows.Forms.Button
        Me.label3 = New System.Windows.Forms.Label
        Me.ImageFormatLabel = New System.Windows.Forms.Label
        Me.openSaveSwfFolderDialog = New System.Windows.Forms.FolderBrowserDialog
        Me.label1 = New System.Windows.Forms.Label
        Me.selectPptButton = New System.Windows.Forms.Button
        Me.fileNameLabel = New System.Windows.Forms.Label
        Me.pptOpenFilePathTextBox = New System.Windows.Forms.TextBox
        Me.openPptFileDialog = New System.Windows.Forms.OpenFileDialog
        Me.swfSaveFilePathTextBox = New System.Windows.Forms.TextBox
        Me.selectSaveSwfFolderButton = New System.Windows.Forms.Button
        Me.PreviewGroupBox = New System.Windows.Forms.GroupBox
        Me.Button1 = New System.Windows.Forms.Button
        Me.Button3 = New System.Windows.Forms.Button
        Me.Button4 = New System.Windows.Forms.Button
        Me.swfTabPage.SuspendLayout()
        Me.tabControl1.SuspendLayout()
        Me.htmlTabPage.SuspendLayout()
        Me.PreviewGroupBox.SuspendLayout()
        Me.SuspendLayout()
        '
        'swfTabPage
        '
        Me.swfTabPage.Controls.Add(Me.PreviewGroupBox)
        Me.swfTabPage.Controls.Add(Me.swfFileNameTextBox)
        Me.swfTabPage.Controls.Add(Me.swfFileNameLabel)
        Me.swfTabPage.Controls.Add(Me.convertSwfButton)
        Me.swfTabPage.Location = New System.Drawing.Point(4, 22)
        Me.swfTabPage.Name = "swfTabPage"
        Me.swfTabPage.Padding = New System.Windows.Forms.Padding(3)
        Me.swfTabPage.Size = New System.Drawing.Size(411, 165)
        Me.swfTabPage.TabIndex = 0
        Me.swfTabPage.Text = "SWF"
        Me.swfTabPage.UseVisualStyleBackColor = True
        '
        'swfFileNameTextBox
        '
        Me.swfFileNameTextBox.Location = New System.Drawing.Point(115, 23)
        Me.swfFileNameTextBox.Name = "swfFileNameTextBox"
        Me.swfFileNameTextBox.Size = New System.Drawing.Size(189, 20)
        Me.swfFileNameTextBox.TabIndex = 5
        Me.swfFileNameTextBox.Text = "file.swf"
        '
        'swfFileNameLabel
        '
        Me.swfFileNameLabel.AutoSize = True
        Me.swfFileNameLabel.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(204, Byte))
        Me.swfFileNameLabel.Location = New System.Drawing.Point(6, 23)
        Me.swfFileNameLabel.Name = "swfFileNameLabel"
        Me.swfFileNameLabel.Size = New System.Drawing.Size(98, 15)
        Me.swfFileNameLabel.TabIndex = 4
        Me.swfFileNameLabel.Text = "Swf file name:"
        '
        'convertSwfButton
        '
        Me.convertSwfButton.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.convertSwfButton.Location = New System.Drawing.Point(293, 142)
        Me.convertSwfButton.Name = "convertSwfButton"
        Me.convertSwfButton.Size = New System.Drawing.Size(118, 23)
        Me.convertSwfButton.TabIndex = 1
        Me.convertSwfButton.Text = "Convert"
        Me.convertSwfButton.UseVisualStyleBackColor = True
        '
        'slidesNameTextBox
        '
        Me.slidesNameTextBox.Location = New System.Drawing.Point(124, 107)
        Me.slidesNameTextBox.Name = "slidesNameTextBox"
        Me.slidesNameTextBox.Size = New System.Drawing.Size(119, 20)
        Me.slidesNameTextBox.TabIndex = 10
        Me.slidesNameTextBox.Text = "Slides.html"
        '
        'indexHtmlTextBox
        '
        Me.indexHtmlTextBox.Location = New System.Drawing.Point(124, 64)
        Me.indexHtmlTextBox.Name = "indexHtmlTextBox"
        Me.indexHtmlTextBox.Size = New System.Drawing.Size(119, 20)
        Me.indexHtmlTextBox.TabIndex = 6
        Me.indexHtmlTextBox.Text = "index.html"
        '
        'label2
        '
        Me.label2.AutoSize = True
        Me.label2.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(204, Byte))
        Me.label2.Location = New System.Drawing.Point(6, 107)
        Me.label2.Name = "label2"
        Me.label2.Size = New System.Drawing.Size(91, 15)
        Me.label2.TabIndex = 9
        Me.label2.Text = "Slides name:"
        '
        'linkLabel2
        '
        Me.linkLabel2.AutoSize = True
        Me.linkLabel2.Location = New System.Drawing.Point(389, 282)
        Me.linkLabel2.Name = "linkLabel2"
        Me.linkLabel2.Size = New System.Drawing.Size(29, 13)
        Me.linkLabel2.TabIndex = 18
        Me.linkLabel2.TabStop = True
        Me.linkLabel2.Text = "Help"
        '
        'linkLabel1
        '
        Me.linkLabel1.AutoSize = True
        Me.linkLabel1.Location = New System.Drawing.Point(4, 282)
        Me.linkLabel1.Name = "linkLabel1"
        Me.linkLabel1.Size = New System.Drawing.Size(147, 13)
        Me.linkLabel1.TabIndex = 17
        Me.linkLabel1.TabStop = True
        Me.linkLabel1.Text = "http://www.Ppt2FlashSdk.com"
        '
        'tabControl1
        '
        Me.tabControl1.Controls.Add(Me.swfTabPage)
        Me.tabControl1.Controls.Add(Me.htmlTabPage)
        Me.tabControl1.Location = New System.Drawing.Point(3, 88)
        Me.tabControl1.Name = "tabControl1"
        Me.tabControl1.SelectedIndex = 0
        Me.tabControl1.Size = New System.Drawing.Size(419, 191)
        Me.tabControl1.TabIndex = 13
        '
        'htmlTabPage
        '
        Me.htmlTabPage.Controls.Add(Me.formatsComboBox)
        Me.htmlTabPage.Controls.Add(Me.slidesNameTextBox)
        Me.htmlTabPage.Controls.Add(Me.indexHtmlTextBox)
        Me.htmlTabPage.Controls.Add(Me.label2)
        Me.htmlTabPage.Controls.Add(Me.button2)
        Me.htmlTabPage.Controls.Add(Me.label3)
        Me.htmlTabPage.Controls.Add(Me.ImageFormatLabel)
        Me.htmlTabPage.Location = New System.Drawing.Point(4, 22)
        Me.htmlTabPage.Name = "htmlTabPage"
        Me.htmlTabPage.Padding = New System.Windows.Forms.Padding(3)
        Me.htmlTabPage.Size = New System.Drawing.Size(411, 165)
        Me.htmlTabPage.TabIndex = 1
        Me.htmlTabPage.Text = "Html"
        Me.htmlTabPage.UseVisualStyleBackColor = True
        '
        'formatsComboBox
        '
        Me.formatsComboBox.FormattingEnabled = True
        Me.formatsComboBox.Items.AddRange(New Object() {"JPG", "BMP", "GIF"})
        Me.formatsComboBox.Location = New System.Drawing.Point(124, 17)
        Me.formatsComboBox.Name = "formatsComboBox"
        Me.formatsComboBox.Size = New System.Drawing.Size(59, 21)
        Me.formatsComboBox.TabIndex = 11
        '
        'button2
        '
        Me.button2.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.button2.Location = New System.Drawing.Point(294, 142)
        Me.button2.Name = "button2"
        Me.button2.Size = New System.Drawing.Size(117, 23)
        Me.button2.TabIndex = 7
        Me.button2.Text = "Convert"
        Me.button2.UseVisualStyleBackColor = True
        '
        'label3
        '
        Me.label3.AutoSize = True
        Me.label3.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(204, Byte))
        Me.label3.Location = New System.Drawing.Point(6, 65)
        Me.label3.Name = "label3"
        Me.label3.Size = New System.Drawing.Size(65, 15)
        Me.label3.TabIndex = 5
        Me.label3.Text = "Start file:"
        '
        'ImageFormatLabel
        '
        Me.ImageFormatLabel.AutoSize = True
        Me.ImageFormatLabel.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(204, Byte))
        Me.ImageFormatLabel.Location = New System.Drawing.Point(6, 23)
        Me.ImageFormatLabel.Name = "ImageFormatLabel"
        Me.ImageFormatLabel.Size = New System.Drawing.Size(96, 15)
        Me.ImageFormatLabel.TabIndex = 3
        Me.ImageFormatLabel.Text = "Image format:"
        '
        'label1
        '
        Me.label1.AutoSize = True
        Me.label1.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(204, Byte))
        Me.label1.Location = New System.Drawing.Point(12, 39)
        Me.label1.Name = "label1"
        Me.label1.Size = New System.Drawing.Size(116, 15)
        Me.label1.TabIndex = 14
        Me.label1.Text = "Convert to folder:"
        '
        'selectPptButton
        '
        Me.selectPptButton.Location = New System.Drawing.Point(382, 5)
        Me.selectPptButton.Name = "selectPptButton"
        Me.selectPptButton.Size = New System.Drawing.Size(40, 23)
        Me.selectPptButton.TabIndex = 12
        Me.selectPptButton.Text = "..."
        Me.selectPptButton.UseVisualStyleBackColor = True
        '
        'fileNameLabel
        '
        Me.fileNameLabel.AutoSize = True
        Me.fileNameLabel.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(204, Byte))
        Me.fileNameLabel.Location = New System.Drawing.Point(12, 9)
        Me.fileNameLabel.Name = "fileNameLabel"
        Me.fileNameLabel.Size = New System.Drawing.Size(158, 15)
        Me.fileNameLabel.TabIndex = 10
        Me.fileNameLabel.Text = "Presentation to convert:"
        '
        'pptOpenFilePathTextBox
        '
        Me.pptOpenFilePathTextBox.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.pptOpenFilePathTextBox.Location = New System.Drawing.Point(177, 8)
        Me.pptOpenFilePathTextBox.Name = "pptOpenFilePathTextBox"
        Me.pptOpenFilePathTextBox.Size = New System.Drawing.Size(199, 20)
        Me.pptOpenFilePathTextBox.TabIndex = 11
        '
        'openPptFileDialog
        '
        Me.openPptFileDialog.Filter = "PowerPoint Files(*.ppt; *.pptx;)|*.ppt; *.pptx;"
        Me.openPptFileDialog.InitialDirectory = "c:\apps\ppt2swf\ppts"
        Me.openPptFileDialog.RestoreDirectory = True
        Me.openPptFileDialog.Title = "Pick a PowerPoint file"
        '
        'swfSaveFilePathTextBox
        '
        Me.swfSaveFilePathTextBox.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.swfSaveFilePathTextBox.Location = New System.Drawing.Point(177, 38)
        Me.swfSaveFilePathTextBox.Name = "swfSaveFilePathTextBox"
        Me.swfSaveFilePathTextBox.Size = New System.Drawing.Size(199, 20)
        Me.swfSaveFilePathTextBox.TabIndex = 15
        '
        'selectSaveSwfFolderButton
        '
        Me.selectSaveSwfFolderButton.Location = New System.Drawing.Point(383, 36)
        Me.selectSaveSwfFolderButton.Name = "selectSaveSwfFolderButton"
        Me.selectSaveSwfFolderButton.Size = New System.Drawing.Size(39, 23)
        Me.selectSaveSwfFolderButton.TabIndex = 16
        Me.selectSaveSwfFolderButton.Text = "..."
        Me.selectSaveSwfFolderButton.UseVisualStyleBackColor = True
        '
        'PreviewGroupBox
        '
        Me.PreviewGroupBox.Controls.Add(Me.Button4)
        Me.PreviewGroupBox.Controls.Add(Me.Button3)
        Me.PreviewGroupBox.Controls.Add(Me.Button1)
        Me.PreviewGroupBox.Location = New System.Drawing.Point(8, 49)
        Me.PreviewGroupBox.Name = "PreviewGroupBox"
        Me.PreviewGroupBox.Size = New System.Drawing.Size(397, 53)
        Me.PreviewGroupBox.TabIndex = 6
        Me.PreviewGroupBox.TabStop = False
        Me.PreviewGroupBox.Text = "Preview"
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(7, 19)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(106, 23)
        Me.Button1.TabIndex = 0
        Me.Button1.Text = "Default handler"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'Button3
        '
        Me.Button3.Location = New System.Drawing.Point(145, 19)
        Me.Button3.Name = "Button3"
        Me.Button3.Size = New System.Drawing.Size(107, 23)
        Me.Button3.TabIndex = 0
        Me.Button3.Text = "Default browser"
        Me.Button3.UseVisualStyleBackColor = True
        '
        'Button4
        '
        Me.Button4.Location = New System.Drawing.Point(284, 19)
        Me.Button4.Name = "Button4"
        Me.Button4.Size = New System.Drawing.Size(107, 23)
        Me.Button4.TabIndex = 0
        Me.Button4.Text = "Internet Explorer"
        Me.Button4.UseVisualStyleBackColor = True
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(433, 304)
        Me.Controls.Add(Me.linkLabel2)
        Me.Controls.Add(Me.linkLabel1)
        Me.Controls.Add(Me.tabControl1)
        Me.Controls.Add(Me.label1)
        Me.Controls.Add(Me.selectPptButton)
        Me.Controls.Add(Me.fileNameLabel)
        Me.Controls.Add(Me.pptOpenFilePathTextBox)
        Me.Controls.Add(Me.swfSaveFilePathTextBox)
        Me.Controls.Add(Me.selectSaveSwfFolderButton)
        Me.MaximumSize = New System.Drawing.Size(441, 338)
        Me.MinimumSize = New System.Drawing.Size(441, 338)
        Me.Name = "Form1"
        Me.Text = "Ppt2SwfSDK - Sample Convertor"
        Me.swfTabPage.ResumeLayout(False)
        Me.swfTabPage.PerformLayout()
        Me.tabControl1.ResumeLayout(False)
        Me.htmlTabPage.ResumeLayout(False)
        Me.htmlTabPage.PerformLayout()
        Me.PreviewGroupBox.ResumeLayout(False)
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Private WithEvents swfTabPage As System.Windows.Forms.TabPage
    Private WithEvents swfFileNameTextBox As System.Windows.Forms.TextBox
    Private WithEvents swfFileNameLabel As System.Windows.Forms.Label
    Private WithEvents convertSwfButton As System.Windows.Forms.Button
    Private WithEvents slidesNameTextBox As System.Windows.Forms.TextBox
    Private WithEvents indexHtmlTextBox As System.Windows.Forms.TextBox
    Private WithEvents label2 As System.Windows.Forms.Label
    Private WithEvents linkLabel2 As System.Windows.Forms.LinkLabel
    Private WithEvents linkLabel1 As System.Windows.Forms.LinkLabel
    Private WithEvents tabControl1 As System.Windows.Forms.TabControl
    Private WithEvents htmlTabPage As System.Windows.Forms.TabPage
    Private WithEvents button2 As System.Windows.Forms.Button
    Private WithEvents label3 As System.Windows.Forms.Label
    Private WithEvents ImageFormatLabel As System.Windows.Forms.Label
    Private WithEvents openSaveSwfFolderDialog As System.Windows.Forms.FolderBrowserDialog
    Private WithEvents label1 As System.Windows.Forms.Label
    Private WithEvents selectPptButton As System.Windows.Forms.Button
    Private WithEvents fileNameLabel As System.Windows.Forms.Label
    Private WithEvents pptOpenFilePathTextBox As System.Windows.Forms.TextBox
    Private WithEvents openPptFileDialog As System.Windows.Forms.OpenFileDialog
    Private WithEvents swfSaveFilePathTextBox As System.Windows.Forms.TextBox
    Private WithEvents selectSaveSwfFolderButton As System.Windows.Forms.Button
    Friend WithEvents formatsComboBox As System.Windows.Forms.ComboBox
    Friend WithEvents PreviewGroupBox As System.Windows.Forms.GroupBox
    Friend WithEvents Button4 As System.Windows.Forms.Button
    Friend WithEvents Button3 As System.Windows.Forms.Button
    Friend WithEvents Button1 As System.Windows.Forms.Button

End Class
