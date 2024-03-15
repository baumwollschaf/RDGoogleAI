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
  RD.GoogleAI.Types,
  RD.GoogleAI.DTO.Models,
  System.Generics.Collections;
{$METHODINFO ON}
{$M+}

type
  RDGoogleAIException = class(Exception);

  TRDGoogleAIConnection = class(TComponent)
  public const
    cVERSION = '1.10';
    cDEF_MAX_OUTPUT_TOKENS = 2048; // 100 means 60 to 80 words
    cDEF_TEMP = 0.9;
    cDEF_TOP_P = 1;
    cDEF_TOP_K = 1;
  private
    FApiKey: string;
    FCopyright: String;
    FInputSettings: TInputSettings;
    function GetVersion: String;
  protected
    property InputSettings: TInputSettings read FInputSettings;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ApiKey: string read FApiKey write FApiKey;
    property Copyright: String read FCopyright;
  end;

  TRDGoogleAIRestClient = class abstract(TRDGoogleAIConnection)
  public const
    cDEFAULT_USER_AGENT = 'RD GOOGLE AI CONNECT';
  strict private
    function GetAccept: string;
    procedure SetAccept(const Value: string);
    function GetAcceptCharset: string;
    procedure SetAcceptCharset(const Value: string);
    function GetAcceptEncoding: string;
    procedure SetAcceptEncoding(const Value: string);
    function GetBaseURL: string;
    procedure SetBaseURL(const Value: string);
    function GetProxy: string;
    procedure SetProxy(const Value: string);
    function GetProxyPort: Integer;
    procedure SetProxyPort(const Value: Integer);
  protected
    FTimeOut: Integer;
    FRestClient: TCustomRESTClient;
    property BaseURL: string read GetBaseURL write SetBaseURL;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property RestClient: TCustomRESTClient read FRestClient;
  published
    property Accept: string read GetAccept write SetAccept stored True;
    property AcceptCharset: string read GetAcceptCharset write SetAcceptCharset stored True;
    property AcceptEncoding: string read GetAcceptEncoding write SetAcceptEncoding stored True;
    property Proxy: string read GetProxy write SetProxy;
    property ProxyPort: Integer read GetProxyPort write SetProxyPort default 0;
    property TimeOut: Integer read FTimeOut write FTimeOut default CRestDefaultTimeout;
  end;

  TRDGoolgeAI = class(TRDGoogleAIRestClient, IAIRESTClient)
  private
    FModel: String;
    FRequestInfoProc: TRequestInfoProc;
    FOnModelsLoaded: TTypedEvent<TModels>;
    FOnCandidatesLoaded: TTypedEvent<TCandidates>;
    FOnError: TTypedEvent<string>;

    // AI Models
    FAIModels: TAIModels;
    FAICandidates: TAICandidates;

    function GetURL: string;
    procedure SetURL(const Value: string);
  protected
    // IAIRESTClient
    function GetRESTClient: TCustomRESTClient;
    function GetApiKey: String;
    function GetModelName: String;
    function GetInputSettings: TInputSettings;
    function GetTimeOut: Integer;

    function GetRequestInfoProc: TRequestInfoProc;
    procedure SetRequestInfoProc(const Value: TRequestInfoProc);

    function GetOnModelsLoaded: TTypedEvent<TModels>;
    procedure SetOnModelsLoaded(const Value: TTypedEvent<TModels>);

    function GetOnError: TTypedEvent<string>;
    procedure SetOnError(const Value: TTypedEvent<string>);

    function GetOnCandidatesLoaded: TTypedEvent<TCandidates>;
    procedure SetOnCandidatesLoaded(const Value: TTypedEvent<TCandidates>);

  public const
    cDEF_MODEL = 'models/gemini-pro';
    cDEF_BASE_URL = 'https://generativelanguage.googleapis.com/v1beta';
  published
    property URL: string read GetURL write SetURL stored True;
    property Model: String read FModel { write FModel };
    property RequestInfoProc: TRequestInfoProc read GetRequestInfoProc write SetRequestInfoProc;
    property OnModelsLoaded: TTypedEvent<TModels> read GetOnModelsLoaded write SetOnModelsLoaded;
    property OnError: TTypedEvent<string> read GetOnError write SetOnError;
    property OnCandidatesLoaded: TTypedEvent<TCandidates> read GetOnCandidatesLoaded write SetOnCandidatesLoaded;
  public
    procedure Cancel;
    procedure LoadModels;
    procedure Prompt(AValue: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TRDGoogleAIGemini = class(TRDGoolgeAI)

  end;

procedure Register;

implementation

uses
  System.IOUtils,
  REST.Utils;

procedure Register;
begin
  RegisterComponents('RD AI', [TRDGoogleAIGemini]);
end;

{ TRDGoogleAIConnection }

constructor TRDGoogleAIConnection.Create(AOwner: TComponent);
begin
  inherited;
  FCopyright := 'Copyright © 2024 Ralph Dietrich.';
  FInputSettings := TInputSettings.Create;
  FInputSettings.GenerationConfig.MaxOutputTokens := cDEF_MAX_OUTPUT_TOKENS;
  FInputSettings.GenerationConfig.Temperature := cDEF_TEMP;
  FInputSettings.GenerationConfig.TopK := cDEF_TOP_K;
  FInputSettings.GenerationConfig.TopP := cDEF_TOP_P;
end;

destructor TRDGoogleAIConnection.Destroy;
begin
  FInputSettings.Free;
  inherited;
end;

function TRDGoogleAIConnection.GetVersion: String;
begin
  Result := cVERSION;
end;

{ TRDGoogleAIRestClient }

constructor TRDGoogleAIRestClient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRestClient := TCustomRESTClient.Create(Self);
  FRestClient.UserAgent := cDEFAULT_USER_AGENT;
  FTimeOut := CRestDefaultTimeout;
end;

destructor TRDGoogleAIRestClient.Destroy;
begin
  FRestClient.Free;
  inherited Destroy;
end;

function TRDGoogleAIRestClient.GetAccept: string;
begin
  Result := FRestClient.Accept;
end;

function TRDGoogleAIRestClient.GetAcceptCharset: string;
begin
  Result := FRestClient.AcceptCharset;
end;

function TRDGoogleAIRestClient.GetAcceptEncoding: string;
begin
  Result := FRestClient.AcceptEncoding;
end;

function TRDGoogleAIRestClient.GetBaseURL: string;
begin
  Result := FRestClient.BaseURL;
end;

function TRDGoogleAIRestClient.GetProxy: string;
begin
  Result := FRestClient.ProxyServer;
end;

function TRDGoogleAIRestClient.GetProxyPort: Integer;
begin
  Result := FRestClient.ProxyPort;
end;

procedure TRDGoogleAIRestClient.SetAccept(const Value: string);
begin
  FRestClient.Accept := Value;
end;

procedure TRDGoogleAIRestClient.SetAcceptCharset(const Value: string);
begin
  FRestClient.AcceptCharset := Value;
end;

procedure TRDGoogleAIRestClient.SetAcceptEncoding(const Value: string);
begin
  FRestClient.AcceptEncoding := Value;
end;

procedure TRDGoogleAIRestClient.SetBaseURL(const Value: string);
begin
  FRestClient.BaseURL := Value;
end;

procedure TRDGoogleAIRestClient.SetProxy(const Value: string);
begin
  FRestClient.ProxyServer := Value;
end;

procedure TRDGoogleAIRestClient.SetProxyPort(const Value: Integer);
begin
  FRestClient.ProxyPort := Value;
end;

{ TRDGoolgeAI }

procedure TRDGoolgeAI.Cancel;
begin
  if FAIModels <> nil then
    FAIModels.Cancel;
  if FAICandidates <> nil then
    FAICandidates.Cancel;
end;

constructor TRDGoolgeAI.Create(AOwner: TComponent);
begin
  inherited;
  URL := cDEF_BASE_URL;
  FModel := cDEF_MODEL;
end;

destructor TRDGoolgeAI.Destroy;
begin
  FreeAndNil(FAIModels);
  FreeAndNil(FAICandidates);
  inherited;
end;

function TRDGoolgeAI.GetApiKey: String;
begin
  Result := FApiKey;
end;

function TRDGoolgeAI.GetInputSettings: TInputSettings;
begin
  Result := FInputSettings;
end;

function TRDGoolgeAI.GetModelName: String;
begin
  Result := FModel;
end;

function TRDGoolgeAI.GetOnCandidatesLoaded: TTypedEvent<TCandidates>;
begin
  Result := FOnCandidatesLoaded;
end;

function TRDGoolgeAI.GetOnError: TTypedEvent<string>;
begin
  Result := FOnError;
end;

function TRDGoolgeAI.GetOnModelsLoaded: TTypedEvent<TModels>;
begin
  Result := FOnModelsLoaded;
end;

function TRDGoolgeAI.GetRequestInfoProc: TRequestInfoProc;
begin
  Result := FRequestInfoProc;
end;

function TRDGoolgeAI.GetRESTClient: TCustomRESTClient;
begin
  Result := FRestClient;
end;

function TRDGoolgeAI.GetTimeOut: Integer;
begin
  Result := FTimeOut;
end;

function TRDGoolgeAI.GetURL: string;
begin
  Result := BaseURL;
end;

procedure TRDGoolgeAI.LoadModels;
begin
  if FAIModels = nil then
  begin
    FAIModels := TAIModels.Create(Self, Self);
  end;
  FAIModels.Refresh;
end;

procedure TRDGoolgeAI.Prompt(AValue: String);
begin
  FInputSettings.Contents.Clear;

  var
    C: TContents := TContents.Create;
  var
    P: TParts := TParts.Create;
  P.Text := AValue;
  C.Parts.Add(P);
  FInputSettings.Contents.Add(C);
{$IFDEF DEBUG}
{$IFDEF baumwollschaf}
  TFile.AppendAllText('C:\Users\rdietrich\Desktop\Json.txt', FInputSettings.AsJson);
{$ENDIF}
{$ENDIF}
  if FAICandidates = nil then
  begin
    FAICandidates := TAICandidates.Create(Self, Self);
  end;

{$IFDEF DEBUG}
{$IFDEF baumwollschaf}
  TFile.AppendAllText('C:\Users\rdietrich\Desktop\Json.txt', FAICandidates.Body);
{$ENDIF}
{$ENDIF}
  FAICandidates.Refresh;
end;

procedure TRDGoolgeAI.SetOnCandidatesLoaded(const Value: TTypedEvent<TCandidates>);
begin
  FOnCandidatesLoaded := Value;
end;

procedure TRDGoolgeAI.SetOnError(const Value: TTypedEvent<string>);
begin
  FOnError := Value;
end;

procedure TRDGoolgeAI.SetOnModelsLoaded(const Value: TTypedEvent<TModels>);
begin
  FOnModelsLoaded := Value;
end;

procedure TRDGoolgeAI.SetRequestInfoProc(const Value: TRequestInfoProc);
begin
  FRequestInfoProc := Value;
end;

procedure TRDGoolgeAI.SetURL(const Value: string);
begin
  BaseURL := Value;
end;

end.
