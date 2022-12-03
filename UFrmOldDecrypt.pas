unit UFrmOldDecrypt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, CryptMod;

type
  TFrmOldDeCrypt = class(TForm)
    mmSource: TMemo;
    mmDest: TMemo;
    Splitter1: TSplitter;
    PnlSource: TPanel;
    PnlDest: TPanel;
    Pnl: TPanel;
    // JvXPBtnImport: TJvXPButton;
    // JvXPBtnSave: TJvXPButton;
    // JvXPBtnDecrypt: TJvXPButton;
    // JvGradient1: TJvGradient;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure JvXPBtnImportClick(Sender: TObject);
    procedure JvXPBtnDecryptClick(Sender: TObject);
    procedure JvXPBtnSaveClick(Sender: TObject);
  private
    ALGO: TAlgoType;
    PASSWORD: AnsiString;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmOldDeCrypt: TFrmOldDeCrypt;

implementation

USES UfrmMain, UFrmSelectEncrypt, UFrmMasterPwd;

{$R *.dfm}

procedure TFrmOldDeCrypt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmOldDeCrypt.JvXPBtnDecryptClick(Sender: TObject);
var
  Actxt: AnsiString;
begin
  if mmSource.lines.Count = 0 then Exit;
  FrmSelectEncrypt.FrmShowModal(DLG_DECRYPT);
  if FrmSelectEncrypt.Apply = False then Exit;
  ALGO := GetAlgoType(FrmSelectEncrypt.CmBoxExAlgo.ItemsEx
    [FrmSelectEncrypt.CmBoxExAlgo.ItemIndex].Caption);
  case FrmSelectEncrypt.RadioGroup.ItemIndex of
    0:
      begin
        // Decrypt the MASTER_PASSWORD
        // Проверка мастер пароля
        if MASTER_PASSWORD = '' then
        begin
          FrmMain.Act_GetMasterPasswordExecute(Nil);
        end;
        PASSWORD := MASTER_PASSWORD;
      end;
    1:
      begin
        // Decrypt the OLP PASSWOD
        FrmMasterPwd.ShowModeDlg(DLG_OLDPWD);
        if FrmMasterPwd.Apply = False then
          Exit;
        PASSWORD := FrmMasterPwd.edPwd1.Text;
      end;
  end;
  Actxt := mmSource.Text;
  case ALGO of
    RC4_SHA1:   mmDest.Text := DecryptRC4_SHA1(PASSWORD, Actxt);
    RC4_SHA256: mmDest.Text := DecryptRC4_SHA256(PASSWORD, Actxt);
    RC4_SHA512: mmDest.Text := DecryptRC4_SHA512(PASSWORD, Actxt);
  end;

end;

procedure TFrmOldDeCrypt.JvXPBtnImportClick(Sender: TObject);
begin
  FrmMain.OpenDialog.Filter := 'Все файлы (*.*)|*.*';
  if Not FrmMain.OpenDialog.Execute then Exit;
  mmSource.lines.LoadFromFile(FrmMain.OpenDialog.FileName);
end;

procedure TFrmOldDeCrypt.JvXPBtnSaveClick(Sender: TObject);
begin
  if not FrmMain.SaveDialog.Execute then Exit;
  mmDest.lines.SaveToFile(FrmMain.SaveDialog.FileName);
end;

end.
