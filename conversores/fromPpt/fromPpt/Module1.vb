Imports System
Imports System.IO
Imports Ppt2SwfSdk.Converters
Imports Ppt2SwfSdk.Interfaces

Module Module1

    Function Main() As Integer
        Dim argc As Integer = My.Application.CommandLineArgs.Count
        If argc <> 2 And argc <> 4 Then
            System.Console.WriteLine("Usage: " + vbNewLine + "<inputfile> <outputPath> [width height]" + vbNewLine)
            System.Console.WriteLine(vbTab + vbTab + "defaults: width=1024, height=768")
            Return 0
        End If

        Dim inputFile As String = Path.Combine(My.Application.Info.DirectoryPath, My.Application.CommandLineArgs(0)) 'input ppt file
        Dim savePath As String = My.Application.CommandLineArgs(1)  'output path (folder)

        If ((savePath = "") OrElse (savePath Is Nothing)) Then
            System.Console.WriteLine("Incorrect output path")
            Return -1
        End If

        ' set up license
        Ppt2SwfConverter.LicenseKey = "d7a840e5fcf31f1b72f86a55e3dbfba0"
        Ppt2SwfConverter.LicenseUser = "Diego Avendano"

        ' create object (to configure out)
        Dim thumbnailProd As New ThumbnailProducer

        If (argc > 2) Then
            Dim w As Integer = Integer.Parse((My.Application.CommandLineArgs(2)).ToString)
            Dim h As Integer = Integer.Parse((My.Application.CommandLineArgs(3)).ToString)
            If w < 1 Or h < 1 Then
                System.Console.WriteLine("ERROR reescaling image")
                Return -1
            End If
            System.Console.Write("Reescaling to {0} x {1}" + vbNewLine, w, h)
            thumbnailProd.ScaleWidth() = w
            thumbnailProd.ScaleHeight() = h
        Else
            thumbnailProd.ScaleWidth = 1024
            thumbnailProd.ScaleHeight = 768
        End If

        thumbnailProd.PresentationPath = inputFile

        If Not Directory.Exists(savePath) Then
            Directory.CreateDirectory(savePath)
            System.Console.WriteLine("output path created!")
        End If
        thumbnailProd.OutputDirectory = savePath
        thumbnailProd.IndexHTMLName = "none.html"

        thumbnailProd.ImageFormat = "JPG"
        thumbnailProd.SlidesHTMLName = "none2.html"
        Try
            System.Console.WriteLine("Process started...")
            thumbnailProd.Produce()
        Catch expn As Exception
            System.Console.WriteLine("ERROR producing output ")
            Return -1
        End Try

        'eliminando archivos innecesarios (html)
        File.Delete(Path.Combine(savePath, "none.html"))
        File.Delete(Path.Combine(savePath, "none2.html"))
        Dim numImages As Integer = My.Computer.FileSystem.GetFiles(savePath).Count
        System.Console.Write("{0} Images succefully saved!" + vbNewLine, numImages)
        Stop
        Return numImages

    End Function

End Module
