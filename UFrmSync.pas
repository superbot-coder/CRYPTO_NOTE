unit UFrmSync;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.Menus, Vcl.ActnPopup, Vcl.ExtCtrls,
  Vcl.FileCtrl,
  System.masks, Error, System.ImageList, Vcl.ImgList, Winapi.ShellAPI, sButton,
  sPanel, sStatusBar, sSkinProvider, sListView, sCheckBox, sLabel, sEdit;

Type
  TProcessType = (ptScan, ptSync);

type
  TFrmSync = class(TForm)
    LVRep_old: TListView;
    ImageList: TImageList;
    LVRep: TsListView;
    sSkinProvider: TsSkinProvider;
    sStatusBar: TsStatusBar;
    sPnlBar: TsPanel;
    LVDirBackUp: TsListView;
    BtnScan: TsButton;
    BtnSync: TsButton;
    sBtnMaskEdit: TsButton;
    edExt: TsEdit;
    sLblExt: TsLabel;
    ProgressBar: TProgressBar;
    ChBoxSyncDirect: TsCheckBox;
    ChBoxSyncRevers: TsCheckBox;
    PopMenu: TPopupMenu;
    PopMenuLVRep: TPopupMenu;
    PM_LVRepSetCheck: TMenuItem;
    PM_LVRepCheckDown: TMenuItem;
    PM_AddDirFromParam: TMenuItem;
    PM_AddDir: TMenuItem;
    PM_VLClear: TMenuItem;
    PM_DeleteItem: TMenuItem;
    PM_Spliter: TMenuItem;
    mm: TMemo;
    LVDirMaster: TsListView;
    procedure ShowModalInit;
    function OpenDirectory: String;
    procedure AddItem(LVAddDir, LVCheckDir: TsListView; AddDir: String);
    function AddItemReport: TListItem;
    procedure PA_VLClearClick(Sender: TObject);
    procedure LVMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtnScanClick(Sender: TObject);
    procedure SynchronizeDirect(StartDir, FirstDir, OldDir, Mask: string;
      ScanSubFolders: Boolean);
    procedure SynchronizeRevers(StartDir, FirstDir, OldDir, Mask: string;
      ScanSubFolders: Boolean);
    function GetDateTimeFromFile(SR: TSearchRec): TDateTime;
    procedure BtnMaskEditClick(Sender: TObject);
    function AddAssociatedIcon(FileName: String): Integer;
    function AddIconFromImageList(ImgList: TImageList; index: Integer): Integer;
    procedure PA_LVRepSetCheckClick(Sender: TObject);
    procedure BtnSyncClick(Sender: TObject);
    procedure PA_LVRepCheckDownClick(Sender: TObject);
    function CheckFileCopy(FileSource, FileDest: String): Boolean;
    procedure LVRep_oldCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure LockControl(ProcType: TProcessType);
    procedure UnlockControl(ProcType: TProcessType);
    procedure ImagListClear;
    procedure PM_LVRepSetCheckClick(Sender: TObject);
    procedure PM_LVRepCheckDownClick(Sender: TObject);
    procedure PM_AddDirFromParamClick(Sender: TObject);
    procedure PM_AddDirClick(Sender: TObject);
    procedure PM_VLClearClick(Sender: TObject);
    procedure PM_DeleteItemClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSync: TFrmSync;
  OpenDirSrt: String;
  LastActivLV: TsListView;
  si: SmallInt;
  I: Integer;
  StartProcess: Boolean;

implementation

USES UFrmMain, UFrmSelectDir, UFrmExt;

{$R *.dfm}
{ TFrmSync }

function TFrmSync.AddAssociatedIcon(FileName: String): Integer;
var
  wd: WORD;
  Icon: Ticon;
  Ext: String;
begin
  // Добавление ассоциированной иконки файла в ListView
  Icon := Ticon.Create;
  Icon.SetSize(16, 16);
  try
    Ext := AnsiLowerCase(ExtractFileExt(FileName));
    if Ext = '.ctxt' then
    begin
      ImageList.GetIcon(1, Icon);
      Result := ImageList.AddIcon(Icon);
      Exit;
    end;

    if Ext = '.txt' then
    begin
      ImageList.GetIcon(2, Icon);
      Result := ImageList.AddIcon(Icon);
      Exit;
    end;

    wd := 0;
    Icon.Handle := ExtractAssociatedIcon(HInstance, PChar(FileName), wd);
    if Icon.HandleAllocated then
      Result := ImageList.AddIcon(Icon)
    else
    begin
      ImageList.GetIcon(0, Icon);
      Result := ImageList.AddIcon(Icon);
    end;

  finally
    Icon.Free;
  end;
