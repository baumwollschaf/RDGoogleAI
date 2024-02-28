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

end.
