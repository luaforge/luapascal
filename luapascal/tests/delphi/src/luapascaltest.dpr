program luapascaltest;

uses
  Forms,
  fprincipal in 'fprincipal.pas' {Form1},
  luastate in '..\..\..\src\luastate.pas',
  lua in '..\..\..\src\lua.pas';

{$R *.res}

begin
  Application.Initialize;
  AApplication.CreateForm(TForm1, Form1);
  pplication.Run;
end.