end;

function TFrmSync.AddIconFromImageList(ImgList: TImageList;
  index: Integer): Integer;
var
  Icon: Ticon;
begin
  Icon := Ticon.Create;
  try
    ImgList.GetIcon(index, Icon);
    Result := ImageList.AddIcon(Icon);
  finally
    Icon.Free;
  end;
end;

procedure TFrmSync.AddItem(LVAddDir, LVCheckDir: TsListView; AddDir: String);
Var
  NewItem: TListItem;
  I: SmallInt;
begin
  for I := 0 to LVAddDir.Items.Count - 1 do
    if LowerCase(AddDir) = LowerCase(LVAddDir.Items[I].Caption) then
    begin
      MessageBox(Handle,
        PChar('Данная директория уже существует в данном списке.'),
        PChar(MB_CAPTION), MB_ICONWARNING);
      Exit;
    end;

  for I := 0 to LVCheckDir.Items.Count - 1 do
    if LowerCase(AddDir) = LowerCase(LVCheckDir.Items[I].Caption) then
    begin
      MessageBox(Handle,
        PChar('Данная директория уже существует в противоположенном списке.'),
        PChar(MB_CAPTION), MB_ICONWARNING);
      Exit;
    end;

  NewItem := LVAddDir.Items.Add;
  NewItem.Checked := true;
  NewItem.Caption := AddDir;
  NewItem.ImageIndex := 0;

end;

Function TFrmSync.AddItemReport: TListItem;
var
  I: ShortInt;
begin
  Result := LVRep.Items.Add;
  Result.Checked := true;
  for I := 1 to 6 do
    Result.SubItems.Add('');
end;

procedure TFrmSync.BtnMaskEditClick(Sender: TObject);
var
  s: string;
begin
  FrmExt.ShowModal;

  if FrmExt.sChBoxAllFiles.Checked then
  begin
    edExt.Text := '*.*';
    Exit;
  end;

  for si := 0 to FrmExt.LVExt.Items.Count - 1 do
  begin
    if FrmExt.LVExt.Items[si].Checked then
      s := s + FrmExt.LVExt.Items[si].Caption + '|';
  end;
  edExt.Text := ExcludeTrailingPathDelimiter(s);
end;

procedure TFrmSync.BtnScanClick(Sender: TObject);
var
  I: SmallInt;
begin

  if StartProcess = true then
  begin
    StartProcess := false;
    Exit;
  end;

  if (LVDirMaster.Items.Count = 0) or (LVDirBackUp.Items.Count = 0) then
  begin
    MessageBox(Handle, PChar('Не добавлена директория.'), PChar(MB_CAPTION),
      MB_ICONWARNING);
    Exit;
  end;
  StartProcess := true;
  LockControl(ptScan);
  ProgressBar.Position := 0;
  LVRep.Clear;
  ImagListClear;
  LVRep.Items.BeginUpdate;
  for I := 0 to LVDirBackUp.Items.Count - 1 do
  begin
    if LVDirBackUp.Items[I].Checked then
    begin
      if ChBoxSyncDirect.Checked then
        SynchronizeDirect(LVDirMaster.Items[0].Caption,
          LVDirMaster.Items[0].Caption, LVDirBackUp.Items[I].Caption,
          edExt.Text, true);
      if ChBoxSyncRevers.Checked then
        SynchronizeRevers(LVDirBackUp.Items[I].Caption,
          LVDirBackUp.Items[I].Caption, LVDirMaster.Items[0].Caption,
          edExt.Text, true);
    end;
  end;
  StartProcess := false;
  LVRep.Items.EndUpdate;
  UnlockControl(ptScan);
end;

procedure TFrmSync.BtnSyncClick(Sender: TObject);
var
  I: Integer;
  max: Integer;
  FileSource: string;
  FileDest: String;
  FileDir: String;
  cnt: Integer;
