object FrmColorParam: TFrmColorParam
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1094#1074#1077#1090#1086#1074' '#1092#1086#1085#1072' '#1080' '#1096#1088#1080#1092#1090#1086#1074
  ClientHeight = 234
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 16
  object ColorBox: TColorBox
    Left = 120
    Top = 30
    Width = 174
    Height = 22
    TabOrder = 0
  end
  object mmDemo: TMemo
    Left = 8
    Top = 64
    Width = 424
    Height = 130
    Lines.Strings = (
      #1064#1088#1080#1092#1090#1099' '#1080' '#1094#1074#1077#1090#1072)
    TabOrder = 1
  end
  object ColorDialog: TColorDialog
    Left = 324
    Top = 80
  end
end
