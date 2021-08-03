unit UFrmSelectEncrypt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls,  Vcl.ComCtrls, CryptMod, sButton;

type
  TFrmSelectEncrypt = class(TForm)
    RadioGroup: TRadioGroup;
    ChBoxDeleteSource: TCheckBox;
    CmBoxExAlgo: TComboBoxEx;
    lblAlgo: TLabel;
    sButton1: TsButton;
    procedure FrmShowModal(DLG: TCryptDlgMode);
    procedure FormCreate(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    Apply: Boolean;
    ALGO : TAlgoType;
  end;

var
  FrmSelectEncrypt: TFrmSelectEncrypt;

implementation

USES UfrmMain;

{$R *.dfm}

procedure TFrmSelectEncrypt.FormCreate(Sender: TObject);
var I: ShortInt;
    NewItem: TComboExItem;
begin
  CmBoxExAlgo.Clear;
  for i:=1 to Length(AlgoName)-1 do
  begin
    NewItem := CmBoxExAlgo.ItemsEx.Add;
    NewItem.Caption := AlgoName[TAlgoType(i)];
    NewItem.ImageIndex := 4;
  end;
  CmBoxExAlgo.ItemIndex := 0;
end;

procedure TFrmSelectEncrypt.FrmShowModal(DLG: TCryptDlgMode);
begin
  Apply := false;
  RadioGroup.ItemIndex := 0;
  ChBoxDeleteSource.Checked := false;
  CmBoxExAlgo.ItemIndex := 0;
  case DLG of

   DLG_ECRYPT:
   begin
     caption := 'Параметры шифрования';
     RadioGroup.Items[0] := 'Шифровать МАСТЕР паролем';
     RadioGroup.Items[1] := 'Шифровать другим паролем';
     //ChBoxDeleteSource.Caption := 'Удалить файл(ы) источник(и)';
     //ChBoxDeleteSource.Visible := true;
   end;

   DLG_DECRYPT:
   begin
     caption := 'Параметры дешифрования';
     RadioGroup.Items[0] := 'Дешифровать МАСТЕР паролем';
     RadioGroup.Items[1] := 'Дешифровать другим паролем';
     //ChBoxDeleteSource.Caption := 'Удалить шифрованный(е) файл(ы)';
     //ChBoxDeleteSource.Visible := false;
   end;

  end;

  ShowModal;
end;

procedure TFrmSelectEncrypt.sButton1Click(Sender: TObject);
begin
  ALGO  := GetAlgoType(FrmSelectEncrypt.CmBoxExAlgo.Items[FrmSelectEncrypt.CmBoxExAlgo.ItemIndex]);
  Apply := true;
  Close;
end;

end.