begin
  if LVRep.Items.Count = 0 then
    Exit;

  if StartProcess = true then
  begin
    StartProcess := false;
    Exit;
  end;

  LockControl(ptSync);
  // для прогресс бар
  for I := 0 to LVRep.Items.Count - 1 do
    if LVRep.Items[I].Checked then
      inc(max);
  cnt := 0;

  StartProcess := true;
  for I := 0 to LVRep.Items.Count - 1 do
  begin
    Application.ProcessMessages;
    if StartProcess = false then
      Break;
    if Not LVRep.Items[I].Checked then
      Continue;

    if LVRep.Items[I].SubItems[1] = '-->>' then
    begin
      FileSource := LVRep.Items[I].Caption;
      if LVRep.Items[I].SubItems[3] <> '' then
        FileDest := LVRep.Items[I].SubItems[3]
      else
        FileDest := LVRep.Items[I].SubItems[5];
    end
    else
    begin
      FileSource := LVRep.Items[I].SubItems[3];
      if LVRep.Items[I].Caption <> '' then
        FileDest := LVRep.Items[I].Caption
      else
        FileDest := LVRep.Items[I].SubItems[5];
    end;

    // проверка существования директории
    FileDir := ExtractFileDir(FileDest);
    if Not DirectoryExists(FileDir) then
      if Not ForceDirectories(FileDir) then
      begin
        LVRep.Items[I].SubItems[4] := 'Ошибка: ' +
          SystemErrorMessage(GetLastError);
        Continue;
      end;

    // Копирование файла
    CopyFile(PChar(FileSource), PChar(FileDest), false);

    // проверка что файл был дейтвительно скопирован и заменен
    if CheckFileCopy(FileSource, FileDest) then
    begin
      if LVRep.Items[I].SubItems[1] = '-->>' then
      begin
        if LVRep.Items[I].SubItems[3] <> '' then
          LVRep.Items[I].SubItems[4] := 'Обновлен'
        else
          LVRep.Items[I].SubItems[4] := 'Скопирован';
      end
      else
      begin
        if LVRep.Items[I].Caption <> '' then
          LVRep.Items[I].SubItems[4] := 'Обновлен'
        else
          LVRep.Items[I].SubItems[4] := 'Скопирован';
      end;
    end
    else
    begin
      // копирование не удалось
      LVRep.Items[I].SubItems[4] := 'Не удачно';
    end;

    inc(cnt);
    ProgressBar.Position := (cnt * 100) div max;
    LVRep.Refresh;

  end;
  StartProcess := false;
  LVRep.Refresh;
  UnlockControl(ptSync);
end;

function TFrmSync.CheckFileCopy(FileSource, FileDest: String): Boolean;
var
  SR_source, SR_Dest: TSearchRec;
  dt_source, dt_dest: TDateTime;
begin
  Result := false;
  try
    if FindFirst(FileSource, faAnyFile, SR_source) = 0 then
      dt_source := GetDateTimeFromFile(SR_source)
    else
      Exit;

    if FindFirst(FileDest, faAnyFile, SR_Dest) = 0 then
      dt_dest := GetDateTimeFromFile(SR_Dest)
    else
      Exit;

    if dt_source = dt_dest then
      Result := true;

  finally
    FindClose(SR_source);
    FindClose(SR_Dest);
  end;
end;

procedure TFrmSync.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

function TFrmSync.GetDateTimeFromFile(SR: TSearchRec): TDateTime;
Var
  sys_time: TSystemTime;
  LocalTime: TFileTime;
begin
  FileTimeToLocalFileTime(SR.FindData.ftLastWriteTime, LocalTime);
  FileTimeToSystemTime(LocalTime, sys_time);
  Result := SystemTimeToDateTime(sys_time);
end;

procedure TFrmSync.ImagListClear;
begin
  while ImageList.Count > 3 do
    ImageList.Delete(ImageList.Count - 1);
end;

procedure TFrmSync.LockControl(ProcType: TProcessType);
begin
  ChBoxSyncDirect.Enabled := false;
  ChBoxSyncRevers.Enabled := false;

  case ProcType of
    ptScan:
      begin
        BtnScan.Caption := 'ОСТАНОВИТЬ';
        BtnSync.Enabled := false;
        ProgressBar.Style := pbstMarquee;
      end;
    ptSync:
      begin
        BtnScan.Enabled := false;
        BtnSync.Caption := 'ОСТАНОВИТЬ';
      end;
  end;
end;

procedure TFrmSync.LVMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  LastActivLV := Sender as TsListView;
end;

procedure TFrmSync.LVRep_oldCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  DefaultDraw := true;
  with Sender.Canvas do
  begin
    if Item.SubItems[4] = 'Не удачно' then
      Brush.Color := $00D9D9FF;
    if Item.SubItems[4] = 'Обновлен' then
      Brush.Color := $00FFD5D5;
    if Item.SubItems[4] = 'Скопирован' then
      Brush.Color := $00E7FFCE;
    // FillRect(Item.DisplayRect(drBounds));
  end;

