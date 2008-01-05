program luapascaltest;

uses
  Forms,
  fprincipal in 'fprincipal.pas' {Form1},
  Lua in 'Lua.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
