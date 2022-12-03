object FrmMasterPwd: TFrmMasterPwd
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1052#1072#1089#1090#1077#1088' '#1087#1072#1088#1086#1083#1100
  ClientHeight = 208
  ClientWidth = 365
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    365
    208)
  PixelsPerInch = 96
  TextHeight = 16
  object BtnSave: TButton
    Left = 104
    Top = 167
    Width = 153
    Height = 33
    Anchors = [akLeft, akRight, akBottom]
    Caption = #1055#1056#1048#1052#1045#1053#1048#1058#1068
    TabOrder = 0
    OnClick = BtnSaveClick
  end
  object edPwd1: TLabeledEdit
    Left = 16
    Top = 32
    Width = 321
    Height = 24
    EditLabel.Width = 48
    EditLabel.Height = 16
    EditLabel.Caption = #1055#1072#1088#1086#1083#1100':'
    MaxLength = 64
    PasswordChar = '*'
    TabOrder = 1
  end
  object edPwd2: TLabeledEdit
    Left = 16
    Top = 82
    Width = 321
    Height = 24
    EditLabel.Width = 103
    EditLabel.Height = 16
    EditLabel.Caption = #1055#1072#1088#1086#1083#1100' ('#1087#1086#1074#1090#1086#1088'):'
    MaxLength = 64
    PasswordChar = '*'
    TabOrder = 2
  end
  object ChBoxStrView: TCheckBox
    Left = 16
    Top = 135
    Width = 217
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1090#1077#1082#1089#1090' '#1087#1086#1076' '#1079#1074#1077#1079#1076#1072#1095#1082#1072#1084#1080
    TabOrder = 3
    OnClick = ChBoxStrViewClick
  end
  object ChBoxSaveНаrdLink: TCheckBox
    Left = 16
    Top = 114
    Width = 257
    Height = 17
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080' '#1087#1088#1080#1074#1103#1079#1072#1090#1100' '#1082' '#1082#1086#1084#1087#1100#1102#1090#1077#1088#1091
    TabOrder = 4
  end
end
