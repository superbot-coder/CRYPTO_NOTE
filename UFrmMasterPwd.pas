unit UFrmMasterPwd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Registry, CryptMod;

Type TDlgPwdMode = (DLG_MASTERPWD, DLG_OLDPWD);

type
  TFrmMasterPwd = class(TForm)
    BtnSave: TButton;
    edPwd1: TLabeledEdit;
    edPwd2: TLabeledEdit;
    ChBoxStrView: TCheckBox;
    ChBoxSaveНаrdLink: TCheckBox;
    procedure BtnSaveClick(Sender: TObject);
    procedure ChBoxStrViewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SaveMasterPassword;
    procedure ShowModeDlg(DlgMode: TDlgPwdMode);
  private
    { Private declarations }
    Procedure ReadPassword;
  public
    Apply: Boolean;
    DialogMode: TDlgPwdMode;
    { Public declarations }
  end;

var
  FrmMasterPwd: TFrmMasterPwd;
  Reg : Tregistry;
implementation

USES UFrmMain;

{$R *.dfm}

procedure TFrmMasterPwd.BtnSaveClick(Sender: TObject);
begin
  if edPwd1.Text = '' then
  begin
    ShowMessage('Введите пароль.');
    exit;
  end;

  case DialogMode of
    DLG_MASTERPWD :
     begin
       if edPwd1.Text <> edPwd2.Text then
       begin
         ShowMessage('Веденные пароли не совпадают');
         Exit;
       end;
       MASTER_PASSWORD := edPwd1.Text;
       SaveMasterPassword;
     end;

    DLG_OLDPWD    :
      begin
        //
      end;

  end;

  Apply := True;
  Close;
end;

procedure TFrmMasterPwd.ChBoxStrViewClick(Sender: TObject);
begin
  if ChBoxStrView.Checked then
  begin
    edPwd1.PasswordChar := #0;
    edPwd2.PasswordChar := #0;
  end
    else
  begin
    edPwd1.PasswordChar := '*';
    edPwd2.PasswordChar := '*';
  end;

end;

procedure TFrmMasterPwd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  edPwd1.Text := '';
  edPwd2.Text := '';
end;

procedure TFrmMasterPwd.FormCreate(Sender: TObject);
begin
  ReadPassword;
end;

procedure TFrmMasterPwd.ShowModeDlg(DlgMode: TDlgPwdMode);
begin
  Apply      := False;
  DialogMode := DlgMode;

  Case DlgMode of

    DLG_MASTERPWD:
     begin
       Height  := 230;
       Caption := 'Мастер пароль';
       ChBoxSaveНаrdLink.Visible := true;
       ChBoxSaveНаrdLink.Checked := False;
       edPwd2.Show;
     end;

    DLG_OLDPWD:
     begin
       Height  := 160;
       Caption := 'Пароль';
       ChBoxSaveНаrdLink.Visible := False;
       edPwd1.Text := '';
       edPwd2.Hide;
     end;

  End;
  ShowModal;
end;

procedure TFrmMasterPwd.ReadPassword;
var Reg: Tregistry;
begin
  try
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\CryptoNote', true) then
    begin
      G_PWDHASH := Reg.ReadString('PasswordHash');
      MASTER_PASSWORD := Reg.ReadString('MasterPassword');


      if MASTER_PASSWORD = '' then
      begin
        G_PWDHASH := '';
        Exit;
      end;

      MASTER_PASSWORD := DecryptRC4_SHA1(GetKey, MASTER_PASSWORD);

      if G_PWDHASH = GetMD5Hash(MASTER_PASSWORD) then
      begin
        MASTER_PASSWORD      := copy(MASTER_PASSWORD, 1, Length(MASTER_PASSWORD) - 16);
        edPwd1.Text := '********';
        edPwd2.Text := '********';
        ChBoxSaveНаrdLink.Checked := True;
      end
        else
      begin;
        G_PWDHASH := '';
        MASTER_PASSWORD := '';
        edPwd1.Text := '';
        edPwd2.Text := '';
      end;

      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TFrmMasterPwd.SaveMasterPassword;
var
  s_rand : AnsiString;
  PwdHash: AnsiString;
       i : Integer;
begin
  if ChBoxSaveНаrdLink.Checked then
  begin
    try
      Reg := TRegistry.Create;
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('\Software\CryptoNote', true) then
      begin

        for i:=1 to 16 do s_rand := s_rand + AnsiChar(Random(255));
        PwdHash := GetMD5Hash(MASTER_PASSWORD + s_rand);

        Reg.WriteString('MasterPassword', EncryptRC4_SHA1(GetKey, MASTER_PASSWORD + s_rand));
        Reg.WriteString('PasswordHash', PwdHash);

        Reg.CloseKey;
        MessageBox(Handle,PChar('МАСТЕР ПАРОЛЬ сохранен и привязан к компьютеру, '+
         ' МАСТЕР ПАРОЛЬ будет действовать пока его не замените.'),
         PChar(MB_CAPTION), MB_ICONINFORMATION);
      end;
    finally
      Reg.Free;
    end;
  end
    else
  begin
    try
      Reg := TRegistry.Create;
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('\Software\CryptoNote', true) then
      begin
        Reg.WriteString('MasterPassword', '');
        Reg.WriteString('PasswordHash', '');
        Reg.CloseKey;
        MessageBox(Handle,
                   PChar('МАСТЕР ПАРОЛЬ введен и будет действовать пока не закроете программу'),
                   PChar(MB_CAPTION), MB_ICONINFORMATION);
      end;
    finally
      Reg.Free;
    end
  end;
end;

end.
