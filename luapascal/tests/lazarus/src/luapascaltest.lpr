program luaPascalTest;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { you can add units after this }, Unit1, lua;

begin
 Application.Title:='LuaPascal Test Application';
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

