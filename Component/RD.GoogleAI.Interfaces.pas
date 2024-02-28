unit RD.GoogleAI.Interfaces;

interface

uses
  REST.Client;

type
  IAIRESTClient = interface
    ['{E9EEA633-4528-496C-8405-3262CFB508A7}']
    function GetRESTClient: TCustomRESTClient;
  end;

implementation

end.
