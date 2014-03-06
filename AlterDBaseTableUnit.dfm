object AlterDBaseTableForm: TAlterDBaseTableForm
  Left = 126
  Top = 96
  Width = 800
  Height = 600
  Caption = 'Alter DBase Tables'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = TableFunctionsPopupMenu
  Position = poOwnerFormCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 512
    Top = 420
    Width = 32
    Height = 13
    Caption = 'Label5'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 792
    Height = 572
    Align = alClient
    TabOrder = 0
    object PageControl: TPageControl
      Left = 1
      Top = 1
      Width = 790
      Height = 570
      ActivePage = ViewEditTablesPage
      Align = alClient
      TabOrder = 0
      object AlterTablesPage: TTabSheet
        Caption = 'Alter Tables'
        object Panel14: TPanel
          Left = 0
          Top = 488
          Width = 774
          Height = 44
          Align = alBottom
          TabOrder = 0
          object ExecuteButton: TBitBtn
            Left = 193
            Top = 7
            Width = 89
            Height = 33
            Caption = '&Execute'
            TabOrder = 0
            OnClick = ExecuteButtonClick
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
              333333333337FF3333333333330003333333333333777F333333333333080333
              3333333F33777FF33F3333B33B000B33B3333373F777773F7333333BBB0B0BBB
              33333337737F7F77F333333BBB0F0BBB33333337337373F73F3333BBB0F7F0BB
              B333337F3737F73F7F3333BB0FB7BF0BB3333F737F37F37F73FFBBBB0BF7FB0B
              BBB3773F7F37337F377333BB0FBFBF0BB333337F73F333737F3333BBB0FBF0BB
              B3333373F73FF7337333333BBB000BBB33333337FF777337F333333BBBBBBBBB
              3333333773FF3F773F3333B33BBBBB33B33333733773773373333333333B3333
              333333333337F33333333333333B333333333333333733333333}
            NumGlyphs = 2
          end
          object LoadButton: TBitBtn
            Left = 297
            Top = 7
            Width = 89
            Height = 33
            Caption = '&Load'
            TabOrder = 1
            OnClick = LoadButtonClick
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              5555555555555555555555555555555555555555555555555555555555555555
              555555555555555555555555555555555555555FFFFFFFFFF555550000000000
              55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
              B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
              000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
              555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
              55555575FFF75555555555700007555555555557777555555555555555555555
              5555555555555555555555555555555555555555555555555555}
            NumGlyphs = 2
          end
          object SaveButton: TBitBtn
            Left = 401
            Top = 7
            Width = 89
            Height = 33
            Caption = '&Save'
            TabOrder = 2
            OnClick = SaveButtonClick
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
              7700333333337777777733333333008088003333333377F73377333333330088
              88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
              000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
              FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
              99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
              99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
              99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
              93337FFFF7737777733300000033333333337777773333333333}
            NumGlyphs = 2
          end
          object PrintButton: TBitBtn
            Left = 505
            Top = 7
            Width = 89
            Height = 33
            Caption = '&Print'
            TabOrder = 3
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
              0003377777777777777308888888888888807F33333333333337088888888888
              88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
              8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
              8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
              03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
              03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
              33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
              33333337FFFF7733333333300000033333333337777773333333}
            NumGlyphs = 2
          end
        end
        object Panel15: TPanel
          Left = 0
          Top = 0
          Width = 774
          Height = 488
          Align = alClient
          TabOrder = 1
          object GroupBox1: TGroupBox
            Left = 1
            Top = 1
            Width = 772
            Height = 486
            Align = alClient
            Caption = ' Perform the following actions: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Panel16: TPanel
              Left = 2
              Top = 443
              Width = 768
              Height = 41
              Align = alBottom
              TabOrder = 0
              object ProgressLabel: TLabel
                Left = 9
                Top = 14
                Width = 91
                Height = 16
                Caption = 'ProgressLabel'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = -13
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                Visible = False
              end
              object MoveUpButton: TBitBtn
                Left = 230
                Top = 7
                Width = 111
                Height = 31
                Caption = 'Move Up'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -13
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
                OnClick = MoveUpButtonClick
                Glyph.Data = {
                  76010000424D7601000000000000760000002800000020000000100000000100
                  04000000000000010000120B0000120B00001000000000000000000000000000
                  800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
                  3333333333777F33333333333309033333333333337F7F333333333333090333
                  33333333337F7F33333333333309033333333333337F7F333333333333090333
                  33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
                  3333333777737777F333333099999990333333373F3333373333333309999903
                  333333337F33337F33333333099999033333333373F333733333333330999033
                  3333333337F337F3333333333099903333333333373F37333333333333090333
                  33333333337F7F33333333333309033333333333337373333333333333303333
                  333333333337F333333333333330333333333333333733333333}
                NumGlyphs = 2
              end
              object MoveDownButton: TBitBtn
                Left = 351
                Top = 7
                Width = 111
                Height = 31
                Caption = 'Move Down'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -13
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
                OnClick = MoveDownButtonClick
                Glyph.Data = {
                  76010000424D7601000000000000760000002800000020000000100000000100
                  04000000000000010000120B0000120B00001000000000000000000000000000
                  800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
                  333333333337F33333333333333033333333333333373F333333333333090333
                  33333333337F7F33333333333309033333333333337373F33333333330999033
                  3333333337F337F33333333330999033333333333733373F3333333309999903
                  333333337F33337F33333333099999033333333373333373F333333099999990
                  33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
                  33333333337F7F33333333333309033333333333337F7F333333333333090333
                  33333333337F7F33333333333309033333333333337F7F333333333333090333
                  33333333337F7F33333333333300033333333333337773333333}
                NumGlyphs = 2
              end
            end
            object Panel17: TPanel
              Left = 2
              Top = 18
              Width = 120
              Height = 425
              Align = alLeft
              TabOrder = 1
              object AddActionButton: TButton
                Left = 9
                Top = 90
                Width = 106
                Height = 29
                Caption = '&Add Action'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
                OnClick = AddActionButtonClick
              end
              object DeleteActionButton: TButton
                Left = 9
                Top = 159
                Width = 106
                Height = 29
                Caption = '&Delete Action'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
                OnClick = DeleteActionButtonClick
              end
              object ClearActionsButton: TButton
                Left = 9
                Top = 193
                Width = 106
                Height = 29
                Caption = '&Clear Actions'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 2
                OnClick = ClearActionsButtonClick
              end
              object ChangeActionButton: TButton
                Left = 9
                Top = 124
                Width = 106
                Height = 29
                Caption = '&Change Action'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -12
                Font.Name = 'Arial'
                Font.Style = []
                ParentFont = False
                TabOrder = 3
                OnClick = ChangeActionButtonClick
              end
            end
            object Panel18: TPanel
              Left = 122
              Top = 18
              Width = 648
              Height = 425
              Align = alClient
              TabOrder = 2
              object ActionGrid: TStringGrid
                Left = 1
                Top = 1
                Width = 646
                Height = 423
                Align = alClient
                ColCount = 4
                DefaultColWidth = 106
                DefaultRowHeight = 20
                FixedCols = 0
                RowCount = 40
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlue
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
                ParentFont = False
                ScrollBars = ssVertical
                TabOrder = 0
                OnDblClick = ActionGridDblClick
                ColWidths = (
                  151
                  158
                  157
                  158)
              end
            end
          end
        end
      end
      object ViewEditTablesPage: TTabSheet
        Caption = 'View\Edit Tables'
        ImageIndex = 1
        object RecCountLabel: TLabel
          Left = 14
          Top = 399
          Width = 74
          Height = 13
          Caption = 'RecCountLabel'
          Visible = False
        end
        object Panel2: TPanel
          Left = 0
          Top = 506
          Width = 782
          Height = 36
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 0
          object RecordCountLabel: TLabel
            Left = 500
            Top = 15
            Width = 70
            Height = 13
            Caption = 'Records = 0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Navigator: TwwDBNavigator
            Left = 212
            Top = 9
            Width = 350
            Height = 25
            DataSource = DataSource
            RepeatInterval.InitialDelay = 500
            RepeatInterval.Interval = 100
            Anchors = [akBottom]
            object NavigatorFirst: TwwNavButton
              Left = 0
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Move to first record'
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'NavigatorFirst'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 0
              Style = nbsFirst
            end
            object NavigatorPriorPage: TwwNavButton
              Left = 25
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Move backward 10 records'
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'NavigatorPriorPage'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 1
              Style = nbsPriorPage
            end
            object NavigatorPrior: TwwNavButton
              Left = 50
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Move to prior record'
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'NavigatorPrior'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 2
              Style = nbsPrior
            end
            object NavigatorNext: TwwNavButton
              Left = 75
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Move to next record'
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'NavigatorNext'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 3
              Style = nbsNext
            end
            object NavigatorNextPage: TwwNavButton
              Left = 100
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Move forward 10 records'
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'NavigatorNextPage'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 4
              Style = nbsNextPage
            end
            object NavigatorLast: TwwNavButton
              Left = 125
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Move to last record'
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'NavigatorLast'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 5
              Style = nbsLast
            end
            object NavigatorInsert: TwwNavButton
              Left = 150
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Insert new record'
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'NavigatorInsert'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 6
              Style = nbsInsert
            end
            object NavigatorDelete: TwwNavButton
              Left = 175
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Delete current record'
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'NavigatorDelete'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 7
              Style = nbsDelete
            end
            object NavigatorEdit: TwwNavButton
              Left = 200
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Edit current record'
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'NavigatorEdit'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 8
              Style = nbsEdit
            end
            object NavigatorPost: TwwNavButton
              Left = 225
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Post changes of current record'
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'NavigatorPost'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 9
              Style = nbsPost
            end
            object NavigatorCancel: TwwNavButton
              Left = 250
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Cancel changes made to current record'
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'NavigatorCancel'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 10
              Style = nbsCancel
            end
            object NavigatorRefresh: TwwNavButton
              Left = 275
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Refresh the contents of the dataset'
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'NavigatorRefresh'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 11
              Style = nbsRefresh
            end
            object NavigatorSaveBookmark: TwwNavButton
              Left = 300
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Bookmark current record'
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'NavigatorSaveBookmark'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 12
              Style = nbsSaveBookmark
            end
            object NavigatorRestoreBookmark: TwwNavButton
              Left = 325
              Top = 0
              Width = 25
              Height = 25
              Hint = 'Go back to saved bookmark'
              ImageIndex = -1
              NumGlyphs = 2
              Spacing = 4
              Transparent = False
              Caption = 'NavigatorRestoreBookmark'
              Enabled = False
              DisabledTextColors.ShadeColor = clGray
              DisabledTextColors.HighlightColor = clBtnHighlight
              Index = 13
              Style = nbsRestoreBookmark
            end
          end
          object CloseTableButton: TBitBtn
            Left = 3
            Top = 9
            Width = 75
            Height = 25
            Caption = 'Close Table'
            TabOrder = 1
            OnClick = CloseTableButtonClick
          end
        end
        object Panel3: TPanel
          Left = 0
          Top = 82
          Width = 782
          Height = 424
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object DBGrid: TwwDBGrid
            Left = 0
            Top = 0
            Width = 782
            Height = 424
            MemoAttributes = [mSizeable, mWordWrap, mGridShow]
            IniAttributes.Delimiter = ';;'
            TitleColor = clBtnFace
            FixedCols = 0
            ShowHorzScrollBar = True
            EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm, ecoDisableDateTimePicker]
            Align = alClient
            DataSource = DataSource
            KeyOptions = [dgEnterToTab, dgAllowDelete, dgAllowInsert]
            Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgMultiSelect]
            TabOrder = 0
            TitleAlignment = taLeftJustify
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            TitleLines = 1
            TitleButtons = False
            IndicatorColor = icBlack
          end
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 782
          Height = 82
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 2
          object Label8: TLabel
            Left = 10
            Top = 5
            Width = 80
            Height = 13
            Caption = 'Database Name:'
          end
          object Label9: TLabel
            Left = 237
            Top = 5
            Width = 61
            Height = 13
            Caption = 'Table Name:'
          end
          object Label10: TLabel
            Left = 500
            Top = 5
            Width = 60
            Height = 13
            Caption = 'Index Name:'
          end
          object Label11: TLabel
            Left = 10
            Top = 58
            Width = 72
            Height = 13
            Caption = 'Last Operation:'
          end
          object Label12: TLabel
            Left = 434
            Top = 58
            Width = 56
            Height = 13
            Caption = 'Last Result:'
          end
          object DatabaseComboBox: TComboBox
            Left = 10
            Top = 23
            Width = 208
            Height = 21
            ItemHeight = 13
            Sorted = True
            TabOrder = 0
            OnChange = DatabaseComboBoxChange
            OnClick = DatabaseComboBoxChange
          end
          object TableComboBox: TComboBox
            Left = 237
            Top = 23
            Width = 245
            Height = 21
            ItemHeight = 13
            Sorted = True
            TabOrder = 1
            OnChange = TableComboBoxChange
            OnClick = TableComboBoxChange
          end
          object IndexComboBox: TwwKeyCombo
            Left = 500
            Top = 23
            Width = 273
            Height = 21
            Style = csDropDownList
            DropDownCount = 8
            ItemHeight = 0
            Sorted = True
            TabOrder = 2
            OnChange = IndexComboBoxChange
            OnClick = IndexComboBoxChange
            ShowAllIndexes = True
            DataSource = DataSource
            PrimaryKeyName = 'PrimaryKey'
          end
          object LastOperationEdit: TEdit
            Left = 90
            Top = 54
            Width = 304
            Height = 21
            TabStop = False
            ReadOnly = True
            TabOrder = 3
          end
          object LastResultEdit: TEdit
            Left = 500
            Top = 54
            Width = 106
            Height = 21
            TabStop = False
            ReadOnly = True
            TabOrder = 4
          end
          object ShowConditionEnteredButton: TButton
            Left = 397
            Top = 54
            Width = 18
            Height = 21
            Caption = '...'
            TabOrder = 5
          end
        end
      end
    end
  end
  object ActionSelectionPanel: TPanel
    Left = 167
    Top = 121
    Width = 607
    Height = 467
    BevelInner = bvLowered
    BevelOuter = bvNone
    BorderWidth = 2
    BorderStyle = bsSingle
    TabOrder = 1
    Visible = False
    object Panel5: TPanel
      Left = 3
      Top = 203
      Width = 597
      Height = 257
      Align = alBottom
      TabOrder = 0
      object ValuesNotebook: TNotebook
        Left = 237
        Top = 4
        Width = 240
        Height = 203
        PageIndex = 2
        TabOrder = 0
        Visible = False
        object TPage
          Left = 0
          Top = 0
          Caption = 'FieldNamePage'
          object FieldNameGroupBox: TGroupBox
            Left = 0
            Top = 0
            Width = 240
            Height = 203
            Align = alClient
            Caption = ' Enter Field Name: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label1: TLabel
              Left = 9
              Top = 17
              Width = 36
              Height = 16
              Caption = 'Field:'
            end
            object AddDropFieldNameEdit: TEdit
              Left = 9
              Top = 35
              Width = 183
              Height = 24
              TabOrder = 0
            end
            object LookupFieldButton: TButton
              Left = 193
              Top = 35
              Width = 23
              Height = 25
              Hint = 'Browse for the field name.'
              Caption = '...'
              TabOrder = 1
              Visible = False
            end
            object FieldType_LengthRadioGroup: TRadioGroup
              Left = 9
              Top = 62
              Width = 206
              Height = 136
              Caption = ' Field Type\ Length: '
              Items.Strings = (
                ' String'
                ' Integer'
                ' Float'
                ' Boolean'
                ' AutoIncrement'
                ' Memo'
                ' Date')
              TabOrder = 2
              Visible = False
              OnClick = FieldType_LengthRadioGroupClick
            end
            object StringLengthEdit: TEdit
              Left = 97
              Top = 80
              Width = 45
              Height = 23
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              Visible = False
            end
          end
        end
        object TPage
          Left = 0
          Top = 0
          Caption = 'IndexNamePage'
          object IndexNameGroupBox: TGroupBox
            Left = 0
            Top = 0
            Width = 240
            Height = 203
            Align = alClient
            Caption = ' Enter Index Name: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label4: TLabel
              Left = 9
              Top = 20
              Width = 40
              Height = 16
              Caption = 'Index:'
            end
            object IndexExpressionLabel: TLabel
              Left = 10
              Top = 70
              Width = 113
              Height = 16
              Caption = 'Index Expression:'
              Visible = False
            end
            object IndexNameEdit: TEdit
              Left = 9
              Top = 38
              Width = 183
              Height = 24
              TabOrder = 0
            end
            object LookupIndexButton: TButton
              Left = 193
              Top = 38
              Width = 23
              Height = 25
              Hint = 'Browse for the index name.'
              Caption = '...'
              TabOrder = 1
              Visible = False
            end
            object IndexExpressionEdit: TEdit
              Left = 10
              Top = 88
              Width = 183
              Height = 24
              TabOrder = 2
              Visible = False
            end
            object CreateIndexExpressionButton: TButton
              Left = 194
              Top = 88
              Width = 23
              Height = 25
              Hint = 'Browse for the index name.'
              Caption = '...'
              TabOrder = 3
              Visible = False
            end
            object IndexAttributeGroupBox: TGroupBox
              Left = 10
              Top = 119
              Width = 207
              Height = 59
              Caption = ' Index Properties: '
              TabOrder = 4
              Visible = False
              object PrimaryIndexCheckBox: TCheckBox
                Left = 13
                Top = 17
                Width = 78
                Height = 17
                Alignment = taLeftJustify
                Caption = 'Primary'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -13
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
              end
              object UniqueIndexCheckBox: TCheckBox
                Left = 13
                Top = 35
                Width = 78
                Height = 17
                Alignment = taLeftJustify
                Caption = 'Unique'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -13
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 1
              end
              object DescendingIndexCheckBox: TCheckBox
                Left = 103
                Top = 17
                Width = 97
                Height = 17
                Alignment = taLeftJustify
                Caption = 'Descending'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -13
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 2
              end
            end
          end
        end
        object TPage
          Left = 0
          Top = 0
          Caption = 'FileNamePage'
          object EnterFileNameGroupBox: TGroupBox
            Left = 0
            Top = 0
            Width = 240
            Height = 203
            Align = alClient
            Caption = ' Enter File Name: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label7: TLabel
              Left = 9
              Top = 38
              Width = 28
              Height = 16
              Caption = 'File:'
            end
            object FileNameEdit: TEdit
              Left = 9
              Top = 61
              Width = 199
              Height = 23
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -12
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
            end
            object SpecifyFileNameButton: TButton
              Left = 210
              Top = 61
              Width = 23
              Height = 25
              Hint = 'Specify the file name to save \ open the file.'
              Caption = '...'
              TabOrder = 1
              OnClick = SpecifyFileNameButtonClick
            end
            object HeadersOnFirstLineCheckBox: TCheckBox
              Left = 9
              Top = 99
              Width = 198
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Headers on First Line'
              TabOrder = 2
              Visible = False
            end
            object ClearTablePriorToImportCheckBox: TCheckBox
              Left = 9
              Top = 132
              Width = 198
              Height = 17
              Alignment = taLeftJustify
              Caption = 'Clear Table Prior To Import'
              TabOrder = 3
              Visible = False
            end
          end
        end
        object TPage
          Left = 0
          Top = 0
          Caption = 'SetBDEParameter'
          object SetBDEParameterGroupBox: TGroupBox
            Left = 0
            Top = 0
            Width = 240
            Height = 203
            Align = alClient
            Caption = ' Set BDE Parameters: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label13: TLabel
              Left = 17
              Top = 94
              Width = 40
              Height = 16
              Caption = 'Value:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label14: TLabel
              Left = 17
              Top = 35
              Width = 71
              Height = 16
              Caption = 'Parameter:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object BDEParameterValueEdit: TEdit
              Left = 17
              Top = 114
              Width = 181
              Height = 24
              TabOrder = 0
            end
            object BDEParameterNameEdit: TComboBox
              Left = 17
              Top = 56
              Width = 181
              Height = 24
              Style = csDropDownList
              ItemHeight = 16
              Sorted = True
              TabOrder = 1
              Items.Strings = (
                'AUTOODBC'
                'DATAREPOSITORY'
                'DBASELANGDRIVER'
                'DBASELEVEL'
                'DBASEMDXBLOCKSIZE'
                'DBASEMEMOFILEBLOCKSIZE'
                'DBASETYPE'
                'DBASEVERSION'
                'DEFAULTDRIVER'
                'LANGDRIVER'
                'LOCALSHARE'
                'LOWMEMORYUSAGELIMIT'
                'MAXBUFSIZE'
                'MAXFILEHANDLES'
                'MEMSIZE'
                'MINBUFSIZE'
                'MTSPOOLING'
                'SHAREDMEMLOCATION'
                'SHAREDMEMSIZE'
                'SQLQRYMODE'
                'SYSFLAGS'
                'VERSION')
            end
          end
        end
        object TPage
          Left = 0
          Top = 0
          Caption = 'AddBDEAlias'
          object AddBDEAliasGroupBox: TGroupBox
            Left = 0
            Top = 0
            Width = 240
            Height = 203
            Align = alClient
            Caption = ' Add BDE Alias: '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label15: TLabel
              Left = 17
              Top = 35
              Width = 106
              Height = 16
              Caption = 'BDE Alias Name:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label16: TLabel
              Left = 17
              Top = 94
              Width = 33
              Height = 16
              Caption = 'Path:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -13
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object BDEAliasNameEdit: TEdit
              Left = 17
              Top = 56
              Width = 181
              Height = 24
              TabOrder = 0
            end
            object BDEAliasPathEdit: TEdit
              Left = 17
              Top = 114
              Width = 181
              Height = 24
              TabOrder = 1
            end
          end
        end
      end
      object ActionTypeRadioGroup: TRadioGroup
        Left = 23
        Top = 1
        Width = 191
        Height = 252
        Caption = ' Action: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Items.Strings = (
          ' Add Field'
          ' Drop Field'
          ' Add Index'
          ' Drop Index'
          ' Pack'
          ' Reindex'
          ' Export Table'
          ' Import Table '
          ' Set BDE Parameter'
          ' Create BDE Alias'
          ' Empty Table'
          ' Pack, Reindex'
          ' Empty, Pack, Reindex'
          ' Change Field'
          ' Replace Field from File')
        ParentFont = False
        TabOrder = 1
        OnClick = ActionTypeRadioGroupClick
      end
      object CancelActionButton: TBitBtn
        Left = 493
        Top = 65
        Width = 69
        Height = 33
        Cancel = True
        Caption = '&Cancel'
        TabOrder = 2
        OnClick = CancelActionButtonClick
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033337733333333333333333F333333333333
          0000333911733333973333333377F333333F3333000033391117333911733333
          37F37F333F77F33300003339111173911117333337F337F3F7337F3300003333
          911117111117333337F3337F733337F3000033333911111111733333337F3337
          3333F7330000333333911111173333333337F333333F73330000333333311111
          7333333333337F3333373333000033333339111173333333333337F333733333
          00003333339111117333333333333733337F3333000033333911171117333333
          33337333337F333300003333911173911173333333373337F337F33300003333
          9117333911173333337F33737F337F33000033333913333391113333337FF733
          37F337F300003333333333333919333333377333337FFF730000333333333333
          3333333333333333333777330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
      end
      object DoneActionButton: TBitBtn
        Left = 493
        Top = 5
        Width = 69
        Height = 33
        Caption = '&OK'
        Default = True
        TabOrder = 3
        OnClick = DoneActionButtonClick
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333377F3333333333000033334224333333333333
          337337F3333333330000333422224333333333333733337F3333333300003342
          222224333333333373333337F3333333000034222A22224333333337F337F333
          7F33333300003222A3A2224333333337F3737F337F33333300003A2A333A2224
          33333337F73337F337F33333000033A33333A222433333337333337F337F3333
          0000333333333A222433333333333337F337F33300003333333333A222433333
          333333337F337F33000033333333333A222433333333333337F337F300003333
          33333333A222433333333333337F337F00003333333333333A22433333333333
          3337F37F000033333333333333A223333333333333337F730000333333333333
          333A333333333333333337330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
      end
    end
    object Panel7: TPanel
      Left = 3
      Top = 3
      Width = 597
      Height = 27
      Align = alTop
      TabOrder = 1
      object ActionDialogLabel: TLabel
        Left = 202
        Top = 6
        Width = 169
        Height = 19
        Caption = 'Add \ Modify an Action'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object Panel6: TPanel
      Left = 3
      Top = 30
      Width = 597
      Height = 173
      Align = alClient
      TabOrder = 2
      object Panel8: TPanel
        Left = 1
        Top = 1
        Width = 298
        Height = 171
        Align = alLeft
        TabOrder = 0
        object Panel11: TPanel
          Left = 1
          Top = 1
          Width = 296
          Height = 19
          Align = alTop
          TabOrder = 0
          object Label2: TLabel
            Left = 12
            Top = 3
            Width = 126
            Height = 16
            Caption = 'Choose a Database:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object DatabaseListBox: TListBox
          Left = 1
          Top = 20
          Width = 296
          Height = 150
          Align = alClient
          ExtendedSelect = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clFuchsia
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ItemHeight = 15
          ParentFont = False
          Sorted = True
          TabOrder = 1
          OnClick = DatabaseListBoxClick
        end
      end
      object Panel9: TPanel
        Left = 299
        Top = 1
        Width = 297
        Height = 171
        Align = alClient
        TabOrder = 1
        object Panel10: TPanel
          Left = 1
          Top = 1
          Width = 295
          Height = 19
          Align = alTop
          TabOrder = 0
          object Label3: TLabel
            Left = 12
            Top = 3
            Width = 102
            Height = 16
            Caption = 'Choose a Table:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object TableListBox: TListBox
          Left = 1
          Top = 20
          Width = 295
          Height = 150
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ItemHeight = 15
          MultiSelect = True
          ParentFont = False
          Sorted = True
          TabOrder = 1
        end
      end
    end
  end
  object Query: TwwQuery
    ValidateWithMask = True
    Left = 318
    Top = 318
  end
  object Table: TwwTable
    TableType = ttDBase
    SyncSQLByRange = False
    NarrowSearch = False
    ValidateWithMask = True
    Left = 268
    Top = 371
  end
  object DataSource: TwwDataSource
    DataSet = Table
    Left = 214
    Top = 309
  end
  object TableFunctionsPopupMenu: TPopupMenu
    Left = 565
    Top = 379
    object FindARecord: TMenuItem
      Caption = '&Find a Record'
      OnClick = FindARecordClick
    end
    object SetRange: TMenuItem
      Caption = '&Set Range'
      OnClick = SetRangeClick
    end
    object CancelRange: TMenuItem
      Caption = 'Cancel Ran&ge'
      Enabled = False
      OnClick = CancelRangeClick
    end
    object DeleteCurrentRange1: TMenuItem
      Caption = '&Delete Current Range'
      OnClick = DeleteCurrentRange1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object ApplyFilter: TMenuItem
      Caption = '&Apply Filter'
      OnClick = ApplyFilterClick
    end
    object ApplySpecialFilter1: TMenuItem
      Caption = 'Apply Special Filter'
      object StringStartsWith: TMenuItem
        Caption = 'String - Starts With'
        OnClick = SpecialFilterClick
      end
      object StringContains: TMenuItem
        Caption = 'String - Contains'
        OnClick = SpecialFilterClick
      end
      object StringEndsWith: TMenuItem
        Caption = 'String - Ends With'
        OnClick = SpecialFilterClick
      end
    end
    object RemoveFilter: TMenuItem
      Caption = '&Remove Filter'
      Enabled = False
      OnClick = RemoveFilterClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object ExecuteSQLQuery: TMenuItem
      Caption = '&Execute SQL Query'
      OnClick = ExecuteSQLClick
    end
    object ExecuteSQLModify: TMenuItem
      Caption = 'Execute S&QL Change'
      OnClick = ExecuteSQLClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object SetFieldValue: TMenuItem
      Caption = 'Set &Value for Field'
      OnClick = AggregateClick
    end
    object ReplaceTextInAField: TMenuItem
      Caption = 'Replace Text in a Field'
      OnClick = ReplaceTextInAFieldClick
    end
    object SetValuefromaDifferentField1: TMenuItem
      Caption = 'Set Value from a &Different Field'
      OnClick = SetValuefromaDifferentField1Click
    end
    object mnuitmApplyPercentagetoaNumericField: TMenuItem
      Caption = 'Apply Percentage to a Numeric Field'
      OnClick = AggregateClick
    end
    object mnuChangeValueofFieldforallTables: TMenuItem
      Caption = 'Change Value of Field for all Tables'
      OnClick = mnuChangeValueofFieldforallTablesClick
    end
    object mnuTrimField: TMenuItem
      Caption = 'Trim Field'
      OnClick = AggregateClick
    end
    object mnuUpperCase: TMenuItem
      Caption = 'Upper Case'
      OnClick = AggregateClick
    end
    object mnuSRAZ: TMenuItem
      Caption = 'SRAZ'
      OnClick = AggregateClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object CountofRows: TMenuItem
      Caption = '&Count of Rows'
      OnClick = CountofRowsClick
    end
    object SumaColumn: TMenuItem
      Caption = 'S&um a Column'
      OnClick = AggregateClick
    end
    object FindMaximum: TMenuItem
      Caption = 'Find &Maximum'
      OnClick = AggregateClick
    end
    object FindMinimum: TMenuItem
      Caption = 'Find Mi&nimum'
      OnClick = AggregateClick
    end
    object FindAverage: TMenuItem
      Caption = 'Find &Average'
      OnClick = AggregateClick
    end
    object N4: TMenuItem
      Caption = '-'
      Hint = '-'
    end
    object ExportData1: TMenuItem
      Caption = 'E&xport Data'
      OnClick = ExportData1Click
    end
    object ImportData1: TMenuItem
      Caption = '&Import Data'
      OnClick = ImportData1Click
    end
    object CopyDataFromAnotherTable1: TMenuItem
      Caption = 'Copy Data From Another Table'
      OnClick = CopyDataFromAnotherTable1Click
    end
    object CopyRecordToCipboard: TMenuItem
      Caption = 'Copy Record to Clipboard'
      OnClick = CopyRecordToCipboardClick
    end
    object PasteRecordfromClipboard1: TMenuItem
      Caption = 'Paste Record from Clipboard'
      OnClick = PasteRecordfromClipboard1Click
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'spt'
    Filter = 'Alter DBase Tables Scripts (*.spt)|*.spt|All Files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofExtensionDifferent, ofPathMustExist, ofEnableSizing]
    Left = 159
    Top = 65532
  end
  object OpenDialog: TOpenDialog
    Filter = 'Alter DBase Tables Scripts (*.spt)|*.spt|All Files (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 390
    Top = 8
  end
  object UpdateSQL1: TUpdateSQL
    Left = 543
    Top = 56
  end
  object Query1: TQuery
    Left = 549
    Top = 117
  end
  object EndTaskTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = EndTaskTimerTimer
    Left = 519
    Top = 177
  end
  object ResizeTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = ResizeTimerTimer
    Left = 70
    Top = 108
  end
  object ClipboardSaveDialog: TSaveDialog
    DefaultExt = 'clp'
    Filter = 'Clipboard Files (*.clp)|clp|All Files (*.*)|*.*'
    Options = [ofHideReadOnly, ofExtensionDifferent, ofPathMustExist, ofEnableSizing]
    Left = 136
    Top = 96
  end
  object ClipboardOpenDialog: TOpenDialog
    DefaultExt = 'clp'
    Filter = 'Clipboard Files (*.clp)|*.clp|All Files (*.*)|*.*'
    FilterIndex = 0
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 271
    Top = 129
  end
  object OpenFileDialog: TOpenDialog
    Left = 472
    Top = 63
  end
  object SaveFileDialog: TSaveDialog
    Left = 376
    Top = 109
  end
end
