object FrmDlgFileName: TFrmDlgFileName
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1092#1072#1081#1083
  ClientHeight = 102
  ClientWidth = 319
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lblFileName: TLabel
    Left = 8
    Top = 13
    Width = 136
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1074#1086#1077' '#1080#1084#1103' '#1092#1072#1081#1083#1072':'
  end
  object BtnOk: TButton
    Left = 110
    Top = 65
    Width = 99
    Height = 30
    Caption = #1057#1054#1061#1056#1040#1053#1048#1058#1068
    TabOrder = 0
    OnClick = btnOkClick
  end
  object edFileName: TEdit
    Left = 8
    Top = 32
    Width = 301
    Height = 21
    TabOrder = 1
  end
end
