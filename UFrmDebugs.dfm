object FrmDebugs: TFrmDebugs
  Left = 0
  Top = 0
  Caption = 'FrmDebugs'
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
  PixelsPerInch = 96
  TextHeight = 13
  object mm: TMemo
    Left = 0
    Top = 41
    Width = 859
    Height = 479
    Align = alClient
    Lines.Strings = (
      'mm')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object PnlBar: TPanel
    Left = 0
    Top = 0
    Width = 859
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
  end
end