end;

function TFrmSync.OpenDirectory: String;
var
  Options: TSelectDirExtOpts;
begin
  /// sdNewFolder, sdShowEdit, sdShowShares,, sdShowFiles, sdValidateDir
  Options := [sdNewFolder, sdShowEdit, sdShowShares, sdNewUI];
  SelectDirectory('Укажите директорию', '', Result, Options, Nil);
end;

procedure TFrmSync.PA_LVRepCheckDownClick(Sender: TObject);
begin
  if LVRep.SelCount = 0 then
    Exit;
  for I := 0 to LVRep.Items.Count - 1 do
    if LVRep.Items[I].Selected then
      if LVRep.Items[I].Checked then
        LVRep.Items[I].Checked := false;
end;

procedure TFrmSync.PA_LVRepSetCheckClick(Sender: TObject);
begin
  if LVRep.SelCount = 0 then
    Exit;
  for I := 0 to LVRep.Items.Count - 1 do
    if LVRep.Items[I].Selected then
      if Not LVRep.Items[I].Checked then
        LVRep.Items[I].Checked := true;
end;

procedure TFrmSync.PA_VLClearClick(Sender: TObject);
begin
  if MessageBox(Handle, PChar('Вы действительно желаете очистить список?'),
    PChar(MB_CAPTION), MB_ICONWARNING or MB_YESNO) = IDNO then
    Exit;
  LastActivLV.Clear;
end;

procedure TFrmSync.PM_AddDirClick(Sender: TObject);
begin
  if LastActivLV = LVDirMaster then
    if LVDirMaster.Items.Count > 0 then
    begin
      MessageBox(Handle,
        PChar('Мастер директория не может быть более чем одна директория.'),
        PChar(MB_CAPTION), MB_ICONINFORMATION);
      Exit;
    end;
  OpenDirSrt := OpenDirectory;
  if OpenDirSrt = '' then
    Exit;
  if LastActivLV = LVDirMaster then
    AddItem(LVDirMaster, LVDirBackUp, OpenDirSrt);
  if LastActivLV = LVDirBackUp then
    AddItem(LVDirBackUp, LVDirMaster, OpenDirSrt);
  LVRep.Clear;
  ImagListClear;
end;

procedure TFrmSync.PM_AddDirFromParamClick(Sender: TObject);
var
  I: SmallInt;
  FrmMode: TFrmInitMode;
begin

  if LastActivLV = LVDirMaster then
  begin
    if LVDirMaster.Items.Count > 0 then
    begin
      MessageBox(Handle,
        PChar('Мастер директория не может быть более чем одна директория.'),
        PChar(MB_CAPTION), MB_ICONINFORMATION);
      Exit;
    end;
    FrmMode := fmMasterDir;
  end
  else
    FrmMode := fmBuckUpDir;

  FrmSelectDir.Apply := false;
  FrmSelectDir.ShowModalInit(FrmMode);

  if Not FrmSelectDir.Apply then
    Exit;
  for I := 0 to FrmSelectDir.LVDir.Items.Count - 1 do
  begin
    if FrmSelectDir.LVDir.Items[I].Checked then
    begin
      mm.Lines.Add(FrmSelectDir.LVDir.Items[I].Caption);
      if LastActivLV = LVDirMaster then
        AddItem(LVDirMaster, LVDirBackUp, FrmSelectDir.LVDir.Items[I].Caption);
      if LastActivLV = LVDirBackUp then
        AddItem(LVDirBackUp, LVDirMaster, FrmSelectDir.LVDir.Items[I].Caption);
    end;
  end;

  LVRep.Clear;
  ImagListClear;
end;

procedure TFrmSync.PM_DeleteItemClick(Sender: TObject);
begin
  if LastActivLV.SelCount = 0 then
    Exit;
  if MessageBox(Handle,
    PChar('Вы действительно желаете удалить выделенную директорию из списока?'),
    PChar(MB_CAPTION), MB_ICONWARNING or MB_YESNO) = IDNO then
    Exit;
  LastActivLV.Selected.Delete;
end;

procedure TFrmSync.PM_LVRepCheckDownClick(Sender: TObject);
begin
  if LVRep.SelCount = 0 then
    Exit;
  for I := 0 to LVRep.Items.Count - 1 do
    if LVRep.Items[I].Selected then
      if LVRep.Items[I].Checked then
        LVRep.Items[I].Checked := false;
end;

