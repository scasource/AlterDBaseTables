unit AggregateDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DB, DBTables, Utilitys;

const
  frNone = -1;
  frMaximum = 6;
  frMinimum = 7;
  frSum = 8;
  frAverage = 9;
  frReplace = 10;
  frApplyPercent = 11;
  frTrimField = 12;
  frSRAZ = 13;
  frUpperCase = 14;

type
  TAggregateDialog = class(TForm)
    ChooseFieldLabel: TLabel;
    FieldListBox: TListBox;
    ConditionalMemoLabel: TLabel;
    ConditionalCommandMemo: TMemo;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    NewValueLabel: TLabel;
    NewValueEdit: TEdit;
    lbRoundToNearest: TLabel;
    edRoundToNearest: TEdit;
    procedure FieldListBoxClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FindRecordMethod : Integer;
    TempQuery : TQuery;
    Table : TTable;
    FieldName : String;
  end;

Function ExecuteAggregateDialog(    _FindRecordMethod : Integer;
                                    _Table : TTable;
                                var Operation : String;
                                var LastResult : String) : Boolean;

var
  AggregateDialog: TAggregateDialog;

implementation

{$R *.DFM}

var
  QueryNumericalResult : Double;

const
  DecimalEditDisplay = '0.00';

{===================================================}
Function ExecuteAggregateDialog(    _FindRecordMethod : Integer;
                                    _Table : TTable;
                                var Operation : String;
                                var LastResult : String) : Boolean;

var
  I, ReturnResult : Integer;
  TempStr : String;

begin
  try
    AggregateDialog := TAggregateDialog.Create(nil);

    with AggregateDialog do
      begin
        FindRecordMethod := _FindRecordMethod;
        TempQuery := TQuery.Create(nil);
        Table := _Table;
        TempQuery.DatabaseName := Table.DatabaseName;
        Table.GetFieldNames(FieldListBox.Items);

        case FindRecordMethod of
          frSum :
            begin
              Caption := 'Sum a field';
              ConditionalMemoLabel.Caption := 'Sum the field for rows where:';
            end;

          frMaximum :
            begin
              Caption := 'Find the maximum value for a field';
              ConditionalMemoLabel.Caption := 'Find the maximum for the field for rows where:';
            end;

          frMinimum :
            begin
              Caption := 'Find the minimum value for a field';
              ConditionalMemoLabel.Caption := 'Find the minimum for the field for rows where:';
            end;

          frAverage :
            begin
              Caption := 'Find the average value for a field';
              ConditionalMemoLabel.Caption := 'Find the average for the field for rows where:';
            end;

          frReplace:
            begin
              Caption := 'Change value of a field';
              ConditionalMemoLabel.Caption := 'Limit to rows where:';
              NewValueEdit.Visible := True;
              NewValueLabel.Visible := True;
            end;  {frReplace}

          frApplyPercent:
            begin
              Caption := 'Apply percentage';
              ConditionalMemoLabel.Caption := 'Limit to rows where:';
              NewValueEdit.Visible := True;
              NewValueLabel.Visible := True;
              NewValueLabel.Caption := 'Percentage:';
              lbRoundToNearest.Visible := True;
              edRoundToNearest.Visible := True;

            end;  {frReplace}

          frSRAZ:
            begin
              Caption := 'Shift Right Add Zeroes';
              ConditionalMemoLabel.Caption := 'Limit to rows where:';
              NewValueEdit.Visible := True;
              NewValueLabel.Visible := True;
              NewValueLabel.Caption := 'SRAZ number of spaces:';

            end;  {frSRAZ}

          frUpperCase:
            begin
              Caption := 'Upper Case';
              ConditionalMemoLabel.Caption := 'Limit to rows where:';
              NewValueEdit.Visible := False;
              NewValueLabel.Visible := False;

            end;  {frUpperCase}

        end;  {case FindRecordMethod of}

        ReturnResult := ShowModal;

        Result := (ReturnResult = mrOK);

          {Compose the last operation and the result.}

        If (FindRecordMethod = frReplace)
          then
            begin
              If (ConditionalCommandMemo.Lines.Count > 0)
                then
                  begin
                    Operation := 'Replace field ' + FieldName + ' with ' +
                                 NewValueEdit.Text + ' where';

                    For I := 0 to (ConditionalCommandMemo.Lines.Count - 1) do
                      Operation := Operation + ' ' + ConditionalCommandMemo.Lines[I];
                  end
                else Operation := 'Replace field ' + FieldName + ' with ' +
                                 NewValueEdit.Text + ' for all rows.';
            end
          else
            begin
              If (ConditionalCommandMemo.Lines.Count > 0)
                then
                  begin
                    Operation := TempStr + ' of field ' + FieldName + ' where';

                    For I := 0 to (ConditionalCommandMemo.Lines.Count - 1) do
                      Operation := Operation + ' ' + ConditionalCommandMemo.Lines[I];
                  end
                else Operation := TempStr + ' of field ' + FieldName + ' for all rows.';

             end;  {If (FindRecordMethod = frReplace)}

        If Result
          then
            If (FindRecordMethod = frReplace)
              then LastResult := 'Successful'
              else LastResult := FormatFloat(DecimalEditDisplay,
                                             QueryNumericalResult);

        TempQuery.Free;

      end;  {with ConditionalCommandDialog do}

  finally
    AggregateDialog.Free;
  end;

