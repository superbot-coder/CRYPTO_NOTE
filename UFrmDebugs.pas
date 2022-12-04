unit UFrmDebugs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, SynEdit,
  SynEditHighlighter, SynHighlighterGeneral, SynEditCodeFolding,
  SynHighlighterJSON, SynHighlighterTeX;

type
  TFrmDebugs = class(TForm)
    PnlBar: TPanel;
    SynEdit: TSynEdit;
    SynGeneralSyn: TSynGeneralSyn;
    ChBoxWordWrap: TCheckBox;
    SynJSONSyn: TSynJSONSyn;
    CmBoxSelHighLighter: TComboBox;
    lblSelHighLighter: TLabel;
    SynTeXSyn1: TSynTeXSyn;
    procedure ChBoxWordWrapClick(Sender: TObject);
    procedure CmBoxSelHighLighterSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FMsgCount: Cardinal;
    FStMsg: TStrings;
  public
    procedure AddDbgMessage(DbgMsgStr: String);
    { Public declarations }
  end;

var
  FrmDebugs: TFrmDebugs;

implementation

{$R *.dfm}

{ TFrmDebugs }

procedure TFrmDebugs.AddDbgMessage(DbgMsgStr: String);
begin
  SynEdit.Lines.Add('');
  SynEdit.Lines.Add('Message ID: ' + UIntToStr(FMsgCount));
  FStMsg.Text := DbgMsgStr;
  SynEdit.Lines.AddStrings(FStMsg);
  Inc(FMsgCount);
end;

procedure TFrmDebugs.ChBoxWordWrapClick(Sender: TObject);
begin
  if ChBoxWordWrap.Checked then
    SynEdit.WordWrap := true
  else
    SynEdit.WordWrap := false;
end;

procedure TFrmDebugs.CmBoxSelHighLighterSelect(Sender: TObject);
begin
  case CmBoxSelHighLighter.ItemIndex of
    0: SynEdit.Highlighter := SynGeneralSyn;
    1: SynEdit.Highlighter := SynJSONSyn;
  end;
end;

procedure TFrmDebugs.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FStMsg.Free;
end;

procedure TFrmDebugs.FormCreate(Sender: TObject);
begin
  FStMsg := TStringList.Create;
end;

end.
