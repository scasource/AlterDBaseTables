object ReplaceInFieldDialog: TReplaceInFieldDialog
  Left = 333
  Top = 141
  Width = 516
  Height = 408
  Caption = 'Replace text in field'
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
  object ConditionalMemoLabel: TLabel
    Left = 164
    Top = 12
    Width = 33
    Height = 13
    Caption = 'Filter:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NewValueLabel: TLabel
    Left = 164
    Top = 227
    Width = 79
    Height = 13
    Caption = 'Replace with:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 164
    Top = 155
    Width = 70
    Height = 13
    Caption = 'Text to find:'
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
    Width = 121
    Height = 307
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
    OnClick = FieldListBoxClick
  end
  object ConditionalCommandMemo: TMemo
    Left = 164
    Top = 36
    Width = 328
    Height = 112
    TabOrder = 1
  end
  object OKButton: TBitBtn
    Left = 164
    Top = 317
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
    Left = 417
    Top = 317
    Width = 75
    Height = 25
    TabOrder = 5
    Kind = bkCancel
  end
  object TextToFindEdit: TEdit
    Left = 164
    Top = 175
    Width = 329
    Height = 21
    TabOrder = 2
  end
  object ReplaceWithEdit: TEdit
    Left = 164
    Top = 246
    Width = 329
    Height = 21
    TabOrder = 3
  end
  object ProgressBar: TProgressBar
    Left = 0
    Top = 353
    Width = 500
    Height = 17
    Align = alBottom
    Min = 0
    Max = 100
    TabOrder = 6
  end
  object cbExactMatchOnly: TCheckBox
    Left = 164
    Top = 292
    Width = 132
    Height = 17
    Alignment = taLeftJustify
    Caption = 'Exact Match Only'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
end
