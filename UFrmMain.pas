unit UFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, CryptMod, Vcl.StdCtrls, System.Actions,
  Vcl.ActnList, Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ExtCtrls, GUID, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, System.masks, Vcl.Buttons, Vcl.Menus,
  Vcl.ActnPopup, System.Win.Registry, System.StrUtils,
  ShellAPI, Vcl.Tabs, Math, Error,
  sSkinManager, sSplitter,
  sComboBoxes, sTreeView, sPanel, sComboBox, sLabel, acShellCtrls, sButton,
  Vcl.Mask, sMaskEdit, sCustomComboEdit, sComboEdit, aceCheckComboBox,
  sStatusBar, acCoolBar, sSkinProvider, sPageControl, acHeaderControl,
  sTabControl, acTitleBar, sScrollBox, sFrameBar, sToolBar, aceListView;

type THashType = (MD5_TXT, MD5_CTXT);

type
  TFrmMain = class(TForm)
    SaveDialog: TSaveDialog;
    ActionManager: TActionManager;
    Act_ShowFrmMasterPwd: TAction;
    Act_OpenFile: TAction;
    Act_Settings: TAction;
    Act_Exit: TAction;
    PopActBarTV: TPopupActionBar;
    OpenFile: TMenuItem;
    Act_UpDateFileListBrowser: TAction;
    Act_CreateNewFile: TAction;
    Act_GetMasterPassword: TAction;
    PA_OpenTxtEditor: TMenuItem;
    TabSet: TTabSet;
    Act_ChildCascade: TAction;
    Act_ChildTileHorizont: TAction;
    Act_ChildTileVertical: TAction;
    ImgListLogo: TImageList;
    Act_tets: TAction;
    OpenDialog: TOpenDialog;
    Act_FrmDecryptOld: TAction;
    FontDialog: TFontDialog;
    Act_CryptSelectedDir: TAction;
    PA_CryptSelectedDir: TMenuItem;
    Act_DecryptSelectedDir: TAction;
    PA_DecryptSelectedDir: TMenuItem;
    Act_Show_MasterPassword: TAction;
    Act_Synchronize: TAction;
    TrayIcon: TTrayIcon;
    PopActBarTray: TPopupActionBar;
    PA_TrayExit: TMenuItem;
    PA_TrayShow: TMenuItem;
    PA_TraySplit: TMenuItem;
    Act_ExitToTray: TAction;
    ImageListTree: TImageList;
    Act_OpenTreeDir: TAction;
    Act_TreeViewSearch: TAction;
    Act_ShowDebugWindow: TAction;
    sSplitterBrowser: TsSplitter;
    sSkinManager: TsSkinManager;
    sSkinSelector: TsSkinSelector;
    sPnlTabs: TsPanel;
    sCmBoxSearch: TsComboBox;
    sLblSearch: TsLabel;
    sCmBoxExRootDirs: TsComboBoxEx;
    sBtnSearch: TsButton;
    sBtnOpenTreeDir: TsButton;
    sBtnUpDate: TsButton;
    ImageListButtons: TImageList;
    sStatusBar: TsStatusBar;
    sPnlBrowser: TsPanel;
    MainMenu: TMainMenu;
    N_OpenFile: TMenuItem;
    N_FrmDecryptOld: TMenuItem;
    N_CreateNewFile: TMenuItem;
    N_Exit: TMenuItem;
    Menu_Top_File: TMenuItem;
    sSkinProvider: TsSkinProvider;
    Menu_Top_Settings: TMenuItem;
    N_FrmMasterPwd: TMenuItem;
    N_Settings: TMenuItem;
    N_Synchronize: TMenuItem;
    N_Show_MasterPassword: TMenuItem;
    Menu_Top_Vid: TMenuItem;
    N_ChildCascade: TMenuItem;
    N_ChildTileHorizont: TMenuItem;
    N_ChildTileVertical: TMenuItem;
    N_ShadowTray: TMenuItem;
    N_ExitToTray: TMenuItem;
    N_ShowDebugWindow: TMenuItem;
    N_Spliter: TMenuItem;
    N_tets: TMenuItem;
    TV: TsTreeViewEx;
    Act_SpliterSvich: TAction;
    procedure Act_SettingsExecute(Sender: TObject);
    procedure Act_ShowFrmMasterPwdExecute(Sender: TObject);
    procedure FindFilesMskTV(StartFolder,  Mask: string; TNParent: TTreeNode; ScanSubFolders: Boolean);
    procedure Act_OpenFileExecute(Sender: TObject);
    function GetFullFileName: String;
    procedure Act_UpDateFileListBrowserExecute(Sender: TObject);
    procedure Act_CreateNewFileExecute(Sender: TObject);
    function LoadMasterPWD: String;
    procedure Act_GetMasterPasswordExecute(Sender: TObject);
    function ExtractHash(Hash: THashType; st: TStrings): AnsiString;
    procedure PA_OpenTxtEditorClick(Sender: TObject);
    function GetTextEditor: String;
    procedure TabSetClick(Sender: TObject);
    function ConvertStringToInteger(StrValue: String): Integer;
    Function IncrementTabsName(TabsName: string): String;
    procedure Act_ChildCascadeExecute(Sender: TObject);
    procedure Act_ChildTileHorizontExecute(Sender: TObject);
    procedure Act_ChildTileVerticalExecute(Sender: TObject);
    function CheckStrToDateTime(StrDT: String): Boolean;
    procedure Act_tetsExecute(Sender: TObject);
    procedure Act_ExitExecute(Sender: TObject);
    procedure Act_FrmDecryptOldExecute(Sender: TObject);
    procedure TabSetReplase(TabNameOld, TabNameNew: String);
    function FindTreeViewNode(FindPath, BeginPath: String; TN: TTreeNode): TTreeNode;
    Procedure AddNodeToTreeView(FullNameNode: String; ImageIndex: integer);
    procedure DeletNodeFromTreeVies(FullNameNode: String);
    procedure Act_CryptSelectedDirExecute(Sender: TObject);
    procedure PopActBarTVPopup(Sender: TObject);
    Procedure FindFilesMsk(StartDir, Mask: string; List: TStrings; ScanSubFolders: Boolean);
    procedure Act_DecryptSelectedDirExecute(Sender: TObject);
    procedure Act_Show_MasterPasswordExecute(Sender: TObject);
    function SetFileNameExtention(FileName, NewExt: String): string;
    procedure SendLog(txt: string; Err: Integer);
    procedure Act_SynchronizeExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TVNodeSort(RootTxt: String; TN: TTreeNode);
    function AddAssociatedIcon(FileName: String; ImageList: TImageList; SizeImage: integer): Integer;
    procedure UpdateCbBoxDirList;
    procedure BtnOpenTreeDirClick(Sender: TObject);
    procedure Act_OpenTreeDirExecute(Sender: TObject);
    function TVSearch(TN: TTreeNode; SearchText: AnsiString): TTreeNode;
    procedure TVSearh;
    procedure AddSearchBookMark;
    procedure Act_ShowDebugWindowExecute(Sender: TObject);
    procedure LoadSearchBookMark;
    procedure sBtnSearchClick(Sender: TObject);
    procedure sSplitterBrowserMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Act_SpliterSvichExecute(Sender: TObject);
  private
    { Private declarations }
    LastIndexSearch: integer;
  public
    { Public declarations }
    StartNodeSort: Boolean;
  end;

