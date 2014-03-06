object ResultsDisplayForm: TResultsDisplayForm
  Left = 45
  Top = 67
  Width = 553
  Height = 424
  Caption = 'Results'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 21
    Top = 12
    Width = 105
    Height = 13
    Caption = 'Changed \ Added:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 21
    Top = 180
    Width = 79
    Height = 13
    Caption = 'Not Changed:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SuccessfulListBox: TListBox
    Left = 21
    Top = 31
    Width = 495
    Height = 132
    ItemHeight = 13
    TabOrder = 0
  end
  object OKButton: TBitBtn
    Left = 231
    Top = 358
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object UnsuccessfulListBox: TListBox
    Left = 21
    Top = 203
    Width = 495
    Height = 132
    ItemHeight = 13
    TabOrder = 2
  end
end
