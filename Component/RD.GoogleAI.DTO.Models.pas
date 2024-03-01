unit RD.GoogleAI.DTO.Models;

interface

uses
  RD.GoogleAI.Pkg.Json.DTO,
  System.Generics.Collections,
  REST.Json.Types;

{$M+}

type
  TModel = class(TJsonDTO)
  private
    FDescription: string;
    FDisplayName: string;
    FInputTokenLimit: Integer;
    FName: string;
    FOutputTokenLimit: Integer;
    [JSONName('supportedGenerationMethods')]
    FSupportedGenerationMethodsArray: TArray<string>;
    [JSONMarshalled(False)]
    FSupportedGenerationMethods: TList<string>;
    FTemperature: Double;
    FTopK: Integer;
    FTopP: Integer;
    FVersion: string;
    function GetSupportedGenerationMethods: TList<string>;
  protected
    function GetAsJson: string; override;
  published
    property Description: string read FDescription write FDescription;
    property DisplayName: string read FDisplayName write FDisplayName;
    property InputTokenLimit: Integer read FInputTokenLimit write FInputTokenLimit;
    property Name: string read FName write FName;
    property OutputTokenLimit: Integer read FOutputTokenLimit write FOutputTokenLimit;
    property SupportedGenerationMethods: TList<string> read GetSupportedGenerationMethods;
    property Temperature: Double read FTemperature write FTemperature;
    property TopK: Integer read FTopK write FTopK;
    property TopP: Integer read FTopP write FTopP;
    property Version: string read FVersion write FVersion;
  public
    destructor Destroy; override;
  end;

  TModels = class(TJsonDTO)
  private
    [JSONName('models'), JSONMarshalled(False)]
    FModelsArray: TArray<TModel>;
    [GenericListReflect]
    FModels: TObjectList<TModel>;
    function GetModels: TObjectList<TModel>;
  protected
    function GetAsJson: string; override;
  published
    property Models: TObjectList<TModel> read GetModels;
  public
    destructor Destroy; override;
  end;

  TContent = class;
  TParts = class;
  TSafetyRatings = class;

  TSafetyRatings = class
  private
    FCategory: string;
    FProbability: string;
  published
    property Category: string read FCategory write FCategory;
    property Probability: string read FProbability write FProbability;
  end;

  TPromptFeedback = class(TJsonDTO)
  private
    [JSONName('safetyRatings'), JSONMarshalled(False)]
    FSafetyRatingsArray: TArray<TSafetyRatings>;
    [GenericListReflect]
    FSafetyRatings: TObjectList<TSafetyRatings>;
    function GetSafetyRatings: TObjectList<TSafetyRatings>;
  protected
    function GetAsJson: string; override;
  published
    property SafetyRatings: TObjectList<TSafetyRatings> read GetSafetyRatings;
  public
    destructor Destroy; override;
  end;

  TParts = class
  private
    FText: string;
  published
    property Text: string read FText write FText;
  end;

  TContent = class(TJsonDTO)
  private
    [JSONName('parts'), JSONMarshalled(False)]
    FPartsArray: TArray<TParts>;
    [GenericListReflect]
    FParts: TObjectList<TParts>;
    FRole: string;
    function GetParts: TObjectList<TParts>;
  protected
    function GetAsJson: string; override;
  published
    property Parts: TObjectList<TParts> read GetParts;
    property Role: string read FRole write FRole;
  public
    destructor Destroy; override;
  end;

  TCandidate = class(TJsonDTO)
  private
    FContent: TContent;
    FFinishReason: string;
    FIndex: Integer;
    [JSONName('safetyRatings'), JSONMarshalled(False)]
    FSafetyRatingsArray: TArray<TSafetyRatings>;
    [GenericListReflect]
    FSafetyRatings: TObjectList<TSafetyRatings>;
    function GetSafetyRatings: TObjectList<TSafetyRatings>;
  protected
    function GetAsJson: string; override;
  published
    property Content: TContent read FContent;
    property FinishReason: string read FFinishReason write FFinishReason;
    property Index: Integer read FIndex write FIndex;
    property SafetyRatings: TObjectList<TSafetyRatings> read GetSafetyRatings;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TCandidates = class(TJsonDTO)
  private
    [JSONName('candidates'), JSONMarshalled(False)]
    FCandidatesArray: TArray<TCandidate>;
    [GenericListReflect]
    FCandidates: TObjectList<TCandidate>;
    FPromptFeedback: TPromptFeedback;
    function GetCandidates: TObjectList<TCandidate>;
  protected
    function GetAsJson: string; override;
  published
    property Candidates: TObjectList<TCandidate> read GetCandidates;
    property PromptFeedback: TPromptFeedback read FPromptFeedback;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TGenerationConfig = class(TJsonDTO)
  private
    FMaxOutputTokens: Integer;
    [JSONName('stopSequences')]
    FStopSequencesArray: TArray<string>;
    [JSONMarshalled(False)]
    FStopSequences: TList<string>;
    FTemperature: Double;
    FTopK: Integer;
    FTopP: Double;
    function GetStopSequences: TList<string>;
  protected
    function GetAsJson: string; override;
  published
    property MaxOutputTokens: Integer read FMaxOutputTokens write FMaxOutputTokens;
    property StopSequences: TList<string> read GetStopSequences;
    property Temperature: Double read FTemperature write FTemperature;
    property TopK: Integer read FTopK write FTopK;
    property TopP: Double read FTopP write FTopP;
  public
    destructor Destroy; override;
  end;

  TSafetySettings = class
  private
    FCategory: string;
    FThreshold: string;
  published
    property Category: string read FCategory write FCategory;
    property Threshold: string read FThreshold write FThreshold;
  end;

  TContents = class(TJsonDTO)
  private
    [JSONName('parts'), JSONMarshalled(False)]
    FPartsArray: TArray<TParts>;
    [GenericListReflect]
    FParts: TObjectList<TParts>;
    function GetParts: TObjectList<TParts>;
  protected
    function GetAsJson: string; override;
  published
    property Parts: TObjectList<TParts> read GetParts;
  public
    destructor Destroy; override;
  end;

  TInputSettings = class(TJsonDTO)
  private
    [JSONName('contents'), JSONMarshalled(False)]
    FContentsArray: TArray<TContents>;
    [GenericListReflect]
    FContents: TObjectList<TContents>;
    FGenerationConfig: TGenerationConfig;
    [JSONName('safetySettings'), JSONMarshalled(False)]
    FSafetySettingsArray: TArray<TSafetySettings>;
    [GenericListReflect]
    FSafetySettings: TObjectList<TSafetySettings>;
    function GetContents: TObjectList<TContents>;
    function GetSafetySettings: TObjectList<TSafetySettings>;
  protected
    function GetAsJson: string; override;
  published
    property Contents: TObjectList<TContents> read GetContents;
    property GenerationConfig: TGenerationConfig read FGenerationConfig;
    property SafetySettings: TObjectList<TSafetySettings> read GetSafetySettings;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TModels }

