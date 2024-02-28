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
  RD.GoogleAI.Interfaces,
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
  public
    procedure Refresh; virtual;
    property LastError: string read FLastError;
    constructor Create(AOwner: TComponent; AAIRest: IAIRESTClient); reintroduce; virtual;
  end;

  TAIModels = class(TAIBaseEndpoint)

  end;

implementation

{ TBaseEndpoint<T> }

constructor TAIBaseEndpoint.Create(AOwner: TComponent; AAIRest: IAIRESTClient);
begin
  Assert(AAIRest <> nil);
  inherited Create(AOwner);
  FAIRest := AAIRest;
end;

procedure TAIBaseEndpoint.Refresh;
begin

end;

end.
