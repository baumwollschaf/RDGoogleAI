program GoogleAIExample;

uses
  Vcl.Forms,
  RD.GoogleAI.Forms.AppRDGoogleAIExmplMainForm in 'RD.GoogleAI.Forms.AppRDGoogleAIExmplMainForm.pas' {AppRDGoogleAIExmplMainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TAppRDGoogleAIExmplMainForm, AppRDGoogleAIExmplMainForm);
  Application.Run;
end.
