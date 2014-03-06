unit AlterDBaseTableUnit;

interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Grids, DBTables, DBaseActionObject, Mask,
  wwdbedit, Wwdotdot, Wwdbcomb, Wwkeycb, wwSpeedButton, wwDBNavigator,
  wwclearpanel, Wwdbigrd, Wwdbgrid, Db, Wwdatsrc, Wwtable, Wwquery,
  ComCtrls, Menus, BDE, SysUtils;

type
  TAlterDBaseTableForm = class(TForm)
    Query: TwwQuery;
    Table: TwwTable;
    DataSource: TwwDataSource;
    TableFunctionsPopupMenu: TPopupMenu;
    FindARecord: TMenuItem;
    SetRange: TMenuItem;
    ApplyFilter: TMenuItem;
    RemoveFilter: TMenuItem;
    FindMaximum: TMenuItem;
    FindMinimum: TMenuItem;
    FindAverage: TMenuItem;
    CountofRows: TMenuItem;
    ExecuteSQLQuery: TMenuItem;
    SumaColumn: TMenuItem;
    CancelRange: TMenuItem;
    SetFieldValue: TMenuItem;
    ExecuteSQLModify: TMenuItem;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    UpdateSQL1: TUpdateSQL;
    Query1: TQuery;
    EndTaskTimer: TTimer;
    DeleteCurrentRange1: TMenuItem;
    SetValuefromaDifferentField1: TMenuItem;
    Panel1: TPanel;
    PageControl: TPageControl;
    AlterTablesPage: TTabSheet;
    ViewEditTablesPage: TTabSheet;
    RecCountLabel: TLabel;
    ActionSelectionPanel: TPanel;
    Panel2: TPanel;
    Navigator: TwwDBNavigator;
    NavigatorFirst: TwwNavButton;
    NavigatorPriorPage: TwwNavButton;
    NavigatorPrior: TwwNavButton;
    NavigatorNext: TwwNavButton;
    NavigatorNextPage: TwwNavButton;
    NavigatorLast: TwwNavButton;
    NavigatorInsert: TwwNavButton;
    NavigatorDelete: TwwNavButton;
    NavigatorEdit: TwwNavButton;
    NavigatorPost: TwwNavButton;
    NavigatorCancel: TwwNavButton;
    NavigatorRefresh: TwwNavButton;
    NavigatorSaveBookmark: TwwNavButton;
    NavigatorRestoreBookmark: TwwNavButton;
    Panel3: TPanel;
    DBGrid: TwwDBGrid;
    Panel4: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    DatabaseComboBox: TComboBox;
    TableComboBox: TComboBox;
    IndexComboBox: TwwKeyCombo;
    LastOperationEdit: TEdit;
    LastResultEdit: TEdit;
    ShowConditionEnteredButton: TButton;
    Label5: TLabel;
    RecordCountLabel: TLabel;
    CopyDataFromAnotherTable1: TMenuItem;
    ExportData1: TMenuItem;
    Panel5: TPanel;
    ValuesNotebook: TNotebook;
    FieldNameGroupBox: TGroupBox;
    Label1: TLabel;
    AddDropFieldNameEdit: TEdit;
    LookupFieldButton: TButton;
    FieldType_LengthRadioGroup: TRadioGroup;
    StringLengthEdit: TEdit;
    IndexNameGroupBox: TGroupBox;
    Label4: TLabel;
    IndexExpressionLabel: TLabel;
    IndexNameEdit: TEdit;
    LookupIndexButton: TButton;
    IndexExpressionEdit: TEdit;
    CreateIndexExpressionButton: TButton;
    IndexAttributeGroupBox: TGroupBox;
    PrimaryIndexCheckBox: TCheckBox;
    UniqueIndexCheckBox: TCheckBox;
    DescendingIndexCheckBox: TCheckBox;
    EnterFileNameGroupBox: TGroupBox;
    Label7: TLabel;
    FileNameEdit: TEdit;
    SpecifyFileNameButton: TButton;
    HeadersOnFirstLineCheckBox: TCheckBox;
    ClearTablePriorToImportCheckBox: TCheckBox;
    SetBDEParameterGroupBox: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    BDEParameterValueEdit: TEdit;
    BDEParameterNameEdit: TComboBox;
    AddBDEAliasGroupBox: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    BDEAliasNameEdit: TEdit;
    BDEAliasPathEdit: TEdit;
    ActionTypeRadioGroup: TRadioGroup;
    CancelActionButton: TBitBtn;
    DoneActionButton: TBitBtn;
    Panel14: TPanel;
    ExecuteButton: TBitBtn;
    LoadButton: TBitBtn;
    SaveButton: TBitBtn;
    PrintButton: TBitBtn;
    Panel15: TPanel;
    GroupBox1: TGroupBox;
    Panel16: TPanel;
    MoveUpButton: TBitBtn;
    MoveDownButton: TBitBtn;
    Panel17: TPanel;
    AddActionButton: TButton;
    DeleteActionButton: TButton;
    ClearActionsButton: TButton;
    ChangeActionButton: TButton;
    Panel18: TPanel;
    ActionGrid: TStringGrid;
    ResizeTimer: TTimer;
    CopyRecordToCipboard: TMenuItem;
    PasteRecordfromClipboard1: TMenuItem;
    ClipboardSaveDialog: TSaveDialog;
    ClipboardOpenDialog: TOpenDialog;
    ApplySpecialFilter1: TMenuItem;
    StringStartsWith: TMenuItem;
    StringContains: TMenuItem;
    StringEndsWith: TMenuItem;
    ImportData1: TMenuItem;
    OpenFileDialog: TOpenDialog;
    SaveFileDialog: TSaveDialog;
    ProgressLabel: TLabel;
    CloseTableButton: TBitBtn;
    ReplaceTextInAField: TMenuItem;
    mnuitmApplyPercentagetoaNumericField: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    mnuChangeValueofFieldforallTables: TMenuItem;
    mnuTrimField: TMenuItem;
    Panel7: TPanel;
    ActionDialogLabel: TLabel;
    Panel6: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    DatabaseListBox: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    TableListBox: TListBox;
    mnuSRAZ: TMenuItem;
    mnuUpperCase: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure DatabaseListBoxClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DatabaseComboBoxChange(Sender: TObject);
    procedure TableComboBoxChange(Sender: TObject);
    procedure IndexComboBoxChange(Sender: TObject);
    procedure FindARecordClick(Sender: TObject);
    procedure CancelRangeClick(Sender: TObject);
    procedure SetRangeClick(Sender: TObject);
    procedure ApplyFilterClick(Sender: TObject);
    procedure RemoveFilterClick(Sender: TObject);
    procedure ExecuteSQLClick(Sender: TObject);
    procedure AggregateClick(Sender: TObject);
    procedure CountofRowsClick(Sender: TObject);
    procedure AddActionButtonClick(Sender: TObject);
    procedure ChangeActionButtonClick(Sender: TObject);
    procedure DeleteActionButtonClick(Sender: TObject);
    procedure ClearActionsButtonClick(Sender: TObject);
    procedure DoneActionButtonClick(Sender: TObject);
    procedure CancelActionButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure LoadButtonClick(Sender: TObject);
    procedure ExecuteButtonClick(Sender: TObject);
    procedure ActionTypeRadioGroupClick(Sender: TObject);
    procedure FieldType_LengthRadioGroupClick(Sender: TObject);
    procedure ActionGridDblClick(Sender: TObject);
    procedure MoveUpButtonClick(Sender: TObject);
    procedure MoveDownButtonClick(Sender: TObject);
    procedure EndTaskTimerTimer(Sender: TObject);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure DeleteCurrentRange1Click(Sender: TObject);
    procedure SetValuefromaDifferentField1Click(Sender: TObject);
    procedure CopyDataFromAnotherTable1Click(Sender: TObject);
    procedure ExportData1Click(Sender: TObject);
    procedure ResizeTimerTimer(Sender: TObject);
    procedure CopyRecordToCipboardClick(Sender: TObject);
    procedure PasteRecordfromClipboard1Click(Sender: TObject);
    procedure SpecialFilterClick(Sender: TObject);
    procedure ImportData1Click(Sender: TObject);
    procedure SpecifyFileNameButtonClick(Sender: TObject);
    procedure CloseTableButtonClick(Sender: TObject);
    procedure ReplaceTextInAFieldClick(Sender: TObject);
    procedure mnuChangeValueofFieldforallTablesClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    Actions : TDBaseActionObject;
    Mode : Integer;
    CurrentRow : Integer;
    LoadingFromFileOnStartup, RunHidden : Boolean;
    InitialLoadScript, ResultFileName : String;
    LastClipboardFileName, LastClipboardDirectory : String;

    Procedure RefreshActionGrid;
    Procedure SetValuesNotebookInformation(ActionRec : ActionRecord);
    Procedure DisplayActionDialog(ActionRec : ActionRecord);
    Procedure AddActionItemToGrid(ActionRec : ActionRecord);
    Function GetActionRecEntered : ActionRecord;
  end;

