unit UFrmConfig;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
    System.Win.Registry,
    Vcl.FileCtrl, ShellAPI,
    // JvExControls, JvXPCore, JvXPButtons, JvExStdCtrls, JvListComb,
    Vcl.Menus, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup,
    Vcl.ComCtrls, sComboBoxes, sButton, sLabel, Vcl.Mask, sMaskEdit,
    sCustomComboEdit, sToolEdit, sListView, sComboBox;

type
    TFrmConfig = class(TForm)
        PopActionBar: TPopupActionBar;
        PA_DeletDir: TMenuItem;
        PM_AddDir: TMenuItem;
        sSkinSelector: TsSkinSelector;
        sLblTxtEditors: TsLabel;
        sBtnApply: TsButton;
        LVDir: TsListView;
        sFilenameEditTxtEditor: TsFilenameEdit;
        procedure FormCreate(Sender: TObject);
        procedure BtnApply(Sender: TObject);
        procedure AddDirToList;
        procedure SaveDirToRegistry;
        procedure ReadDirListFromRegistry;
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure JvXPBtnAddDirClick(Sender: TObject);
        procedure PA_DeletDirClick(Sender: TObject);
        procedure PM_AddDirClick(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    FrmConfig: TFrmConfig;
    Reg: TRegistry;
    Dir: string;
    st: TStrings;
    NewItem: TListItem;
    i: integer;

const
    SELDIRHELP = 1000;

implementation

Uses UFrmMain;

{$R *.dfm}

procedure TFrmConfig.AddDirToList;
var
    Options: TSelectDirExtOpts;
    ChosenDirectory: String;
begin
    Options := [sdShowShares, sdNewUI];
    if Not SelectDirectory('Укажите директорию', '', ChosenDirectory, Options,
      Nil) then
        Exit;
    if ChosenDirectory = '' then
        Exit;

    for i := 0 to LVDir.Items.Count - 1 do
    begin
        if LVDir.Items[i].Caption = ChosenDirectory then
        begin
            MessageBox(Handle,
              PChar('Такая директория уже существует в списке.'),
              PChar(MB_CAPTION), MB_ICONINFORMATION);
            Exit;
        end;
    end;

    NewItem := LVDir.Items.Add;
    NewItem.Caption := ChosenDirectory;
    NewItem.ImageIndex := 0;
    NewItem.Checked := True;

end;

procedure TFrmConfig.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    ReadDirListFromRegistry;
end;

procedure TFrmConfig.FormCreate(Sender: TObject);
begin
    // ReadSettings;
    ReadDirListFromRegistry;
    FrmMain.UpdateCbBoxDirList;
end;

procedure TFrmConfig.BtnApply(Sender: TObject);
begin
    SaveDirToRegistry;
    MessageBox(Handle, PChar('Праметры были успешно сохранены.'),
      PChar(MB_CAPTION), MB_ICONINFORMATION);
    Close;
end;

procedure TFrmConfig.PA_DeletDirClick(Sender: TObject);
begin
    if MessageBox(Handle,
      PChar('Вы действительно хотите удалить выделенные директории?' + #13#10 +
      'Для удаления нажмите ДА, для отмены Нет.'), PChar(MB_CAPTION),
      MB_YESNO or MB_ICONWARNING) = ID_NO Then
        Exit;
    LVDir.DeleteSelected;
end;

procedure TFrmConfig.PM_AddDirClick(Sender: TObject);
begin
    AddDirToList;
end;

procedure TFrmConfig.JvXPBtnAddDirClick(Sender: TObject);
begin
    AddDirToList;
end;

procedure TFrmConfig.ReadDirListFromRegistry;
begin
    LVDir.Clear;
    try
        st := TStringList.Create;
        Reg := TRegistry.Create;
        Reg.RootKey := HKEY_CURRENT_USER;

        if Reg.OpenKey('\Software\CryptoNote\CryptoDirectories', false) then
        begin
            Reg.GetValueNames(st);
            if st.Count = 0 then
                Exit;
            for i := 0 to st.Count - 1 do
            begin
                NewItem := LVDir.Items.Add;
                NewItem.Caption := st.Strings[i];
                NewItem.ImageIndex := 0;
                NewItem.Checked := Reg.ReadBool(st.Strings[i]);
            end;
            Reg.CloseKey;
        end;

        if Reg.OpenKey('\Software\CryptoNote', True) then
        begin
            sFilenameEditTxtEditor.Text := Reg.ReadString('OldTxtEditor');
            Reg.CloseKey;
        end;

    finally
        st.Free;
        Reg.Free;
    end;
end;

procedure TFrmConfig.SaveDirToRegistry;
begin
    if LVDir.Items.Count = 0 then
        Exit;
    try
        Reg := TRegistry.Create;
        Reg.RootKey := HKEY_CURRENT_USER;
        Reg.DeleteKey('\Software\CryptoNote\CryptoDirectories');
        if Reg.OpenKey('\Software\CryptoNote\CryptoDirectories', True) then
        begin
            for i := 0 to LVDir.Items.Count - 1 do
                Reg.WriteBool(LVDir.Items[i].Caption, LVDir.Items[i].Checked);
            Reg.CloseKey;
        end;

        if Reg.OpenKey('\Software\CryptoNote', True) then
        begin
            Reg.WriteString('OldTxtEditor', sFilenameEditTxtEditor.Text);
            Reg.CloseKey;
        end;

    finally
        Reg.Free;
    end;
end;

end.
