object FrmExt: TFrmExt
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #1056#1072#1089#1096#1080#1088#1077#1085#1080#1103' '#1092#1072#1081#1083#1086#1074
  ClientHeight = 279
  ClientWidth = 422
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LblExt: TLabel
    Left = 8
    Top = 13
    Width = 65
    Height = 13
    Caption = #1056#1072#1089#1096#1080#1088#1077#1085#1080#1077':'
  end
  object LblDescript: TLabel
    Left = 112
    Top = 13
    Width = 144
    Height = 13
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077' ('#1085#1077' '#1086#1073#1103#1079#1072#1090#1077#1083#1100#1085#1086'):'
  end
  object BtnOk: TButton
    Left = 154
    Top = 243
    Width = 98
    Height = 30
    Caption = 'OK'
    TabOrder = 0
    OnClick = BtnOKClick
  end
  object BtnAdd: TButton
    Left = 323
    Top = 30
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 1
    OnClick = BtnAddClick
  end
  object ChBoxAllFiles: TCheckBox
    Left = 8
    Top = 59
    Width = 97
    Height = 17
    Caption = '*.* '#1042#1089#1077' '#1092#1072#1081#1083#1099
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object edExt: TEdit
    Left = 8
    Top = 32
    Width = 89
    Height = 21
    TabOrder = 3
  end
  object EdDescript: TEdit
    Left = 111
    Top = 32
    Width = 206
    Height = 21
    TabOrder = 4
  end
  object LVExt: TListView
    Left = 8
    Top = 82
    Width = 401
    Height = 150
    Checkboxes = True
    Columns = <
      item
        Caption = #1052#1072#1089#1082#1072' '#1088#1072#1089#1096#1080#1088#1077#1085#1080#1103
      end
      item
        Caption = #1054#1087#1080#1089#1072#1085#1080#1077' ('#1085#1077' '#1086#1073#1103#1079#1072#1090#1077#1083#1100#1085#1086')'
      end>
    Items.ItemData = {
      05960000000200000000000000FFFFFFFFFFFFFFFF01000000FFFFFFFF000000
      00052A002E007400780074000E220435043A04410442043E0432044B04390420
      004404300439043B04088B142B00000000FFFFFFFFFFFFFFFF01000000FFFFFF
      FF00000000062A002E0063007400780074001128043804440440043E04320430
      043D043D044B04350420004404300439043B044B04A88D142BFFFFFFFF}
    PopupMenu = PopupMenu
    TabOrder = 5
    ViewStyle = vsReport
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
