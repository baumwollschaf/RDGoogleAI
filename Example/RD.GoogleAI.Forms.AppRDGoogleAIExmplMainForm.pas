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
  RD.GoogleAI.DTO.Models,
{$IFDEF baumwollschaf}
  RD.GoogleAI.ApiKey,
{$ENDIF}
  RD.GoogleAI.Gemini.ViewModel,
  Vcl.StdCtrls;

type
  TAppRDGoogleAIExmplMainForm = class(TForm)
    RDGoogleAIGemini1: TRDGoogleAIGemini;
    Button1: TButton;
    edPrompt: TEdit;
    comboModels: TComboBox;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MemoContent: TMemo;
    Label4: TLabel;
    MemoError: TMemo;
    Label5: TLabel;
    edBaseURL: TEdit;
    Label6: TLabel;
    edApiKey: TEdit;
    procedure RDGoogleAIGemini1Error(Sender: TObject; AType: string);
    procedure RDGoogleAIGemini1CandidatesLoaded(Sender: TObject; AType: TCandidates);
    procedure Button2Click(Sender: TObject);
    procedure RDGoogleAIGemini1ModelsLoaded(Sender: TObject; AType: TModels);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    procedure Init;
    function GetModel: TModel;
  public
    { Public-Deklarationen }
  end;

var
  AppRDGoogleAIExmplMainForm: TAppRDGoogleAIExmplMainForm;

implementation

{$R *.dfm}

procedure TAppRDGoogleAIExmplMainForm.Button1Click(Sender: TObject);
begin
  Init;
  RDGoogleAIGemini1.Prompt(edPrompt.Text, GetModel);
end;

procedure TAppRDGoogleAIExmplMainForm.Button2Click(Sender: TObject);
begin
  Init;
  RDGoogleAIGemini1.LoadModels;
end;

procedure TAppRDGoogleAIExmplMainForm.FormCreate(Sender: TObject);
begin
{$IFDEF baumwollschaf}
  // This is just a constant to my own secret APIKEY
  edApiKey.Text := TSecretGoogleAIApi.cAPIKEY;
{$ENDIF}
end;

function TAppRDGoogleAIExmplMainForm.GetModel: TModel;
begin
  Result := nil;
  if comboModels.ItemIndex = -1 then
    Exit;
  Result := TModel(comboModels.Items.Objects[comboModels.ItemIndex])
end;

procedure TAppRDGoogleAIExmplMainForm.Init;
begin
  RDGoogleAIGemini1.Cancel;
  MemoContent.Text := '';
  MemoError.Text := '';
  RDGoogleAIGemini1.URL := edBaseURL.Text;
  RDGoogleAIGemini1.ApiKey := edApiKey.Text;
end;

procedure TAppRDGoogleAIExmplMainForm.RDGoogleAIGemini1CandidatesLoaded(Sender: TObject; AType: TCandidates);
begin
  // Answers etc
  MemoContent.Lines.Clear;
  if AType = nil then
    Exit;
  if AType.Candidates.Count <> 0 then
  begin
    if AType.Candidates[0].Content <> nil then
    begin
      // Take a look at the model to check out other properties...
      // i.e. TCandidate, TContent etc.
      if AType.Candidates[0].Content.Parts.Count <> 0 then
      begin
        MemoContent.Text := AType.Candidates[0].Content.Parts[0].Text;
      end;
    end;
  end;
end;

procedure TAppRDGoogleAIExmplMainForm.RDGoogleAIGemini1Error(Sender: TObject; AType: string);
begin
  MemoError.Text := AType;
end;

procedure TAppRDGoogleAIExmplMainForm.RDGoogleAIGemini1ModelsLoaded(Sender: TObject; AType: TModels);
begin
  comboModels.Items.Clear;
  if AType = nil then
    Exit;
  for var i := 0 to AType.Models.Count - 1 do
  begin
    comboModels.Items.AddObject(AType.Models[i].DisplayName, AType.Models[i]);
  end;
end;

end.