var
  FrmMain: TFrmMain;
  SELECT_FULL_FILENAME: String;
  CRYPT_DIR       : String;
  MASTER_PASSWORD : AnsiString;
  G_PWDHASH       : AnsiString;
  SELECT_ROOT_DIR : String;
  WinDir          : String;
  CurrDir         : String;
  SkinDir         : String;
  DEBUG_MODE      : Boolean;
  I               : Integer;

  TNRootArray: Array of TTreeNode;

const
  MB_CAPTION = 'CRYPTO LOGIC';
  IMG_INDEX_CTXT = 1;
  IMG_INDEX_TXT  = 2;
  MAX_SEARCH_BOOKMARK: ShortInt = 15;

implementation

USES UFrmMDIChild, UFrmConfig, UFrmMasterPwd, UFrmOldDecrypt, UFrmSelectEncrypt,
     UFrmDebugs, UFrmSync, UfrmProgressBar;

{$R *.dfm}

function TFrmMain.LoadMasterPWD: String;
var Reg : Tregistry;
begin
  try
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\CryptoNote', true) then
    begin
      Result := Reg.ReadString('MasterPassword');
      Reg.CloseKey;
    end;
  finally
    reg.Free;
  end;

end;

procedure TFrmMain.LoadSearchBookMark;
var Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\CryptoNote', false) then
    begin
      sCmBoxSearch.Items.Text := Reg.ReadString('SearchBookmark');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TFrmMain.PA_OpenTxtEditorClick(Sender: TObject);
var
  FullName: String;
begin
  FullName := GetFullFileName;
  if GetFileAttributes(PChar(FullName)) = FILE_ATTRIBUTE_DIRECTORY then
  begin
    TV.Selected.Expanded := true;
    Exit;
  end;

  if LowerCase(ExtractFileExt(FullName)) = '.ctxt' then
  begin
    if FrmConfig.sFilenameEditTxtEditor.Text = '' then
      ShellExecute(Handle, 'open', PChar(GetEnvironmentVariable('windir')+'\notepad.exe'),
                   PChar(FullName), Nil, SW_SHOWNORMAL)
    else ShellExecute(Handle, 'open', PChar(FrmConfig.sFilenameEditTxtEditor.Text),
                      PChar(FullName), nil, SW_SHOWNORMAL);
  end
    else
  begin
    if FrmConfig.sFilenameEditTxtEditor.Text = '' then
      ShellExecute(Handle, 'open', PChar(FullName), nil, nil, SW_SHOWNORMAL)
    else ShellExecute(Handle, 'open', PChar(FrmConfig.sFilenameEditTxtEditor.Text),
                      PChar(FullName), nil, SW_SHOWNORMAL);
  end;

end;

procedure TFrmMain.PopActBarTVPopup(Sender: TObject);
begin
  if GetFileAttributes(PChar(GetFullFileName)) = FILE_ATTRIBUTE_DIRECTORY then
  begin
    PA_CryptSelectedDir.Visible   := true;
    PA_DecryptSelectedDir.Visible := true;
  end
  else
  begin
    PA_CryptSelectedDir.Visible   := false;
    PA_DecryptSelectedDir.Visible := false;
  end;
end;

procedure TFrmMain.sBtnSearchClick(Sender: TObject);
begin
  if (sCmBoxSearch.Text = '') or (TV.Items.Count = 0) then Exit;
  TVSearh;
  sStatusBar.Panels[0].Text := 'Поиск: ' + GetFullFileName;
end;

procedure TFrmMain.SendLog(txt: string; Err: Integer);
var
  sErr: string;
begin
  if Err = -1 then
    FrmDebugs.mm.Lines.Add(FormatDateTime('dd.mm.yyyy hh:mm:ss.zzz', Date + Time) + ' ' + txt)
  else
  begin
    sErr := ' Error Code: [' + IntToStr(Err) + '] '+SysErrorMessage(Err);
    FrmDebugs.mm.Lines.Add(
           FormatDateTime('dd.mm.yyyy hh:mm:ss.zzz', Date + Time) + ' ' + txt + sErr);
  end;
