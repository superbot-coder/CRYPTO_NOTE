unit UFrmMDIChild;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  JvExControls, JvXPCore, JvXPButtons, CryptMod, JvExStdCtrls,
  Vcl.ComCtrls, Error, MsgLog, JvButton, JvNavigationPane, JvLabel, JvGradient,
  sStatusBar, sButton, sPanel, sMemo, sSkinProvider;

type TMDIStatusFile = (sfNewFile, sfCryptFile, sfUnCryptFile, sfUnDecryptedFile);

type
  TFrmMDIChild = class(TForm)
    sPnlBar: TsPanel;
    sBtnSaveUnCrypt: TsButton;
    ImageLogo: TImage;
    StatusBar: TsStatusBar;
    sBtnSave: TsButton;
    sBtnDecrypt: TsButton;
    sBtnEncrypt: TsButton;
    mm: TsMemo;
    sBtnParam: TsButton;
    sSkinProvider: TsSkinProvider;
    procedure mmChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SaveFileCrypt;
    procedure SaveFile(Notification: Boolean);
    procedure EnCryptTxtToSave(EnCryptFileName: String; PAtxt: PAnsiChar; ALGO: TAlgoType; APwd: AnsiString);
    procedure SetPassword;
    Procedure EncryptFile;
    procedure FormCreate(Sender: TObject);
    procedure SetStatusBarInfo;
    procedure JvXPBtnDecryptClick(Sender: TObject);
    procedure JvXPBtnFontDlgClick(Sender: TObject);
    procedure SaveDialogNewFile(sfType: TMDIStatusFile);
    procedure sBtnSaveClick(Sender: TObject);
    procedure sBtnSaveUnCryptClick(Sender: TObject);
    procedure sBtnDecryptClick(Sender: TObject);
    procedure sBtnEncryptClick(Sender: TObject);
    procedure sBtnParamClick(Sender: TObject);
  private
    PASSWORD: AnsiString;
    { Private declarations }
  public
    ChangeTxt: Boolean;
    //FileNameCrypt : String;
    MDIStatusFile : TMDIStatusFile;
    TabSetID: String;
    ALGO: TAlgoType;
    OpenedFileName: String;
  end;

var
  FrmMDIChild: TFrmMDIChild;

implementation

Uses
UFrmMain, UFrmDlgFileName, UFrmConfig, UFrmSelectEncrypt,
UFrmMasterPwd, UFrmColorParam;

{$R *.dfm}

procedure TFrmMDIChild.EncryptFile;
var
  st: TStrings;
  Atxt, Password : AnsiString;
  EncriptFileName, ext: String;
  SourceFile: String;
  NewTabName: String;
begin

  // Проверка и генерация Имени Файла
  case MDIStatusFile of
    sfNewFile:
      begin
        SaveDialogNewFile(sfCryptFile);
        if OpenedFileName = '' then Exit;
        EncriptFileName := OpenedFileName;
      end;

    sfCryptFile:
      begin
        EncriptFileName := OpenedFileName; //lblFileName.Caption;
      end;

    sfUnCryptFile:
      begin
        ext := ExtractFileExt(OpenedFileName);
        EncriptFileName := Copy(OpenedFileName,1 , Length(OpenedFileName) - Length(ext));
        EncriptFileName := EncriptFileName + '.ctxt';
      end;

  end;

  FrmSelectEncrypt.FrmShowModal(DLG_ECRYPT);
  if FrmSelectEncrypt.Apply = false then Exit;
  case FrmSelectEncrypt.RadioGroup.ItemIndex of
    0: begin
         if MASTER_PASSWORD = '' then
           FrmMain.Act_GetMasterPasswordExecute(Nil);
         //if MASTER_PASSWORD = '' then
         //begin
         //  FrmMasterPwd.ShowModal;
         //end;
         if MASTER_PASSWORD = '' then
         begin
           MessageBox(Handle, PChar('МАСТЕР ПАРОЛЬ не был введен.'),
                      PChar(MB_CAPTION), MB_ICONWARNING);
           Exit;
         end;

         PASSWORD := MASTER_PASSWORD;
       end;

    1: begin
         // Диалог
       end;
  end;

  // Шифруем и сохраняем
  EnCryptTxtToSave(EncriptFileName, PAnsiChar(AnsiString(mm.Text)), ALGO, PASSWORD);

  // обновляю статусы и свойства формы
  if MDIStatusFile = sfNewFile then
  begin
    NewTabName :=  FrmMain.IncrementTabsName(ExtractFileName(EncriptFileName));
    FrmMain.TabSetReplase(TabSetID, NewTabName);
    TabSetID   := NewTabName;
  end;
  MDIStatusFile          := sfCryptFile;
  SourceFile             := OpenedFileName;
  OpenedFileName         := EncriptFileName;
  Caption                := EncriptFileName;

  if FrmSelectEncrypt.ChBoxDeleteSource.Checked then
  begin
    if FileExists(EncriptFileName) then
    begin
      if DeleteFile(SourceFile) then
        FrmMain.DeletNodeFromTreeVies(SourceFile);
    end;
  end;

  // обновления списка дерева файлов
  SetStatusBarInfo;
  if FileExists(EncriptFileName) then
    FrmMain.AddNodeToTreeView(EncriptFileName, IMG_INDEX_CTXT);
  //FrmMain.Act_UpDateFileListBrowserExecute(nil);

  MessageBox(Handle, PChar('Файл успешно зашифрован и сохранен.'),
             PChar(MB_CAPTION), MB_ICONINFORMATION);
