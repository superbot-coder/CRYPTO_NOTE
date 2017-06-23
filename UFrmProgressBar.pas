unit UFrmProgressBar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  JvProgressBar, JvExControls, JvGradient, sPanel, sSkinProvider;

type
  TFrmProgressBar = class(TForm)
    TimerProgress: TTimer;
    sSkinProvider: TsSkinProvider;
    JvGradProgressBar: TJvGradientProgressBar;
    LblCaption: TLabel;
    procedure TimerProgressTimer(Sender: TObject);
    procedure Start;
    procedure Stop;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmProgressBar: TFrmProgressBar;

implementation

{$R *.dfm}

procedure TFrmProgressBar.Start;
begin
  TimerProgress.Enabled := true;
  Show;
end;

procedure TFrmProgressBar.Stop;
begin
  TimerProgress.Enabled := false;
  close;
end;

procedure TFrmProgressBar.TimerProgressTimer(Sender: TObject);
begin
   if JvGradProgressBar.Position = 100 then
  begin
    JvGradProgressBar.Position := 0;
    if JvGradProgressBar.Inverted = false then
    begin
      JvGradProgressBar.Inverted     := true;
      JvGradProgressBar.BarColorFrom := clLime;
      JvGradProgressBar.BarColorTo   := clGreen;
    end
    else
    begin
      JvGradProgressBar.Inverted     := false;
      JvGradProgressBar.BarColorFrom := clGreen;
      JvGradProgressBar.BarColorTo   := clLime;
    end;
  end;
  JvGradProgressBar.Position := JvGradProgressBar.Position + 2;
end;

end.
