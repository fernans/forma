program sdkForm;

uses
  Forms,
  delphi7sdkForm in 'delphi7sdkForm.pas' {Form1},
  Ppt2SwfSdk_TLB in 'D:\Program Files\Borland\Delphi7\Imports\Ppt2SwfSdk_TLB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
