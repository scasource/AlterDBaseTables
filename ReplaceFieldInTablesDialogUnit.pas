unit ReplaceFieldInTablesDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DB, DBTables, ComCtrls;

type
  TReplaceFieldInTablesDialog = class(TForm)
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    NewValueLabel: TLabel;
    Label1: TLabel;
    ProgressBar: TProgressBar;
    ChooseFieldLabel: TLabel;
    lbxTables: TListBox;
    lbTableName: TLabel;
    edCurrentValue: TEdit;
    edFieldName: TEdit;
    tbTemp: TTable;
    Label2: TLabel;
    edNewValue: TEdit;
    lbNumberChanged: TLabel;
    cbAllowPartialMatch: TCheckBox;
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sDatabaseName, sFieldName, sCurrentValue, sNewValue : String;
    iNumberOfFieldsReplaced : LongInt;
  end;

Function ExecuteReplaceFieldValueInTablesDialog(    _DatabaseName : String;
                                                var Operation : String;
                                                var LastResult : String) : Boolean;

var
  ReplaceFieldInTablesDialog: TReplaceFieldInTablesDialog;

implementation

{$R *.DFM}

{===================================================}
Function ExecuteReplaceFieldValueInTablesDialog(    _DatabaseName : String;
                                                var Operation : String;
                                                var LastResult : String) : Boolean;

var
  ReturnResult : Integer;

begin
  try
    ReplaceFieldInTablesDialog := TReplaceFieldInTablesDialog.Create(nil);

    with ReplaceFieldInTablesDialog do
      begin
        sDatabaseName := _DatabaseName;
        Session.GetTableNames(sDatabaseName, '*.*', False, False, lbxTables.Items);

        ReturnResult := ShowModal;

        Result := (ReturnResult = mrOK);

          {Compose the last operation and the result.}

        Operation := 'Replace field ' + sFieldName + ' with ' + sNewValue + ' in tables ' +
                     'where current value = ' + sCurrentValue + '.';

        If Result
          then LastResult := IntToStr(iNumberOfFieldsReplaced) + ' fields replaced.';

      end;  {with ConditionalCommandDialog do}

  finally
    ReplaceFieldInTablesDialog.Free;
  end;

end;  {ExecuteReplaceInFieldDialog}

{======================================================}
Procedure TReplaceFieldInTablesDialog.OKButtonClick(Sender: TObject);

var
  Error : Boolean;
  slSelectedTables : TStringList;
  I, X, iCurValDl,
  iCurValEnd, iOldValEnd : Integer;
  sCurVal, sOldVal : String;

begin
  Error := False;
  slSelectedTables := TStringList.Create;
  sFieldName := edFieldName.Text;
  sCurrentValue := edCurrentValue.Text;
  sNewValue := edNewValue.Text;
  iNumberOfFieldsReplaced := 0;

  with lbxTables do
    For I := 0 to (Items.Count - 1) do
      If Selected[I]
      then slSelectedTables.Add(Items[I]);

  For I := 0 to (slSelectedTables.Count - 1) do
  begin
    with tbTemp do
    begin
      Close;
      TableName := slSelectedTables[I];
      DatabaseName := sDatabaseName;
      Open;

      ProgressBar.Position := 0;
      ProgressBar.Max := RecordCount;
      lbTableName.Caption := 'Table = ' + slSelectedTables[I];
      Application.ProcessMessages;

      If (FindField(sFieldName) <> nil)
      then
        begin
          First;

          while not EOF do
          begin
            If (Trim(FieldByName(sFieldName).AsString) = Trim(sCurrentValue))
            then
              begin
                try
                  Edit;
                  FieldByName(sFieldName).AsString := sNewValue;
                  Post;
                except
                  Error := True;
                end;

                inc(iNumberOfFieldsReplaced);

              end;  {If (FieldByName(sFieldName).AsString = sCurrentValue)}

            ProgressBar.StepIt;
            lbNumberChanged.Caption := '# Changed = ' + IntToStr(iNumberOfFieldsReplaced);
            Application.ProcessMessages;
            Next;

          end;  {while not EOF do}

        end;  {If (FindField(sFieldName) <> nil)}

        {CHG2242014(MPT): Allow for searching based on partial match. Currently works in the pattern [sCurrentValue*]}
      If cbAllowPartialMatch.Checked
        then
          begin
            First;

            while not EOF do
              begin
                sCurVal := FieldByName(sFieldName).AsString;
                iCurValEnd := Length(sNewValue) + 1;
                iCurValDl := Length(sCurVal) - iCurValEnd + 1;
                System.Delete(sCurVal,iCurValEnd,iCurValDl); //Check sCurrentValue against the first Length(sCurrentValue) chars in the searched field.
                if (Trim(sCurVal) = Trim(sCurrentValue))
                  then
                    begin
                      try
                        sOldVal := FieldByName(sFieldName).AsString;
                        iOldValEnd := Length(sNewValue);
                        System.Delete(sOldVal,1,iOldValEnd);
                        sOldVal := sNewValue + sOldVal;
                        Edit;
                        FieldByName(sFieldName).AsString := sOldVal;
                        Post;
                      except
                        Error := True;
                      end; //Modify the table with new value.

                      inc(iNumberOfFieldsReplaced);
                    end; //If search input matches partial key.

                ProgressBar.StepIt;
                lbNumberChanged.Caption := '# Changed = ' + IntToStr(iNumberOfFieldsReplaced);
                Application.ProcessMessages;
                Next;
                
              end; //While there are still records to process.
          end; //If user has specified partial search via checkbox.
    end;  {with _Table do}

  end;  {For I := 0 to (slSelectedTables.Count - 1) do}

  If Error
    then ModalResult := mrAbort
    else ModalResult := mrOK;

  slSelectedTables.Free;

end;  {OKButtonClick}

end.
