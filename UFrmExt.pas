unit UFrmExt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, System.Win.Registry,
  sButton, sListView, sSkinProvider, sCheckBox, sLabel, sEdit, Vcl.Menus;

type
  TFrmExt = class(TForm)
    LVExt: TsListView;
    sBtnOk: TsButton;
    sBtnAdd: TsButton;
    sEdDescript: TsEdit;
    sLblDescript: TsLabel;
    sEdExt: TsEdit;
    sLblExt: TsLabel;
    sChBoxAllFiles: TsCheckBox;
    sSkinProvider: TsSkinProvider;
    PopupMenu: TPopupMenu;
    PM_Delete: TMenuItem;
    procedure BtnOKClick(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure SaveLVExtToReg;
    procedure LoadLVExtFromReg;
    function MaskExistes(mask: string): boolean;
    procedure FormCreate(Sender: TObject);
    procedure PM_DeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExt: TFrmExt;
  I: SmallInt;

implementation

USES UFrmMain, UFrmSync;

{$R *.dfm}

procedure TFrmExt.BtnAddClick(Sender: TObject);
Var
  NewItem: TListItem;
begin
  for I := 0 to LVExt.Items.Count - 1 do
    if LVExt.Items[I].Caption = LowerCase(sEdExt.Text) then
    begin
      MessageBox(Handle, PChar('Такая маска уже существует.'),
        PChar(MB_CAPTION), MB_ICONWARNING);
      Exit;
    end;

  NewItem := LVExt.Items.Add;
  NewItem.Caption := sEdExt.Text;
  NewItem.SubItems.Add(sEdDescript.Text);

end;

procedure TFrmExt.BtnOKClick(Sender: TObject);
begin
  SaveLVExtToReg;
  close;
end;

procedure TFrmExt.FormCreate(Sender: TObject);
begin
  LoadLVExtFromReg;
end;

procedure TFrmExt.LoadLVExtFromReg;
var
  Reg: TRegistry;
  I: SmallInt;
  st: TStrings;
  s_temp: AnsiString;
  NewItem: TListItem;
begin
  Reg := TRegistry.Create;
  st := TStringList.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\CryptoNote\Extentions', false) then
    begin
      Reg.GetValueNames(st);
      for I := 0 to st.Count - 1 do
      begin
        if MaskExistes(st.Strings[I]) or (st.Strings[I] = '') then
          Continue;
        s_temp := Reg.ReadString(st.Strings[I]);
        NewItem := LVExt.Items.Add;
        if AnsiPos('checked', s_temp) > 0 then
        begin
          s_temp := copy(s_temp, 1, length(s_temp) - length('checked'));
          NewItem.Checked := true;
        end;
        NewItem.Caption := st.Strings[I];
        NewItem.SubItems.Add(s_temp);
      end;
    end;
  finally
    Reg.Free;
    st.Free;
  end;
end;

function TFrmExt.MaskExistes(mask: string): boolean;
begin
  Result := false;
  for I := 0 to LVExt.Items.Count - 1 do
  begin
    if LVExt.Items[I].Caption = mask then
    begin
      Result := true;
      Exit;
    end;
  end;
end;

procedure TFrmExt.PM_DeleteClick(Sender: TObject);
begin
  if LVExt.SelCount = 0 then
    Exit;
  LVExt.DeleteSelected;
end;

procedure TFrmExt.SaveLVExtToReg;
var
  Reg: TRegistry;
  si: SmallInt;
  Checked: string;
begin
  Reg := TRegistry.Create;

  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('\Software\CryptoNote\Extentions', true) then
    begin
      for si := 0 to LVExt.Items.Count - 1 do
      begin
        if LVExt.Items[si].Checked then
          Checked := 'checked'
        else
          Checked := '';
        Reg.WriteString(LVExt.Items[si].Caption, LVExt.Items[si].SubItems[0] +
          ' ' + Checked);
      end;
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;

end;

end.
