program prjSk;

uses
  Forms,
  testapp in 'testapp.pas' {Ftestapp};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFtestapp, Ftestapp);
  Application.Run;
end.
