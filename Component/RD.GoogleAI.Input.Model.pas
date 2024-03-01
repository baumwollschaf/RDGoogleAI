unit RD.GoogleAI.Input.Model;

interface

uses
  RD.GoogleAI.Pkg.Json.DTO,
  System.Generics.Collections,
  REST.Json.Types;

{$M+}

type
  TParts = class;

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

  TParts = class
  private
    FText: string;
  published
    property Text: string read FText write FText;
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

{ TGenerationConfig }

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