destructor TModel.Destroy;
begin
  GetSupportedGenerationMethods.Free;
  inherited;
end;

function TModel.GetSupportedGenerationMethods: TList<string>;
begin
  Result := List<string>(FSupportedGenerationMethods, FSupportedGenerationMethodsArray);
end;

function TModel.GetAsJson: string;
begin
  RefreshArray<string>(FSupportedGenerationMethods, FSupportedGenerationMethodsArray);
  Result := inherited;
end;

{ TRoot }

destructor TModels.Destroy;
begin
  GetModels.Free;
  inherited;
end;

function TModels.GetModels: TObjectList<TModel>;
begin
  Result := ObjectList<TModel>(FModels, FModelsArray);
end;

function TModels.GetAsJson: string;
begin
  RefreshArray<TModel>(FModels, FModelsArray);
  Result := inherited;
end;

destructor TPromptFeedback.Destroy;
begin
  GetSafetyRatings.Free;
  inherited;
end;

function TPromptFeedback.GetSafetyRatings: TObjectList<TSafetyRatings>;
begin
  Result := ObjectList<TSafetyRatings>(FSafetyRatings, FSafetyRatingsArray);
end;

function TPromptFeedback.GetAsJson: string;
begin
  RefreshArray<TSafetyRatings>(FSafetyRatings, FSafetyRatingsArray);
  Result := inherited;