end;

function TFrmMain.SetFileNameExtention(FileName, NewExt: String): string;
begin
 Result := Copy(FileName, 1, Length(FileName) - Length(ExtractFileExt(FileName)));
 Result := Result + NewExt;
end;

procedure TFrmMain.sSplitterBrowserMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var pos: SmallInt;
begin
  if Not (Button = mbRight) then Exit;
  if sSplitterBrowser.SizingByClick then sSplitterBrowser.SizingByClick := false
  else sSplitterBrowser.SizingByClick := true;
end;

procedure TFrmMain.Act_ChildTileHorizontExecute(Sender: TObject);
begin
  TileMode := tbHorizontal;
  Tile;
end;

procedure TFrmMain.Act_ChildTileVerticalExecute(Sender: TObject);
begin
 TileMode := tbVertical;
 Tile;
end;

procedure TFrmMain.Act_CreateNewFileExecute(Sender: TObject);
var i : SmallInt;
    NewChild: TFrmMDIChild;
begin
  NewChild := TFrmMDIChild.Create(Application);
  NewChild.Caption             := 'Новая запись';
  NewChild.MDIStatusFile       := sfNewFile;
  NewChild.ChangeTxt           := False;
  NewChild.sBtnDecrypt.Enabled := false;
  ImgListLogo.GetIcon(0, NewChild.ImageLogo.Picture.Icon);
  i := TabSet.Tabs.Add(IncrementTabsName(ExtractFileName('Новая запись')));
  NewChild.TabSetID := TabSet.Tabs[i];
  TabSet.TabIndex   := i;
end;

procedure TFrmMain.Act_CryptSelectedDirExecute(Sender: TObject);
var SR: TSearchRec;
    FilesList: TStrings;
    ST : TStrings;
    PASSWORD: AnsiString;
    i: Integer;
    EncriptFileName: string;
begin
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

  FilesList := TStringList.Create;
  ST        := TStringList.Create;

  try
    FindFilesMsk(GetFullFileName, '*.txt', FilesList, True);
    for i := 0 to FilesList.Count -1 do
    begin
      ST.LoadFromFile(FilesList.Strings[i]);

      EncriptFileName := Copy(FilesList.Strings[i], 1, Length(FilesList.Strings[i]) - Length('.txt'));
      EncriptFileName := EncriptFileName + '.ctxt';

      FrmMDIChild.EnCryptTxtToSave(EncriptFileName, PAnsiChar(AnsiString(ST.Text)) , FrmSelectEncrypt.ALGO, PASSWORD);

      // Дабавление в дерево записи
      if FileExists(EncriptFileName) then
      begin
        AddNodeToTreeView(EncriptFileName, 1);
      end;

      // Удаление файлов источников
      if FrmSelectEncrypt.ChBoxDeleteSource.Checked then
      begin
        if DeleteFile(FilesList.Strings[i]) then DeletNodeFromTreeVies(FilesList.Strings[i]);
      end;

    end;
  finally
    ST.Free;
    FilesList.Free;
  end;
end;

procedure TFrmMain.Act_DecryptSelectedDirExecute(Sender: TObject);
var SR: TSearchRec;
    FilesList: TStrings;
    ST : TStrings;
    PASSWORD: AnsiString;
    i: Integer;
    Sign: TSignature;
    Actxt, Atxt: AnsiString;
begin
  FrmSelectEncrypt.FrmShowModal(DLG_DECRYPT);
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

  FilesList := TStringList.Create;
  ST        := TStringList.Create;
  try
    // Получаю список всех шифрованных файлов в выделенной директории
    FindFilesMsk(GetFullFileName, '*.ctxt', FilesList, True);
    FrmDebugs.Show;
    FrmDebugs.mm.Lines.Add(FilesList.Text);
    for i := 0 to FilesList.Count -1 do
    begin

      ST.LoadFromFile(FilesList.Strings[i]);
      if (ST.Count < 2) or (ST.Count > 2) then
      begin
        SendLog('Not Decrypt (ST.Count < 2) or (ST.Count > 2) file: '+FilesList.Strings[i], -1);
        Continue;
      end;

      if Not GetSignature(st.Strings[0],@Sign) then
      begin
        SendLog('Not Decrypt GetSignature = false file: '+FilesList.Strings[i], -1);
        Continue;
      end;

      Actxt := st.Strings[1];

      if Sign.hash_encrypt <> GetMD5Hash(Actxt) then
      begin
        SendLog('Decrypt err: Sign.hash_encrypt no check: '+FilesList.Strings[i], -1);
        Continue;
      end;

      case Sign.Algo of
        RC4_SHA1  : Atxt := DecryptRC4_SHA1(PASSWORD, Actxt);
        RC4_SHA256: Atxt := DecryptRC4_SHA256(PASSWORD, Actxt);
        RC4_SHA512: Atxt := DecryptRC4_SHA512(PASSWORD, Actxt);
      end;

      if Sign.hash_encrypt <> GetMD5Hash(Atxt) then
      begin
        SendLog('Decrypt err: Sign.hash_encrypt no check: '+FilesList.Strings[i], -1);
        Continue;
      end;

      st.Text := Atxt;
      try
        st.SaveToFile(SetFileNameExtention(FilesList.Strings[i],'.txt'));
      Except
        SendLog('Act_DecryptSelectedDirExecute SaveToFile ' + SetFileNameExtention(FilesList.Strings[i],'.txt'), GetLastError);
      end;

    end;
  finally
    ST.Free;
    FilesList.Free;
  end;


end;

procedure TFrmMain.Act_ExitExecute(Sender: TObject);
begin
  //
  close;
end;

