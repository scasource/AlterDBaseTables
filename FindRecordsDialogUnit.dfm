object FindRecordsDialog: TFindRecordsDialog
  Left = 14
  Top = 117
  Width = 551
  Height = 352
  ActiveControl = StartRangeEdit1
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
  object FindRecordMethodRadioGroup: TRadioGroup
    Left = 18
    Top = 249
    Width = 146
    Height = 67
    Caption = ' Find Record Method: '
    ItemIndex = 1
    Items.Strings = (
      ' Nearest'
      ' Exact Match')
    TabOrder = 2
  end
  object OKButton: TBitBtn
    Left = 353
    Top = 291
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 3
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
    Left = 449
    Top = 291
    Width = 75
    Height = 25
    TabOrder = 4
    Kind = bkCancel
  end
  object StartRangeGroupBox: TGroupBox
    Left = 18
    Top = 10
    Width = 506
    Height = 108
    Caption = ' Start Range: '
    TabOrder = 0
    object StartRangeLabel1: TLabel
      Left = 15
      Top = 19
      Width = 86
      Height = 13
      Caption = 'StartRangeLabel1'
    end
    object StartRangeLabel2: TLabel
      Left = 177
      Top = 19
      Width = 86
      Height = 13
      Caption = 'StartRangeLabel2'
    end
    object StartRangeLabel3: TLabel
      Left = 339
      Top = 19
      Width = 86
      Height = 13
      Caption = 'StartRangeLabel3'
    end
    object StartRangeLabel4: TLabel
      Left = 15
      Top = 64
      Width = 86
      Height = 13
      Caption = 'StartRangeLabel4'
    end
    object StartRangeLabel5: TLabel
      Left = 177
      Top = 64
      Width = 86
      Height = 13
      Caption = 'StartRangeLabel5'
    end
    object StartRangeLabel6: TLabel
      Left = 339
      Top = 64
      Width = 86
      Height = 13
      Caption = 'StartRangeLabel6'
    end
    object StartRangeEdit1: TEdit
      Left = 15
      Top = 37
      Width = 145
      Height = 21
      TabOrder = 0
    end
    object StartRangeEdit2: TEdit
      Left = 177
      Top = 37
      Width = 145
      Height = 21
      TabOrder = 1
    end
    object StartRangeEdit3: TEdit
      Left = 339
      Top = 37
      Width = 145
      Height = 21
      TabOrder = 2
    end
    object StartRangeEdit4: TEdit
      Left = 15
      Top = 82
      Width = 145
      Height = 21
      TabOrder = 3
    end
    object StartRangeEdit5: TEdit
      Left = 177
      Top = 82
      Width = 145
      Height = 21
      TabOrder = 4
    end
    object StartRangeEdit6: TEdit
      Left = 339
      Top = 82
      Width = 145
      Height = 21
      TabOrder = 5
    end
  end
  object EndRangeGroupBox: TGroupBox
    Left = 18
    Top = 129
    Width = 506
    Height = 108
    Caption = ' End Range: '
    TabOrder = 1
    Visible = False
    object EndRangeLabel1: TLabel
      Left = 15
      Top = 19
      Width = 83
      Height = 13
      Caption = 'EndRangeLabel1'
    end
    object EndRangeLabel2: TLabel
      Left = 177
      Top = 19
      Width = 83
      Height = 13
      Caption = 'EndRangeLabel2'
    end
    object EndRangeLabel3: TLabel
      Left = 339
      Top = 19
      Width = 83
      Height = 13
      Caption = 'EndRangeLabel3'
    end
    object EndRangeLabel4: TLabel
      Left = 15
      Top = 64
      Width = 83
      Height = 13
      Caption = 'EndRangeLabel4'
    end
    object EndRangeLabel5: TLabel
      Left = 177
      Top = 64
      Width = 83
      Height = 13
      Caption = 'EndRangeLabel5'
    end
    object EndRangeLabel6: TLabel
      Left = 339
      Top = 64
      Width = 83
      Height = 13
      Caption = 'EndRangeLabel6'
    end
    object EndRangeEdit1: TEdit
      Left = 15
      Top = 37
      Width = 145
      Height = 21
      TabOrder = 0
    end
    object EndRangeEdit2: TEdit
      Left = 177
      Top = 37
      Width = 145
      Height = 21
      TabOrder = 1
    end
    object EndRangeEdit3: TEdit
      Left = 339
      Top = 37
      Width = 145
      Height = 21
      TabOrder = 2
    end
    object EndRangeEdit4: TEdit
      Left = 15
      Top = 82
      Width = 145
      Height = 21
      TabOrder = 3
    end
    object EndRangeEdit5: TEdit
      Left = 177
      Top = 82
      Width = 145
      Height = 21
      TabOrder = 4
    end
    object EndRangeEdit6: TEdit
      Left = 339
      Top = 82
      Width = 145
      Height = 21
      TabOrder = 5
    end
  end
end
