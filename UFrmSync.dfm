object FrmSync: TFrmSync
  Left = 0
  Top = 0
  Caption = #1057#1080#1085#1093#1088#1086#1085#1080#1079#1072#1094#1080#1103' '#1092#1072#1081#1083#1086#1074
  ClientHeight = 647
  ClientWidth = 1157
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 16
  object LVRep: TListView
    Left = 0
    Top = 233
    Width = 1157
    Height = 395
    Align = alClient
    Checkboxes = True
    Color = clCream
    Columns = <
      item
        AutoSize = True
        Caption = #1060#1072#1081#1083#1099' '#1074' '#1086#1089#1085#1086#1074#1085#1086#1081' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1080
        MaxWidth = 600
        MinWidth = 100
      end
      item
        AutoSize = True
        Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1081' '#1079#1072#1087#1080#1089#1080
        MaxWidth = 200
        MinWidth = 50
      end
      item
        Alignment = taCenter
        AutoSize = True
        Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077
        MaxWidth = 100
        MinWidth = 30
      end
      item
        AutoSize = True
        Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1081' '#1079#1072#1087#1080#1089#1080' '
        MaxWidth = 200
        MinWidth = 50
      end
      item
        AutoSize = True
        Caption = #1060#1072#1081#1083#1099' '#1074' '#1088#1077#1079#1077#1088#1074#1085#1086#1081' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1080
        MaxWidth = 600
        MinWidth = 100
      end
      item
        AutoSize = True
        Caption = #1057#1090#1072#1090#1091#1089
        MaxWidth = 200
        MinWidth = 30
      end
      item
        MaxWidth = 1
        Width = 1
      end>
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    SmallImages = ImageList
    TabOrder = 0
    ViewStyle = vsReport
    OnCustomDrawItem = LVRepCustomDrawItem
    ExplicitTop = 225
    ExplicitHeight = 403
  end
  object mm: TMemo
    Left = 372
    Top = 520
    Width = 769
    Height = 89
    Lines.Strings = (
      'mm')
    TabOrder = 1
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 628
    Width = 1157
    Height = 19
    Panels = <>
  end
  object PnlBar: TPanel
    Left = 0
    Top = 0
    Width = 1157
    Height = 233
    Align = alTop
    Caption = 'PnlBar'
    TabOrder = 3
    ExplicitTop = -6
    object lblExt: TLabel
      Left = 12
      Top = 13
      Width = 112
      Height = 16
      Caption = #1052#1072#1089#1082#1072' '#1088#1072#1089#1096#1080#1088#1077#1085#1080#1103
    end
    object LVDirMaster: TListView
      Left = 7
      Top = 65
      Width = 454
      Height = 150
      Columns = <
        item
          AutoSize = True
          Caption = #1054#1089#1085#1086#1074#1085#1072#1103' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1103
          MaxWidth = 800
          MinWidth = 100
        end>
      PopupMenu = PopMenu
      TabOrder = 0
      ViewStyle = vsReport
      OnMouseDown = LVMouseDown
    end
    object LVDirBackUp: TListView
      Left = 631
      Top = 65
      Width = 449
      Height = 154
      Columns = <
        item
          AutoSize = True
          Caption = #1044#1080#1088#1077#1082#1090#1086#1088#1080#1080' '#1076#1083#1103' '#1088#1077#1079#1077#1088#1074#1085#1099#1093' '#1082#1086#1087#1080#1081
        end>
      PopupMenu = PopMenu
      TabOrder = 1
      ViewStyle = vsReport
      OnMouseDown = LVMouseDown
    end
    object ProgressBar: TProgressBar
      Left = 467
      Top = 185
      Width = 158
      Height = 23
      Align = alCustom
      DoubleBuffered = False
      ParentDoubleBuffered = False
      MarqueeInterval = 50
      Step = 1
      TabOrder = 2
    end
    object BtnSync: TButton
      Left = 467
      Top = 149
      Width = 158
      Height = 30
      Caption = #1057#1048#1053#1061#1056#1054#1053#1048#1047#1048#1056#1054#1042#1040#1058#1068
      TabOrder = 3
      OnClick = BtnSyncClick
    end
    object BtnScan: TButton
      Left = 467
      Top = 114
      Width = 158
      Height = 29
      Caption = #1057#1050#1040#1053#1048#1056#1054#1042#1040#1058#1068
      TabOrder = 4
      OnClick = BtnScanClick
    end
    object ChBoxSyncRevers: TCheckBox
      Left = 479
      Top = 91
      Width = 140
      Height = 17
      Caption = '<< '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
    end
    object ChBoxSyncDirect: TCheckBox
      Left = 479
      Top = 68
      Width = 146
      Height = 17
      Caption = '>> '#1085#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
    end
    object BtnMaskEdit: TButton
      Left = 343
      Top = 34
      Width = 81
      Height = 25
      Caption = #1053#1072#1089#1090#1088#1086#1080#1090#1100
      TabOrder = 7
      OnClick = BtnMaskEditClick
    end
    object edExt: TEdit
      Left = 12
      Top = 35
      Width = 325
      Height = 24
      TabOrder = 8
      Text = '*.*'
    end
  end
  object ImageList: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Left = 932
    Top = 8
  end
  object PopMenu: TPopupMenu
    Left = 856
    Top = 284
    object PM_AddDirFromParam: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1102' '#1080#1079' '#1085#1072#1089#1090#1088#1086#1077#1082
      OnClick = PM_AddDirFromParamClick
    end
    object PM_AddDir: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1091#1102' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1102
      OnClick = PM_AddDirClick
    end
    object PM_Spliter: TMenuItem
      Caption = '-'
    end
    object PM_VLClear: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
      OnClick = PM_VLClearClick
    end
    object PM_DeleteItem: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1080#1088#1077#1082#1090#1086#1088#1080#1102' '#1080#1079' '#1089#1087#1080#1089#1082#1072
      OnClick = PM_DeleteItemClick
    end
  end
  object PopMenuLVRep: TPopupMenu
    Left = 776
    Top = 284
    object PM_LVRepSetCheck: TMenuItem
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1075#1072#1083#1086#1095#1082#1080' '#1075#1076#1077' '#1074#1099#1076#1077#1083#1077#1085#1085#1086
      OnClick = PM_LVRepSetCheckClick
    end
    object PM_LVRepCheckDown: TMenuItem
      Caption = #1057#1073#1088#1086#1089#1080#1090#1100' '#1075#1072#1083#1086#1095#1082#1080' '#1075#1076#1077' '#1074#1099#1076#1077#1083#1077#1085#1086
      OnClick = PM_LVRepCheckDownClick
    end
  end
end
