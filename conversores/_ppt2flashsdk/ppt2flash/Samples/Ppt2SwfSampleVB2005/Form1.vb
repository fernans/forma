Imports System
Imports System.IO
Imports System.Windows.Forms
Imports Ppt2SwfSdk.Converters
Imports Ppt2SwfSdk.Interfaces




Public Class Form1

    Public Function checkFileName(ByVal fileName As String) As Boolean
        Dim fileParts As String() = fileName.Split(New Char() {"."c})
        If (fileParts(fileParts.Length - 1).ToLower = "swf") Then
            Return True
        End If
        Return False
    End Function



    Public Function correctIndexFileName(ByVal indexFileName As String) As Boolean
        Dim fileParts As String() = indexFileName.Split(New Char() {"."c})
        If (fileParts.Length > 2) Then
            Return False
        End If
        If (fileParts(1).ToLower <> "html") Then
            Return False
        End If
        Return True
    End Function



    Private Sub selectPptButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles selectPptButton.Click
        If Not Directory.Exists(Me.openPptFileDialog.InitialDirectory) Then
            Me.openPptFileDialog.InitialDirectory = Directory.GetCurrentDirectory
        End If
        If (Me.openPptFileDialog.ShowDialog = DialogResult.OK) Then
            Me.pptOpenFilePathTextBox.Text = Me.openPptFileDialog.FileName
        End If
    End Sub

    Private Sub selectSaveSwfFolderButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles selectSaveSwfFolderButton.Click
        If (Me.openSaveSwfFolderDialog.ShowDialog = DialogResult.OK) Then
            Me.swfSaveFilePathTextBox.Text = Me.openSaveSwfFolderDialog.SelectedPath
        End If
    End Sub

    Private Sub convertSwfButton_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles convertSwfButton.Click
        If File.Exists(Me.pptOpenFilePathTextBox.Text) Then
            If Not Me.checkFileName(Me.swfFileNameTextBox.Text) Then
                MessageBox.Show("Incorrect .swf filename !", "Name Entry Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
                Return
            End If
            If (Me.swfSaveFilePathTextBox.Text Is Nothing) Then
                MessageBox.Show("Incorrect folder path to save .swf file !", "Folder Path Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
                Return
            End If
            Try
                If Not Directory.Exists(Me.swfSaveFilePathTextBox.Text) Then
                    Directory.CreateDirectory(Me.swfSaveFilePathTextBox.Text)
                End If
            Catch expn As Exception
                Directory.CreateDirectory((Directory.GetCurrentDirectory & "\Converted"))
                Me.swfSaveFilePathTextBox.Text = (Directory.GetCurrentDirectory & "\Converted")
            End Try
            Dim conver As New Ppt2SwfConverter("")
            Ppt2SwfConverter.LicenseKey = "d7a840e5fcf31f1b72f86a55e3dbfba0"
            Ppt2SwfConverter.LicenseUser = "Diego Avendano"
            conver.PresentationPath = Me.openPptFileDialog.FileName
            conver.OutputDirectory = Me.swfSaveFilePathTextBox.Text
            conver.ConvertSlideAnimation = True
            conver.ConvertSlideTransitions = True
            conver.ConvertToExe = True
            conver.EffectOnClick = True
            conver.GenerateXml = True
            Try
                conver.Convert(Path.Combine(Me.swfSaveFilePathTextBox.Text, Me.swfFileNameTextBox.Text))
                Process.Start(Me.swfSaveFilePathTextBox.Text)
                Return
            Catch expn As Exception
                MessageBox.Show(("Power Point could not open current presentation: " & Me.pptOpenFilePathTextBox.Text), "Supporting .pptx Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
                Return
            End Try
        End If
        MessageBox.Show("Please select valid PowerPoint file", "File not found", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)


    End Sub

    Private Sub pptOpenFilePathTextBox_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles pptOpenFilePathTextBox.TextChanged
        Dim file As String = Path.GetFileNameWithoutExtension(Me.pptOpenFilePathTextBox.Text)
        Me.swfFileNameTextBox.Text = (file & ".swf")
        Me.swfSaveFilePathTextBox.Text = Path.Combine(Path.GetDirectoryName(Me.pptOpenFilePathTextBox.Text), "Converted")
    End Sub

    Private Sub button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button2.Click
        If Not Me.correctIndexFileName(Me.indexHtmlTextBox.Text) Then
            MessageBox.Show("Incorrect index .html  filename !", "Html  Filename Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
        ElseIf Not Me.correctIndexFileName(Me.slidesNameTextBox.Text) Then
            MessageBox.Show("Incorrect slides .html file name !", "Html  Filename Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
        ElseIf ((Me.swfSaveFilePathTextBox.Text = "") OrElse (Me.swfSaveFilePathTextBox.Text Is Nothing)) Then
            MessageBox.Show("Incorrect folder path to save .swf file !", "Folder Path Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
        Else
            'Dim conver As New Ppt2SwfConverter

            Ppt2SwfConverter.LicenseKey = "d7a840e5fcf31f1b72f86a55e3dbfba0"
            Ppt2SwfConverter.LicenseUser = "Diego Avendano"

            Dim thumbnailProd As New ThumbnailProducer

            thumbnailProd.ScaleWidth = 1024
            thumbnailProd.ScaleHeight = 768

            thumbnailProd.PresentationPath = Me.openPptFileDialog.FileName
            If Not Directory.Exists(Path.Combine(Me.swfSaveFilePathTextBox.Text, "thumbs")) Then
                Directory.CreateDirectory(Path.Combine(Me.swfSaveFilePathTextBox.Text, "thumbs"))
            End If
            thumbnailProd.OutputDirectory = Path.Combine(Me.swfSaveFilePathTextBox.Text, "thumbs")
            thumbnailProd.IndexHTMLName = Me.indexHtmlTextBox.Text
            If (Me.formatsComboBox.SelectedIndex = -1) Then
                MessageBox.Show("Image format not selected ", "Select combobox item Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
                Return
            End If
            thumbnailProd.ImageFormat = Me.formatsComboBox.SelectedItem.ToString
            thumbnailProd.SlidesHTMLName = Me.slidesNameTextBox.Text
            Try
                thumbnailProd.Produce()
                Process.Start(Me.swfSaveFilePathTextBox.Text)
            Catch expn As Exception
                MessageBox.Show(("Power Point could not open current presentation: " & Me.pptOpenFilePathTextBox.Text), "Supporting .pptx Error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
            End Try
        End If

    End Sub

    Private Sub linkLabel1_LinkClicked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles linkLabel1.LinkClicked
        Process.Start(Me.linkLabel1.Text)
    End Sub

    Private Sub linkLabel2_LinkClicked(ByVal sender As System.Object, ByVal e As System.Windows.Forms.LinkLabelLinkClickedEventArgs) Handles linkLabel2.LinkClicked
        If (File.Exists(Directory.GetCurrentDirectory & "\Ppt2SwfSDK.chm")) Then
            Process.Start((Directory.GetCurrentDirectory & "\Ppt2SwfSDK.chm"))
        Else
            MessageBox.Show("File of documentation does not exists", "File exists error", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
        End If
    End Sub

    Private Sub tabControl1_Selected(ByVal sender As System.Object, ByVal e As System.Windows.Forms.TabControlEventArgs) Handles tabControl1.Selected
        formatsComboBox.SelectedIndex = 0
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim swfFile As String : swfFile = swfSaveFilePathTextBox.Text + "\" + swfFileNameTextBox.Text
        If (File.Exists(swfFile)) Then
            Process.Start(swfFile)
        Else
            MessageBox.Show("The target file doesn't exist", String.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error)
        End If
    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click
        Dim htmlFilename As String
        htmlFilename = swfSaveFilePathTextBox.Text + "\" + swfFileNameTextBox.Text
        If (File.Exists(htmlFilename)) Then
            Process.Start(GetDefaultBrowserFilename, htmlFilename)
        Else
            MessageBox.Show("The target file doesn't exist", String.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error)
        End If
    End Sub

    Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button4.Click
        Dim htmlFilename As String
        htmlFilename = swfSaveFilePathTextBox.Text + "\" + swfFileNameTextBox.Text
        If (File.Exists(htmlFilename)) Then
            Process.Start("iexplore.exe", htmlFilename)
        Else
            MessageBox.Show("The target file doesn't exist", String.Empty, MessageBoxButtons.OK, MessageBoxIcon.Error)
        End If
    End Sub

    Private Function GetDefaultBrowserFilename() As String
        GetDefaultBrowserFilename = "iexplore.exe"
    End Function

    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()
        'Ppt2SwfConverter.LicenseKey = "d7a840e5fcf31f1b72f86a55e3dbfba0"
        'Ppt2SwfConverter.LicenseUser = "Diego Avendano"
        ' Add any initialization after the InitializeComponent() call.

    End Sub
End Class
