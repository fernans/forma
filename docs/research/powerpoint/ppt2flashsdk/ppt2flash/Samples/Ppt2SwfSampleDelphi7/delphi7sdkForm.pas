unit delphi7sdkForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, OleServer, ShlObj, ShellAPI, FileCtrl, StrUtils,
  Ppt2SwfSdk_TLB;

type

  SArray = array of string;

  TForm1 = class(TForm)
    Label1: TLabel;
    pptFilePathEdit: TEdit;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    openFileDialogButton: TButton;
    Label2: TLabel;
    folderConvertToEdit: TEdit;
    openFolderDialogButton: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label3: TLabel;
    swfFileEdit: TEdit;
    swfConvertButton: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    thumbsnailProduceButton: TButton;
    ImageFormatComboBox: TComboBox;
    indexHtmlEdit: TEdit;
    slidesNameEdit: TEdit;
    Ppt2SwfConverter1: TPpt2SwfConverter;
    ThumbnailProducer1: TThumbnailProducer;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    procedure openFileDialogButtonClick(Sender: TObject);
    procedure openFolderDialogButtonClick(Sender: TObject);
    function BrowseDialogCallBack(Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): integer stdcall;
    function BrowseDialog(const Title: string; const Flag: integer): string;
    procedure swfConvertButtonClick(Sender: TObject);
    function checkFileExt(fileName: string; fileExt: string): boolean;
    procedure pptFilePathEditChange(Sender: TObject);
    function Split(const Source,Delimiter:String):SArray;
    procedure thumbsnailProduceButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public

    { Public declarations }

  end;



var
  Form1: TForm1;
  var lg_StartFolder: String;


implementation

uses ComObj;



{$R *.dfm}


function TForm1.Split(const Source,Delimiter:String):SArray;
var
  iCount,iPos,iLength: Integer;
  sTemp: String;
  aSplit:SArray;
begin
  sTemp := Source;
  iCount := 0;
  iLength := Length(Delimiter) - 1;
repeat
  iPos := Pos(Delimiter, sTemp);
  if iPos = 0 then
    break
  else begin
    Inc(iCount);
    SetLength(aSplit, iCount);
    aSplit[iCount - 1] := Copy(sTemp, 1, iPos - 1);
    Delete(sTemp, 1, iPos + iLength);
  end;
until False;
  if Length(sTemp) > 0 then begin
    Inc(iCount);
    SetLength(aSplit, iCount);
    aSplit[iCount - 1] := sTemp;
  end;
    Result := aSplit;
end;


function TForm1.checkFileExt(fileName: string; fileExt: string): boolean;
var
   stringList: SArray;
begin
   stringList :=  Split(fileName, '.');
   if (Length(stringList) > 2) then
   begin
     Result := false;
   end
   else
   begin
     if (LowerCase(stringList[1]) <> fileExt) then
     begin
       Result := false;
     end
     else
     begin
       Result := true;
     end;
   end
end;

function TForm1.BrowseDialogCallBack(Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM):integer stdcall;
var
  wa, rect : TRect;
  dialogPT : TPoint;
begin
  //center in work area
  if uMsg = BFFM_INITIALIZED then
  begin
    wa := Screen.WorkAreaRect;
    GetWindowRect(Wnd, Rect);
    dialogPT.X := ((wa.Right-wa.Left) div 2) -
                  ((rect.Right-rect.Left) div 2);
    dialogPT.Y := ((wa.Bottom-wa.Top) div 2) -
                  ((rect.Bottom-rect.Top) div 2);
    MoveWindow(Wnd,
               dialogPT.X,
               dialogPT.Y,
               Rect.Right - Rect.Left,
               Rect.Bottom - Rect.Top,
               True);
  end;

  Result := 0;
end; (*BrowseDialogCallBack*)


function TForm1.BrowseDialog(const Title: string; const Flag: integer): string;
var
  lpItemID : PItemIDList;
  BrowseInfo : TBrowseInfo;
  DisplayName : array[0..MAX_PATH] of char;
  TempPath : array[0..MAX_PATH] of char;
begin
  Result:='';
  FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
  with BrowseInfo do begin
    hwndOwner := Application.Handle;
    pszDisplayName := @DisplayName;
    lpszTitle := PChar(Title);
    ulFlags := Flag;
    lpfn := @TForm1.BrowseDialogCallBack;
  end;
  lpItemID := SHBrowseForFolder(BrowseInfo);
  if lpItemId <> nil then begin
    SHGetPathFromIDList(lpItemID, TempPath);
    Result := TempPath;
    GlobalFreePtr(lpItemID);
  end;
end;

procedure TForm1.openFileDialogButtonClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'PowerPoint files (*.ppt; *.pptx)|*.ppt;*.pptx';
  OpenDialog1.FilterIndex := 1;
  OpenDialog1.InitialDir := GetCurrentDir;
  OpenDialog1.Options := [ofFileMustExist];

  if OpenDialog1.Execute then
    begin
       pptFilePathEdit.Text :=  OpenDialog1.FileName;
    end;

end;

procedure TForm1.openFolderDialogButtonClick(Sender: TObject);
var
  sFolder: string;
begin
  if SelectDirectory('Please select folder to save to', '', sFolder) then
    folderConvertToEdit.Text :=  sFolder;