end;

procedure TFrmMDIChild.EnCryptTxtToSave(EnCryptFileName: String; PAtxt: PAnsiChar; ALGO: TAlgoType; APwd: AnsiString);
var st   : TStrings;
   Atxt, Actxt  : AnsiString;
   ASign  : AnsiString; //Signature
   d_size: Integer;
begin
  try
    st   := TStringList.Create;
    d_size := Length(PAnsiChar(PAtxt));

    // шифруемый текст менее 20 символов, то добавляются еще 20 символов мусора
    if d_size < 20 then
      //Atxt := 'dsz:' + IntToStr(d_size) + ';' + mm.Text + #13 + GetTrashStr(20)
      Atxt := 'dsz:' + IntToStr(d_size) + ';' + PAnsiChar(PAtxt) + #13 + GetTrashStr(20)
    else
      Atxt := Atxt +  PAnsiChar(PAtxt);
      //Atxt := Atxt + mm.Text;

    ASign := ASign+ 'sign:0;' + GetMD5Hash(Atxt); // add to Signature hash_md5_txt
    case ALGO of
      RC4_SHA1:   Actxt := EncryptRC4_SHA1(APwd, Atxt);  // шифруеется
      RC4_SHA256: Actxt := EncryptRC4_SHA256(APwd, Atxt);  // шифруеется
      RC4_SHA512: Actxt := EncryptRC4_SHA512(APwd, Atxt);  // шифруеется
    end;

    ASign := ASign + ';' + GetMD5Hash(Actxt);    // add to Signature hash_md5_ctxt
    ASign := ASign + ';' + AlgoName[ALGO];       // add to Signature vertion Algoritm
    st.Add(ASign);
    st.Add(Actxt);
    st.SaveToFile(EnCryptFileName);
  finally
    st.Free;
  end;
end;

procedure TFrmMDIChild.FormClose(Sender: TObject; var Action: TCloseAction);
var i: integer;
begin
  if ChangeTxt then
    case MessageBox(Handle, PChar('Сохранить изменения в тексте?'),
                  PChar(MB_CAPTION), MB_YESNOCANCEL or MB_ICONQUESTION) of

     ID_YES     : SaveFile(false);
     ID_CANCEL  : begin Action := caNone; Exit; end;
    end;

  // Удатение TabSet элемента
  if FrmMain.TabSet.Tabs.Count <> 0 then
  begin
    for I:=0 to FrmMain.TabSet.Tabs.Count do
    begin
      if TabSetID =  FrmMain.TabSet.Tabs[i] then
      begin
       FrmMain.TabSet.Tabs.Delete(i);
       Break;
     end;
    end;
  end;

  Action := caFree;
end;

