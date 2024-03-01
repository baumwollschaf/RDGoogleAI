unit RD.GoogleAI.DTO.Models;

interface

uses
  RD.Pkg.Json.DTO,
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
    FCandidatesArray: TArray<TCandidates>;
    [GenericListReflect]
    FCandidates: TObjectList<TCandidates>;
    FPromptFeedback: TPromptFeedback;
    function GetCandidates: TObjectList<TCandidates>;
  protected
    function GetAsJson: string; override;
  published
    property Candidates: TObjectList<TCandidates> read GetCandidates;
    property PromptFeedback: TPromptFeedback read FPromptFeedback;
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

function TCandidates.GetCandidates: TObjectList<TCandidates>;
begin
  Result := ObjectList<TCandidates>(FCandidates, FCandidatesArray);
end;

function TCandidates.GetAsJson: string;
begin
  RefreshArray<TCandidates>(FCandidates, FCandidatesArray);
  Result := inherited;
end;

end.