end;

procedure TForm1.swfConvertButtonClick(Sender: TObject);
begin
   if (FileExists(pptFilePathEdit.Text)) then
   begin
          if (not checkFileExt(swfFileEdit.Text, 'swf')) then
          begin
              ShowMessage('Incorrect .swf filename !');
              Exit;
          end;

          if (folderConvertToEdit.Text = '') then
          begin
              ShowMessage('Incorrect folder path to save .swf file !');
              Exit;
          end;

          if (not DirectoryExists(folderConvertToEdit.Text)) then
             if ( not CreateDir(folderConvertToEdit.Text)) then
             begin
               CreateDir(GetCurrentDir() + '\Converted');
               folderConvertToEdit.Text := GetCurrentDir() + '\Converted';
               pptFilePathEdit.Text := GetCurrentDir() + '\Converted';
             end;


          Ppt2SwfConverter1.PresentationPath := pptFilePathEdit.Text;
          Ppt2SwfConverter1.OutputDirectory := folderConvertToEdit.Text;
          Ppt2SwfConverter1.ConvertSlideTransitions := true;
          Ppt2SwfConverter1.ConvertSlideAnimation := true;
          Ppt2SwfConverter1.GenerateXml := true;
          Ppt2SwfConverter1.ConvertToExe := true;
          Ppt2SwfConverter1.EffectOnClick := true;
          try
             Ppt2SwfConverter1.Convert( folderConvertToEdit.Text + '\' + swfFileEdit.Text);
             ShellExecute(0, nil, PChar(folderConvertToEdit.Text), nil, nil, SW_SHOWNORMAL);
          except
              ShowMessage('Power Point could not open current presentation: ' + swfFileEdit.Text);
          end;
   end
   else
   begin
      ShowMessage('Please select valid PowerPoint file');
      Exit;
   end



end;

procedure TForm1.pptFilePathEditChange(Sender: TObject);
var
  strFile: string;
  stringList: SArray;
  filePath: string;
  i: integer;
begin
  filePath := '';
  stringList := Split(OpenDialog1.FileName, '\');
  for i := 0 to Length(stringList) - 2 do
    filePath := filePath + stringList[i] + '\';
  folderConvertToEdit.Text := filePath + 'Converted';

  strFile := stringList[Length(stringList) - 1];
  SetLength(stringList, 0);
  stringList := Split(strFile, '.');
  swfFileEdit.Text := stringList[0] + '.swf';
end;

procedure TForm1.thumbsnailProduceButtonClick(Sender: TObject);
var currentPath: string;
begin
  if ( not checkFileExt(indexHtmlEdit.Text, 'html')) then
  begin
      ShowMessage('Incorrect slides .html file name !');
      Exit;
  end;

  if ( not checkFileExt(slidesNameEdit.Text, 'html'))   then
  begin
      ShowMessage('Incorrect slides .html file name !');
      Exit;
  end;

  if (folderConvertToEdit.Text = '') then
  begin
      ShowMessage('Incorrect folder path to save .swf file !');
      Exit;
  end;

  ThumbnailProducer1.PresentationPath := pptFilePathEdit.Text;

  currentPath := folderConvertToEdit.Text;
  if (not DirectoryExists(folderConvertToEdit.Text)) then
  begin
     currentPath := folderConvertToEdit.Text;
     if ( not CreateDir(folderConvertToEdit.Text)) then
     begin
       currentPath := GetCurrentDir() + '\Converted';
       CreateDir(currentPath);
       folderConvertToEdit.Text := currentPath;
     end;
  end;
  if (not DirectoryExists(currentPath + '\thumbs')) then
     CreateDir(currentPath + '\thumbs');

  ThumbnailProducer1.OutputDirectory := currentPath + '\thumbs';
  ThumbnailProducer1.IndexHTMLName := indexHtmlEdit.Text;
  if (ImageFormatComboBox.ItemIndex = -1) then
  begin
      ShowMessage('Image file format not selected !');
      Exit;
  end;

  ThumbnailProducer1.ImageFormat := ImageFormatComboBox.Text;
  ThumbnailProducer1.SlidesHTMLName := slidesNameEdit.Text;
  try
      ThumbnailProducer1.Produce();
      ShellExecute(0, nil, PChar(currentPath), nil, nil, SW_SHOWNORMAL);
  except
      ShowMessage('Power Point could not open current presentation: ' + pptFilePathEdit.Text);
      Exit;
  end

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CoInitializeEx(nil, 0);
  ImageFormatComboBox.ItemIndex := 0;
  PageControl1.TabIndex := 0;
end;

procedure TForm1.Button1Click(Sender: TObject);
var swfFile: string;
begin
  try
     swfFile := folderConvertToEdit.Text + '\' + swfFileEdit.Text;
     ShellExecute(0, nil, PChar(swfFile), nil, nil, SW_SHOWNORMAL);
  except
     ShowMessage('Cannot run default handler!');
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var swfFile: string;
begin
  try
     swfFile := folderConvertToEdit.Text + '\' + swfFileEdit.Text;
     ShellExecute(0, nil, PChar('iexplore.exe'), PChar(swfFile), nil, SW_SHOWNORMAL);
  except
     ShowMessage('Cannot run default handler!');
  end;
end;

end.

