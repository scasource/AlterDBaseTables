object SetValueFromAnotherFieldDialog: TSetValueFromAnotherFieldDialog
  Left = 176
  Top = 87
  Width = 517
  Height = 262
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
    Left = 9
    Top = 12
    Width = 78
    Height = 13
    Caption = 'Choose Field:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object RecCountLabel: TLabel
    Left = 165
    Top = 176
    Width = 108
    Height = 13
    Caption = 'Records Processed =0'
  end
  object FieldListBox: TListBox
    Left = 9
    Top = 35
    Width = 139
    Height = 180
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
  end
  object OKButton: TBitBtn
    Left = 166
    Top = 200
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
    Left = 267
    Top = 200
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
  object GroupBox1: TGroupBox
    Left = 165
    Top = 35
    Width = 328
    Height = 126
    Caption = ' New Value: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label8: TLabel
      Left = 15
      Top = 59
      Width = 95
      Height = 13
      Caption = 'Database Name:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label9: TLabel
      Left = 15
      Top = 91
      Width = 73
      Height = 13
      Caption = 'Table Name:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label1: TLabel
      Left = 15
      Top = 26
      Width = 68
      Height = 13
      Caption = 'Field Name:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DatabaseComboBox: TComboBox
      Left = 118
      Top = 55
      Width = 197
      Height = 21
      ItemHeight = 13
      Sorted = True
      TabOrder = 0
      Visible = False
    end
    object TableComboBox: TComboBox
      Left = 118
      Top = 87
      Width = 197
      Height = 21
      ItemHeight = 13
      Sorted = True
      TabOrder = 1
      Visible = False
    end
    object FieldComboBox: TComboBox
      Left = 118
      Top = 22
      Width = 197
      Height = 21
      ItemHeight = 13
      Sorted = True
      TabOrder = 2
    end
  end
end
