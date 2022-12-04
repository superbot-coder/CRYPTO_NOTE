object FrmDebugs: TFrmDebugs
  Left = 0
  Top = 0
  Caption = 'Debugging messages'
  ClientHeight = 520
  ClientWidth = 859
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PnlBar: TPanel
    Left = 0
    Top = 0
    Width = 859
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblSelHighLighter: TLabel
      Left = 24
      Top = 18
      Width = 57
      Height = 13
      Caption = #1057#1080#1085#1090#1072#1082#1089#1080#1089':'
    end
    object ChBoxWordWrap: TCheckBox
      Left = 224
      Top = 17
      Width = 97
      Height = 17
      Caption = #1055#1077#1088#1077#1085#1086#1089' '#1089#1090#1088#1086#1082
      TabOrder = 0
      OnClick = ChBoxWordWrapClick
    end
    object CmBoxSelHighLighter: TComboBox
      Left = 87
      Top = 15
      Width = 113
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 1
      Text = #1043#1077#1085#1077#1088#1072#1083#1100#1085#1099#1081
      OnSelect = CmBoxSelHighLighterSelect
      Items.Strings = (
        #1043#1077#1085#1077#1088#1072#1083#1100#1085#1099#1081
        'JSON')
    end
  end
  object SynEdit: TSynEdit
    Left = 0
    Top = 49
    Width = 859
    Height = 471
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Consolas'
    Font.Style = []
    Font.Quality = fqClearTypeNatural
    TabOrder = 1
    UseCodeFolding = False
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Consolas'
    Gutter.Font.Style = []
    Highlighter = SynGeneralSyn
    Lines.Strings = (
      'Debugs mesagess:')
  end
  object SynGeneralSyn: TSynGeneralSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    DetectPreprocessor = False
    Left = 424
    Top = 192
  end
  object SynJSONSyn: TSynJSONSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 504
    Top = 192
  end
  object SynTeXSyn1: TSynTeXSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 424
    Top = 264
  end
end