procedure TFrmMain.Act_FrmDecryptOldExecute(Sender: TObject);
begin
  TFrmOldDeCrypt.Create(Application);
end;

procedure TFrmMain.Act_GetMasterPasswordExecute(Sender: TObject);
var Reg : Tregistry;
begin
  try
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\CryptoNote', true) then
    begin
      MASTER_PASSWORD := Reg.ReadString('MasterPassword');
      Reg.CloseKey;
    end;
  finally
    reg.Free;
  end;

  if MASTER_PASSWORD = '' then FrmMasterPwd.ShowModeDlg(DLG_MASTERPWD);

end;

procedure TFrmMain.Act_ChildCascadeExecute(Sender: TObject);
begin
  Cascade;
end;

procedure TFrmMain.Act_OpenFileExecute(Sender: TObject);
var
  //NewChild: TFrmMDIChild;
  i: integer;
  ImageIndex: integer;
  FullName, hash_txt, hash_ctxt, szd: string;
  st: TStrings;
  Actxt, Atxt, ASig: AnsiString;
  Sign: TSignature;
begin

  if TV.Selected = Nil then exit;


  FullName := GetFullFileName;
  if GetFileAttributes(PChar(FullName)) = FILE_ATTRIBUTE_DIRECTORY then
  begin
    TV.Selected.Expanded := true;
    Exit;
  end;

  // Если окно уже открыто то оно распахнется на максимум
  for i := 0 to FrmMain.MDIChildCount -1 do
  begin
    if FrmMain.MDIChildren[i].Caption = FullName then
    begin
      //FrmMain.MDIChildren[i].WindowState := wsMaximized;
      FrmMain.MDIChildren[i].SetFocus;
      Exit;
    end;
  end;

  // Создание экземпляра окна
  FrmMDIChild := TFrmMDIChild.Create(Application);
  FrmMDIChild.Caption             := FullName;
  FrmMDIChild.OpenedFileName      := FullName;
  //FrmMDIChild.Width               := FrmMain.Width - PnlBrowser.Width - 60;
  //FrmMDIChild.Height              := FrmMain.Height - 140;
  FrmMDIChild.WindowState         := wsNormal;

  if ExtractFileExt(LowerCase(FullName)) = '.ctxt' then
  begin
    try
      ImageIndex := 1;
      // Проверка мастер пароля
      if MASTER_PASSWORD = '' then
      begin
         Act_GetMasterPasswordExecute(Nil);
      end;

      // Записываем в созданную форму PASSWORD,
      // что бы использовался при сохранееии открытого файла
      FrmMDIChild.SetPassword; //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

      st := TStringList.Create;
      st.LoadFromFile(FullName);
      if st.Count = 0 then
      begin
        MessageBox(Handle,
                   PChar('Файл является пустым и дальнейшая его расшифровка не возможна.'),
                   PChar(MB_CAPTION), MB_ICONERROR);
        FrmMDIChild.Close;
        Exit;
      end;

      GetSignature(st.Strings[0],@Sign);

      if Not Sign.Checked then
      begin
        if MessageBox(Handle,
                   PChar('В этом файле не были найдены хэши файла, '+
                         'которые являются контрольными суммами файла.'+#13+
                         'Возможно этот файл не является зашифровонным и '+
                         'его дальнейшая расшифровка не удастся.'+#13+
                         'Вы хотит продолжить?'),
                   PChar(MB_CAPTION), MB_YESNO or MB_ICONWARNING) = IDNO then
         begin
           FrmMDIChild.Close; //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
           Exit;
         end;
      end;

      if st.Count > 1 then Actxt := st.Strings[1]
      else Actxt := st.Strings[0];

      // Сверка содержимого зашифрованного файла с Хэшем
      if Sign.hash_encrypt <> GetMD5Hash(Actxt) then
      begin
       if Sign.hash_encrypt <> '' then
         MessageBox(Handle,
                   PChar('Так как хэш файла не совпадает с хешем содержимого файла, '+#13#10+
                   'это означает, что файл поврежден или не весь, '+
                   'файл может быть расшифрован не верно.'),
                   PChar(MB_CAPTION), MB_ICONWARNING);
      end;

      case Sign.Algo of
        RC4_SHA1:   Atxt := DecryptRC4_SHA1(MASTER_PASSWORD, Actxt);
        RC4_SHA256: Atxt := DecryptRC4_SHA256(MASTER_PASSWORD, Actxt);
        RC4_SHA512: Atxt := DecryptRC4_SHA512(MASTER_PASSWORD, Actxt);
      end;

      // Сверка расшифрованного файла с Хэшем
      if GetMD5Hash(Atxt) = Sign.hash_uncrypt then
      begin
        // файл расшифрован
        if 'dsz:' = copy(Atxt, 1 ,4) then
        begin
          i := ConvertStringToInteger(copy(Atxt, 5 , AnsiPos(';', Atxt) - 5));
          Atxt := Copy(Atxt, AnsiPos(';', Atxt) + 1, i);
        end;

        FrmMDIChild.mm.Text       := Atxt;
        FrmMDIChild.MDIStatusFile := sfCryptFile;
        FrmMDIChild.sBtnDecrypt.Enabled := false;
      end
        else
      begin
        // Файл не удалось расшифровать
        if Sign.hash_uncrypt <> '' then
          MessageBox(Handle,
                   PChar('Так как хэш файла не совпадает с хэшем расшифрованного файла '+#13+
                   'это означяет, что файл не был правильно расшифрован. '+
                   'Возможно у вас введен не верный пароль. '+#13+
                   'Попробуйте повторить попытку с другим паролем.'),
                   PCHar(MB_CAPTION), MB_ICONWARNING);
        FrmMDIChild.mm.Text       := Atxt;
        FrmMDIChild.mm.ReadOnly   := true;
        FrmMDIChild.sBtnEncrypt.Enabled := false;
        FrmMDIChild.MDIStatusFile := sfUnDecryptedFile;

      end;
      //FrmMDIChild.JvXPBtnEncrypt.Enabled := false;

    finally
      st.Free;
    end;
  end
    else
  begin
    ImageIndex := 0;
    FrmMDIChild.mm.Lines.LoadFromFile(FullName);
    FrmMDIChild.sBtnDecrypt.Enabled     := false;
    FrmMDIChild.sBtnSaveUnCrypt.Enabled := false;
    FrmMDIChild.MDIStatusFile           := sfUnCryptFile;
  end;

  // Генерация TabNameID
  ImgListLogo.GetIcon(ImageIndex, FrmMDIChild.ImageLogo.Picture.Icon);

  i := TabSet.Tabs.Add(IncrementTabsName(ExtractFileName(FullName)));
  FrmMDIChild.TabSetID := TabSet.Tabs[i];
  TabSet.TabIndex := i;
  FrmMDIChild.ChangeTxt := False;
  FrmMDIChild.SetStatusBarInfo;

