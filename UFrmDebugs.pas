unit UFrmDebugs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFrmDebugs = class(TForm)
    mm: TMemo;
    PnlBar: TPanel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDebugs: TFrmDebugs;

implementation

{$R *.dfm}

end.
