unit RD.GoogleAI.Gemini.Model;

interface

uses
  IdSSLOpenSSLHeaders,
  WinApi.Windows,
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
  RD.Pkg.JSON.DTO,
  RD.GoogleAI.Types,
  RD.GoogleAI.DTO.Models,
  System.Generics.Collections;
{$METHODINFO ON}
{$M+}

type
  TAIBaseEndpoint = class(TComponent)
  protected
    FAIRest: IAIRESTClient;
    [JSONMarshalled(False)]
    FResponse: TRESTResponse;
    [JSONMarshalled(False)]
    FRequest: TRESTRequest;
    [JSONMarshalled(False)]
    FLastError: string;
    class function GetResourcePath: String; virtual;
    procedure DoCompletionHandlerWithError(AObject: TObject);
    procedure DoError(AMessage: String);
  public
    procedure Refresh; virtual;
    property LastError: string read FLastError;
    constructor Create(AOwner: TComponent; AAIRest: IAIRESTClient); reintroduce; virtual;
  end;

  TAIModels = class(TAIBaseEndpoint)
  private
    FModels: TModels;
    procedure ModelsCompletion;
    procedure DoFinishLoad(AModels: TModels);
  protected
    class function GetResourcePath: String; override;
  public
    procedure Refresh; override;
    constructor Create(AOwner: TComponent; AAIRest: IAIRESTClient); override;
    destructor Destroy; override;
  end;

implementation

uses
  REST.Utils;

constructor TAIBaseEndpoint.Create(AOwner: TComponent; AAIRest: IAIRESTClient);
begin
  Assert(AAIRest <> nil);
  inherited Create(AOwner);
  FAIRest := AAIRest;
end;

procedure TAIBaseEndpoint.DoCompletionHandlerWithError(AObject: TObject);
begin
  try
    DoError(Exception(AObject).Message);
  except
    ;
  end;
end;

procedure TAIBaseEndpoint.DoError(AMessage: String);
begin
  if FAIRest = nil then
    Exit;
  if assigned(FAIRest.OnError) then
  begin
    FAIRest.OnError(Self, AMessage);
  end;
end;

class function TAIBaseEndpoint.GetResourcePath: String;
begin
  Result := '';
end;

procedure TAIBaseEndpoint.Refresh;
begin
  Assert(FAIRest <> nil);
  if not assigned(FResponse) then
  begin
    FResponse := TRESTResponse.Create(Self);
    FRequest := TRESTRequest.Create(Self);
    FRequest.Method := TRESTRequestMethod.rmPost;
    FRequest.Client := FAIRest.GetRestClient;
    FRequest.Resource := URIEncode(GetResourcePath + '?key=$' + FAIRest.GetApiKey);
    FRequest.Response := FResponse;
  end;
end;

{ TAIModels }

constructor TAIModels.Create(AOwner: TComponent; AAIRest: IAIRESTClient);
begin
  inherited;

end;

destructor TAIModels.Destroy;
begin
  FreeAndNil(FModels);
  inherited;
end;

procedure TAIModels.DoFinishLoad(AModels: TModels);
begin
  if FAIRest = nil then
    Exit;
  if assigned(FAIRest.OnModelsLoaded) then
  begin
    FAIRest.OnModelsLoaded(Self, AModels);
  end;
end;

class function TAIModels.GetResourcePath: String;
begin
  Result := 'models';
end;

procedure TAIModels.ModelsCompletion;
begin
  var
    JsonObj: TJSONObject;
  begin
    if FRequest = nil then
      Exit;
    if FResponse = nil then
      Exit;

    if FResponse.StatusCode <> 200 then
    begin
      FLastError := FResponse.StatusText;
      DoError(FLastError);
      Exit;
    end;

    if assigned(FAIRest.RequestInfoProc) then
      FAIRest.RequestInfoProc(FRequest.Resource, rFinish);

    JsonObj := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(FResponse.Content), 0) as TJSONObject;
    if JsonObj = nil then
      Exit;

    try
      try
        FreeAndNil(FModels);
        FModels := TJson.JsonToObject<TModels>(TJSONObject(JsonObj));
        DoFinishLoad(FModels);
      finally
        JsonObj.Free;
      end;
    except
      on E: Exception do
      begin
        FLastError := E.Message;
        DoError(FLastError);
      end;
    end;
  end;
end;

procedure TAIModels.Refresh;
begin
  inherited Refresh;

  try
    if assigned(FAIRest.GetRequestInfoProc) then
      FAIRest.RequestInfoProc(FRequest.Resource, rGet);
    FRequest.ExecuteAsync(ModelsCompletion, True, True, DoCompletionHandlerWithError);
  except
    on E: Exception do
      FLastError := E.Message;
  end;
end;

end.