procedure TFrmSync.PM_LVRepSetCheckClick(Sender: TObject);
begin
  if LVRep.SelCount = 0 then
    Exit;
  for I := 0 to LVRep.Items.Count - 1 do
    if LVRep.Items[I].Selected then
      if Not LVRep.Items[I].Checked then
        LVRep.Items[I].Checked := true;
end;

procedure TFrmSync.PM_VLClearClick(Sender: TObject);
begin
  if MessageBox(Handle, PChar('Вы действительно желаете очистить список?'),
    PChar(MB_CAPTION), MB_ICONWARNING or MB_YESNO) = IDNO then
    Exit;
  LastActivLV.Clear;
end;

procedure TFrmSync.ShowModalInit;
var
  NewItem: TListItem;
begin
  //
end;

procedure TFrmSync.SynchronizeDirect(StartDir, FirstDir, OldDir, Mask: string;
  ScanSubFolders: Boolean);
var
  SR, SR_Old: TSearchRec;
  MaskStrings: TStrings;
  I: Integer;
  FindFile: String;
  dt_start, dt_sync: TDateTime;
  NewItem: TListItem;
  IcnIndex: Integer;
begin
  StartDir := IncludeTrailingPathDelimiter(StartDir);
  try
    MaskStrings := TStringList.Create;
    if Mask = '' then
      MaskStrings.Add('*.*')
    else
      MaskStrings.Text := StringReplace(Mask, '|', #13,
        [rfReplaceAll, rfIgnoreCase]);

    if FindFirst(StartDir + '*.*', $3F, SR) = 0 then
    Begin
      Repeat
        Application.ProcessMessages;
        if StartProcess = false then
          Break;
        if (SR.Attr and faDirectory) <> 0 then
        begin
          if ScanSubFolders and (SR.Name <> '.') and (SR.Name <> '..') then
          begin
            SynchronizeDirect(StartDir + SR.Name, FirstDir, OldDir, Mask,
              ScanSubFolders);
          end;
        end
        else
        begin

          for I := 0 to MaskStrings.Count - 1 do
          begin
            if MatchesMask(SR.Name, MaskStrings[I]) then
            Begin

              FindFile := Copy(StartDir + SR.Name, Length(FirstDir) + 1,
                Length(StartDir + SR.Name) - Length(FirstDir));

              // Получаем дату последнего изменения
              dt_start := GetDateTimeFromFile(SR);

              /// /  поиск Файла в резервной директории
              if FindFirst(OldDir + FindFile, faAnyFile, SR_Old) = 0 then
              begin

                // Получаем дату файла последнего изменения в синхронизируемой папке
                dt_sync := GetDateTimeFromFile(SR_Old);

                // Если даты последнего изменения равны то переход на следующий цикл
                if (dt_start = dt_sync) or (dt_start < dt_sync) then
                  Continue;

                // Получение иконки
                IcnIndex := AddAssociatedIcon(StartDir + SR.Name);

                // Создаем новый итем в списке
                NewItem := AddItemReport;
                NewItem.Caption := StartDir + SR.Name;
                NewItem.ImageIndex := IcnIndex;
                NewItem.SubItems[0] := FormatDateTime('dd.mm.yyyy hh:mm:ss.zz',
                  dt_start);
                NewItem.SubItems[2] :=
                  FormatDateTime('dd.mm.yyyy hh:mm:ss.zz', dt_sync);
                NewItem.SubItems[3] := OldDir + FindFile;
                NewItem.SubItemImages[3] := IcnIndex;

                //
                if dt_start > dt_sync then
                begin
                  // NewItem.SubItems[4] := 'Заменен';
                  NewItem.SubItems[1] := '-->>';
                end;

              end
              else
              begin
                // Если файл не найден в синхронизируемой директории

                // Получение иконки
                IcnIndex := AddAssociatedIcon(StartDir + SR.Name);

                NewItem := AddItemReport;
                NewItem.Caption := StartDir + SR.Name;
                NewItem.ImageIndex := IcnIndex;
                NewItem.SubItems[0] := FormatDateTime('dd.mm.yyyy hh:mm:ss.zz',
                  dt_start);
                NewItem.SubItems[1] := '-->>';
                NewItem.SubItems[5] := OldDir + FindFile;
                // NewItem.SubItems[4] := 'Скопирован';
              end;

              FindClose(SR_Old);

            end;
          end;
        end;

      until FindNext(SR) <> 0;
    end
    else
    begin
      MessageBox(Handle, PChar('Error: ' + SystemErrorMessage(GetLastError)),
        PChar(MB_CAPTION), MB_ICONSTOP);
    end;

  finally
    MaskStrings.Free;
    FindClose(SR);
  end;

