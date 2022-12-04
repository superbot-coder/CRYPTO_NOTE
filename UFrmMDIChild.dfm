object FrmMDIChild: TFrmMDIChild
  Left = 0
  Top = 0
  Caption = 'FrmMDIChild'
  ClientHeight = 522
  ClientWidth = 889
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SynEdit: TSynEdit
    Left = 0
    Top = 60
    Width = 889
    Height = 440
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Consolas'
    Font.Style = []
    Font.Quality = fqClearTypeNatural
    TabOrder = 0
    UseCodeFolding = False
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Consolas'
    Gutter.Font.Style = []
    Gutter.Visible = False
    Gutter.Width = 0
    Highlighter = SynGeneralSyn
    Lines.Strings = (
      #1083#1091#1095#1096#1080#1081' '#1073#1072#1083#1072#1085#1089'        = 22400'
      #1090#1077#1082#1091#1097#1072#1103#1103' '#1079#1072#1076#1086#1083#1078#1085#1086#1089#1090#1100' = 32581'
      ''
      'USD1 =  +10240'
      'USD2 =   +8700'
      'USD3 =   +5800')
  end
  object PanelBar: TPanel
    Left = 0
    Top = 0
    Width = 889
    Height = 60
    Align = alTop
    TabOrder = 1
    object ImageLogo: TImage
      Left = 12
      Top = 6
      Width = 48
      Height = 48
    end
    object BtnEncrypt: TButton
      Left = 518
      Top = 16
      Width = 121
      Height = 25
      Caption = #1047#1072#1096#1080#1092#1088#1086#1074#1072#1090#1100
      TabOrder = 0
      OnClick = BtnEncryptClick
    end
    object BtnDecrypt: TButton
      Left = 391
      Top = 16
      Width = 121
      Height = 25
      Caption = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1072#1090#1100
      TabOrder = 1
      OnClick = BtnDecryptClick
    end
    object BtnSaveDecrypt: TButton
      Left = 209
      Top = 17
      Width = 176
      Height = 24
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1085#1077' '#1079#1072#1096#1080#1092#1088#1086#1074#1072#1085#1085#1099#1084
      DoubleBuffered = False
      ParentDoubleBuffered = False
      TabOrder = 2
      OnClick = BtnSaveDecryptClick
    end
    object BtnSave: TButton
      Left = 82
      Top = 17
      Width = 121
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 3
      OnClick = BtnSaveClick
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 500
    Width = 889
    Height = 22
    Panels = <
      item
        Text = #1057#1086#1079#1076#1072#1085':'
        Width = 250
      end
      item
        Text = #1048#1079#1084#1077#1085#1077#1085':'
        Width = 50
      end>
  end
  object SynGeneralSyn: TSynGeneralSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    DetectPreprocessor = True
    Left = 312
    Top = 352
  end
end
