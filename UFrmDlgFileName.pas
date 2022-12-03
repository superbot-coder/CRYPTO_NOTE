unit UFrmDlgFileName;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmDlgFileName = class(TForm)
    BtnOk: TButton;
    edFileName: TEdit;
    lblFileName: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDlgFileName: TFrmDlgFileName;

implementation

{$R *.dfm}

procedure TFrmDlgFileName.btnOkClick(Sender: TObject);
begin
  if edFileName.Text = '' then Exit;
end;

procedure TFrmDlgFileName.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then Close;
end;

end.