end;

procedure TFrmSync.SynchronizeRevers(StartDir, FirstDir, OldDir, Mask: string;
  ScanSubFolders: Boolean);
var
  SR, SR_Old: TSearchRec;
  MaskStrings: TStrings;
  I: Integer;
  FindFile: String;
  dt_start, dt_sync: TDateTime;
  NewItem: TListItem;
  IcnIndex: ShortInt;
begin
  StartDir := IncludeTrailingPathDelimiter(StartDir);
  try
    MaskStrings := TStringList.Create;
    if Mask = '' then
      MaskStrings.Add('*.*')
    else
      MaskStrings.Text := StringReplace(Mask, '|', #13,
        [rfReplaceAll, rfIgnoreCase]);

    if FindFirst(StartDir + '*.*', $3F, SR) = 0 then
    Begin
      Repeat
        Application.ProcessMessages;
        if StartProcess = false then
          Break;
        if (SR.Attr and faDirectory) <> 0 then
        begin
          if ScanSubFolders and (SR.Name <> '.') and (SR.Name <> '..') then
          begin
            SynchronizeRevers(StartDir + SR.Name, FirstDir, OldDir, Mask,
              ScanSubFolders);
          end;
        end
        else
        begin

          for I := 0 to MaskStrings.Count - 1 do
          begin
            if MatchesMask(SR.Name, MaskStrings[I]) then
            Begin

              FindFile := Copy(StartDir + SR.Name, Length(FirstDir) + 1,
                Length(StartDir + SR.Name) - Length(FirstDir));

              // Получаем дату последнего изменения
              dt_start := GetDateTimeFromFile(SR);

              // поиск Файла в другой директории
              if FindFirst(OldDir + FindFile, faAnyFile, SR_Old) = 0 then
              begin

                dt_sync := GetDateTimeFromFile(SR_Old);

                if (dt_start = dt_sync) or (dt_start < dt_sync) then
                  Continue;

                // Получение иконки
                IcnIndex := AddAssociatedIcon(StartDir + SR.Name);

                // Если файл не найден в синхронизируемой директории
                NewItem := AddItemReport;
                NewItem.Caption := OldDir + FindFile; // StartDir + SR.Name;
                NewItem.ImageIndex := IcnIndex;
                NewItem.SubItemImages[3] :=
                  AddAssociatedIcon(StartDir + SR.Name);
                NewItem.SubItems[2] := FormatDateTime('dd.mm.yyyy hh:mm:ss.zz',
                  dt_start);
                NewItem.SubItems[1] := '<<--';
                NewItem.SubItems[3] := StartDir + SR.Name;

              end
              else
              begin
                // Если файл не найден в другой директории

                // Получение иконки
                IcnIndex := AddAssociatedIcon(StartDir + SR.Name);

                // Если файл не найден в синхронизируемой директории
                NewItem := AddItemReport;
                NewItem.Caption := '';
                // OldDir + FindFile; //StartDir + SR.Name;
                NewItem.ImageIndex := -1;
                NewItem.SubItemImages[3] := IcnIndex;
                NewItem.SubItems[2] := FormatDateTime('dd.mm.yyyy hh:mm:ss.zz',
                  dt_start);
                NewItem.SubItems[1] := '<<--';
                NewItem.SubItems[3] := StartDir + SR.Name;
                NewItem.SubItems[5] := OldDir + FindFile;

              end;

              FindClose(SR_Old);

            end;
          end;
        end;

      until FindNext(SR) <> 0;
    end
    else
    begin
      MessageBox(Handle, PChar('Error: ' + SystemErrorMessage(GetLastError)),
        PChar(MB_CAPTION), MB_ICONSTOP);
    end;

  finally
    MaskStrings.Free;
    FindClose(SR);
  end;

end;

procedure TFrmSync.UnlockControl(ProcType: TProcessType);
begin
  ChBoxSyncDirect.Enabled := true;
  ChBoxSyncRevers.Enabled := true;
  case ProcType of
    ptScan:
      begin
        BtnScan.Caption := 'СКАНИРОВАТЬ';
        BtnSync.Enabled := true;
        ProgressBar.Style := pbstNormal;
      end;
    ptSync:
      begin
        BtnScan.Enabled := true;
        BtnSync.Caption := 'СИНХРОНИЗИРОВАТЬ';
      end;
  end;
end;

end.