procedure TFrmMDIChild.FormCreate(Sender: TObject);
begin
  ALGO                 := RC4_SHA1;
  ChangeTxt            := False;
  Constraints.MinWidth := 725;
  Constraints.MinHeight:= 300
end;

procedure TFrmMDIChild.JvXPBtnDecryptClick(Sender: TObject);
var
  Sign: TSignature;
  Atxt: AnsiString;
  szd, i:  Integer;
begin
  SendDebugMsg('procedure TFrmMDIChild.FormCreate(Sender: TObject);');
  FrmSelectEncrypt.FrmShowModal(DLG_DECRYPT);
  if FrmSelectEncrypt.Apply = False then Exit;
  ALGO := GetAlgoType(FrmSelectEncrypt.CmBoxExAlgo.ItemsEx[FrmSelectEncrypt.CmBoxExAlgo.ItemIndex].Caption);

  case FrmSelectEncrypt.RadioGroup.ItemIndex of

    0: begin
         //Decrypt the MASTER_PASSWORD
         // Проверка мастер пароля
         if MASTER_PASSWORD = '' then
         begin
           FrmMain.Act_GetMasterPasswordExecute(Nil);
         end;
         PASSWORD := MASTER_PASSWORD;
       end;

    1: begin
         // Decrypt the OLP PASSWOD
         FrmMasterPwd.ShowModeDlg(DLG_OLDPWD);
         if FrmMasterPwd.Apply = False then Exit;
         PASSWORD := FrmMasterPwd.edPwd1.Text;
       end;
  end;

  st := TStringList.Create;
  try
    st.LoadFromFile(OpenedFileName);
    GetSignature(st.Strings[0],@Sign);

    if Sign.Checked then
    begin
      if Sign.hash_encrypt <> GetMD5Hash(st.Strings[1]) then
      begin
       if MessageBox(Handle,
                     PChar('Хэш из сигнатуры несовпадает с полученным хешем зашифрованного файла,' + #13+
                           'возможно файл поврежден и его не удастся правильно дешифровать.'+ #13+
                           'Вы желаете продолжить?'),
                     PChar(MB_CAPTION),
                     MB_ICONWARNING or MB_YESNO) = IDNO
       then Exit;
      end;

      case ALGO of
        RC4_SHA1:   Atxt := DecryptRC4_SHA1(PASSWORD, st.Strings[1]);
        RC4_SHA256: Atxt := DecryptRC4_SHA256(PASSWORD, st.Strings[1]);
        RC4_SHA512: Atxt := DecryptRC4_SHA512(PASSWORD, st.Strings[1]);
      end;

      if Sign.hash_uncrypt <> GetMD5Hash(Atxt) then
      begin
        MessageBox(Handle,
                   PChar('Текст не убалось дешифровать,' + #13 +
                         'хэш сигнатуры не совпал с дешифрованным текстом.' + #13 +
                         'Возможно был выбран не верный алгоритм или введен не верный пароль.'),
                   PChar(MB_CAPTION), MB_ICONWARNING);
        mm.ReadOnly := True;
      end
      else
      begin
        if 'szd:' = Copy(Atxt, 1, 4) then
        begin
          i := FrmMain.ConvertStringToInteger(copy(Atxt, 5 , AnsiPos(';', Atxt) - 4));
          Atxt := Copy(Atxt, AnsiPos(';', Atxt) + 1, i);
        end;
        mm.ReadOnly := False;
        sBtnEncrypt.Enabled := true;
      end;
      mm.Text := Atxt;

    end
      else
    begin
      if MessageBox(Handle,
         PChar('Сигнатура файла не найдена или повреждена.'+#13+
               'Возможно этот файл не является зашифровонным. '+
               'Возможно дальнейшая расшифровка текста не удастся.'+#13+
               'Вы хотит продолжить?'),
         PChar(MB_CAPTION), MB_ICONWARNING or MB_YESNO) = IDNO
      then Exit;

     for i := 0 to st.Count -1 do
     begin
       case ALGO of
         RC4_SHA1:   Atxt := DecryptRC4_SHA1(PASSWORD, st.Strings[i]);
         RC4_SHA256: Atxt := DecryptRC4_SHA256(PASSWORD, st.Strings[i]);
         RC4_SHA512: Atxt := DecryptRC4_SHA512(PASSWORD, st.Strings[i]);
       end;

       if 'szd:' = Copy(Atxt, 1, 4) then
       begin
         szd  := FrmMain.ConvertStringToInteger(copy(Atxt, 5 , AnsiPos(';', Atxt) - 4));
         Atxt := Copy(Atxt, AnsiPos(';', Atxt) + 1, szd);
         mm.Text := Atxt;
         Break;
       end;

     end;

    end;

  finally
    st.Free
  end;