end;  {ExecuteAggregateDialog}

{======================================================}
Procedure TAggregateDialog.FieldListBoxClick(Sender: TObject);

begin
  FieldName := FieldListBox.Items[FieldListBox.ItemIndex];

  case FindRecordMethod of
    frSum : ConditionalMemoLabel.Caption := 'Sum the field "' + FieldName + '" for rows where:';
    frMaximum : ConditionalMemoLabel.Caption := 'Find the maximum for the field "' + FieldName + '" for rows where:';
    frMinimum : ConditionalMemoLabel.Caption := 'Find the minimum for the field "' + FieldName + '" for rows where:';
    frAverage : ConditionalMemoLabel.Caption := 'Find the average for the field "' + FieldName + '" for rows where:';

  end;  {case FindRecordMethod of}

end;  {FieldListBoxClick}

{======================================================}
Procedure TAggregateDialog.OKButtonClick(Sender: TObject);

var
  TempStr : String;
  I, iRoundToNearest, iSpaces : LongInt;
  fPercentage, fCurrentValue : Double;
  Error : Boolean;

begin
  Error := False;

  case FindRecordMethod of
    frApplyPercent :
    begin
      try
        iRoundToNearest := StrToInt(edRoundToNearest.Text);
      except
        iRoundToNearest := 1;
      end;

      try
        fPercentage := StrToFloat(NewValueEdit.Text);
      except
        fPercentage := 100;
      end;

      with Table do
      begin
        DisableControls;
        Filtered := False;
        Filter := ConditionalCommandMemo.Text;
        Filtered := True;

        First;

        while (not EOF) do
        begin
          try
            Edit;
            fCurrentValue := FieldByName(FieldName).AsFloat;
            fCurrentValue := Round(fCurrentValue * (fPercentage / 100) * (1 / iRoundToNearest)) * iRoundToNearest;

            If ((FieldByName(FieldName).DataType = ftInteger) or
                (FieldByName(FieldName).DataType = ftSmallInt))
            then FieldByName(FieldName).AsInteger := Trunc(fCurrentValue)
            else FieldByName(FieldName).AsFloat := fCurrentValue;

            Post;
          except
          end;

          First;

        end;  {while (not EOF) do}

        First;
        EnableControls;

      end;  {with Table do}

      If Error
      then ModalResult := mrAbort
      else
      begin
        QueryNumericalResult := 0;
        ModalResult := mrOK;

      end;  {else of If Error}

    end;  {frApplyPercent}

    frTrimField :
    begin
      with Table do
      begin
        DisableControls;
        Filtered := False;
        Filter := ConditionalCommandMemo.Text;
        Filtered := True;

        First;

        while (not EOF) do
        begin
          try
            Edit;

            If (FieldByName(FieldName).DataType = ftString)
            then FieldByName(FieldName).AsString := Trim(FieldByName(FieldName).AsString);

            Post;
          except
          end;

          Next;

        end;  {while (not EOF) do}

        First;
        EnableControls;

      end;  {with Table do}

    end;  {frTrimField}


    frSRAZ :
    begin
      with Table do
      begin
        DisableControls;
        Filtered := False;
        Filter := ConditionalCommandMemo.Text;
        Filtered := True;
        try
          iSpaces := StrToInt(NewValueEdit.Text);
        except
          iSpaces := 10;
        end;

        First;

        while (not EOF) do
        begin
          try
            Edit;

            If (FieldByName(FieldName).DataType = ftString)
            then FieldByName(FieldName).AsString := Trim(ShiftRightAddZeroes(FieldByName(FieldName).AsString, iSpaces));

            Post;
          except
          end;

          Next;

        end;  {while (not EOF) do}

        First;
        EnableControls;

      end;  {with Table do}

      If Error
      then ModalResult := mrAbort
      else
      begin
        QueryNumericalResult := 0;
        ModalResult := mrOK;

      end;  {else of If Error}

    end;  {frSRAZ}

    frUpperCase :
    begin
      with Table do
      begin
        DisableControls;
        Filtered := False;
        Filter := ConditionalCommandMemo.Text;
        Filtered := True;

        First;

        while (not EOF) do
        begin
          try
            Edit;

            If (FieldByName(FieldName).DataType = ftString)
            then FieldByName(FieldName).AsString := Trim(ANSIUpperCase(FieldByName(FieldName).AsString));

            Post;
          except
          end;

          Next;

        end;  {while (not EOF) do}

        First;
        EnableControls;

      end;  {with Table do}

      If Error
      then ModalResult := mrAbort
      else
      begin
        QueryNumericalResult := 0;
        ModalResult := mrOK;

      end;  {else of If Error}

    end;  {frUpperCase}

    else
    begin
      TempQuery.SQL.Clear;

      If (ConditionalCommandMemo.Lines.Count > 0)
        then TempStr := ' WHERE'
        else TempStr := '';

      case FindRecordMethod of
        frSum : TempQuery.SQL.Add('SELECT SUM(' + FieldName + ') AS AGGREGATE FROM ' + Table.TableName + TempStr);
        frAverage : TempQuery.SQL.Add('SELECT AVG(' + FieldName + ') AS AGGREGATE FROM ' + Table.TableName + TempStr);
        frMinimum : TempQuery.SQL.Add('SELECT MIN(' + FieldName + ') AS AGGREGATE FROM ' + Table.TableName + TempStr);
        frMaximum : TempQuery.SQL.Add('SELECT MAX(' + FieldName + ') AS AGGREGATE FROM ' + Table.TableName + TempStr);
        frReplace : TempQuery.SQL.Add('UPDATE ' + Table.TableName +
                                      ' SET ' + FieldName +
                                      ' = ''' + NewValueEdit.Text +
                                      ''' ' + TempStr);

      end;  {case FindRecordMethod of}

      For I := 0 to (ConditionalCommandMemo.Lines.Count - 1) do
        TempQuery.SQL.Add(ConditionalCommandMemo.Lines[I]);

      try
        TempQuery.Prepare;

        If (FindRecordMethod = frReplace)
          then TempQuery.ExecSQL
          else TempQuery.Open;
      except
        Error := True;
        MessageDlg('The condition you entered is not valid.' + #13 +
                   'Please re-enter.', mtError, [mbOK], 0);
      end;

      If Error
        then ModalResult := mrAbort
        else
          If (FindRecordMethod = frReplace)
            then ModalResult := mrOK
            else
              begin
                QueryNumericalResult := TempQuery.FieldByName('Aggregate').AsFloat;
                ModalResult := mrOK;

              end;  {else of If Error}

    end;  {else of If (FindRecordMethod = frApplyPercent)}

  end;  {case FindRecordMethod of}

end;  {OKButtonClick}

end.
