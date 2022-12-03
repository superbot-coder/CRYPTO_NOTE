object FrmProgressBar: TFrmProgressBar
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 55
  ClientWidth = 316
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
  object LblCaption: TLabel
    Left = 88
    Top = 18
    Width = 129
    Height = 16
    Caption = #1048#1076#1077#1090' '#1089#1082#1072#1085#1080#1088#1086#1074#1072#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object TimerProgress: TTimer
    Enabled = False
    Interval = 100
    OnTimer = TimerProgressTimer
    Left = 234
    Top = 8
  end
end
