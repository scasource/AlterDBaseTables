unit FindRecordsDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, DBTables;

const
  frFindKey = 0;
  frSetRange = 1;

type
  TFindRecordsDialog = class(TForm)
    FindRecordMethodRadioGroup: TRadioGroup;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    StartRangeGroupBox: TGroupBox;
    StartRangeEdit1: TEdit;
    StartRangeEdit2: TEdit;
    StartRangeEdit3: TEdit;
    StartRangeEdit4: TEdit;
    StartRangeEdit5: TEdit;
    StartRangeEdit6: TEdit;
    StartRangeLabel1: TLabel;
    StartRangeLabel2: TLabel;
    StartRangeLabel3: TLabel;
    StartRangeLabel4: TLabel;
    StartRangeLabel5: TLabel;
    StartRangeLabel6: TLabel;
    EndRangeGroupBox: TGroupBox;
    EndRangeLabel1: TLabel;
    EndRangeLabel2: TLabel;
    EndRangeLabel3: TLabel;
    EndRangeLabel4: TLabel;
    EndRangeLabel5: TLabel;
    EndRangeLabel6: TLabel;
    EndRangeEdit1: TEdit;
    EndRangeEdit2: TEdit;
    EndRangeEdit3: TEdit;
    EndRangeEdit4: TEdit;
    EndRangeEdit5: TEdit;
    EndRangeEdit6: TEdit;
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FindRecordMethod : Integer;
    Table : TTable;
    DataSource : TDataSource;

  end;

Function ExecuteRecordLookupDialog(    _FindRecordMethod : Integer;
                                       _Table : TTable;
                                       _DataSource : TDataSource;
                                   var Operation : String) : Boolean;
  
var
  FindRecordsDialog: TFindRecordsDialog;

implementation

{$R *.DFM}

{===================================================}
Function ExecuteRecordLookupDialog(    _FindRecordMethod : Integer;
                                       _Table : TTable;
                                       _DataSource : TDataSource;
                                   var Operation : String) : Boolean;

var
  TempFieldName, TempLabelName,
  TempEditName, IndexExpression : String;
  I, FieldNo, PlusPos,
  ReturnResult, IndexPosition : Integer;

begin
  try
    FindRecordsDialog := TFindRecordsDialog.Create(nil);

    with FindRecordsDialog do
      begin
        FindRecordMethod := _FindRecordMethod;
        Table := _Table;
        DataSource := _DataSource;

          {Clear the edit boxes from last time.}

        For I := 1 to 6 do
          begin
            TempEditName := 'StartRangeEdit' + IntToStr(I);
            TEdit(FindComponent(TempEditName)).Text := '';

            TempEditName := 'EndRangeEdit' + IntToStr(I);
            TEdit(FindComponent(TempEditName)).Text := '';

          end;  {For I := 1 to 6 do}

          {Figure out the field names.}

        IndexPosition := Table.IndexDefs.IndexOf(Table.IndexName);