var
  AlterDBaseTableForm: TAlterDBaseTableForm;

implementation

{$R *.DFM}

uses FindRecordsDialogUnit,
     ConditionalCommandDialogUnit,
     AggregateDialogUnit,
     SetValueFromAnotherFieldUnit,
     CopyTableDataUnit,
     ExportDataDialogUnit,
     ImportDataDialogUnit,
     SpecialFilterDialogUnit,
     ReplaceInFieldDialogUnit,
     ReplaceFieldInTablesDialogUnit;

const
  mdAdd = 0;
  mdChange = 1;

  clDatabaseName = 0;
  clTableName = 1;
  clAction = 2;
  clValue = 3;

{======================================================================}
Procedure ClearStringGrid(StringGrid : TStringGrid;
                          StartingRow : Integer);

var
  I, J : Integer;

begin
  with StringGrid do
    For J := StartingRow to (RowCount - 1) do
      For I := 0 to (ColCount - 1) do
        Cells[I, J] := '';

end;  {ClearStringGrid}

{=============================================================================}
Function NumEntriesInGridCol(StringGrid : TStringGrid;
                             Column : Integer) : Integer;

{Determine the number of non=blank entries in a column of a string grid.}

var
  I : Integer;

begin
  Result := 0;

  For I := 0 to (StringGrid.RowCount - 1) do
    If (StringGrid.Cells[0, I] <> '')
      then Result := Result + 1;

end;  {NumEntriesInGridCol}

{=============================================================================}
Function NumEntriesInGrid(StringGrid : TStringGrid) : Integer;

{Determine the number of rows in a string grid that have information.}

var
  I, J : Integer;
  EntriesInRow : Boolean;

begin
  Result := 0;

  with StringGrid do
    For I := 0 to (RowCount - 1) do
      begin
        EntriesInRow := False;

        For J := 0 to (ColCount - 1) do
          If (Cells[J, I] <> '')
            then EntriesInRow := True;

        If EntriesInRow
          then Result := Result + 1;

      end;  {For I := 0 to (RowCount - 1) do}

end;  {NumEntriesInGridCol}

{===================================================}
Procedure ExchangeGridRows(Grid : TStringGrid;
                           Row1,
                           Row2 : Integer);

var
  I : Integer;
  TempStr : String;

begin
  with Grid do
    For I := 0 to (ColCount - 1) do
      begin
        TempStr := Cells[I, Row1];
        Cells[I, Row1] := Cells[I, Row2];
        Cells[I, Row2] := TempStr;

      end;  {For I := 0 to (ColCount - 1) do}

end;  {ExchangeGridRows}

{===================================================================}
Function LTrim(Arg : String) : String;
{DS: trim Leading blanks off of a string }

var
  Pos, Lgn :Integer;

begin
  Lgn := Length(Arg);

  Pos := 1;

    {Delete spaces off the front.}

  while ((Pos <= Lgn) and
         (Arg[1] = ' ')) do
    begin
      Delete(Arg, 1, 1);
      Pos := Pos + 1;
    end;

  LTrim := Arg;

end;  {LTrim}

{====================================================================}
Function ReturnPath(Path : String) : String;

{Remove the file name from a path.}

var
  TempLen, Index : Integer;
  SlashFound : Boolean;

