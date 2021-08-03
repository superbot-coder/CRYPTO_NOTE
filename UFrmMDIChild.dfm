object FrmMDIChild: TFrmMDIChild
  Left = 0
  Top = 0
  Caption = 'FrmMDIChild'
  ClientHeight = 522
  ClientWidth = 889
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object sPnlBar: TsPanel
    Left = 0
    Top = 0
    Width = 889
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      889
      65)
    object ImageLogo: TImage
      Left = 12
      Top = 12
      Width = 48
      Height = 48
    end
    object sBtnSaveUnCrypt: TsButton
      Left = 209
      Top = 15
      Width = 119
      Height = 37
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1085#1077' '#1079#1072#1096#1080#1092#1088#1086#1074#1072#1085#1085#1099#1084
      TabOrder = 0
      OnClick = sBtnSaveUnCryptClick
    end
    object sBtnSave: TsButton
      Left = 82
      Top = 15
      Width = 121
      Height = 37
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 1
      OnClick = sBtnSaveClick
    end
    object sBtnDecrypt: TsButton
      Left = 334
      Top = 16
      Width = 121
      Height = 35
      Caption = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1072#1090#1100
      TabOrder = 2
      OnClick = sBtnDecryptClick
    end
    object sBtnEncrypt: TsButton
      Left = 461
      Top = 16
      Width = 121
      Height = 35
      Caption = #1047#1072#1096#1080#1092#1088#1086#1074#1072#1090#1100
      TabOrder = 3
      OnClick = sBtnEncryptClick
    end
    object sBtnParam: TsButton
      Left = 777
      Top = 15
      Width = 105
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1042#1085#1077#1096#1085#1080#1081' '#1074#1080#1076
      TabOrder = 4
      OnClick = sBtnParamClick
    end
  end
  object StatusBar: TsStatusBar
    Left = 0
    Top = 502
    Width = 889
    Height = 20
    Panels = <
      item
        Text = #1057#1086#1079#1076#1072#1085': '
        Width = 250
      end
      item
        Text = #1048#1079#1084#1077#1085#1077#1085':'
        Width = 200
      end>
    SizeGrip = False
  end
  object mm: TsMemo
    Left = 0
    Top = 65
    Width = 889
    Height = 437
    Align = alClient
    Color = 3682598
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = 16772838
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    BoundLabel.Font.Charset = RUSSIAN_CHARSET
    BoundLabel.Font.Color = 16772838
    BoundLabel.Font.Height = -13
    BoundLabel.Font.Name = 'Courier New'
    BoundLabel.Font.Style = []
  end
  object sSkinProvider: TsSkinProvider
    ShowAppIcon = False
    AddedTitle.Font.Charset = DEFAULT_CHARSET
    AddedTitle.Font.Color = clNone
    AddedTitle.Font.Height = -11
    AddedTitle.Font.Name = 'Tahoma'
    AddedTitle.Font.Style = []
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 68
    Top = 80
  end
end
