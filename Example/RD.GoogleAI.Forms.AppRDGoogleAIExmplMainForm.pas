unit RD.GoogleAI.Forms.AppRDGoogleAIExmplMainForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  RD.GoogleAI.Input.Model,
  RD.GoogleAI.Gemini.ViewModel,
  Vcl.StdCtrls;

type
  TAppRDGoogleAIExmplMainForm = class(TForm)
    RDGoogleAIGemini1: TRDGoogleAIGemini;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure RDGoogleAIGemini1Error(Sender: TObject; AType: string);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  AppRDGoogleAIExmplMainForm: TAppRDGoogleAIExmplMainForm;

implementation

{$R *.dfm}

procedure TAppRDGoogleAIExmplMainForm.Button1Click(Sender: TObject);
begin
  RDGoogleAIGemini1.LoadModels;
end;

procedure TAppRDGoogleAIExmplMainForm.RDGoogleAIGemini1Error(Sender: TObject; AType: string);
begin
  ShowMessage(AType);
end;

end.
