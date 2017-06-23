object FrmSelectEncrypt: TFrmSelectEncrypt
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1096#1080#1092#1088#1086#1074#1072#1085#1080#1103
  ClientHeight = 179
  ClientWidth = 496
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object lblAlgo: TLabel
    Left = 8
    Top = 71
    Width = 60
    Height = 16
    Caption = #1040#1083#1075#1086#1088#1080#1090#1084':'
  end
  object JvXPBtton: TJvXPButton
    Left = 184
    Top = 136
    Width = 121
    Height = 35
    Caption = #1055#1056#1048#1052#1045#1053#1048#1058#1068
    TabOrder = 0
    OnClick = JvXPBttonClick
  end
  object RadioGroup: TRadioGroup
    Left = 8
    Top = 8
    Width = 480
    Height = 57
    Caption = #1042#1099#1073#1086#1088' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074
    Columns = 2
    Items.Strings = (
      #1064#1080#1092#1088#1086#1074#1072#1090#1100' '#1052#1040#1057#1058#1045#1056' '#1087#1072#1088#1086#1083#1077#1084
      #1064#1080#1092#1088#1086#1074#1072#1090#1100' '#1076#1088#1091#1075#1080#1084' '#1087#1072#1088#1086#1083#1077#1084)
    TabOrder = 1
  end
  object ChBoxDeleteSource: TCheckBox
    Left = 271
    Top = 97
    Width = 202
    Height = 17
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1092#1072#1081#1083'('#1099') '#1080#1089#1090#1086#1095#1085#1080#1082'('#1080')'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 2
  end
  object CmBoxExAlgo: TComboBoxEx
    Left = 8
    Top = 93
    Width = 249
    Height = 25
    ItemsEx = <
      item
        Caption = 'RC_SHA1'
        ImageIndex = 4
        SelectedImageIndex = 4
      end>
    TabOrder = 3
    Images = FrmMain.ImageList
  end
end
