object FrmExt: TFrmExt
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1056#1072#1089#1096#1080#1088#1077#1085#1080#1103' '#1092#1072#1081#1083#1086#1074
  ClientHeight = 285
  ClientWidth = 422
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object sLblDescript: TsLabel
    Left = 112
    Top = 10
    Width = 164
    Height = 16
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077' ('#1085#1077' '#1086#1073#1103#1079#1072#1090#1077#1083#1100#1085#1086')'
  end
  object sLblExt: TsLabel
    Left = 8
    Top = 10
    Width = 72
    Height = 16
    Caption = #1056#1072#1089#1096#1080#1088#1077#1085#1080#1077
  end
  object LVExt: TsListView
    Left = 8
    Top = 90
    Width = 401
    Height = 147
    Checkboxes = True
    Columns = <
      item
        Caption = #1052#1072#1089#1082#1072' '#1088#1072#1089#1096#1080#1088#1077#1085#1080#1103
        MaxWidth = 250
        MinWidth = 50
        Width = 150
      end
      item
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077' ('#1085#1077' '#1086#1073#1103#1079#1072#1090#1077#1083#1100#1085#1086')'
        MaxWidth = 300
        MinWidth = 50
        Width = 240
      end>
    Items.ItemData = {
      05980000000200000000000000FFFFFFFFFFFFFFFF01000000FFFFFFFF000000
      00052A002E007400780074000F220435043A04410442043E0432044B04350420
      004404300439043B044B0440DC1F2500000000FFFFFFFFFFFFFFFF01000000FF
      FFFFFF00000000062A002E0063007400780074001128043804440440043E0432
      0430043D043D044B04350420004404300439043B044B04D0DB1F25FFFFFFFF}
    ReadOnly = True
    RowSelect = True
    PopupMenu = PopupMenu
    TabOrder = 0
    ViewStyle = vsReport
  end
  object sBtnOk: TsButton
    Left = 160
    Top = 243
    Width = 105
    Height = 34
    Caption = 'OK'
    TabOrder = 1
    OnClick = BtnOKClick
  end
  object sBtnAdd: TsButton
    Left = 323
    Top = 32
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 2
    OnClick = BtnAddClick
  end
  object sEdDescript: TsEdit
    Left = 112
    Top = 32
    Width = 205
    Height = 24
    TabOrder = 3
  end
  object sEdExt: TsEdit
    Left = 8
    Top = 32
    Width = 89
    Height = 24
    TabOrder = 4
  end
  object sChBoxAllFiles: TsCheckBox
    Left = 8
    Top = 64
    Width = 108
    Height = 20
    Caption = '*.* '#1042#1089#1077' '#1092#1072#1081#1083#1099
    Checked = True
    State = cbChecked
    TabOrder = 5
    ImgChecked = 0
    ImgUnchecked = 0
  end
  object sSkinProvider: TsSkinProvider
    SkinData.SkinSection = 'FORM'
    TitleButtons = <>
    Left = 324
    Top = 152
  end
  object PopupMenu: TPopupMenu
    Left = 240
    Top = 168
    object PM_Delete: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1088#1086#1082#1091
      OnClick = PM_DeleteClick
    end
  end
end
