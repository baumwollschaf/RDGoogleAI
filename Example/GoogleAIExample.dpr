program GoogleAIExample;

uses
  Vcl.Forms,
  {$IFDEF baumwollschaf}
  RD.GoogleAI.ApiKey in '..\..\RD.GoogleAI.ApiKey.pas',
  {$ENDIF }
  RD.GoogleAI.Forms.AppRDGoogleAIExmplMainForm in 'RD.GoogleAI.Forms.AppRDGoogleAIExmplMainForm.pas' {AppRDGoogleAIExmplMainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TAppRDGoogleAIExmplMainForm, AppRDGoogleAIExmplMainForm);
  Application.Run;

end.
