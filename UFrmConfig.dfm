object FrmConfig: TFrmConfig
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 325
  ClientWidth = 527
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
  PixelsPerInch = 96
  TextHeight = 16
  object LblTxtEditors: TLabel
    Left = 8
    Top = 217
    Width = 126
    Height = 16
    Caption = #1058#1077#1082#1089#1090#1086#1074#1099#1081' '#1088#1077#1076#1072#1082#1090#1086#1088':'
  end
  object SpBtnOpenDlg: TSpeedButton
    Left = 494
    Top = 238
    Width = 25
    Height = 25
    Caption = '...'
    OnClick = SpBtnOpenDlgClick
  end
  object LVDir: TListView
    Left = 8
    Top = 8
    Width = 511
    Height = 193
    Columns = <
      item
        Caption = #1044#1080#1088#1077#1082#1090#1086#1088#1080#1080
        MinWidth = 400
        Width = 500
      end>
    TabOrder = 0
    ViewStyle = vsReport
  end
  object BtnApply: TButton
    Left = 198
    Top = 283
    Width = 111
    Height = 34
    Caption = #1055#1056#1048#1052#1045#1053#1048#1058#1068
    TabOrder = 1
    OnClick = BtnApplyOnClick
  end
  object edTxtEditor: TEdit
    Left = 8
    Top = 239
    Width = 480
    Height = 24
    TabOrder = 2
  end
  object PopActionBar: TPopupActionBar
    Left = 296
    Top = 104
    object PM_AddDir: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1102
      OnClick = PM_AddDirClick
    end
    object PA_DeletDir: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1102
      OnClick = PA_DeletDirClick
    end
  end
end
