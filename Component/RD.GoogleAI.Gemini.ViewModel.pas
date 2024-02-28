unit RD.GoogleAI.Gemini.ViewModel;

interface

uses
  System.SysUtils,
  System.Variants,
  System.Classes,
  REST.JSON.Types,
  System.JSON,
  System.Rtti,
  System.TypInfo,
  System.Character,
  System.Math,
  System.DateUtils,
  IPPeerClient,
  REST.Client,
  REST.Authenticator.Basic,
  Data.Bind.ObjectScope,
  REST.Response.Adapter,
  REST.Types,
  REST.JSON,
  RD.GoogleAI.Gemini.Model,
  RD.GoogleAI.Input.Model,
  System.Generics.Collections;
{$METHODINFO ON}
{$M+}

type
  RDGoogleAIException = class(Exception);

  TRDGoogleAIConnection = class(TComponent)
  public const
    cVERSION = '1.0';
    cDEF_URL = 'https://generativelanguage.googleapis.com/v1beta';
    cDEF_MAX_OUTPUT_TOKENS = 400; // 100 means 60 to 80 words
    cDEF_TEMP = 0.1;
    cDEF_TOP_P = 0.95;
    cDEF_TOP_K = 5;
  private
    FApiKey: string;
    FGenerationConfig: TGenerationConfig;
    function GetVersion: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ApiKey: string read FApiKey write FApiKey;
    property GenerationConfig: TGenerationConfig read FGenerationConfig;
  end;

procedure Register;

implementation

procedure Register;
begin
  // RegisterComponents('RD AI', [TRDGoogleAIGemini]);
end;

{ TRDGoogleAIConnection }

constructor TRDGoogleAIConnection.Create(AOwner: TComponent);
begin
  inherited;
  FGenerationConfig := TGenerationConfig.Create;
  FGenerationConfig.MaxOutputTokens := cDEF_MAX_OUTPUT_TOKENS;
  FGenerationConfig.Temperature := cDEF_TEMP;
  FGenerationConfig.TopK := cDEF_TOP_K;
  FGenerationConfig.TopP := cDEF_TOP_P;
end;

destructor TRDGoogleAIConnection.Destroy;
begin
  FGenerationConfig.Free;
  inherited;
end;

function TRDGoogleAIConnection.GetVersion: String;
begin
  Result := cVERSION;
end;

end.
