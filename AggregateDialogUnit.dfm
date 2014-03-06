object AggregateDialog: TAggregateDialog
  Left = 695
  Top = 137
  Width = 521
  Height = 324
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
    Width = 128
    Height = 13
    Caption = 'ConditionalMemoLabel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NewValueLabel: TLabel
    Left = 164
    Top = 182
    Width = 66
    Height = 13
    Caption = 'New Value:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object lbRoundToNearest: TLabel
    Left = 403
    Top = 183
    Width = 65
    Height = 13
    Caption = 'Round To: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object FieldListBox: TListBox
    Left = 26
    Top = 35
    Width = 121
    Height = 192
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
    OnClick = FieldListBoxClick
  end
  object ConditionalCommandMemo: TMemo
    Left = 164
    Top = 36
    Width = 328
    Height = 125
    TabOrder = 1
  end
  object OKButton: TBitBtn
    Left = 156
    Top = 258
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
    Left = 283
    Top = 258
    Width = 75
    Height = 25
    TabOrder = 5
    Kind = bkCancel
  end
  object NewValueEdit: TEdit
    Left = 164
    Top = 206
    Width = 227
    Height = 21
    TabOrder = 2
    Visible = False
  end
  object edRoundToNearest: TEdit
    Left = 403
    Top = 206
    Width = 87
    Height = 21
    TabOrder = 3
    Visible = False
  end
end