end;

procedure TFrmMain.Act_OpenTreeDirExecute(Sender: TObject);
var
  TN: TTreeNode;
   i, j: integer;
begin
  if (sCmBoxExRootDirs.ItemsEx.Count = 0) or (sCmBoxExRootDirs.ItemIndex = -1) then Exit;

  sBtnUpDate.Enabled := false;
  // FrmProgressBar.Start;
  //while ImageListTree.Count > 4 do ImageListTree.Delete(ImageListTree.Count -1);
  //TV.Items.Clear;
  if sCmBoxExRootDirs.ItemIndex = 0 then
  begin
    TV.Items.BeginUpdate;
    for i := 1 to sCmBoxExRootDirs.ItemsEx.Count -1 do
    begin
      for j := 0 to Length(TNRootArray) - 1 do
        if TNRootArray[j].Text = sCmBoxExRootDirs.ItemsEx[i].Caption then continue;

      TN := TV.Items.Add(Nil, sCmBoxExRootDirs.ItemsEx[i].Caption);
      TN.ImageIndex    := 1;
      TN.SelectedIndex := 1;
      FindFilesMskTV(TN.Text, '*.txt|*.ctxt', TN, true);
     // Добавление в массив
     SetLength(TNRootArray, Length(TNRootArray) + 1);
     TNRootArray[Length(TNRootArray) - 1] := TN;
    end;
    TV.Items.EndUpdate;

    // Сортировка дерева
    StartNodeSort := true;
    TV.Items.BeginUpdate;
    for i := 0 to Length(TNRootArray) - 1 do TVNodeSort(TNRootArray[i].Text, TNRootArray[i]);
    TV.FullCollapse;
    TV.Items.EndUpdate;

  end
    else
  begin
    for j := 0 to Length(TNRootArray) - 1 do
      if TNRootArray[j].Text = sCmBoxExRootDirs.ItemsEx[sCmBoxExRootDirs.ItemIndex].Caption then Exit;
    TN := TV.Items.Add(Nil, sCmBoxExRootDirs.ItemsEx[sCmBoxExRootDirs.ItemIndex].Caption);
    TN.ImageIndex    := 1;
    TN.SelectedIndex := 1;
    FindFilesMskTV(TN.Text, '*.txt|*.ctxt', TN, true);
    // Добавление в массив
    SetLength(TNRootArray, Length(TNRootArray) + 1);
    TNRootArray[Length(TNRootArray)- 1] := TN;

    // Сортировка дерева
    StartNodeSort := true;
    TV.Items.BeginUpdate;
    TVNodeSort(TNRootArray[Length(TNRootArray) - 1].Text, TNRootArray[Length(TNRootArray) - 1]);
    TV.FullCollapse;
    TV.Items.EndUpdate;

  end;


  FrmProgressBar.Stop;
  sBtnUpDate.Enabled := true;
end;

procedure TFrmMain.Act_SettingsExecute(Sender: TObject);
begin
  FrmConfig.ShowModal;
end;

procedure TFrmMain.Act_ShowDebugWindowExecute(Sender: TObject);
begin
  FrmDebugs.Show;
end;

procedure TFrmMain.Act_ShowFrmMasterPwdExecute(Sender: TObject);
begin
  FrmMasterPwd.ShowModeDlg(DLG_MASTERPWD);
end;

procedure TFrmMain.Act_Show_MasterPasswordExecute(Sender: TObject);
begin
  FrmDebugs.mm.Lines.Add('MASTER PASSWORD: '+MASTER_PASSWORD);
  FrmDebugs.Show;
end;

procedure TFrmMain.Act_SpliterSvichExecute(Sender: TObject);
begin
  if sSplitterBrowser.SizingByClick then
    sSplitterBrowser.SizingByClick := false
  else
    sSplitterBrowser.SizingByClick := true;
end;

procedure TFrmMain.Act_SynchronizeExecute(Sender: TObject);
begin
  for I := 0 to FrmMain.MDIChildCount - 1 do
    if FrmMain.MDIChildren[I] = FrmSync then
      ShowMessage('FrmMain.MDIChildren.FindChildControl(FrmSync) = true ')
    else
    begin
      ShowMessage('FrmMain.MDIChildren.FindChildControl(FrmSync) = false ');
      TFrmSync.Create(Application);
      exit;
    end;
end;

procedure TFrmMain.Act_tetsExecute(Sender: TObject);
var s, s2: AnsiString;
    sz: integer;
    buf: array [1..4] of byte;
    i: integer;
   st: TStrings;
   TN, NewNode : TTreeNode;