end;

{ TContent }

destructor TContent.Destroy;
begin
  GetParts.Free;
  inherited;
end;

function TContent.GetParts: TObjectList<TParts>;
begin
  Result := ObjectList<TParts>(FParts, FPartsArray);
end;

function TContent.GetAsJson: string;
begin
  RefreshArray<TParts>(FParts, FPartsArray);
  Result := inherited;
end;

{ TCandidate }

constructor TCandidate.Create;
begin
  inherited;
  FContent := TContent.Create;
end;

destructor TCandidate.Destroy;
begin
  FContent.Free;
  GetSafetyRatings.Free;
  inherited;
end;

function TCandidate.GetSafetyRatings: TObjectList<TSafetyRatings>;
begin
  Result := ObjectList<TSafetyRatings>(FSafetyRatings, FSafetyRatingsArray);
end;

function TCandidate.GetAsJson: string;
begin
  RefreshArray<TSafetyRatings>(FSafetyRatings, FSafetyRatingsArray);
  Result := inherited;
end;

{ TCandidates }

constructor TCandidates.Create;
begin
  inherited;
  FPromptFeedback := TPromptFeedback.Create;
end;

destructor TCandidates.Destroy;
begin
  FPromptFeedback.Free;
  GetCandidates.Free;
  inherited;
end;

function TCandidates.GetCandidates: TObjectList<TCandidate>;
begin
  Result := ObjectList<TCandidate>(FCandidates, FCandidatesArray);
end;

function TCandidates.GetAsJson: string;
begin
  RefreshArray<TCandidate>(FCandidates, FCandidatesArray);
  Result := inherited;
end;

destructor TGenerationConfig.Destroy;
begin
  GetStopSequences.Free;
  inherited;
end;

function TGenerationConfig.GetStopSequences: TList<string>;
begin
  Result := List<string>(FStopSequences, FStopSequencesArray);
end;

function TGenerationConfig.GetAsJson: string;
begin
  RefreshArray<string>(FStopSequences, FStopSequencesArray);
  Result := inherited;
end;

{ TContents }

destructor TContents.Destroy;
begin
  GetParts.Free;
  inherited;
end;

function TContents.GetParts: TObjectList<TParts>;
begin
  Result := ObjectList<TParts>(FParts, FPartsArray);
end;

function TContents.GetAsJson: string;
begin
  RefreshArray<TParts>(FParts, FPartsArray);
  Result := inherited;
end;

{ TRoot }

constructor TInputSettings.Create;
begin
  inherited;
  FGenerationConfig := TGenerationConfig.Create;
end;

destructor TInputSettings.Destroy;
begin
  FGenerationConfig.Free;
  GetContents.Free;
  GetSafetySettings.Free;
  inherited;
end;

function TInputSettings.GetContents: TObjectList<TContents>;
begin
  Result := ObjectList<TContents>(FContents, FContentsArray);
end;

function TInputSettings.GetSafetySettings: TObjectList<TSafetySettings>;
begin
  Result := ObjectList<TSafetySettings>(FSafetySettings, FSafetySettingsArray);
end;

function TInputSettings.GetAsJson: string;
begin
  RefreshArray<TContents>(FContents, FContentsArray);
  RefreshArray<TSafetySettings>(FSafetySettings, FSafetySettingsArray);
  Result := inherited;
end;

end.
