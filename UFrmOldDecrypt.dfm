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
  end
end
