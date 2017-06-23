object FrmOldDeCrypt: TFrmOldDeCrypt
  Left = 0
  Top = 0
  Caption = 'CRYPTO LOGIC'
  ClientHeight = 586
  ClientWidth = 1028
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 16
  object Splitter1: TSplitter
    Left = 0
    Top = 292
    Width = 1028
    Height = 10
    Cursor = crVSplit
    Align = alTop
    Beveled = True
    ExplicitWidth = 846
  end
  object PnlSource: TPanel
    Left = 0
    Top = 57
    Width = 1028
    Height = 235
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PnlSource'
    TabOrder = 0
    object mmSource: TMemo
      Left = 0
      Top = 0
      Width = 1028
      Height = 235
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object PnlDest: TPanel
    Left = 0
    Top = 302
    Width = 1028
    Height = 284
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object mmDest: TMemo
      Left = 0
      Top = 0
      Width = 1028
      Height = 284
      Align = alClient
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object Pnl: TPanel
    Left = 0
    Top = 0
    Width = 1028
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object JvGradient1: TJvGradient
      Left = 0
      Top = 0
      Width = 1028
      Height = 57
      Style = grVertical
      StartColor = clBtnFace
      EndColor = clSkyBlue
      ExplicitLeft = 624
      ExplicitTop = 8
      ExplicitWidth = 100
      ExplicitHeight = 41
    end
    object JvXPBtnImport: TJvXPButton
      Left = 24
      Top = 12
      Width = 150
      Height = 30
      Caption = #1048#1084#1087#1086#1088#1090' '#1080#1079' '#1092#1072#1081#1083#1072
      TabOrder = 0
      OnClick = JvXPBtnImportClick
    end
    object JvXPBtnSave: TJvXPButton
      Left = 375
      Top = 12
      Width = 150
      Height = 30
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090
      TabOrder = 1
      OnClick = JvXPBtnSaveClick
    end
    object JvXPBtnDecrypt: TJvXPButton
      Left = 196
      Top = 12
      Width = 150
      Height = 30
      Caption = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1072#1090#1100
      TabOrder = 2
      OnClick = JvXPBtnDecryptClick
    end
  end
end