(*        FieldNo := 1;
        Table.IndexDefs.Update;

        with Table do
          For I := 0 to (IndexFieldCount - 1) do
            begin
              TempFieldName := IndexFields[I].FieldName;

              TempLabelName := 'StartRangeLabel' + IntToStr(FieldNo);
              TLabel(FindComponent(TempLabelName)).Caption := TempFieldName;

              TempLabelName := 'EndRangeLabel' + IntToStr(FieldNo);
              TLabel(FindComponent(TempLabelName)).Caption := TempFieldName;

              FieldNo := FieldNo + 1;

            end;  {For I := 0 to (IndexFieldCount - 1) do} *)

        IndexExpression := Table.IndexDefs[IndexPosition].FieldExpression;

          {Strip out the ')', 'DTOS(', 'STR('.}

        IndexExpression := StringReplace(IndexExpression, ')', '', [rfReplaceAll, rfIgnoreCase]);
        IndexExpression := StringReplace(IndexExpression, 'DTOS(', '', [rfReplaceAll, rfIgnoreCase]);
        IndexExpression := StringReplace(IndexExpression, 'TTOS(', '', [rfReplaceAll, rfIgnoreCase]);
        IndexExpression := StringReplace(IndexExpression, 'STR(', '', [rfReplaceAll, rfIgnoreCase]);
        IndexExpression := StringReplace(IndexExpression, ':', '', [rfReplaceAll, rfIgnoreCase]);

        FieldNo := 1;

        repeat
          PlusPos := Pos('+', IndexExpression);

          If (PlusPos > 0)
            then TempFieldName := Copy(IndexExpression, 1, (PlusPos - 1))
            else TempFieldName := IndexExpression;

          TempLabelName := 'StartRangeLabel' + IntToStr(FieldNo);
          TLabel(FindComponent(TempLabelName)).Caption := TempFieldName;

          TempLabelName := 'EndRangeLabel' + IntToStr(FieldNo);
          TLabel(FindComponent(TempLabelName)).Caption := TempFieldName;

          If (PlusPos > 0)
            then Delete(IndexExpression, 1, PlusPos)
            else IndexExpression := '';

          FieldNo := FieldNo + 1;

        until ((FieldNo > 6) or (IndexExpression = ''));

          {Blank out the rest of the labels and make the
           corresponding edits blank.}

        For I := FieldNo to 6 do
          begin
            TempLabelName := 'StartRangeLabel' + IntToStr(I);
            TLabel(FindComponent(TempLabelName)).Caption := '';

            TempLabelName := 'EndRangeLabel' + IntToStr(I);
            TLabel(FindComponent(TempLabelName)).Caption := '';

            TempEditName := 'StartRangeEdit' + IntToStr(I);
            TEdit(FindComponent(TempEditName)).Visible := False;

            TempEditName := 'EndRangeEdit' + IntToStr(I);
            TEdit(FindComponent(TempEditName)).Visible := False;

          end;  {For I := FieldNo to 6 do}

        case FindRecordMethod of
          frFindKey :
            begin
              EndRangeGroupBox.Visible := False;
              FindRecordMethodRadioGroup.Visible := True;
              StartRangeGroupBox.Caption := ' Fields to Find: ';

            end;  {frFindKey}

          frSetRange :
            begin
              EndRangeGroupBox.Visible := True;
              FindRecordMethodRadioGroup.Visible := False;
              StartRangeGroupBox.Caption := ' Start Range: ';
              EndRangeGroupBox.Caption := ' End Range: ';

            end;  {frSetRange}

        end;  {case FindRecordMethod of}

        ReturnResult := ShowModal;

        Result := (ReturnResult = mrOK);

      end;  {with FindRecordsDialog do}

  finally
    FindRecordsDialog.Free;
  end;

end;  {ExecuteRecordLookupDialog}

{===================================================}
Procedure SetRangeDBase(      Table : TTable;
                        const _Fields : Array of String;
                        const StartRange : Array of String;
                        const EndRange : Array of String);

var
  I, NumValidFields : Integer;
  TempStr : String;
  FieldType : TFieldType;

begin
  with Table do
    begin
      SetRangeStart;

      NumValidFields := 0;
      For I := 0 to High(_Fields) do
        If (_Fields[I] <> '')
          then NumValidFields := NumValidFields + 1;

      For I := 0 to (NumValidFields - 1) do
        begin
          FieldType := FieldByName(_Fields[I]).DataType;

          If ((Trim(StartRange[I]) = '') and
              (not (FieldType in [ftDate, ftTime, ftBoolean])))
            then TempStr := ''
            else TempStr := StartRange[I];

          If (Trim(TempStr) <> '')
            then FieldByName(_Fields[I]).Text := TempStr;

        end;  {For I := 0 to High(_Fields) do}

      SetRangeEnd;

      For I := 0 to (NumValidFields - 1) do
        FieldByName(_Fields[I]).Text := EndRange[I];

      ApplyRange;

    end;  {with Table do}
 
end;  {SetRangeOld}

{===================================================}
Function FindKeyDBase(      Table : TTable;
                      const _Fields : Array of String;
                      const Values : Array of String) : Boolean;

var
  I, NumValidFields : Integer;

begin
  with Table do
    begin
      SetKey;

      NumValidFields := 0;
      For I := 0 to High(_Fields) do
        If (_Fields[I] <> '')
          then NumValidFields := NumValidFields + 1;

      For I := 0 to (NumValidFields - 1) do
        FieldByName(_Fields[I]).Text := Values[I];

      Result := GotoKey;

    end;  {with Table do}

