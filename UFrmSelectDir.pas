unit UFrmSelectDir;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ComCtrls;

Type
  TFrmInitMode = (fmMasterDir, fmBuckUpDir);

type
  TFrmSelectDir = class(TForm)
    LVDir: TListView;
    BtnOK: TButton;
    Procedure ShowModalInit(FrmMode: TFrmInitMode);
    procedure BtnOKClick(Sender: TObject);
  private
    FFrmMode: TFrmInitMode;
    { Private declarations }
  public
    Apply: Boolean;

    { Public declarations }
  end;

var
  FrmSelectDir: TFrmSelectDir;

implementation

USES UFrmConfig, UFrmMain;

{$R *.dfm}
{ TFrmSelectDir }

procedure TFrmSelectDir.BtnOKClick(Sender: TObject);
var
  i: SmallInt;
  CheckedCount: SmallInt;
begin
  if FFrmMode = fmMasterDir then
  begin
    CheckedCount := 0;
    for i := 0 to LVDir.Items.Count - 1 do
      if LVDir.Items[i].Checked then
        inc(CheckedCount);
    if CheckedCount > 1 then
    begin
      MessageBox(Handle,
        PChar('ћастер директори¤ не может быть более чем одна директори¤. ' +
        '—нимите лишнии галочки.'), PChar(MB_CAPTION), MB_ICONWARNING);
      exit;
    end;
  end;
  Apply := True;
  Close;
end;

procedure TFrmSelectDir.ShowModalInit(FrmMode: TFrmInitMode);
var
  i: SmallInt;
  NewItem: TListItem;
begin
  FFrmMode := FrmMode;
  LVDir.Clear;
  if FrmConfig.LVDir.Items.Count = 0 then exit;
  for i := 0 to FrmConfig.LVDir.Items.Count - 1 do
  begin
    NewItem := LVDir.Items.Add;
    NewItem.Caption := FrmConfig.LVDir.Items[i].Caption;
    NewItem.ImageIndex := 0;
  end;

  ShowModal;
end;

end.
