object FrmSelectDir: TFrmSelectDir
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'FrmSelectDir'
  ClientHeight = 249
  ClientWidth = 494
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
  object LVDir: TListView
    Left = 8
    Top = 8
    Width = 477
    Height = 193
    Checkboxes = True
    Columns = <
      item
        AutoSize = True
        Caption = #1044#1080#1088#1077#1082#1090#1086#1088#1080#1080
      end>
    TabOrder = 0
    ViewStyle = vsReport
  end
  object BtnOK: TButton
    Left = 184
    Top = 208
    Width = 129
    Height = 33
    Caption = #1054#1050
    TabOrder = 1
    OnClick = BtnOKClick
  end
end
