object ReplaceFieldInTablesDialog: TReplaceFieldInTablesDialog
  Left = 396
  Top = 130
  Width = 479
  Height = 557
  Caption = 'Replace field value for tables'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object NewValueLabel: TLabel
    Left = 182
    Top = 67
    Width = 46
    Height = 26
    Caption = 'Current Value:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label1: TLabel
    Left = 182
    Top = 23
    Width = 32
    Height = 13
    Caption = 'Field:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ChooseFieldLabel: TLabel
    Left = 17
    Top = 6
    Width = 97
    Height = 13
    Caption = 'Choose Table(s):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbTableName: TLabel
    Left = 18
    Top = 463
    Width = 48
    Height = 13
    Caption = 'Table = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 182
    Top = 118
    Width = 37
    Height = 26
    Caption = 'New Value:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object lbNumberChanged: TLabel
    Left = 18
    Top = 484
    Width = 78
    Height = 13
    Caption = '# Changed = '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object OKButton: TBitBtn
    Left = 217
    Top = 456
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 4
    OnClick = OKButtonClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object CancelButton: TBitBtn
    Left = 314
    Top = 456
    Width = 75
    Height = 25
    TabOrder = 5
    Kind = bkCancel
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 502
    Width = 463
    Height = 17
    Align = alBottom
    Min = 0
    Max = 100
    Smooth = True
    Step = 1
    TabOrder = 6
  end
  object lbxTables: TListBox
    Left = 17
    Top = 22
    Width = 158
    Height = 433
    IntegralHeight = True
    ItemHeight = 13
    MultiSelect = True
    Sorted = True
    TabOrder = 0
  end
  object edCurrentValue: TEdit
    Left = 231
    Top = 70
    Width = 209
    Height = 21
    TabOrder = 2
  end
  object edFieldName: TEdit
    Left = 231
    Top = 19
    Width = 209
    Height = 21
    TabOrder = 1
  end
  object edNewValue: TEdit
    Left = 231
    Top = 122
    Width = 209
    Height = 21
    TabOrder = 3
  end
  object cbAllowPartialMatch: TCheckBox
    Left = 180
    Top = 160
    Width = 261
    Height = 17
    Alignment = taLeftJustify
    BiDiMode = bdLeftToRight
    Caption = 'Include partial matches'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 7
  end
  object tbTemp: TTable
    TableType = ttDBase
    Left = 268
    Top = 188
  end
end
