unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
   Button1: TButton;
   Button2: TButton;
   procedure Button1Click(Sender: TObject);
   procedure Button2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

uses lua;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
//  LoadLuaLib();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
//  FreeLuaLib();
end;

initialization
  {$I unit1.lrs}

end.