end;  {FindKeyDBase}

{===================================================}
Procedure FindNearestDBase(      Table : TTable;
                           const _Fields : Array of String;
                           const Values : Array of String);

var
  I, NumValidFields : Integer;

begin
  with Table do
    begin
      SetKey;

      NumValidFields := 0;
      For I := 0 to High(_Fields) do
        If (_Fields[I] <> '')
          then NumValidFields := NumValidFields + 1;

      For I := 0 to (NumValidFields - 1) do
        FieldByName(_Fields[I]).Text := Values[I];

      GotoNearest;

    end;  {with Table do}

end;  {FindNearestDBase}

{=========================================================}
Procedure TFindRecordsDialog.OKButtonClick(Sender: TObject);

var
  _Found : Boolean;

begin
  If (DataSource.Dataset <> Table)
    then DataSource.Dataset := Table;

  If (FindRecordMethod = frFindKey)
    then
      begin
        If (FindRecordMethodRadioGroup.ItemIndex = 0)
          then
            begin
              FindNearestDBase(Table,
                               [StartRangeLabel1.Caption, StartRangeLabel2.Caption,
                                StartRangeLabel3.Caption, StartRangeLabel4.Caption,
                                StartRangeLabel5.Caption, StartRangeLabel6.Caption],
                               [StartRangeEdit1.Text, StartRangeEdit2.Text,
                                StartRangeEdit3.Text, StartRangeEdit4.Text,
                                StartRangeEdit5.Text, StartRangeEdit6.Text]);

              If Table.EOF
                then ModalResult := mrAbort
                else ModalResult := mrOK;

            end  {FindNearest}
          else
            begin
              _Found := FindKeyDBase(Table,
                                     [StartRangeLabel1.Caption, StartRangeLabel2.Caption,
                                      StartRangeLabel3.Caption, StartRangeLabel4.Caption,
                                      StartRangeLabel5.Caption, StartRangeLabel6.Caption],
                                     [StartRangeEdit1.Text, StartRangeEdit2.Text,
                                      StartRangeEdit3.Text, StartRangeEdit4.Text,
                                      StartRangeEdit5.Text, StartRangeEdit6.Text]);

              If _Found
                then ModalResult := mrOK
                else ModalResult := mrAbort;

            end;  {FindKey}

      end;  {If (FindRecordType = frFindKey)}

  If (FindRecordMethod = frSetRange)
    then
      begin
          {If they do not fill in an end range, use the start range.}

        Table.CancelRange;

        If (EndRangeEdit1.Text = '')
          then SetRangeDBase(Table,
                             [StartRangeLabel1.Caption, StartRangeLabel2.Caption,
                              StartRangeLabel3.Caption, StartRangeLabel4.Caption,
                              StartRangeLabel5.Caption, StartRangeLabel6.Caption],
                             [StartRangeEdit1.Text, StartRangeEdit2.Text,
                              StartRangeEdit3.Text, StartRangeEdit4.Text,
                              StartRangeEdit5.Text, StartRangeEdit6.Text],
                             [StartRangeEdit1.Text, StartRangeEdit2.Text,
                              StartRangeEdit3.Text, StartRangeEdit4.Text,
                              StartRangeEdit5.Text, StartRangeEdit6.Text])
          else SetRangeDBase(Table,
                             [StartRangeLabel1.Caption, StartRangeLabel2.Caption,
                              StartRangeLabel3.Caption, StartRangeLabel4.Caption,
                              StartRangeLabel5.Caption, StartRangeLabel6.Caption],
                             [StartRangeEdit1.Text, StartRangeEdit2.Text,
                              StartRangeEdit3.Text, StartRangeEdit4.Text,
                              StartRangeEdit5.Text, StartRangeEdit6.Text],
                             [EndRangeEdit1.Text, EndRangeEdit2.Text,
                              EndRangeEdit3.Text, EndRangeEdit4.Text,
                              EndRangeEdit5.Text, EndRangeEdit6.Text]);

        If Table.EOF
          then ModalResult := mrAbort
          else ModalResult := mrOK;

      end;  {If (FindRecordType = frSetRange)}

end;  {OKButtonClick}

end.
