object CopyTableDataDialog: TCopyTableDataDialog
  Left = 176
  Top = 87
  Width = 374
  Height = 275
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
  object RecCountLabel: TLabel
    Left = 129
    Top = 185
    Width = 108
    Height = 13
    Caption = 'Records Processed =0'
  end
  object OKButton: TBitBtn
    Left = 90
    Top = 207
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
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
    Left = 187
    Top = 207
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkCancel
  end
  object GroupBox1: TGroupBox
    Left = 19
    Top = 5
    Width = 328
    Height = 83
    Caption = ' Source Table: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object Label8: TLabel
      Left = 11
      Top = 25
      Width = 95
      Height = 13
      Caption = 'Database Name:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 11
      Top = 57
      Width = 73
      Height = 13
      Caption = 'Table Name:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object SourceDatabaseComboBox: TComboBox
      Left = 114
      Top = 21
      Width = 197
      Height = 21
      ItemHeight = 13
      Sorted = True
      TabOrder = 0
      OnChange = DatabaseComboBoxChange
    end
    object SourceTableComboBox: TComboBox
      Left = 114
      Top = 53
      Width = 197
      Height = 21
      ItemHeight = 13
      Sorted = True
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 19
    Top = 96
    Width = 328
    Height = 83
    Caption = ' Destination Table: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label1: TLabel
      Left = 11
      Top = 25
      Width = 95
      Height = 13
      Caption = 'Database Name:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 11
      Top = 57
      Width = 73
      Height = 13
      Caption = 'Table Name:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DestinationDatabaseComboBox: TComboBox
      Left = 114
      Top = 21
      Width = 197
      Height = 21
      ItemHeight = 13
      Sorted = True
      TabOrder = 0
      OnChange = DatabaseComboBoxChange
    end
    object DestinationTableComboBox: TComboBox
      Left = 114
      Top = 53
      Width = 197
      Height = 21
      ItemHeight = 13
      Sorted = True
      TabOrder = 1
    end
  end
end
