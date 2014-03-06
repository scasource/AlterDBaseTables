object ImportDataDialog: TImportDataDialog
  Left = 638
  Top = 97
  Width = 271
  Height = 535
  Caption = 'Import Data'
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
  object ChooseFieldLabel: TLabel
    Left = 26
    Top = 5
    Width = 83
    Height = 13
    Caption = 'Choose Table:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 31
    Top = 401
    Width = 63
    Height = 13
    Caption = 'Key Fields:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object TableListBox: TListBox
    Left = 26
    Top = 20
    Width = 205
    Height = 238
    IntegralHeight = True
    ItemHeight = 13
    MultiSelect = True
    Sorted = True
    TabOrder = 0
  end
  object OKButton: TBitBtn
    Left = 26
    Top = 448
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
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
    Left = 156
    Top = 448
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
  object ClearTableBeforeImportCheckBox: TCheckBox
    Left = 26
    Top = 265
    Width = 166
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Clear Table Before Import'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 480
    Width = 255
    Height = 17
    Align = alBottom
    Min = 0
    Max = 100
    Smooth = True
    TabOrder = 4
  end
  object ImportMemosFromFilesCheckBox: TCheckBox
    Left = 26
    Top = 288
    Width = 166
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Import Memos from files'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object BreakOnErrorsCheckBox: TCheckBox
    Left = 26
    Top = 310
    Width = 166
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Break on Errors'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object cb_UpdateData: TCheckBox
    Left = 26
    Top = 333
    Width = 166
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Update Data'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = cb_UpdateDataClick
  end
  object ed_KeyFields: TEdit
    Left = 29
    Top = 417
    Width = 213
    Height = 21
    Enabled = False
    TabOrder = 8
  end
  object cb_UpdateDataSequentially: TCheckBox
    Left = 26
    Top = 355
    Width = 166
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Update Data Sequentially'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = cb_UpdateDataClick
  end
  object cb_YYYYMMDDFormat: TCheckBox
    Left = 26
    Top = 378
    Width = 166
    Height = 17
    Alignment = taLeftJustify
    Caption = 'YYYYMMDD Format'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    OnClick = cb_UpdateDataClick
  end
  object ImportFileOpenDialog: TOpenDialog
    Left = 105
    Top = 103
  end
  object Table: TTable
    TableType = ttDBase
    Left = 195
    Top = 120
  end
end
