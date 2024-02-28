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
    property GenerationConfig: TGenerationConfig read FGenerationConfig;
  published
    property ApiKey: string read FApiKey write FApiKey;
  end;

  TRDGoogleAIRestClient = class abstract(TRDGoogleAIConnection)
  public const
    cDEF_BASE_URL = 'https://generativelanguage.googleapis.com/v1beta';
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
  end;

  TRDGoolgeAI = class (TRDGoogleAIRestClient)

  end;

  TRDGoogleAIGemini = class (TRDGoolgeAI)

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('RD AI', [TRDGoogleAIGemini]);
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

{ TRDGoogleAIRestClient }

constructor TRDGoogleAIRestClient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRestClient := TCustomRESTClient.Create(Self);
  FRestClient.UserAgent := cDEFAULT_USER_AGENT;
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

end.