end;

procedure TFrmMDIChild.JvXPBtnFontDlgClick(Sender: TObject);
begin
  FrmMain.FontDialog.Font := mm.Font;
  if Not FrmMain.fontDialog.Execute then exit;
  mm.Font := FrmMain.FontDialog.Font;

end;

procedure TFrmMDIChild.mmChange(Sender: TObject);
begin
  ChangeTxt := True;
end;

procedure TFrmMDIChild.SaveDialogNewFile(sfType: TMDIStatusFile);
begin
  FrmMain.SaveDialog.FileName := '';
  case sfType of
    sfNewFile   :
      begin
        FrmMain.SaveDialog.Filter := 'Text file (*.txt)|*.txt';
        if Not FrmMain.SaveDialog.Execute then Exit;
        if AnsiLowerCase(ExtractFileExt(FrmMain.SaveDialog.FileName)) <> '.txt' then
          OpenedFileName := FrmMain.SaveDialog.FileName + '.txt'
        else OpenedFileName := FrmMain.SaveDialog.FileName;
      end;
    sfCryptFile :
      begin
        FrmMain.SaveDialog.Filter := 'Crypted Text file (*.ctxt)|*.ctxt';
        if Not FrmMain.SaveDialog.Execute then Exit;
        if AnsiLowerCase(ExtractFileExt(FrmMain.SaveDialog.FileName)) <> '.ctxt' then
          OpenedFileName := FrmMain.SaveDialog.FileName + '.ctxt'
        else OpenedFileName := FrmMain.SaveDialog.FileName;
      end;
  end;

  if FileExists(OpenedFileName) then
    if MessageBox(Handle,
                PChar(OpenedFileName+' Фай, уже существует.' + #13 + 'Заменить?'),
                PChar(MB_CAPTION),
                MB_YESNO or MB_ICONWARNING) = ID_NO then
    begin
      OpenedFileName := '';
    end;
end;

procedure TFrmMDIChild.SaveFile(Notification: Boolean);
begin
  case MDIStatusFile of
    sfNewFile:
      begin
        SaveDialogNewFile(sfNewFile);
        if OpenedFileName = '' then Exit;
        mm.Lines.SaveToFile(OpenedFileName);
        Caption := OpenedFileName;
        FrmMain.TabSetReplase(TabSetID, FrmMain.IncrementTabsName(ExtractFileName(OpenedFileName)));
        SetStatusBarInfo;
        MDIStatusFile := sfUnCryptFile;
      end;

    // Сохранение Криптованного файла
    sfCryptFile:
      begin
        EnCryptTxtToSave(OpenedFileName, PAnsiChar(AnsiString(mm.Text)), ALGO , PASSWORD);
      end;

    sfUnCryptFile:
      begin
        mm.Lines.SaveToFile(OpenedFileName);
      end;

    sfUnDecryptedFile:
      begin
        //
      end;
    end;
  if Notification then
    MessageBox(Handle,PChar('Файл '+OpenedFileName+' был сохранен.'),
               PChar(MB_CAPTION), MB_ICONINFORMATION);
end;

procedure TFrmMDIChild.SaveFileCrypt;
var FileCrypt: String;
begin
  ShowMessage('TFrmMDIChild.SaveFileCrypt = is empty');
  {
  if FileNameCrypt = '' then
  begin
    FrmDlgFileName.ShowModal;
    //FrmMain.savedialog.InitialDir := FrmConfig.edEncryptDir.Text;
    if Not FrmMain.savedialog.Execute then Exit;
    lblFileName.Caption := FrmMain.savedialog.FileName;
    caption := FrmMain.savedialog.FileName;
    ChangeTxt := false;
  end;
   }
end;

procedure TFrmMDIChild.sBtnDecryptClick(Sender: TObject);
var
  Sign: TSignature;
  Atxt: AnsiString;
  szd, i:  Integer;
begin
  SendDebugMsg('procedure TFrmMDIChild.FormCreate(Sender: TObject);');
  FrmSelectEncrypt.FrmShowModal(DLG_DECRYPT);
  if FrmSelectEncrypt.Apply = False then Exit;
  ALGO := GetAlgoType(FrmSelectEncrypt.CmBoxExAlgo.ItemsEx[FrmSelectEncrypt.CmBoxExAlgo.ItemIndex].Caption);

  case FrmSelectEncrypt.RadioGroup.ItemIndex of

    0: begin
         //Decrypt the MASTER_PASSWORD
         // Проверка мастер пароля
         if MASTER_PASSWORD = '' then
         begin
           FrmMain.Act_GetMasterPasswordExecute(Nil);
         end;
         PASSWORD := MASTER_PASSWORD;
       end;

    1: begin
         // Decrypt the OLP PASSWOD
         FrmMasterPwd.ShowModeDlg(DLG_OLDPWD);
         if FrmMasterPwd.Apply = False then Exit;
         PASSWORD := FrmMasterPwd.edPwd1.Text;
       end;
  end;

  st := TStringList.Create;
  try
    st.LoadFromFile(OpenedFileName);
    GetSignature(st.Strings[0],@Sign);

    if Sign.Checked then
    begin
      if Sign.hash_encrypt <> GetMD5Hash(st.Strings[1]) then
      begin
       if MessageBox(Handle,
                     PChar('Хэш из сигнатуры несовпадает с полученным хешем зашифрованного файла,' + #13+
                           'возможно файл поврежден и его не удастся правильно дешифровать.'+ #13+
                           'Вы желаете продолжить?'),
                     PChar(MB_CAPTION),
                     MB_ICONWARNING or MB_YESNO) = IDNO
       then Exit;
      end;

      case ALGO of
        RC4_SHA1:   Atxt := DecryptRC4_SHA1(PASSWORD, st.Strings[1]);
        RC4_SHA256: Atxt := DecryptRC4_SHA256(PASSWORD, st.Strings[1]);
        RC4_SHA512: Atxt := DecryptRC4_SHA512(PASSWORD, st.Strings[1]);
      end;

      if Sign.hash_uncrypt <> GetMD5Hash(Atxt) then
      begin
        MessageBox(Handle,
                   PChar('Текст не убалось дешифровать,' + #13 +
                         'хэш сигнатуры не совпал с дешифрованным текстом.' + #13 +
                         'Возможно был выбран не верный алгоритм или введен не верный пароль.'),
                   PChar(MB_CAPTION), MB_ICONWARNING);
        mm.ReadOnly := True;
      end
      else
      begin
        if 'szd:' = Copy(Atxt, 1, 4) then
        begin
          i := FrmMain.ConvertStringToInteger(copy(Atxt, 5 , AnsiPos(';', Atxt) - 4));
          Atxt := Copy(Atxt, AnsiPos(';', Atxt) + 1, i);
        end;
        mm.ReadOnly := False;
        sBtnEncrypt.Enabled := true;
      end;
      mm.Text := Atxt;

    end
      else
    begin
      if MessageBox(Handle,
         PChar('Сигнатура файла не найдена или повреждена.'+#13+
               'Возможно этот файл не является зашифровонным. '+
               'Возможно дальнейшая расшифровка текста не удастся.'+#13+
               'Вы хотит продолжить?'),
         PChar(MB_CAPTION), MB_ICONWARNING or MB_YESNO) = IDNO
      then Exit;

     for i := 0 to st.Count -1 do
     begin
       case ALGO of
         RC4_SHA1:   Atxt := DecryptRC4_SHA1(PASSWORD, st.Strings[i]);
         RC4_SHA256: Atxt := DecryptRC4_SHA256(PASSWORD, st.Strings[i]);
         RC4_SHA512: Atxt := DecryptRC4_SHA512(PASSWORD, st.Strings[i]);
       end;

       if 'szd:' = Copy(Atxt, 1, 4) then
       begin
         szd  := FrmMain.ConvertStringToInteger(copy(Atxt, 5 , AnsiPos(';', Atxt) - 4));
         Atxt := Copy(Atxt, AnsiPos(';', Atxt) + 1, szd);
         mm.Text := Atxt;
         Break;
       end;

     end;

    end;

  finally
    st.Free
  end;
end;

procedure TFrmMDIChild.sBtnEncryptClick(Sender: TObject);
begin
  if mm.Lines.Count = 0 then exit;
  EncryptFile;
end;

procedure TFrmMDIChild.sBtnParamClick(Sender: TObject);
begin
  FrmColorParam.ShowModal(mm);
end;

procedure TFrmMDIChild.sBtnSaveClick(Sender: TObject);
begin
  if mm.Lines.Count = 0 then exit;
  SaveFile(true);
  SetStatusBarInfo;
  ChangeTxt := false;
end;

procedure TFrmMDIChild.sBtnSaveUnCryptClick(Sender: TObject);
var FileName, ext: string;
begin
  if mm.Lines.Count = 0 then Exit;
  case MDIStatusFile of
    sfNewFile:
      begin
         //
      end;
    else
      begin
        ext := ExtractFileExt(OpenedFileName);
        FileName := copy(OpenedFileName, 1,
                        Length(OpenedFileName) - length(ext)) +'.txt';

        if FileExists(FileName) then
        begin
          if MessageBox(Handle,
                        PChar('Файл с таким именем '+FileName+
                        ' уже существует, вы хотите его заменить?'),
                        PChar(MB_CAPTION),MB_YESNO or MB_ICONWARNING) = IDNO
          then Exit;
        end;

        mm.Lines.SaveToFile(FileName);
        MessageBox(Handle,PChar('Файл успешно сохранен.'),
                   PChar(MB_CAPTION), MB_ICONINFORMATION);
      end;
  end;

  FrmMain.AddNodeToTreeView(FileName, IMG_INDEX_TXT);
  //FrmMain.Act_UpDateFileListBrowserExecute(Nil);
end;

procedure TFrmMDIChild.SetPassword;
begin
  PASSWORD := MASTER_PASSWORD;
end;

procedure TFrmMDIChild.SetStatusBarInfo;
var
  SR : TSearchRec;
  sys_time: _SYSTEMTIME;
  LocalTime : tFileTime;
  str_dt: String;
begin

  if OpenedFileName = '' then
  begin
    StatusBar.Panels[0].Text := 'Создан: 00.00.0000 00:00:00';
    StatusBar.Panels[1].Text := 'Изменен: 00.00.0000 00:00:00';
    Exit;
  end;

  if FindFirst(OpenedFileName, faAnyFile, SR) = 0 then
  begin
    FileTimeToLocalFileTime(SR.FindData.ftCreationTime, LocalTime);
    FileTimeToSystemTime(LocalTime, sys_time);
    SetLength(str_dt, GetDateFormat(LOCALE_SYSTEM_DEFAULT,0,@sys_time,PChar('dd MMMM yyyy'),Nil,0));
    GetDateFormat(LOCALE_SYSTEM_DEFAULT,0,@sys_time,PChar('dd MMMM yyyy'),PChar(str_dt),Length(str_dt));
    StatusBar.Panels[0].Text := 'Создан: ' + Trim(str_dt) + ' ' + TimeToStr(SystemTimeToDateTime(sys_time));

    FileTimeToLocalFileTime(SR.FindData.ftLastWriteTime, LocalTime);
    FileTimeToSystemTime(LocalTime, sys_time);
    SetLength(str_dt, GetDateFormat(LOCALE_SYSTEM_DEFAULT,0,@sys_time,PChar('dd MMMM yyyy'),Nil,0));
    GetDateFormat(LOCALE_SYSTEM_DEFAULT,0,@sys_time,PChar('dd MMMM yyyy'),PChar(str_dt),Length(str_dt));
    StatusBar.Panels[1].Text := 'Изменен: ' + Trim(str_dt) + ' ' + TimeToStr(SystemTimeToDateTime(sys_time));
  end;

end;

end.