begin
  TempLen := Length(Path);
  Index := TempLen;
  SlashFound := False;

  while ((Index > 0) and
         (not SlashFound)) do
    If (Path[Index] = '\')
      then SlashFound := True
      else Index := Index - 1;

  If (Index = 0)
    then Result := ''
    else Result := Copy(Path, 1, Index);

end;  {ReturnPath}

{===================================================}
Procedure TAlterDBaseTableForm.RefreshActionGrid;

var
  I : Integer;

begin
  ClearStringGrid(ActionGrid, 1);

  For I := 0 to (Actions.Count - 1) do
    begin
      CurrentRow := I + 1;

      If (CurrentRow > ActionGrid.RowCount)
        then ActionGrid.RowCount := ActionGrid.RowCount + 1;

      AddActionItemToGrid(Actions.GetAction(I));

    end;  {For I := 0 to (Actions.Count - 1) do}

end;  {RefreshActionGrid}

{===================================================}
Procedure TAlterDBaseTableForm.FormCreate(Sender: TObject);

var
  I, EqualsPos : Integer;

begin
  LastClipboardDirectory := GetCurrentDir;
  CurrentRow := 1;
  Actions := TDBaseActionObject.Create;

    {Fill in the header for the grid.}

  with ActionGrid do
    begin
      Cells[clDatabaseName, 0] := 'Database Name';
      Cells[clTableName, 0] := 'Table Name';
      Cells[clAction, 0] := 'Action';
      Cells[clValue, 0] := 'Value';

    end;  {with ActionGrid do}

  Session.GetDatabaseNames(DatabaseListBox.Items);
  Session.GetDatabaseNames(DatabaseComboBox.Items);

  ActionSelectionPanel.Left := 28;
  ActionSelectionPanel.Top := 7;

  RunHidden := False;
  InitialLoadScript := '';

  For I := 1 to ParamCount do
    begin
      If (Pos('HIDDEN', ANSIUppercase(ParamStr(I))) > 0)
        then RunHidden := True;

      If (Pos('SCRIPT', ANSIUppercase(ParamStr(I))) > 0)
        then
          begin
            EqualsPos := Pos('=', ParamStr(I));
            InitialLoadScript := Copy(ParamStr(I), (EqualsPos + 1), 200);
            InitialLoadScript := LTrim(InitialLoadScript);

          end;  {If (Pos('SCRIPT', ParamStr(I) > 0)}

      If (Pos('RESULTFILE', ANSIUppercase(ParamStr(I))) > 0)
        then
          begin
            EqualsPos := Pos('=', ParamStr(I));
            ResultFileName := Copy(ParamStr(I), (EqualsPos + 1), 200);
            ResultFileName := LTrim(ResultFileName);

          end;  {If (Pos('RESULTFILE', ParamStr(I) > 0)}

    end;  {For I := 1 to ParamCount do}

  If (InitialLoadScript <> '')
    then
      begin
        LoadingFromFileOnStartup := True;
        LoadButtonClick(Sender);
        LoadingFromFileOnStartup := False;

      end;  {If (InitialLoadScript <> '')}

  If RunHidden
    then
      begin
        Actions.ExecuteAll(RunHidden, ResultFileName, ProgressLabel);
        EndTaskTimer.Enabled := True;
      end
    else ResizeTimer.Enabled := True;

end;  {with ActionGrid do}

{===================================================}
Procedure TAlterDBaseTableForm.EndTaskTimerTimer(Sender: TObject);

begin
  EndTaskTimer.Enabled := False;
  Close;
end;

{===================================================}
Procedure TAlterDBaseTableForm.ResizeTimerTimer(Sender: TObject);

var
  I, EachColumnWidth : Integer;

begin
  EachColumnWidth := (ActionGrid.Width - 25) DIV 4;

  with ActionGrid do
    For I := 0 to (ColCount - 1) do
      ColWidths[I] := EachColumnWidth;

  RecordCountLabel.Left := Width - 140;

end;  {ResizeTimerTimer}

{===================================================}
{========    Alter Table Procedures   ==============}
{===================================================}
Procedure TAlterDBaseTableForm.SetValuesNotebookInformation(ActionRec : ActionRecord);

begin
  with ActionRec do
    begin
      ValuesNotebook.Visible := True;  {Default}

      case ActionType of
        -1,
        acPack,
        acReindex,
        acEmptyTable,
        acPackReindexTable,
        acEmptyPackReindexTable : ValuesNotebook.Visible := False;  {No action selected yet or
                                                                     pack \ reindex}

        acAddField,
        acChangeField,
        acDropField :
          begin
            ValuesNotebook.PageIndex := 0;
            StringLengthEdit.Visible := False;
            FieldType_LengthRadioGroup.Visible := False;
            AddDropFieldNameEdit.Text := FieldName;

            If (ActionType = acAddField)
              then
                with FieldType_LengthRadioGroup do
                  begin
                    Visible := True;

                    case FieldType of
                      fldDBCHAR :
                        begin
                          ItemIndex := 0;
                          StringLengthEdit.Visible := True;
                          StringLengthEdit.Text := IntToStr(FieldLength);
                        end;

                      fldDBLONG : ItemIndex := 1;

                      fldDBDOUBLE : ItemIndex := 2;

                      fldDBBOOL : ItemIndex := 3;

                      fldDBAUTOINC : ItemIndex := 4;

                      fldDBMEMO : ItemIndex := 5;

                      fldDBDate : ItemIndex := 6;

                    end;  {case FieldType of}

                  end;  {If (ActionType = acAddField)}

          end;  {acAddField, ...}

        acAddIndex :
          begin
            ValuesNotebook.PageIndex := 1;

            IndexNameEdit.Text := IndexName;

            IndexExpressionLabel.Visible := True;
            IndexExpressionEdit.Visible := True;
            CreateIndexExpressionButton.Visible := True;
            IndexAttributeGroupBox.Visible := True;

            IndexExpressionEdit.Text := IndexExpression;

            PrimaryIndexCheckBox.Checked := (ixPrimary in IndexOptions);
            UniqueIndexCheckBox.Checked := (ixUnique in IndexOptions);
            DescendingIndexCheckBox.Checked := (ixDescending in IndexOptions);

          end;  {acAddIndex}

        acDropIndex :
          begin
            ValuesNotebook.PageIndex := 1;

            IndexNameEdit.Text := IndexName;

            IndexExpressionLabel.Visible := False;
            IndexExpressionEdit.Visible := False;
            CreateIndexExpressionButton.Visible := False;
            IndexAttributeGroupBox.Visible := False;

          end;  {acDropIndex}

        acExportTable :
          begin
            ValuesNotebook.PageIndex := 2;
            HeadersOnFirstLineCheckBox.Visible := True;
            ClearTablePriorToImportCheckBox.Visible := False;
            HeadersOnFirstLineCheckBox.Checked := HeadersOnFirstLine;

          end;  {acExportTable}

        acImportTable :
          begin
            ValuesNotebook.PageIndex := 2;
            HeadersOnFirstLineCheckBox.Visible := False;
            ClearTablePriorToImportCheckBox.Visible := True;
            ClearTablePriorToImportCheckBox.Checked := ClearTablePriorToImport;

          end;  {acImportTable}

        acSetConfigParameter : ValuesNotebook.PageIndex := 3;
        acCreateBDEAlias : ValuesNotebook.PageIndex := 4;

        acReplaceValueFromFile :
        begin
          ValuesNotebook.PageIndex := 2;
          HeadersOnFirstLineCheckBox.Visible := False;
          ClearTablePriorToImportCheckBox.Visible := False;
        end;

      end;  {case ActionType of}

    end;  {with ActionRec do}

end;  {SetValuesNotebookInformation}

{===================================================}
Procedure TAlterDBaseTableForm.DisplayActionDialog(ActionRec : ActionRecord);

begin
  with ActionSelectionPanel do
    begin
      Visible := True;
      Left := 10;
      Top := 10;
      Width := AlterDBaseTableForm.Width - 40;
      Height := AlterDBaseTableForm.Height - 50;

    end;  {with ActionSelectionPanel do}

  with ActionRec do
    begin
      If (DatabaseName <> '')
        then
          begin
            DatabaseListBox.ItemIndex := DatabaseListBox.Items.IndexOf(DatabaseName);

              {Load the correct tables for this database.}

            DatabaseListBoxClick(DatabaseListBox);

          end;  {If (DatabaseName <> '')}

      If (TableName <> '')
        then TableListBox.ItemIndex := TableListBox.Items.IndexOf(TableName);

      ActionTypeRadioGroup.ItemIndex := ActionType;

      SetValuesNotebookInformation(ActionRec);

    end;  {with ActionRec do}

end;  {DisplayActionDialog}

{===================================================}
Function TAlterDBaseTableForm.GetActionRecEntered : ActionRecord;

begin
  Result := GetEmptyActionRecord;

  with Result do
    begin
      with DatabaseListBox do
        try
          DatabaseName := Items[ItemIndex];
        except
        end;

      with TableListBox do
        try
          TableName := Items[ItemIndex];
        except
        end;

      ActionType := ActionTypeRadioGroup.ItemIndex;

      case ActionType of
        acAddField :
          begin
            FieldName := AddDropFieldNameEdit.Text;

            If (FieldName = '')
              then
                begin
                  MessageDlg('Please enter the field name to add.',
                             mtError, [mbOK], 0);
                  Abort;
                end;

            case FieldType_LengthRadioGroup.ItemIndex of
              -1 : begin
                     MessageDlg('Please choose a field type.',
                                mtError, [mbOk], 0);
                     Abort;
                   end;

              0 : begin
                    FieldType := fldDBCHAR;

                    try
                      FieldLength := StrToInt(StringLengthEdit.Text);
                    except
                      MessageDlg('Please enter a valid string length.',
                                 mtError, [mbOK], 0);
                      Abort;
                    end;

                  end;  {String}

              1 : FieldType := fldDBLONG;

              2 : FieldType := fldDBDOUBLE;

              3 : FieldType := fldDBBOOL;

              4 : FieldType := fldDBAUTOINC;

              5 : FieldType := fldDBMEMO;

              6 : FieldType := fldDBDate;

            end;  {case FieldType_LengthRadioGroup.ItemIndex of}

          end;  {acAddField}

        acDropField :
          begin
            FieldName := AddDropFieldNameEdit.Text;

            If (FieldName = '')
              then
                begin
                  MessageDlg('Please enter the field name to drop.',
                             mtError, [mbOK], 0);
                  Abort;
                end;

          end;  {acDropField}

        acAddIndex :
          begin
            IndexName := IndexNameEdit.Text;

            If (IndexName = '')
              then
                begin
                  MessageDlg('Please enter the index name to add.',
                             mtError, [mbOK], 0);
                  Abort;
                end;

            IndexExpression := IndexExpressionEdit.Text;

            If (IndexExpression = '')
              then
                begin
                  MessageDlg('Please enter the index expression to add.',
                             mtError, [mbOK], 0);
                  Abort;
                end;

            IndexOptions := [];

            If PrimaryIndexCheckBox.Checked
              then IndexOptions := IndexOptions + [ixPrimary];

            If UniqueIndexCheckBox.Checked
              then IndexOptions := IndexOptions + [ixUnique];

            If DescendingIndexCheckBox.Checked
              then IndexOptions := IndexOptions + [ixDescending];

          end;  {acAddIndex}

       acDropIndex :
          begin
            IndexName := IndexNameEdit.Text;

            If (IndexName = '')
              then
                begin
                  MessageDlg('Please enter the index name to drop.',
                             mtError, [mbOK], 0);
                  Abort;
                end;

          end;  {acDropIndex}

        acExportTable :
          begin
            FileName := FileNameEdit.Text;

            If (FileName = '')
              then
                begin
                  MessageDlg('Please enter the file name.',
                             mtError, [mbOK], 0);
                  Abort;
                end;

            HeadersOnFirstLine := HeadersOnFirstLineCheckBox.Checked;

          end;  {acExportTable}

        acImportTable :
          begin
            FileName := FileNameEdit.Text;
            HeadersOnFirstLine := HeadersOnFirstLineCheckBox.Checked;

            If (FileName = '')
              then
                begin
                  MessageDlg('Please enter the file name.',
                             mtError, [mbOK], 0);
                  Abort;
                end;

            ClearTablePriorToImport := ClearTablePriorToImportCheckBox.Checked;

          end;  {acImportTable}

        acSetConfigParameter :
          begin
            ParameterName := BDEParameterNameEdit.Text;

            If (ParameterName = '')
              then
                begin
                  MessageDlg('Please enter the parameter name.',
                             mtError, [mbOK], 0);
                  Abort;
                end;

            ParameterValue := BDEParameterValueEdit.Text;

            If (ParameterValue = '')
              then
                begin
                  MessageDlg('Please enter the parameter value.',
                             mtError, [mbOK], 0);
                  Abort;
                end;

          end;  {acSetConfigParameter}

        acCreateBDEAlias :
          begin
            AliasName := BDEAliasNameEdit.Text;

            If (AliasName = '')
              then
                begin
                  MessageDlg('Please enter the alias name.',
                             mtError, [mbOK], 0);
                  Abort;
                end;

            AliasPath := BDEAliasPathEdit.Text;

            If (AliasPath = '')
              then
                begin
                  MessageDlg('Please enter the alias path.',
                             mtError, [mbOK], 0);
                  Abort;
                end;

          end;  {acCreateBDEAlias}

        acReplaceValueFromFile :
        begin
          FileName := FileNameEdit.Text;

          If (FileName = '')
            then
              begin
                MessageDlg('Please enter the file name.',
                           mtError, [mbOK], 0);
                Abort;
              end;

        end;  {acReplaceValueFromFile}

      end;  {case ActionType of}

    end;  {with Result do}

end;  {GetActionRecEntered}

{===================================================}
Procedure TAlterDBaseTableForm.AddActionItemToGrid(ActionRec : ActionRecord);

begin
  with ActionGrid, ActionRec do
    begin
      Cells[clDatabaseName, CurrentRow] := DatabaseName;
      Cells[clTableName, CurrentRow] := TableName;
      Cells[clAction, CurrentRow] := Actions.GetActionNameForActionType(ActionType);
      Cells[clValue, CurrentRow] := Actions.GetMainValueForActionType(ActionRec);

    end;  {with ActionGrid do}

end;  {AddActionItemToGrid}

{===================================================}
Procedure TAlterDBaseTableForm.ActionTypeRadioGroupClick(Sender: TObject);

var
  ActionRec : ActionRecord;

begin
  ActionRec := GetEmptyActionRecord;
  ActionRec.ActionType := ActionTypeRadioGroup.ItemIndex;
  DisplayActionDialog(ActionRec);

end;  {ActionTypeRadioGroupClick}

{===================================================}
Procedure TAlterDBaseTableForm.FieldType_LengthRadioGroupClick(Sender: TObject);

begin
  StringLengthEdit.Visible := (FieldType_LengthRadioGroup.ItemIndex = 0);
end;  {FieldType_LengthRadioGroupClick}

{===================================================}
Procedure TAlterDBaseTableForm.DoneActionButtonClick(Sender: TObject);

var
  ActionRec : ActionRecord;
  FirstTimeThrough : Boolean;
  I : Integer;

begin
  ActionSelectionPanel.Hide;

    {CHG02272003-1: Allow for multi-select of tables when adding actions.}

  If (Mode = mdAdd)
    then
      begin
        FirstTimeThrough := True;

        with TableListBox do
          For I := 0 to (Items.Count - 1) do
            If Selected[I]
              then
                begin
                  If FirstTimeThrough
                    then
                      begin
                        ActionRec := GetActionRecEntered;
                        FirstTimeThrough := False;
                      end;

                  try
                    ActionRec.TableName := Items[I];
                  except
                  end;

                  If ((CurrentRow - 1) > ActionGrid.RowCount)
                    then ActionGrid.RowCount := ActionGrid.RowCount + 1;

                  Actions.AddAction(ActionRec, (CurrentRow - 1));

                  CurrentRow := CurrentRow + 1;

                end;   {If Selected[I]}

      end
    else
      begin
        ActionRec := GetActionRecEntered;
        Actions.UpdateAction(ActionRec, (CurrentRow - 1));
      end;  {else of If (Mode = mdAdd)}

  RefreshActionGrid;

end;  {DoneActionButtonClick}

{===================================================}
Procedure TAlterDBaseTableForm.CancelActionButtonClick(Sender: TObject);

begin
  ActionSelectionPanel.Hide;
end;

{===================================================}
Procedure TAlterDBaseTableForm.AddActionButtonClick(Sender: TObject);

begin
  Mode := mdAdd;
  CurrentRow := NumEntriesInGrid(ActionGrid);
  DisplayActionDialog(GetEmptyActionRecord);

end;  {AddActionButtonClick}

{===================================================}
Procedure TAlterDBaseTableForm.ChangeActionButtonClick(Sender: TObject);

begin
  Mode := mdChange;
  CurrentRow := ActionGrid.Row;
  DisplayActionDialog(Actions.GetAction(CurrentRow - 1));

end;  {ChangeActionButtonClick}

{===================================================}
Procedure TAlterDBaseTableForm.ActionGridDblClick(Sender: TObject);

begin
  with ActionGrid do
    If (Cells[0, Row] = '')
      then AddActionButtonClick(Sender)
      else ChangeActionButtonClick(Sender);

end;  {ActionGridDblClick}

{===================================================}
Procedure TAlterDBaseTableForm.DeleteActionButtonClick(Sender: TObject);

begin
  Actions.DeleteAction(ActionGrid.Row - 1);

  RefreshActionGrid;

end;  {DeleteActionButtonClick}

{===================================================}
Procedure TAlterDBaseTableForm.ClearActionsButtonClick(Sender: TObject);

begin
  Actions.ClearActions;
  ClearStringGrid(ActionGrid, 1);

end;  {ClearActionsButtonClick}

{===================================================}
Procedure TAlterDBaseTableForm.MoveUpButtonClick(Sender: TObject);

begin
  with ActionGrid do
    If (Row > 1)
      then
        begin
          Actions.SwitchActions((Row - 1), (Row - 2));
          ExchangeGridRows(ActionGrid, Row, (Row - 1));
          Row := Row - 1;

        end;  {If (Row > 1)}

end;  {MoveUpButtonClick}

{===================================================}
Procedure TAlterDBaseTableForm.MoveDownButtonClick(Sender: TObject);

begin
  with ActionGrid do
    If (Row < (NumEntriesInGrid(ActionGrid) - 1))
      then
        begin
          Actions.SwitchActions((Row - 1), Row);
          ExchangeGridRows(ActionGrid, Row, (Row + 1));
          Row := Row + 1;

        end;  {If (Row < RowCount)}

end;  {MoveDownButtonClick}

{===================================================}
Procedure TAlterDBaseTableForm.SaveButtonClick(Sender: TObject);

begin
  If SaveDialog.Execute
    then Actions.WriteActionsToFile(SaveDialog.FileName);

end;  {SaveButtonClick}

{===================================================}
Procedure TAlterDBaseTableForm.LoadButtonClick(Sender: TObject);

var
  TempFileName : String;

begin
  If (LoadingFromFileOnStartup or
      OpenDialog.Execute)
    then
      begin
        If LoadingFromFileOnStartup
          then TempFileName := InitialLoadScript
          else TempFileName := OpenDialog.FileName;

        Actions.LoadActionsFromFile(TempFileName);

        ClearStringGrid(ActionGrid, 1);

        RefreshActionGrid;

        CurrentRow := NumEntriesInGrid(ActionGrid);

      end;  {If OpenDialog.Execute}

end;  {LoadButtonClick}

{===================================================}
Procedure TAlterDBaseTableForm.ExecuteButtonClick(Sender: TObject);

begin
  Actions.ExecuteAll(False, ResultFileName, ProgressLabel);

end;  {ExecuteButtonClick}

{===================================================}
{======== View\Edit Table Procedures   =============}
{===================================================}
Procedure TAlterDBaseTableForm.DatabaseListBoxClick(Sender: TObject);

{Get the list of tables for the database that they selected.}

begin
  Session.GetTableNames(DatabaseListBox.Items[DatabaseListBox.ItemIndex],
                        '*.*', False, False, TableListBox.Items);
end;

{=======================================================}
Procedure TAlterDBaseTableForm.DatabaseComboBoxChange(Sender: TObject);

begin
  with DatabaseComboBox do
    If ((Items.IndexOf(Text) > -1) and  {Is it a whole database name?}
        (Table.DatabaseName <> Items[ItemIndex]))  {Is it already set to this database?}
      then
        begin
          Table.Close;
          Table.Filtered := False;
          Table.IndexName := '';
          Query.DatabaseName := Items[ItemIndex];

          Session.GetTableNames(Items[ItemIndex],
                                '*.*', False, False, TableComboBox.Items);

          TableComboBox.Text := '';
          IndexComboBox.Text := '';

        end;  {If ((Items.IndexOf(Text) > -1) and ...}

end;  {DatabaseComboBoxChange}

{=====================================================}
Procedure TAlterDBaseTableForm.TableComboBoxChange(Sender: TObject);

var
  I : Integer;

begin
  with TableComboBox do
    If ((Items.IndexOf(Text) > -1) and  {Is it a whole table name?}
        ((not Table.Active) or
         (Table.TableName <> Items[ItemIndex])))  {Is it already set to this table?}
      then
        begin
          Table.Close;

          with Table do
            try
              DatabaseName := DatabaseComboBox.Items[DatabaseComboBox.ItemIndex];
              TableName := TableComboBox.Items[TableComboBox.ItemIndex];
              IndexName := '';
              Filtered := False;
              Filter := '';
              Open;
            except
              MessageDlg('Error opening table ' + TableName + ' in database ' +
                         DatabaseName + '.', mtError, [mbOK], 0);
            end;

          LastOperationEdit.Text := 'Open table ' + Table.TableName + ' in database ' +
                                    Table.DatabaseName + '.';

          If Table.Active
            then
              begin
                LastResultEdit.Text := 'Successful';

                  {Set the index to the primary key.}

                with Table do
                  For I := 0 to (IndexDefs.Count - 1) do
                    If (ixPrimary in IndexDefs[I].Options)
                      then
                        begin
                          IndexName := IndexDefs[I].Name;
                          IndexComboBox.Text := IndexName;
                        end;

              end
            else LastResultEdit.Text := 'Unsuccessful';

        end;  {If ((Items.IndexOf(Text) > -1) and ...}

end;  {TableComboBoxChange}

{=====================================================}
Procedure TAlterDBaseTableForm.IndexComboBoxChange(Sender: TObject);

var
  Successful : Boolean;

begin
  with IndexComboBox do
    If (Table.Active and
        (Items.IndexOf(Text) > -1) and  {Is it a whole index name?}
        (Table.IndexName <> Items[ItemIndex]))  {Is it already set to this index?}
      then
        begin
          Successful := True;

          with Table do
            try
              IndexName := IndexComboBox.Items[IndexComboBox.ItemIndex];
            except
              MessageDlg('Error setting index ' + IndexName + ' on table ' +
                         TableName + '.', mtError, [mbOK], 0);
              LastResultEdit.Text := 'Unsuccessful';
              Successful := False;
            end;

          LastOperationEdit.Text := 'Set index to ' + Table.IndexName +
                                    ' on table ' + Table.TableName + '.';

          If Successful
            then LastResultEdit.Text := 'Successful';

        end;  {If Table.Active}

end;  {IndexComboBoxChange}

{=====================================================}
Procedure TAlterDBaseTableForm.FindARecordClick(Sender: TObject);

var
  Successful : Boolean;
  Operation : String;

begin
  If (Trim(Table.IndexName) = '')
    then MessageDlg('Please select an index before choosing this feature.',
                    mtError, [mbOK], 0)
    else
      begin
        Successful := ExecuteRecordLookupDialog(frFindKey, Table,
                                                DataSource, Operation);

        LastOperationEdit.Text := Operation;

        If Successful
          then LastResultEdit.Text := 'Successful'
          else LastResultEdit.Text := 'Not found.';

      end;  {else of If (Trim(Table.IndexName) = '')}

end;  {FindARecordClick}

{=====================================================}
Procedure TAlterDBaseTableForm.SetRangeClick(Sender: TObject);

var
  Successful : Boolean;
  Operation : String;

begin
  If (Trim(Table.IndexName) = '')
    then MessageDlg('Please select an index before choosing this feature.',
                    mtError, [mbOK], 0)
    else
      begin
        Successful := ExecuteRecordLookupDialog(frSetRange, Table,
                                                DataSource, Operation);

        LastOperationEdit.Text := Operation;

        If Successful
          then
            begin
              LastResultEdit.Text := 'Successful';
              CancelRange.Enabled := True;
            end
          else LastResultEdit.Text := 'Not found.';

        RecordCountLabel.Visible := True;
        RecordCountLabel.Caption := 'Records = ' + IntToStr(Table.RecordCount);

      end;  {else of If (Trim(Table.IndexName) = '')}

end;  {SetRangeClick}

{=====================================================}
Procedure TAlterDBaseTableForm.CancelRangeClick(Sender: TObject);

begin
  Table.CancelRange;
  LastOperationEdit.Text := 'Cancel Range';
  LastResultEdit.Text := 'Successful.';
  CancelRange.Enabled := False;

end;  {CancelRangeClick}

{=====================================================}
Procedure TAlterDBaseTableForm.ApplyFilterClick(Sender: TObject);

var
  Successful : Boolean;
  Operation, LastResult : String;
  ConditionEntered : TStringList;

begin
  ConditionEntered := TStringList.Create;
  Table.OnFilterRecord := nil;

  Successful := ExecuteConditionalCommandDialog(frFilter, Table,
                                                Query, DataSource,
                                                Operation, LastResult,
                                                ConditionEntered);

  LastOperationEdit.Text := Operation;

  If Successful
    then
      begin
        LastResultEdit.Text := 'Successful';
        RemoveFilter.Enabled := True;
      end
    else LastResultEdit.Text := 'Unsuccessful.';

  ConditionEntered.Free;

end;  {ApplyFilterClick}

{=====================================================}
Procedure TAlterDBaseTableForm.SpecialFilterClick(Sender: TObject);

var
  Successful : Boolean;
  Operation, LastResult : String;
  ActionType : Integer;

begin
  ActionType := sfNone;
  If (TComponent(Sender).Name = 'StringStartsWith')
    then ActionType := sfStartsWith;

  If (TComponent(Sender).Name = 'StringContains')
    then ActionType := sfContains;

  If (TComponent(Sender).Name = 'StringEndsWith')
    then ActionType := sfEndsWith;

  Successful := ExecuteSpecialFilterDialog(ActionType, Table,
                                           Operation, LastResult);

  LastOperationEdit.Text := Operation;

  If Successful
    then
      begin
        LastResultEdit.Text := 'Successful';
        RemoveFilter.Enabled := True;
      end
    else LastResultEdit.Text := 'Unsuccessful.';

end;  {SpecialFilterClick}

{=====================================================}
Procedure TAlterDBaseTableForm.RemoveFilterClick(Sender: TObject);

begin
  Table.Filtered := False;
  Table.Filter := '';
  Table.OnFilterRecord := nil;
  RemoveFilter.Enabled := False;
  LastOperationEdit.Text := 'Remove Filter';
  LastResultEdit.Text := 'Successful.';

end;  {RemoveFilterClick}

{=====================================================}
Procedure TAlterDBaseTableForm.CountofRowsClick(Sender: TObject);

var
  Successful : Boolean;
  Operation, LastResult : String;
  ConditionEntered : TStringList;

begin
  ConditionEntered := TStringList.Create;
  Successful := ExecuteConditionalCommandDialog(frCount, Table,
                                                Query, DataSource,
                                                Operation, LastResult,
                                                ConditionEntered);

  LastOperationEdit.Text := Operation;

  If Successful
    then LastResultEdit.Text := LastResult
    else LastResultEdit.Text := 'Unsuccessful.';

  ConditionEntered.Free;

end;  {CountofRowsClick}

{=====================================================}
Procedure TAlterDBaseTableForm.AggregateClick(Sender: TObject);

var
  Successful : Boolean;
  Operation, LastResult : String;
  ActionType : Integer;

begin
  ActionType := frNone;
  If (TComponent(Sender).Name = 'SumaColumn')
    then ActionType := frSum;

  If (TComponent(Sender).Name = 'FindMaximum')
    then ActionType := frMaximum;

  If (TComponent(Sender).Name = 'FindMinimum')
    then ActionType := frMinimum;

  If (TComponent(Sender).Name = 'FindAverage')
    then ActionType := frAverage;

  If (TComponent(Sender).Name = 'SetFieldValue')
    then ActionType := frReplace;

  If (TComponent(Sender).Name = 'mnuitmApplyPercentagetoaNumericField')
    then ActionType := frApplyPercent;

  If (TComponent(Sender).Name = 'mnuTrimField')
    then ActionType := frTrimField;

  If (TComponent(Sender).Name = 'mnuSRAZ')
    then ActionType := frSRAZ;

  If (TComponent(Sender).Name = 'mnuUpperCase')
    then ActionType := frUpperCase;

  Successful := ExecuteAggregateDialog(ActionType, Table,
                                       Operation, LastResult);

  LastOperationEdit.Text := Operation;

  If Successful
    then LastResultEdit.Text := LastResult
    else LastResultEdit.Text := 'Unsuccessful.';

  Table.Refresh;

end;  {AggregateClick}

{=====================================================}
Procedure TAlterDBaseTableForm.SetValuefromaDifferentField1Click(Sender: TObject);

var
  Successful : Boolean;
  Operation, LastResult : String;

begin
  Table.DisableControls;
  Successful := ExecuteSetValueFromAnotherFieldDialog(Table, Operation,
                                                      LastResult);
  Table.EnableControls;

  LastOperationEdit.Text := Operation;

  If Successful
    then LastResultEdit.Text := LastResult
    else LastResultEdit.Text := 'Unsuccessful.';

end;  {SetValuefromaDifferentField1Click}

{=====================================================}
Procedure TAlterDBaseTableForm.CopyDataFromAnotherTable1Click(Sender: TObject);

var
  Successful : Boolean;
  Operation, LastResult : String;

begin
  Table.DisableControls;
  Successful := ExecuteCopyTableDataDialog(Operation, LastResult);
  Table.EnableControls;

  LastOperationEdit.Text := Operation;

  If Successful
    then LastResultEdit.Text := LastResult
    else LastResultEdit.Text := 'Unsuccessful.';

end;  {CopyDataFromAnotherTable1Click}

{=====================================================}
Procedure TAlterDBaseTableForm.ExportData1Click(Sender: TObject);

var
  Successful : Boolean;
  Operation, LastResult : String;

begin
  Table.DisableControls;
  Successful := ExecuteExportDataDialog(Table, Operation,
                                        LastResult);
  Table.EnableControls;

  LastOperationEdit.Text := Operation;

  If Successful
    then LastResultEdit.Text := LastResult
    else LastResultEdit.Text := 'Unsuccessful.';

end;  {ExportData1Click}

{=====================================================}
Procedure TAlterDBaseTableForm.ImportData1Click(Sender: TObject);

var
  Successful : Boolean;
  Operation, LastResult : String;

begin
  Table.DisableControls;
  Successful := ExecuteImportDataDialog(DatabaseComboBox.Items[DatabaseComboBox.ItemIndex],
                                        Session, Operation, LastResult);
  Table.EnableControls;

  LastOperationEdit.Text := Operation;

  If Successful
    then LastResultEdit.Text := LastResult
    else LastResultEdit.Text := 'Unsuccessful.';

end;  {ImportData1Click}

{=====================================================}
Procedure TAlterDBaseTableForm.DeleteCurrentRange1Click(Sender: TObject);

var
  NumDeleted : LongInt;

begin
  NumDeleted := 0;
  NumDeleted := NumDeleted + 1;
  RecCountLabel.Visible := True;

  If (MessageDlg('Is the range\filter set that you wish to delete?',
                 mtConfirmation, [mbYes, mbNo], 0) = idYes)
    then
      begin
        Table.DisableControls;

        repeat
          Table.First;
          NumDeleted := NumDeleted + 1;
          RecordCountLabel.Caption := 'Deleted = ' + IntToStr(NumDeleted);
          Application.ProcessMessages;

          If not Table.EOF
            then Table.Delete;

        until Table.EOF;

        Table.EnableControls;

      end;  {If (MessageDlg ...}

end;  {DeleteCurrentRange1Click}

{=====================================================}
Procedure TAlterDBaseTableForm.ExecuteSQLClick(Sender: TObject);

var
  Successful : Boolean;
  Operation, LastResult : String;
  _Action : Integer;
  ConditionEntered : TStringList;

begin
  _Action := frNone;
  ConditionEntered := TStringList.Create;

  If (TComponent(Sender).Name = 'ExecuteSQLQuery')
    then _Action := frQuery;
  If (TComponent(Sender).Name = 'ExecuteSQLModify')
    then _Action := frSQLUpdate;

  Successful := ExecuteConditionalCommandDialog(_Action, Table,
                                                Query, DataSource,
                                                Operation, LastResult,
                                                ConditionEntered);

  LastOperationEdit.Text := Operation;

  If Successful
    then LastResultEdit.Text := 'Successful'
    else LastResultEdit.Text := 'Unsuccessful.';

  ConditionEntered.Free;

end;  {ExecuteSQLClick}

{=====================================================}
Procedure TAlterDBaseTableForm.FormMouseWheelUp(    Sender: TObject;
                                                    Shift: TShiftState;
                                                    MousePos: TPoint;
                                                var Handled: Boolean);
begin
  If (Table.Active and
      (not Table.BOF))
    then Table.Prior;

end;  {FormMouseWheelUp}

{=====================================================}
Procedure TAlterDBaseTableForm.FormMouseWheelDown(    Sender: TObject;
                                                      Shift: TShiftState;
                                                      MousePos: TPoint;
                                                  var Handled: Boolean);

begin
  If (Table.Active and
      (not Table.EOF))
    then Table.Next;

end;  {FormMouseWheelDown}


{=====================================================}
Procedure TAlterDBaseTableForm.CopyRecordToCipboardClick(Sender: TObject);

var
  ClipboardFile : TextFile;
  I : Integer;
  TempFieldName : String;

begin
  ClipboardSaveDialog.FileName := 'Clipboard.clp';
  ClipboardSaveDialog.InitialDir := LastClipboardDirectory;

  If ClipboardSaveDialog.Execute
    then
      begin
        LastClipboardFileName := ClipboardSaveDialog.FileName;
        AssignFile(ClipboardFile, LastClipboardFileName);
        Rewrite(ClipboardFile);

        LastClipboardDirectory := ReturnPath(LastClipboardFileName);

        with Table do
          For I := 0 to (FieldCount - 1) do
            begin
              TempFieldName := Fields[I].FieldName;

              Writeln(ClipboardFile, TempFieldName, ':',
                                     FieldByName(TempFieldName).Text);

            end;  {For I := 0 to (FieldCount - 1) do}

        CloseFile(ClipboardFile);

      end;  {If ClipboardSaveDialog.Execute}

end;  {CopyRecordToCipboardClick}

{=====================================================}
Procedure TAlterDBaseTableForm.PasteRecordfromClipboard1Click(Sender: TObject);

var
  ClipboardFile : TextFile;
  ColonPos : Integer;
  TempFieldName, TempValue, TempStr : String;
  Done : Boolean;

begin
  ClipboardOpenDialog.FileName := LastClipboardFileName;

  If ClipboardOpenDialog.Execute
    then
      begin
        LastClipboardFileName := ClipboardOpenDialog.FileName;
        AssignFile(ClipboardFile, LastClipboardFileName);
        Reset(ClipboardFile);

        with Table do
          try
            Insert;
          except
          end;

        Done := False;

        repeat
          Readln(ClipboardFile, TempStr);

          If EOF(ClipboardFile)
            then Done := True;

          ColonPos := Pos(':', TempStr);

          TempFieldName := Copy(TempStr, 1, (ColonPos - 1));
          TempValue := Copy(TempStr, (ColonPos + 1), 255);

          try
            If (Table.FieldByName(TempFieldName).DataType <> ftAutoInc)
              then
                try
                  Table.FieldByName(TempFieldName).Text := TempValue;
                except
                  Table.FieldByName(TempFieldName).Text := '';
                end;

          except
          end;

        until Done;

        with Table do
          try
            Post;
          except
            Cancel;
          end;

        CloseFile(ClipboardFile);

      end;  {If ClipboardOpenDialog.Execute}

end;  {PasteRecordfromClipboard1Click}

{=====================================================}
Procedure TAlterDBaseTableForm.SpecifyFileNameButtonClick(Sender: TObject);

begin
  If ((ActionTypeRadioGroup.ItemIndex = acExportTable) and
       SaveFileDialog.Execute)
        then FileNameEdit.Text := SaveFileDialog.FileName;

  If ((ActionTypeRadioGroup.ItemIndex = acImportTable) and
       OpenFileDialog.Execute)
        then FileNameEdit.Text := OpenFileDialog.FileName;

end;  {SpecifyFileNameButtonClick}

{=====================================================}
Procedure TAlterDBaseTableForm.ReplaceTextInAFieldClick(Sender: TObject);

var
  Successful : Boolean;
  Operation, LastResult : String;

begin
  Table.DisableControls;
  Successful := ExecuteReplaceInFieldDialog(Table, Operation, LastResult);
  Table.EnableControls;

  LastOperationEdit.Text := Operation;

  If Successful
    then LastResultEdit.Text := LastResult
    else LastResultEdit.Text := 'Unsuccessful.';

end;  {ReplaceTextInAFieldClick}

{========================================================================}
Procedure TAlterDBaseTableForm.mnuChangeValueofFieldforallTablesClick(Sender: TObject);

var
  Successful : Boolean;
  Operation, LastResult : String;

begin
  Table.DisableControls;
  Successful := ExecuteReplaceFieldValueInTablesDialog(DatabaseComboBox.Items[DatabaseComboBox.ItemIndex],
                                                       Operation, LastResult);
  Table.EnableControls;

  LastOperationEdit.Text := Operation;

  If Successful
    then LastResultEdit.Text := LastResult
    else LastResultEdit.Text := 'Unsuccessful.';

end;  {mnuChangeValueofFieldforallTablesClick}

{=====================================================}
Procedure TAlterDBaseTableForm.CloseTableButtonClick(Sender: TObject);

begin
  try
    Table.Close;
  except
  end;

end;  {CloseTableButtonClick}

{=====================================================}
Procedure TAlterDBaseTableForm.FormClose(    Sender: TObject;
                                         var Action: TCloseAction);
begin
  If (Actions <> nil)
    then Actions.Free;

  Action := caFree;

end;  {FormClose}

end.
