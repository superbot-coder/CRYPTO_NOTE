unit UFrmMDIChild;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Error, MsgLog, SynEditHighlighter,
  SynHighlighterGeneral, SynEdit, System.StrUtils, CryptMod, System.IOUtils,
  JSON, REST.JSON;

type
  TMDIStatusFile = (sfNewFile, sfCryptFile, sfUnCryptFile, sfUnDecryptedFile);

type
  TFrmMDIChild = class(TForm)
    SynGeneralSyn: TSynGeneralSyn;
    SynEdit: TSynEdit;
    PanelBar: TPanel;
    BtnEncrypt: TButton;
    BtnDecrypt: TButton;
    BtnSaveDecrypt: TButton;
    BtnSave: TButton;
    ImageLogo: TImage;
    StatusBar: TStatusBar;
    procedure mmChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SaveFileCrypt;
    procedure SaveFile(Notification: Boolean);
    procedure EnCryptTxtToSave(EnCryptFileName: String; PAtxt: PAnsiChar;
      ALGO: TAlgoType; APwd: AnsiString);
    procedure SetPassword;
    procedure EnCryptTxtToSaveTwo(EnCryptFileName: String; PAtxt: PAnsiChar;
      ALGO: TAlgoType; APwd: AnsiString);
    procedure FormCreate(Sender: TObject);
    procedure SetStatusBarInfo;
    procedure SetStatusBarInfoTwo;
    // procedure JvXPBtnDecryptClick(Sender: TObject);
    procedure SaveDialogNewFile(sfType: TMDIStatusFile);
    procedure BtnEncryptClick(Sender: TObject);
    procedure BtnDecryptClick(Sender: TObject);
    procedure BtnSaveDecryptClick(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
  private
    FOpenFileError: boolean;
    PASSWORD: AnsiString;
    Procedure EncryptFile;
  public
    JFileObject: TJSONObject;
    ChangeTxt: Boolean;
    // FileNameCrypt : String;
    MDIStatusFile: TMDIStatusFile;
    TabSetID: String;
    ALGO: TAlgoType;
    OpenedFileName: String;
    property OpenFileError: boolean read FOpenFileError;
    procedure DecryptFile;
  end;

var
  FrmMDIChild: TFrmMDIChild;

implementation

Uses
  UFrmMain, UFrmDlgFileName, UFrmConfig, UFrmSelectEncrypt,
  UFrmMasterPwd, UFrmDebugs;

{$R *.dfm}

procedure TFrmMDIChild.BtnDecryptClick(Sender: TObject);
var
  Sign: TSignature;
  Atxt: AnsiString;
  szd, i: Integer;
begin
  SendDebugMsg('procedure TFrmMDIChild.FormCreate(Sender: TObject);');
  FrmSelectEncrypt.FrmShowModal(DLG_DECRYPT);
  if FrmSelectEncrypt.Apply = false then
    Exit;
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
        if FrmMasterPwd.Apply = false then
          Exit;
        PASSWORD := FrmMasterPwd.edPwd1.Text;
      end;
  end;

  st := TStringList.Create;
  try
    st.LoadFromFile(OpenedFileName);
    GetSignature(st.Strings[0], @Sign);

    if Sign.Checked then
    begin
      if Sign.hash_encrypt <> GetMD5Hash(st.Strings[1]) then
      begin
        if MessageBox(Handle,
          PChar('Хэш из сигнатуры несовпадает с полученным хешем зашифрованного файла,'
          + #13 + 'возможно файл поврежден и его не удастся правильно дешифровать.'
          + #13 + 'Вы желаете продолжить?'), PChar(MB_CAPTION),
          MB_ICONWARNING or MB_YESNO) = IDNO then
          Exit;
      end;

      case ALGO of
        RC4_SHA1:   Atxt := DecryptRC4_SHA1(PASSWORD, st.Strings[1]);
        RC4_SHA256: Atxt := DecryptRC4_SHA256(PASSWORD, st.Strings[1]);
        RC4_SHA512: Atxt := DecryptRC4_SHA512(PASSWORD, st.Strings[1]);
      end;

      if Sign.hash_uncrypt <> GetMD5Hash(Atxt) then
      begin
        MessageBox(Handle, PChar('Текст не убалось дешифровать,' + #13 +
          'хэш сигнатуры не совпал с дешифрованным текстом.' + #13 +
          'Возможно был выбран не верный алгоритм или введен не верный пароль.'),
          PChar(MB_CAPTION), MB_ICONWARNING);
        SynEdit.ReadOnly := True;
      end
      else
      begin
        if 'szd:' = Copy(Atxt, 1, 4) then
        begin
          i := FrmMain.ConvertStringToInteger
            (Copy(Atxt, 5, AnsiPos(';', Atxt) - 4));
          Atxt := Copy(Atxt, AnsiPos(';', Atxt) + 1, i);
        end;
        SynEdit.ReadOnly := false;
        BtnEncrypt.Enabled := True;
      end;
      SynEdit.Text := Atxt;

    end
    else
    begin
      if MessageBox(Handle, PChar('Сигнатура файла не найдена или повреждена.' +
        #13 + 'Возможно этот файл не является зашифровонным. ' +
        'Возможно дальнейшая расшифровка текста не удастся.' + #13 +
        'Вы хотит продолжить?'),
         PChar(MB_CAPTION), MB_ICONWARNING or MB_YESNO) = IDNO then Exit;

      for i := 0 to st.Count - 1 do
      begin
        case ALGO of
          RC4_SHA1:   Atxt := DecryptRC4_SHA1(PASSWORD, st.Strings[i]);
          RC4_SHA256: Atxt := DecryptRC4_SHA256(PASSWORD, st.Strings[i]);
          RC4_SHA512: Atxt := DecryptRC4_SHA512(PASSWORD, st.Strings[i]);
        end;

        if 'szd:' = Copy(Atxt, 1, 4) then
        begin
          szd := FrmMain.ConvertStringToInteger
            (Copy(Atxt, 5, AnsiPos(';', Atxt) - 4));
          Atxt := Copy(Atxt, AnsiPos(';', Atxt) + 1, szd);
          SynEdit.Text := Atxt;
          Break;
        end;

      end;

    end;

  finally
    st.Free
  end;
end;

procedure TFrmMDIChild.BtnEncryptClick(Sender: TObject);
begin
  if SynEdit.Lines.Count = 0 then Exit;
  EncryptFile;
end;

procedure TFrmMDIChild.BtnSaveClick(Sender: TObject);
begin
  if SynEdit.Lines.Count = 0 then Exit;
  SaveFile(True);
  SetStatusBarInfo;
  ChangeTxt := false;
end;

procedure TFrmMDIChild.BtnSaveDecryptClick(Sender: TObject);
var
  FileName, ext: string;
begin
  if SynEdit.Lines.Count = 0 then Exit;
  case MDIStatusFile of
    sfNewFile:
      begin
        //
      end;
  else
    begin
      ext := ExtractFileExt(OpenedFileName);
      FileName := Copy(OpenedFileName, 1, Length(OpenedFileName) - Length(ext)) + '.txt';

      if FileExists(FileName) then
      begin
        if MessageBox(Handle, PChar('Файл с таким именем ' + FileName +
          ' уже существует, вы хотите его заменить?'), PChar(MB_CAPTION),
          MB_YESNO or MB_ICONWARNING) = IDNO then
          Exit;
      end;

      SynEdit.Lines.SaveToFile(FileName);
      MessageBox(Handle, PChar('Файл успешно сохранен.'), PChar(MB_CAPTION),
        MB_ICONINFORMATION);
    end;
  end;

  FrmMain.AddNodeToTreeView(FileName, IMG_INDEX_TXT);
  // FrmMain.Act_UpDateFileListBrowserExecute(Nil);
end;

procedure TFrmMDIChild.DecryptFile;
var
  Atxt, Actxt: AnsiString;
  // JFileObject: TJSONObject;
  JContent: TJSONObject;
  JSONBytes: TBytes;
  Hash: String;
  StrValue: String;
  ALGO: TAlgoType;
begin

  //JSONBytes := System.IOUtils;
  JFileObject := TJSONObject.ParseJSONValue(TFile.ReadAllBytes(OpenedFileName), 0) as TJSONObject;
  try
    if JFileObject = Nil then
    begin
      FOpenFileError := true;
      Exit;
    end;

    FrmDebugs.AddDbgMessage(TJson.Format(JFileObject));

    Hash  := JFileObject.GetValue('content_hash').Value;
    Actxt := JFileObject.GetValue('content').Value;

    FrmDebugs.AddDbgMessage('Hash: ' + Hash);
    FrmDebugs.AddDbgMessage('content: ' + Actxt);


    if GetSHA1Hash(Actxt) <> Hash then
    begin
      FrmDebugs.AddDbgMessage('Error: Не верный content_hash, OpenFile: ' + OpenedFileName);
      Exit;
    end;

    StrValue := JFileObject.GetValue('algo_type').Value;

    //ALGO := ;
    case TAlgoType(AnsiIndexStr(StrValue, AlgoName)) of
      RC4_SHA1:   Atxt := DecryptRC4_SHA1(MASTER_PASSWORD, Actxt);
      RC4_SHA256: Atxt := DecryptRC4_SHA256(MASTER_PASSWORD, Actxt);
      RC4_SHA512: Atxt := DecryptRC4_SHA512(MASTER_PASSWORD, Actxt);
    else
      begin
        FrmDebugs.AddDbgMessage('Error: Не верный "algo_type", OpenFile: ' + OpenedFileName);
        Exit;
      end;
    end;

    FrmDebugs.AddDbgMessage('Atxt: ' + Atxt);

    JContent := TJSONObject.ParseJSONValue(Atxt) as TJSONObject;

    FrmDebugs.AddDbgMessage('JContent: ' + JContent.ToJSON);


    if JContent = Nil then
    begin
      FrmDebugs.AddDbgMessage('Error: var JContent = Nil OpenFile: ' + OpenedFileName);
      Exit;
    end;

    StrValue := JContent.GetValue('content_hash').Value;
    Atxt     := JContent.GetValue('content').Value;

    FrmDebugs.AddDbgMessage('content_hash: '+ StrValue);
    FrmDebugs.AddDbgMessage('Atxt: '+ Atxt);

    if GetSHA1Hash(Atxt) <> StrValue then
    begin
      FrmDebugs.AddDbgMessage('Error: Не верный content_hash 1 уровня OpenFile: ' + OpenedFileName);
      Exit;
    end;

    SynEdit.Lines.Text := Atxt;
    //SetStatusBarInfoTwo;

  except
    MessageBox(Handle, PChar('Возникла критическая ошибка при открытии файла'),
               PChar(MB_CAPTION), MB_ICONERROR);
    FOpenFileError := true;
  end;

end;

procedure TFrmMDIChild.EncryptFile;
var
  st: TStrings;
  Atxt, PASSWORD: AnsiString;
  EncriptFileName, ext: String;
  SourceFile: String;
  NewTabName: String;
begin

  // Проверка и генерация Имени Файла
  case MDIStatusFile of
    sfNewFile:
      begin
        SaveDialogNewFile(sfCryptFile);
        if OpenedFileName = '' then
          Exit;
        EncriptFileName := OpenedFileName;
      end;

    sfCryptFile:
      begin
        EncriptFileName := OpenedFileName; // lblFileName.Caption;
      end;

    sfUnCryptFile:
      begin
        ext := ExtractFileExt(OpenedFileName);
        EncriptFileName := Copy(OpenedFileName, 1, Length(OpenedFileName) -
          Length(ext));
        EncriptFileName := EncriptFileName + '.ctxt';
      end;

  end;

  FrmSelectEncrypt.FrmShowModal(DLG_ECRYPT);
  if FrmSelectEncrypt.Apply = false then
    Exit;
  case FrmSelectEncrypt.RadioGroup.ItemIndex of
    0:
      begin
        if MASTER_PASSWORD = '' then
          FrmMain.Act_GetMasterPasswordExecute(Nil);
        // if MASTER_PASSWORD = '' then
        // begin
        // FrmMasterPwd.ShowModal;
        // end;
        if MASTER_PASSWORD = '' then
        begin
          MessageBox(Handle, PChar('МАСТЕР ПАРОЛЬ не был введен.'),
            PChar(MB_CAPTION), MB_ICONWARNING);
          Exit;
        end;

        PASSWORD := MASTER_PASSWORD;
      end;

    1:
      begin
        // Диалог
      end;
  end;

  // Encrypt and save
  //EnCryptTxtToSave(EncriptFileName, PAnsiChar(AnsiString(SynEdit.Text)), ALGO, PASSWORD);
  EnCryptTxtToSaveTwo(EncriptFileName, PAnsiChar(AnsiString(SynEdit.Text)), ALGO, PASSWORD);

  // обновляю статусы и свойства формы
  if MDIStatusFile = sfNewFile then
  begin
    NewTabName := FrmMain.IncrementTabsName(ExtractFileName(EncriptFileName));
    FrmMain.TabSetReplase(TabSetID, NewTabName);
    TabSetID   := NewTabName;
  end;
  MDIStatusFile  := sfCryptFile;
  SourceFile     := OpenedFileName;
  OpenedFileName := EncriptFileName;
  Caption        := EncriptFileName;

  // удаление файла источника (оригинал)
  if FrmSelectEncrypt.ChBoxDeleteSource.Checked then
  begin
    if FileExists(EncriptFileName) then
    begin
      if DeleteFile(SourceFile) then
        FrmMain.DeletNodeFromTreeVies(SourceFile);
    end;
  end;

  SetStatusBarInfo;  //UpDate StatusBar
  // обновления списка дерева файлов
  if FileExists(EncriptFileName) and (FrmMain.TV.Items.Count <> 0) then
    FrmMain.AddNodeToTreeView(EncriptFileName, IMG_INDEX_CTXT);
  // FrmMain.Act_UpDateFileListBrowserExecute(nil);

  MessageBox(Handle, PChar('Файл успешно зашифрован и сохранен.'),
    PChar(MB_CAPTION), MB_ICONINFORMATION);

end;

procedure TFrmMDIChild.EnCryptTxtToSave(EnCryptFileName: String;
  PAtxt: PAnsiChar; ALGO: TAlgoType; APwd: AnsiString);
var
  st: TStrings;
  Atxt, Actxt: AnsiString;
  ASign: AnsiString; // Signature
  d_size: Integer;
begin
  try
    st := TStringList.Create;
    d_size := Length(PAnsiChar(PAtxt));

    // шифруемый текст менее 20 символов, то добавляются еще 20 символов мусора
    if d_size < 20 then
      // Atxt := 'dsz:' + IntToStr(d_size) + ';' + mm.Text + #13 + GetTrashStr(20)
      Atxt := 'dsz:' + IntToStr(d_size) + ';' + PAnsiChar(PAtxt) + #13 +
        GetTrashStr(20)
    else
      Atxt := Atxt + PAnsiChar(PAtxt);
    // Atxt := Atxt + mm.Text;

    ASign := ASign + 'sign:0;' + GetMD5Hash(Atxt);
    // add to Signature hash_md5_txt
    case ALGO of
      RC4_SHA1:   Actxt := EncryptRC4_SHA1(APwd, Atxt); // шифруеется
      RC4_SHA256: Actxt := EncryptRC4_SHA256(APwd, Atxt); // шифруеется
      RC4_SHA512: Actxt := EncryptRC4_SHA512(APwd, Atxt); // шифруеется
    end;

    ASign := ASign + ';' + GetMD5Hash(Actxt); // add to Signature hash_md5_ctxt
    ASign := ASign + ';' + AlgoName[ALGO]; // add to Signature vertion Algoritm
    st.Add(ASign);
    st.Add(Actxt);
    st.SaveToFile(EnCryptFileName);
  finally
    st.Free;
  end;
end;

procedure TFrmMDIChild.EnCryptTxtToSaveTwo(EnCryptFileName: String;
  PAtxt: PAnsiChar; ALGO: TAlgoType; APwd: AnsiString);
var
  st: TStrings;
  Atxt, Actxt: AnsiString;
  ASign: AnsiString; // Signature
  JFileObject: TJSONObject;
  JContent: TJSONObject;
  dt_create: TDateTime;
begin
  try
    st   := TStringList.Create;
    Atxt := PAnsiChar(PAtxt);

    JFileObject := TJSONObject.Create;
    JContent    := TJSONObject.Create;
    JContent.AddPair('content', Atxt);
    JContent.AddPair('content_hash', GetSHA1Hash(Atxt));

    Atxt := JContent.ToJSON;
    FrmDebugs.AddDbgMessage(JContent.ToJSON); // for debug

    case ALGO of
      RC4_SHA1:   Actxt := EncryptRC4_SHA1(APwd, Atxt);   // encrypt
      RC4_SHA256: Actxt := EncryptRC4_SHA256(APwd, Atxt); // encrypt
      RC4_SHA512: Actxt := EncryptRC4_SHA512(APwd, Atxt); // encrypt
    end;

    dt_create := Date + time;
    With JFileObject do
    begin
      AddPair('version', '1');
      AddPair('algo_type', AlgoName[TAlgoType(ALGO)]);
      AddPair('content_hash', GetSHA1Hash(Actxt));
      AddPair('date_create', DateTimeToStr(dt_create));
      AddPair('date_change', DateTimeToStr(dt_create));
      AddPair('content', Actxt);
    end;

    FrmDebugs.AddDbgMessage(TJson.Format(JFileObject)); //Format for debugs
    //FrmDebugs.SynEdit.Text := TJson.Format(JFileObject); //Format for debugs
    st.Text := JFileObject.ToJSON;
    st.SaveToFile(EnCryptFileName);

  finally
    JFileObject.Free;
    JContent.Free;
    st.Free;
  end;
end;

procedure TFrmMDIChild.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  if ChangeTxt then
    case MessageBox(Handle, PChar('Сохранить изменения в тексте?'),
      PChar(MB_CAPTION), MB_YESNOCANCEL or MB_ICONQUESTION) of

      ID_YES:
        SaveFile(false);
      ID_CANCEL:
        begin
          Action := caNone;
          Exit;
        end;
    end;

  // Удатение TabSet элемента
  if FrmMain.TabSet.Tabs.Count <> 0 then
  begin
    for i := 0 to FrmMain.TabSet.Tabs.Count do
    begin
      if TabSetID = FrmMain.TabSet.Tabs[i] then
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
  ALGO := RC4_SHA1;
  ChangeTxt := false;
  Constraints.MinWidth := 725;
  Constraints.MinHeight := 300
end;

procedure TFrmMDIChild.mmChange(Sender: TObject);
begin
  ChangeTxt := True;
end;

procedure TFrmMDIChild.SaveDialogNewFile(sfType: TMDIStatusFile);
begin
  FrmMain.SaveDialog.FileName := '';
  case sfType of
    sfNewFile:
      begin
        FrmMain.SaveDialog.Filter := 'Text file (*.txt)|*.txt';
        if Not FrmMain.SaveDialog.Execute then
          Exit;
        if AnsiLowerCase(ExtractFileExt(FrmMain.SaveDialog.FileName)) <> '.txt'
        then
          OpenedFileName := FrmMain.SaveDialog.FileName + '.txt'
        else
          OpenedFileName := FrmMain.SaveDialog.FileName;
      end;
    sfCryptFile:
      begin
        FrmMain.SaveDialog.Filter := 'Crypted Text file (*.ctxt)|*.ctxt';
        if Not FrmMain.SaveDialog.Execute then
          Exit;
        if AnsiLowerCase(ExtractFileExt(FrmMain.SaveDialog.FileName)) <> '.ctxt'
        then
          OpenedFileName := FrmMain.SaveDialog.FileName + '.ctxt'
        else
          OpenedFileName := FrmMain.SaveDialog.FileName;
      end;
  end;

  if FileExists(OpenedFileName) then
    if MessageBox(Handle, PChar(OpenedFileName + ' Фай, уже существует.' + #13 +
      'Заменить?'), PChar(MB_CAPTION), MB_YESNO or MB_ICONWARNING) = ID_NO then
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
        if OpenedFileName = '' then
          Exit;
        SynEdit.Lines.SaveToFile(OpenedFileName);
        Caption := OpenedFileName;
        FrmMain.TabSetReplase(TabSetID,
          FrmMain.IncrementTabsName(ExtractFileName(OpenedFileName)));
        SetStatusBarInfo;
        MDIStatusFile := sfUnCryptFile;
      end;

    // Сохранение Криптованного файла
    sfCryptFile:
      begin
        EnCryptTxtToSave(OpenedFileName, PAnsiChar(AnsiString(SynEdit.Text)), ALGO,
          PASSWORD);
      end;

    sfUnCryptFile:
      begin
        SynEdit.Lines.SaveToFile(OpenedFileName);
      end;

    sfUnDecryptedFile:
      begin
        //
      end;
  end;
  if Notification then
    MessageBox(Handle, PChar('Файл ' + OpenedFileName + ' был сохранен.'),
      PChar(MB_CAPTION), MB_ICONINFORMATION);
end;

procedure TFrmMDIChild.SaveFileCrypt;
var
  FileCrypt: String;
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

procedure TFrmMDIChild.SetPassword;
begin
  PASSWORD := MASTER_PASSWORD;
end;

procedure TFrmMDIChild.SetStatusBarInfo;
var
  SR: TSearchRec;
  sys_time: _SYSTEMTIME;
  LocalTime: tFileTime;
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
    SetLength(str_dt, GetDateFormat(LOCALE_SYSTEM_DEFAULT, 0, @sys_time,
      PChar('dd MMMM yyyy'), Nil, 0));
    GetDateFormat(LOCALE_SYSTEM_DEFAULT, 0, @sys_time, PChar('dd MMMM yyyy'),
      PChar(str_dt), Length(str_dt));
    StatusBar.Panels[0].Text := 'Создан: ' + Trim(str_dt) + ' ' +
      TimeToStr(SystemTimeToDateTime(sys_time));

    FileTimeToLocalFileTime(SR.FindData.ftLastWriteTime, LocalTime);
    FileTimeToSystemTime(LocalTime, sys_time);

    SetLength(str_dt, GetDateFormat(LOCALE_SYSTEM_DEFAULT, 0, @sys_time, PChar('dd MMMM yyyy'), Nil, 0));

    GetDateFormat(LOCALE_SYSTEM_DEFAULT, 0, @sys_time, PChar('dd MMMM yyyy'), PChar(str_dt), Length(str_dt));

    StatusBar.Panels[1].Text := 'Изменен: ' + Trim(str_dt) + ' ' +
      TimeToStr(SystemTimeToDateTime(sys_time));
  end;

end;

procedure TFrmMDIChild.SetStatusBarInfoTwo;
var
  sys_time: _SYSTEMTIME;
  LocalTime: tFileTime;
  str_dt: String;
  dt : TDateTime;
begin

  if JFileObject = NIL then
  begin
    StatusBar.Panels[0].Text := 'Создан: 00.00.0000 00:00:00';
    StatusBar.Panels[1].Text := 'Изменен: 00.00.0000 00:00:00';
    Exit;
  end;

  // Получаем дату создания файта
  dt := StrToDateTime(JFileObject.GetValue('date_create').Value);
  // конвертируем и форматируем время сщздания
  DateTimeToSystemTime(dt, sys_time);
  SetLength(str_dt, GetDateFormat(LOCALE_SYSTEM_DEFAULT, 0, @sys_time, PChar('dd MMMM yyyy'), Nil, 0));
  GetDateFormat(LOCALE_SYSTEM_DEFAULT, 0, @sys_time, PChar('dd MMMM yyyy'), PChar(str_dt), Length(str_dt));
  StatusBar.Panels[0].Text := 'Создан: ' + Trim(str_dt) + ' ' + TimeToStr(SystemTimeToDateTime(sys_time));

  // получаем дату изменения файла
  dt := StrToDateTime(JFileObject.GetValue('date_change').Value);
  // конвертируем и форматируем время сщздания
  DateTimeToSystemTime(dt, sys_time);
  SetLength(str_dt, GetDateFormat(LOCALE_SYSTEM_DEFAULT, 0, @sys_time, PChar('dd MMMM yyyy'), Nil, 0));
  GetDateFormat(LOCALE_SYSTEM_DEFAULT, 0, @sys_time, PChar('dd MMMM yyyy'), PChar(str_dt), Length(str_dt));
  StatusBar.Panels[1].Text := 'Изменен: ' + Trim(str_dt) + ' ' + TimeToStr(SystemTimeToDateTime(sys_time));
end;

end.
