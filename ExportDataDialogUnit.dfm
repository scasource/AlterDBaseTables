object ExportDataDialog: TExportDataDialog
  Left = 276
  Top = 112
  Width = 529
  Height = 376
  Caption = 'Export Data'
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
    Top = 12
    Width = 92
    Height = 13
    Caption = 'Choose Field(s):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ConditionalMemoLabel: TLabel
    Left = 204
    Top = 12
    Width = 133
    Height = 13
    Caption = 'Export Records Where:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object FieldListBox: TListBox
    Left = 26
    Top = 35
    Width = 153
    Height = 264
    IntegralHeight = True
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 0
  end
  object ConditionalCommandMemo: TMemo
    Left = 204
    Top = 36
    Width = 298
    Height = 141
    TabOrder = 1
  end
  object OKButton: TBitBtn
    Left = 241
    Top = 293
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
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
    Left = 368
    Top = 293
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
  object FirstLineIsHeadersCheckBox: TCheckBox
    Left = 204
    Top = 224
    Width = 162
    Height = 17
    Alignment = taLeftJustify
    Caption = 'First Line Is Field Names'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    State = cbChecked
    TabOrder = 4
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 321
    Width = 513
    Height = 17
    Align = alBottom
    Min = 0
    Max = 100
    TabOrder = 5
  end
  object ExtractToExcelCheckBox: TCheckBox
    Left = 204
    Top = 202
    Width = 162
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Extract to Excel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object ExportMemosAsFilesCheckBox: TCheckBox
    Left = 204
    Top = 180
    Width = 162
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Export Memos as Files'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object cb_ExtractMailingAddress: TCheckBox
    Left = 204
    Top = 245
    Width = 162
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Extract Mailing Address'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
  end
  object cbCombineYears: TCheckBox
    Left = 204
    Top = 267
    Width = 162
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Combine Years'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
  end
  object SaveDialog: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofExtensionDifferent, ofPathMustExist, ofEnableSizing]
    Left = 174
    Top = 118
  end
end
