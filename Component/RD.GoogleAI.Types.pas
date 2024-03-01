unit RD.GoogleAI.Types;

interface

uses
  REST.Client,
  RD.GoogleAI.DTO.Models;

type
  TGetOrFinish = (rGet, rFinish);
  TRequestInfoProc = procedure(AURL: string; AGetOrFinish: TGetOrFinish) Of Object;
  TTypedEvent<T> = procedure(Sender: TObject; AType: T) of object;

  IAIRESTClient = interface
    ['{E9EEA633-4528-496C-8405-3262CFB508A7}']
    function GetRESTClient: TCustomRESTClient;
    function GetApiKey: String;
    function GetModelName: String;

    function GetRequestInfoProc: TRequestInfoProc;
    procedure SetRequestInfoProc(const Value: TRequestInfoProc);
    property RequestInfoProc: TRequestInfoProc read GetRequestInfoProc write SetRequestInfoProc;

    function GetOnModelsLoaded: TTypedEvent<TModels>;
    procedure SetOnModelsLoaded(const Value: TTypedEvent<TModels>);
    property OnModelsLoaded: TTypedEvent<TModels> read GetOnModelsLoaded write SetOnModelsLoaded;

    function GetOnCandidatesLoaded: TTypedEvent<TCandidates>;
    procedure SetOnCandidatesLoaded(const Value: TTypedEvent<TCandidates>);
    property OnCandidatesLoaded: TTypedEvent<TCandidates> read GetOnCandidatesLoaded write SetOnCandidatesLoaded;

    function GetOnError: TTypedEvent<string>;
    procedure SetOnError(const Value: TTypedEvent<string>);
    property OnError: TTypedEvent<string> read GetOnError write SetOnError;
  end;

implementation

end.
