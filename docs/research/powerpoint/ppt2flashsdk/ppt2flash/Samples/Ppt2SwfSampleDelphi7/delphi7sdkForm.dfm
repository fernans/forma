object Form1: TForm1
  Left = 536
  Top = 253
  BorderStyle = bsToolWindow
  Caption = 'Ppt2SwfSDK - Sample Convertor'
  ClientHeight = 283
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    405
    283)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 138
    Height = 13
    Caption = 'Presentation to convert:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 100
    Height = 13
    Caption = 'Convert to folder:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pptFilePathEdit: TEdit
    Left = 152
    Top = 8
    Width = 193
    Height = 21
    TabOrder = 0
    OnChange = pptFilePathEditChange
  end
  object openFileDialogButton: TButton
    Left = 352
    Top = 8
    Width = 33
    Height = 25
    Caption = '...'
    TabOrder = 1
    OnClick = openFileDialogButtonClick
  end
  object folderConvertToEdit: TEdit
    Left = 152
    Top = 40
    Width = 193
    Height = 21
    TabOrder = 2
  end
  object openFolderDialogButton: TButton
    Left = 352
    Top = 40
    Width = 33
    Height = 25
    Caption = '...'
    TabOrder = 3
    OnClick = openFolderDialogButtonClick
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 80
    Width = 385
    Height = 193
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 4
    object TabSheet1: TTabSheet
      Caption = 'SWF'
      DesignSize = (
        377
        165)
      object Label3: TLabel
        Left = 8
        Top = 32
        Width = 81
        Height = 13
        Caption = 'Swf file name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object swfFileEdit: TEdit
        Left = 96
        Top = 32
        Width = 161
        Height = 21
        TabOrder = 0
      end
      object swfConvertButton: TButton
        Left = 280
        Top = 136
        Width = 91
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Convert'
        TabOrder = 1
        OnClick = swfConvertButtonClick
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 64
        Width = 217
        Height = 65
        Caption = 'GroupBox1'
        TabOrder = 2
        object Button1: TButton
          Left = 8
          Top = 24
          Width = 89
          Height = 25
          Caption = 'Default handler'
          TabOrder = 0
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 112
          Top = 24
          Width = 89
          Height = 25
          Caption = 'Internet Explorer'
          TabOrder = 1
          OnClick = Button2Click
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Html'
      ImageIndex = 1
      DesignSize = (
        377
        165)
      object Label4: TLabel
        Left = 8
        Top = 24
        Width = 78
        Height = 13
        Caption = 'Image format:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 8
        Top = 56
        Width = 53
        Height = 13
        Caption = 'Start file:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 8
        Top = 88
        Width = 73
        Height = 13
        Caption = 'Slides name:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object thumbsnailProduceButton: TButton
        Left = 296
        Top = 136
        Width = 75
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Convert'
        TabOrder = 0
        OnClick = thumbsnailProduceButtonClick
      end
      object ImageFormatComboBox: TComboBox
        Left = 104
        Top = 16
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Text = 'Choose file format'
        Items.Strings = (
          'JPG'
          'BMP'
          'GIF')
      end
      object indexHtmlEdit: TEdit
        Left = 104
        Top = 48
        Width = 145
        Height = 21
        TabOrder = 2
        Text = 'index.html'
      end
      object slidesNameEdit: TEdit
        Left = 104
        Top = 80
        Width = 145
        Height = 21
        TabOrder = 3
        Text = 'slides.html'
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'PowerPoint files|*.pptx; *.ppt'
    Left = 208
    Top = 312
  end
  object SaveDialog1: TSaveDialog
    Left = 152
    Top = 312
  end
  object Ppt2SwfConverter1: TPpt2SwfConverter
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 120
    Top = 48
  end
  object ThumbnailProducer1: TThumbnailProducer
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 88
    Top = 48
  end
end