begin
    //TN := TV.Items.Add(Nil, FrmConfig.LVDir.Items[i].Caption);
    //TN.ImageIndex := 0;
    //FindFilesMskTV(FrmConfig.LVDir.Items[i].Caption,'*.txt|*.ctxt', TN, true);
  //TV.Items[1].Delete;

  s := 'C:\PROJECT+\CRYPT_DIR\NAS\phpMyAdmin.txt';
  //ShowMessage(GetFullFileName);
  //s := 'C:\PROJECT+\CRYPT_DIR\NAS';
  TN := FindTreeViewNode(s, '', TV.Items[0]);
  TV.Items.Delete(TN);
  //FindFilesMskTV(GetFullFileName,'*.txt|*.ctxt', TN, true);
end;

procedure TFrmMain.Act_UpDateFileListBrowserExecute(Sender: TObject);
var
  TN: TTreeNode;
   i: integer;
   ImageIndex: Integer;
begin
  if (sCmBoxExRootDirs.ItemsEx.Count = 0) or (sCmBoxExRootDirs.ItemIndex = -1) then Exit;
  sBtnUpDate.Enabled := false;
  FrmProgressBar.Start;

  TV.Items.BeginUpdate;
  // Очистка хранилища иконок
  while ImageListTree.Count > 4 do ImageListTree.Delete(ImageListTree.Count -1);
  for i := 0 to  Length(TNRootArray) - 1 do
  begin
    TNRootArray[i].DeleteChildren;
    TNRootArray[i].ImageIndex    := 1;
    TNRootArray[i].SelectedIndex := 1;
    FindFilesMskTV(TNRootArray[i].Text, '*.txt|*.ctxt', TNRootArray[i], true);
  end;
  TV.Items.EndUpdate;

  // Сортировка дерева
  StartNodeSort := true;
  TV.Items.BeginUpdate;
  for i := 0 to Length(TNRootArray) - 1 do TVNodeSort(TNRootArray[i].Text, TNRootArray[i]);
  TV.FullCollapse;
  TV.Items.EndUpdate;
  FrmProgressBar.Stop;
  sBtnUpDate.Enabled := true;
end;

function TFrmMain.AddAssociatedIcon(FileName: String;
  ImageList: TImageList; SizeImage: integer): Integer;
var
  wd: WORD;
  Icon: Ticon;
begin
  // Добавление ассоциированной иконки файла в ListView
  Icon := TIcon.Create;
  Icon.SetSize(SizeImage,SizeImage);

  try

    if GetFileAttributes(PChar(FileName)) = FILE_ATTRIBUTE_DIRECTORY then
    begin
      result := 1;
    end;

    if MatchesMask(FileName, '*.ctxt') then
    begin
      Result := 2;
      Exit;
    end;

    if MatchesMask(FileName, '*.txt') then
    begin
      Result := 3;
      Exit;
    end;

    wd := 0;
    Icon.Handle := ExtractAssociatedIcon(HInstance, PChar(FileName), wd);
    if icon.HandleAllocated then
      Result := ImageList.AddIcon(icon)
    else
    begin
      Result := 0;
    end;

  finally
    Icon.Free;
  end;
end;

procedure TFrmMain.AddNodeToTreeView(FullNameNode: String; ImageIndex: integer);
var TN, NewNode: TTreeNode;
begin
  //************ Процедура добавления Нода в дерево *****************

  // Проверка, если такой нод есть, то выход
  TN := FindTreeViewNode(FullNameNode, '', TV.Items[0]);
  if TN <> Nil Then Exit;
  // Если такой нод не найден, то добаляем
  TN := FindTreeViewNode(ExtractFileDir(FullNameNode), '', TV.Items[0]);
  if TN = Nil Then Exit;
  NewNode := TV.Items.AddChild(TN, ExtractFileName(FullNameNode));
  NewNode.ImageIndex    := ImageIndex;
  NewNode.SelectedIndex := ImageIndex;
end;

procedure TFrmMain.AddSearchBookMark;
var i: SmallInt;
    Reg: TRegistry;
begin
  if sCmBoxSearch.Items.IndexOf(sCmBoxSearch.Text) = -1 then
  begin
    if sCmBoxSearch.Items.Count = MAX_SEARCH_BOOKMARK then
      sCmBoxSearch.Items.Delete(MAX_SEARCH_BOOKMARK - 1);
    sCmBoxSearch.Items.Insert(0, sCmBoxSearch.Text);
    Reg := TRegistry.Create;
    try
      Reg.RootKey := HKEY_CURRENT_USER;
      if Reg.OpenKey('\Software\CryptoNote', false) then
      begin
        Reg.WriteString('SearchBookmark', sCmBoxSearch.Items.Text);
        Reg.CloseKey;
      end;
    finally
      Reg.Free;
    end;
  end;
end;

procedure TFrmMain.BtnOpenTreeDirClick(Sender: TObject);
begin
  //
end;

function TFrmMain.CheckStrToDateTime(StrDT: String): Boolean;
begin
  Result := false;
  try
    StrToDateTime(StrDT);
    Result := true;
  except
    Exit;
  end;
end;

function TFrmMain.ConvertStringToInteger(StrValue: String): Integer;
var 
  i: ShortInt;
  num: set of Char;
begin
  num := ['0','1','2','3','4','5','6','7','8','9'];
  for i:=1 to Length(StrValue) do
  begin
    if Not (StrValue[i] in num) then
    begin
      Result := 0;
      Exit;
    end;
  end;

  Result := StrToInt(StrValue);
end;
{------------------------------------------------------------------------------}
procedure TFrmMain.DeletNodeFromTreeVies(FullNameNode: String);
var TN: TTreeNode;
begin
  TN := FindTreeViewNode(FullNameNode, '', TV.Items[0]);
  TV.Items.Delete(TN);
