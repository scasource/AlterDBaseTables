unit ConditionalCommandDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DB, WWTable, WWquery;

const
  frFilter = 3;
  frQuery = 4;
  frCount = 5;
  frSQLUpdate = 11;
  
type
  TConditionalCommandDialog = class(TForm)
    ConditionalCommandMemo: TMemo;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    PromptLabel: TLabel;
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FindRecordMethod : Integer;
    Table : TwwTable;
    Query : TwwQuery;
    TempQuery : TwwQuery;
    DataSource : TDataSource;

  end;

Function ExecuteConditionalCommandDialog(    _FindRecordMethod : Integer;
                                             _Table : TwwTable;
                                             _Query : TwwQuery;
                                             _DataSource : TDataSource;
                                         var Operation : String;
                                         var LastResult : String;
                                             ConditionEntered : TStringList) : Boolean;

var
  ConditionalCommandDialog : TConditionalCommandDialog;

implementation

{$R *.DFM}

var
  QueryNumericalResult : Double;
  TempQuery : TwwQuery;

const
  DecimalEditDisplay = '0.00';
  NoDecimalDisplay = '0.';

{===================================================}
Function ExecuteConditionalCommandDialog(    _FindRecordMethod : Integer;
                                             _Table : TwwTable;
                                             _Query : TwwQuery;
                                             _DataSource : TDataSource;
                                         var Operation : String;
                                         var LastResult : String;
                                             ConditionEntered : TStringList) : Boolean;

var
  I, ReturnResult : Integer;

begin
  try
    ConditionalCommandDialog := TConditionalCommandDialog.Create(nil);

    with ConditionalCommandDialog do
      begin
        FindRecordMethod := _FindRecordMethod;
        Table := _Table;
        Query := _Query;
        DataSource := _DataSource;
        TempQuery := TwwQuery.Create(nil);
        TempQuery.DatabaseName := Table.DatabaseName;

        case FindRecordMethod of
          frFilter :
            begin
              Caption := 'Filter';
              PromptLabel.Caption := 'Enter filter:';

            end;  {frFilter}

          frQuery :
            begin
              Caption := 'Query';
              PromptLabel.Caption := 'Query';

            end;  {frQuery}

          frSQLUpdate :
            begin
              Caption := 'SQL Update';
              PromptLabel.Caption := 'SQL Update';

            end;  {frSQLUpdate}

          frCount :
            begin
              Caption := 'Count Rows';
              PromptLabel.Caption := 'Count rows where:';
            end;

        end;  {case FindRecordMethod of}

        ReturnResult := ShowModal;

        Result := (ReturnResult = mrOK);

        ConditionEntered.Assign(ConditionalCommandMemo.Lines);

        If Result
          then
            case FindRecordMethod of
              frCount :
                begin
                  If (ConditionalCommandMemo.Lines.Count > 0)
                    then
                      begin
                        Operation := 'Count of rows where';

                        For I := 0 to (ConditionalCommandMemo.Lines.Count - 1) do
                          Operation := Operation + ' ' + ConditionalCommandMemo.Lines[I];
                      end
                    else Operation := 'Count of all rows.';

                  LastResult := FormatFloat(NoDecimalDisplay,
                                            QueryNumericalResult);
                end;  {frCount}

            end;  {case FindRecordMethod of}

        TempQuery.Free;

      end;  {with ConditionalCommandDialog do}

  finally
    ConditionalCommandDialog.Free;
  end;

end;  {ExecuteConditionalCommandDialog}

{===========================================================}
Procedure TConditionalCommandDialog.OKButtonClick(Sender: TObject);

var
  Error : Boolean;
  I : Integer;
  TempStr : String;

begin
  Error := False;

  If (FindRecordMethod = frFilter)
    then
      begin
        If (DataSource.Dataset <> Table)
          then DataSource.Dataset := Table;

        Table.Filtered := False;
        Table.Filter := ConditionalCommandMemo.Text;

        try
          Table.Filtered := True;
        except
          Error := True;
          MessageDlg('The filter you entered is not valid.' + #13 +
                     'Please re-enter.', mtError, [mbOK], 0);
        end;

        If Error
          then ModalResult := mrAbort
          else ModalResult := mrOK;

      end;  {If (FindRecordMethod = frFilter)}

  If (FindRecordMethod = frQuery)
    then
      begin
        If (DataSource.Dataset <> Query)
          then DataSource.Dataset := Query;

        Query.SQL.Assign(ConditionalCommandMemo.Lines);

        try
          Query.Prepare;
          Query.Open;
        except
          Error := True;
          MessageDlg('The query you entered is not valid.' + #13 +
                     'Please re-enter.', mtError, [mbOK], 0);

            {Reset to the full database}

          Query.SQL.Clear;
          Query.SQL.Add('SELECT * FROM ' + Table.TableName);
          Query.Open;

        end;

        If Error
          then ModalResult := mrAbort
          else ModalResult := mrOK;

      end;  {If (FindRecordMethod = frFilter)}

  If (FindRecordMethod = frSQLUpdate)
    then
      begin
        If (DataSource.Dataset <> Query)
          then DataSource.Dataset := Query;

        Query.SQL.Assign(ConditionalCommandMemo.Lines);

        try
          Query.ExecSQL;
        except
          Error := True;
          MessageDlg('The query you entered is not valid.' + #13 +
                     'Please re-enter.', mtError, [mbOK], 0);

            {Reset to the full database}

          Query.SQL.Clear;
          Query.SQL.Add('SELECT * FROM ' + Table.TableName);
          Query.Open;

        end;

        If Error
          then ModalResult := mrAbort
          else ModalResult := mrOK;

      end;  {If (FindRecordMethod = frFilter)}

  If (FindRecordMethod = frCount)
    then
      begin
        TempQuery.SQL.Clear;

        If (ConditionalCommandMemo.Lines.Count > 0)
          then TempStr := ' WHERE'
          else TempStr := '';

        TempQuery.SQL.Add('SELECT COUNT(*) FROM ' + Table.TableName + TempStr);

        For I := 0 to (ConditionalCommandMemo.Lines.Count - 1) do
          TempQuery.SQL.Add(ConditionalCommandMemo.Lines[I]);

        try
          TempQuery.Prepare;
          TempQuery.Open;
        except
          Error := True;
          MessageDlg('The query you entered is not valid.' + #13 +
                     'Please re-enter.', mtError, [mbOK], 0);

            {Reset to the full database.}

          TempQuery.SQL.Clear;
          TempQuery.SQL.Add('SELECT * FROM ' + Table.TableName);
          TempQuery.Open;

        end;

        If Error
          then ModalResult := mrAbort
          else
            begin
              QueryNumericalResult := TempQuery.FieldByName('COUNT___').AsFloat;
              ModalResult := mrOK;
            end;

      end;  {If (FindRecordMethod = frCount)}

end;  {OKButtonClick}

end.
