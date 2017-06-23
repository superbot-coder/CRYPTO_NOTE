unit UFrmColorParam;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  JvExControls, JvLabel, JvXPCore, JvXPButtons, JvGradient;

type
  TFrmColorParam = class(TForm)
    JvXPBtnFontDlg: TJvXPButton;
    JvLabel1: TJvLabel;
    ColorBox: TColorBox;
    JvXPBtnColor: TJvXPButton;
    mmDemo: TMemo;
    JvXPBtnOneApply: TJvXPButton;
    JvGradient1: TJvGradient;
    ColorDialog: TColorDialog;
    procedure ShowModal(MM: TMemo); overload;
    procedure JvXPBtnColorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmColorParam: TFrmColorParam;

implementation

{$R *.dfm}

{ TFrmColorParam }

procedure TFrmColorParam.JvXPBtnColorClick(Sender: TObject);
begin
  if Not ColorDialog.Execute then Exit;
end;

procedure TFrmColorParam.ShowModal(MM: TMemo);
var i: ShortInt;
begin
  mmDemo.Clear;
  for i := 0 to 5 do mmDemo.Lines.Add('Font: '+MM.Font.Name);
  mmDemo.Font := MM.Font;
  ColorBox.Color := MM.Color;
  ShowModal;
end;

end.