end;
{------------------------------------------------------------------------------}
function TFrmMain.ExtractHash(Hash: THashType; st: TStrings): AnsiString;
var i: integer;
    TS: TStrings;
begin
  if st.Count = 0 then exit;
  try
    TS := TStringList.Create;
    TS.Text := StringReplace(st.Strings[0], ';',#13,[rfReplaceAll]);
    if TS.Count < 2 then Exit;

    case Hash of
      MD5_TXT:
      begin
        Result := TS.Strings[1];
      end;
      MD5_CTXT:
      begin
        Result := TS.Strings[2];
      end;
    end;
    if Not CheckHash(Result,32) then Result := ''
  finally
    TS.Free;
  end;

 // Старая версия
 { for i := 0 to st.Count -1 do
  begin
    if AnsiContainsStr(st.Strings[i], HashName) = True then
    begin
      s := st.Strings[i];
      if Length(s) < (Length(HashName) + 33) then Continue;
      s := stringReplace(s, HashName+':','',[rfIgnoreCase]);
      if CheckHash(s, 32) then Result := s;
      begin
        Result := s;
        exit;
      end;
    end;
  end; }

end;

procedure TFrmMain.FindFilesMsk(StartDir, Mask: string; List: TStrings;
  ScanSubFolders: Boolean);
var
  SR: TSearchRec;
  MaskStrings: TStrings;
  i: integer;
begin
  StartDir := IncludeTrailingPathDelimiter(StartDir);
  try
    MaskStrings := TStringList.Create;
    if Mask = '' then MaskStrings.Add('*.*')
    else MaskStrings.Text := StringReplace(Mask,'|',#13,[rfReplaceAll,rfIgnoreCase]);

    if FindFirst(StartDir+'*.*',$3f,SR) = 0 then
    Repeat
      Application.ProcessMessages;
      if (SR.Attr and faDirectory) <> 0 then
      begin
        if ScanSubFolders and (SR.Name <> '.') and (SR.Name <> '..') then
        begin
          FindFilesMsk(StartDir+SR.Name, Mask, List, ScanSubFolders);
        end;
      end
        else
      begin
        for i := 0 to MaskStrings.Count-1 do
        begin
          if MatchesMask(SR.Name, MaskStrings[i]) then
          begin
            List.Add(StartDir + SR.Name);
          end;
        end;
      end;

    until FindNext(SR) <> 0;
  finally
    MaskStrings.Free;
    FindClose(SR);
  end;

end;
{------------------------------------------------------------------------------}
procedure TFrmMain.FindFilesMskTV(StartFolder, Mask: string; TNParent: TTreeNode; ScanSubFolders: Boolean);
var
  SR: TSearchRec;
  MaskStrings: TStrings;
  i: integer;
  TN: TTreeNode;
  IconIndex: Integer;
begin
  StartFolder := IncludeTrailingPathDelimiter(StartFolder);
  try
    MaskStrings := TStringList.Create;
    if Mask = '' then MaskStrings.Add('*.*')
    else MaskStrings.Text := StringReplace(Mask,'|',#13,[rfReplaceAll,rfIgnoreCase]);

    if FindFirst(Startfolder+'*.*',$3f,SR) = 0 then
    Repeat
      Application.ProcessMessages;
      if (SR.Attr and faDirectory) <> 0 then
      begin
        if ScanSubFolders and (SR.Name <> '.') and (SR.Name <> '..') then
        begin
          TN := TV.Items.AddChild(TNParent, SR.Name);
          TN.ImageIndex    := 1;
          TN.SelectedIndex := 1;
          FindFilesMskTV(StartFolder + SR.Name, Mask, TN, ScanSubFolders);
        end;
      end
        else
      begin
        for i := 0 to MaskStrings.Count-1 do
        begin
          if MatchesMask(SR.Name, MaskStrings[i]) then
          begin
             TN := TV.Items.AddChild(TNParent, SR.Name);
             IconIndex        := AddAssociatedIcon(StartFolder + SR.Name, ImageListTree, 16);
             TN.ImageIndex    := IconIndex;
             TN.SelectedIndex := IconIndex;
          end;
        end;
      end;

    until FindNext(SR) <> 0;
  finally
    MaskStrings.Free;
    FindClose(SR);
  end;
end;
{------------------------------------------------------------------------------}
function TFrmMain.FindTreeViewNode(FindPath, BeginPath: String; TN: TTreeNode): TTreeNode;
var i: integer;
   ChildNode: TTreeNode;
   TxtNode: String;
begin
  Result := Nil;
  ChildNode := TN;
  While ChildNode <> Nil do
  Begin
    if BeginPath = '' then TxtNode := ChildNode.Text
    else TxtNode := BeginPath + '\' + ChildNode.Text;

    if FindPath = TxtNode then
    begin
      Result := ChildNode;
      Break;
    end;

    if ChildNode.Count > 0 then
       Result := FindTreeViewNode(FindPath, TxtNode , ChildNode.Item[0]);
       if  Result <> Nil then
       begin
         Break;
       end;

    ChildNode := ChildNode.GetNextChild(ChildNode);
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin

  WinDir  := GetEnvironmentVariable('WinDir');
  CurrDir := ExtractFileDir(Application.ExeName);
  LoadSearchBookMark;

  // Загрузка скинов
  {
  if DirectoryExists(SkinDir) then
  begin
    sSkinManager.SkinDirectory := SkinDir;
    sSkinManager.SkinName := 'Air';//'Smoky';//'Black Box';
    sSkinManager.Active   := true;
    sSkinManager.UpdateAllScale;
  end
  else
  begin
    sSkinManager.SkinName := '';
  end;
  }

end;

function TFrmMain.GetFullFileName: String;
var N: TTreeNode;
    S: String;
begin
  S := '';
  N := TV.Selected;
  while N <> NIL do
  begin
    S := N.Text + '\' + S;
    N := N.Parent;
  end;
  //IncludeTrailingPathDelimiter(SELECT_ROOT_DIR) +
  Result :=  ExcludeTrailingPathDelimiter(s);
end;

function TFrmMain.GetTextEditor: String;
begin
  Result := '';
end;

function TFrmMain.IncrementTabsName(TabsName: string): String;
var i, cnt: SmallInt;
    snum: String;
begin
  cnt := 0;
  Result := TabsName;
  for i := 0 to TabSet.Tabs.Count-1 do
  begin

    if ContainsStr(TabSet.Tabs[i], TabsName) then
    begin
      if TabSet.Tabs[i][1] = '[' then
      begin
        snum := copy(TabSet.Tabs[i],2 , AnsiPos(']', TabSet.Tabs[i]) - 2);
        cnt := Max(ConvertStringToInteger(snum),cnt);
      end;
      Inc(cnt);
    end;

  end;
  if cnt > 0 then Result := '['+IntToStr(cnt)+'] '+TabsName;
end;

procedure TFrmMain.TabSetClick(Sender: TObject);
var i: Integer;
begin
  if TabSet.TabIndex =-1 then Exit;
  for i := 0 to MDIChildCount -1 do
    if (MDIChildren[i] as TFrmMDIChild).TabSetID = TabSet.Tabs[TabSet.TabIndex] then
    begin
      MDIChildren[i].BringToFront;
    end;
end;

procedure TFrmMain.TabSetReplase(TabNameOld, TabNameNew: String);
var i: SmallInt;
begin
  for i := 0 to TabSet.Tabs.Count - 1 do
  begin
    if TabSet.Tabs[i] = TabNameOld then
    begin
      TabSet.Tabs[i]  := TabNameNew;
      Break;
    end;
  end;
end;

procedure TFrmMain.TVNodeSort(RootTxt: String; TN: TTreeNode);
var
  N: TTreeNode;
  CountMove: integer;
begin
  // Процедура для сортировки директорий в дереве
  // Директории будут отсортировываться с верху файлов
  CountMove := 0;
  RootTxt  := IncludeTrailingPathDelimiter(RootTxt);
  if DEBUG_MODE then FrmDebugs.mm.Lines.Add('RootTxt + N.Text ' + RootTxt + N.Text);
  N := TN.getFirstChild;
  While Assigned(N) do
  begin
    Application.ProcessMessages;
    if Not StartNodeSort then Break;
    if GetFileAttributes(PChar(RootTxt + N.Text)) = FILE_ATTRIBUTE_DIRECTORY then
    begin
      //if DEBUG_MODE then FrmDebugs.mm.Lines.Add('RootTxt + N.Text ' + RootTxt + N.Text);
      if N.Count > 0 then TVNodeSort(RootTxt + N.Text, N);
      N.MoveTo(TN.Item[CountMove], naInsert);
      inc(CountMove);
    end
      else
    begin
     // Здесь действия для сортировки файлов
     // зарезирвировано т.к. пока не требуется
    end;
    N := N.getNextSibling;
  end;
end;

function TFrmMain.TVSearch(TN: TTreeNode; SearchText: AnsiString): TTreeNode;
var N: TTreeNode;
begin
   Result := Nil;
  if TN.Count > 0 then N := TN.getFirstChild
  else N := TN;

  while Assigned(N) do
  begin
    Application.ProcessMessages;

    if N.Count > 0 then
    begin
      Result := TVSearch(N, SearchText);
      if Assigned(Result) then Break;
    end;

    if AnsiPos(SearchText, AnsiString(N.Text)) > 0 then
    begin
      FrmDebugs.mm.Lines.Add('find!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ' + N.Text);
      Result := N;
      Break;
    end;

    //FrmDebugs.mm.Lines.Add(TN.Text + '\'+ N.Text);
    N := N.getNextSibling;
  end;
end;

procedure TFrmMain.TVSearh;
// Процедура поиска в TReeView
Var i: Integer;
  aSubStr, aStr: AnsiString;
begin

  if LastIndexSearch > 0 then
  begin
    Inc(LastIndexSearch);
    if LastIndexSearch = TV.Items.Count then LastIndexSearch := 0;
  end;

  aSubStr := sCmBoxSearch.Text;

  for i := LastIndexSearch to TV.Items.Count - 1 do
  begin
    Application.ProcessMessages;
    aStr := TV.Items[i].Text;
    if AnsiPos(AnsiLowerCase(aSubStr), AnsiLowerCase(aStr)) > 0 then
    begin
      LastIndexSearch    := i;
      TV.Items[i].Selected := true;
      TV.Items[i].Focused  := true;
      AddSearchBookMark;
      Break;
    end;

  end;

  if (i = TV.Items.Count) and (LastIndexSearch <> 0) then
  begin
    LastIndexSearch := 0;
    TVSearh;
    Exit;
  end;

  TV.SetFocus;
end;

procedure TFrmMain.UpdateCbBoxDirList;
var i: integer;
begin
  sCmBoxExRootDirs.Items.Clear;
  if FrmConfig.LVDir.Items.Count = 0 then Exit;
  sCmBoxExRootDirs.ItemsEx.AddItem('Открыть все директории',1 , 1, 1, 1, 0);
  for i := 0 to FrmConfig.LVDir.Items.Count -1 do
  begin
    sCmBoxExRootDirs.ItemsEx.AddItem(FrmConfig.LVDir.Items[I].Caption , 1, 1, 1, 1, 0);
  end;
  sCmBoxExRootDirs.ItemIndex := 0;
end;

end.
