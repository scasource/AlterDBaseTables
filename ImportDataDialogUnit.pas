unit ImportDataDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DB, DBTables, ComCtrls, Excel97;


type
  TImportDataDialog = class(TForm)
    ChooseFieldLabel: TLabel;
    TableListBox: TListBox;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    ClearTableBeforeImportCheckBox: TCheckBox;
    ProgressBar: TProgressBar;
    ImportFileOpenDialog: TOpenDialog;
    Table: TTable;
    ImportMemosFromFilesCheckBox: TCheckBox;
    BreakOnErrorsCheckBox: TCheckBox;
    cb_UpdateData: TCheckBox;
    Label1: TLabel;
    ed_KeyFields: TEdit;
    cb_UpdateDataSequentially: TCheckBox;
    cb_YYYYMMDDFormat: TCheckBox;
    procedure OKButtonClick(Sender: TObject);
    procedure cb_UpdateDataClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    NumRecordsImported : LongInt;
    DatabaseName : String;
    UpdateData : Boolean;
  end;

Function ExecuteImportDataDialog(    _DatabaseName : String;
                                     Session : TSession;
                                 var Operation : String;
                                 var LastResult : String) : Boolean;

var
  ImportDataDialog: TImportDataDialog;

implementation

{$R *.DFM}

uses Utilitys, GlblCnst;

{==============================================================}
Procedure TImportDataDialog.cb_UpdateDataClick(Sender: TObject);

begin
  ed_KeyFields.Enabled := cb_UpdateData.Checked;
end;

{$H+}
{===========================================================================}
Function StripLeadingAndEndingDuplicateChar(TempStr : String;
                                            CharToStrip : Char) : String;

begin
  Result := TempStr;

  If ((Length(Result) > 1) and
      (Result[1] = CharToStrip) and
      (Result[Length(Result)] = CharToStrip))
    then
      begin
        Delete(Result, Length(Result), 1);
        Delete(Result, 1, 1);
      end;

end;  {StripLeadingAndEndingDuplicateChar}

{===========================================================================}
Procedure ParseCommaDelimitedStringIntoFields(TempStr : String;
                                              FieldList : TStringList;
                                              CapitalizeStrings : Boolean);

var
  InEmbeddedQuote : Boolean;
  CurrentField : String;
  I : Integer;

begin
  FieldList.Clear;
  InEmbeddedQuote := False;
  CurrentField := '';

  For I := 1 to Length(TempStr) do
    begin
      If (TempStr[I] = '"')
        then InEmbeddedQuote := not InEmbeddedQuote;

        {New field if we have found comma and we are not in an embedded quote.}

      If ((TempStr[I] = ',') and
          (not InEmbeddedQuote))
        then
          begin
              {If the field starts and ends with a double quote, strip it.}

            CurrentField := StripLeadingAndEndingDuplicateChar(CurrentField, '"');

            If CapitalizeStrings
              then CurrentField := ANSIUpperCase(CurrentField);

            FieldList.Add(CurrentField);
            CurrentField := '';

          end
        else CurrentField := CurrentField + TempStr[I];

    end;  {For I := 1 to Length(TempStr) do}

  CurrentField := StripLeadingAndEndingDuplicateChar(CurrentField, '"');

  If CapitalizeStrings
    then CurrentField := ANSIUpperCase(CurrentField);

  FieldList.Add(CurrentField);

end;  {ParseCommaDelimitedStringIntoFields}

{$H-}

{===============================================================}
Procedure DeleteTable(Table : TTable);

begin
  Table.First;

  while (Table.RecordCount >= 1) do
    begin
      Table.Delete;

      If not Table.EOF
        then Table.Next;

    end;

end;  {DeleteTable}

{===================================================}
Function ExecuteImportDataDialog(    _DatabaseName : String;
                                     Session : TSession;
                                 var Operation : String;
                                 var LastResult : String) : Boolean;

{$H+}

begin
  try
    ImportDataDialog := TImportDataDialog.Create(nil);

    with ImportDataDialog do
      begin
        DatabaseName := _DatabaseName;
        Session.GetTableNames(DatabaseName, '*.*', False, False, TableListBox.Items);

        Result := (ShowModal = mrOK);

          {Compose the last operation and the result.}

        Operation := 'Import Data.';
        LastResult := IntToStr(NumRecordsImported) + ' records imported to ' + Table.TableName + '.';

      end;  {with ConditionalCommandDialog do}

  finally
    ImportDataDialog.Free;
  end;

{$H-}
end;  {ExecuteImportDataDialog}

{============================================================================}
Function MakeYYYYMMDDSlashed(sDate : String) : String;

{This takes a date in the form YYYYMMDD and returns a date in the form
 MM/DD/YYYY.}

Begin
  If (Trim(sDate) <> '')
    then Result := Copy(sDate, 5, 2) + '/' +
                   Copy(sDate, 7, 2) + '/' +
                   Copy(sDate, 1, 4);

end;  {MakeYYYYMMDDSlashed}

{======================================================}
Procedure TImportDataDialog.OKButtonClick(Sender: TObject);

{$H+}
var
  ImportLine, FieldValue,
  FilterString, ErrorMessage, KeyFields : String;
  I, J, FieldNumber, TotalRecords : LongInt;
  Done, Quit, UpdateDataSequentially,
  ImportMemosFromFiles, BreakOnErrors, bYYYYMMDDFormat : Boolean;
  KeyFieldsList, FieldValuesList,
  FieldNameList, ErrorMessageList : TStringList;
  ImportFile : TextFile;

begin
  BreakOnErrors := BreakOnErrorsCheckBox.Checked;
  UpdateData := cb_UpdateData.Checked;
  UpdateDataSequentially := cb_UpdateDataSequentially.Checked;
  bYYYYMMDDFormat := cb_YYYYMMDDFormat.Checked;
  KeyFields := ed_KeyFields.Text;
  KeyFieldsList := TStringList.Create;
  ParseCommaDelimitedStringIntoFields(KeyFields, KeyFieldsList, True);

  Quit := False;
  ImportMemosFromFiles := ImportMemosFromFilesCheckBox.Checked;

  MessageDlg('The import file must be comma delimited.' + #13 +
             'The first line must be the field names (comma delimited, in any order).',
             mtInformation, [mbOK], 0);

  If ImportFileOpenDialog.Execute
    then
      begin
        Quit := False;
        NumRecordsImported := 1;
        FieldNameList := TStringList.Create;
        FieldValuesList := TStringList.Create;
        ErrorMessageList := TStringList.Create;

        Table.DatabaseName := DatabaseName;

        try
          Table.TableName := TableListBox.Items[TableListBox.ItemIndex];
          Table.Open;
          Table.FieldDefs.Update;

          try
            If ClearTableBeforeImportCheckBox.Checked
              then Table.EmptyTable;
          except
            DeleteTable(Table);
          end;

        except
          MessageDlg('Error opening table ' + Table.TableName + '.',
                     mtError, [mbOK], 0);
          Quit := True;
        end;

        If not Quit
          then
            begin
              AssignFile(ImportFile, ImportFileOpenDialog.FileName);
              Reset(ImportFile);

              TotalRecords := 0;

              repeat
                Readln(ImportFile, ImportLine);
                TotalRecords := TotalRecords + 1;
              until EOF(ImportFile);

              ProgressBar.Max := TotalRecords;
              Reset(ImportFile);

              try
                Readln(ImportFile, ImportLine);
                ParseCommaDelimitedStringIntoFields(ImportLine, FieldNameList, False);
              except
                Quit := True;
                MessageDlg('The first line is not a valid line of field name headers.',
                           mtError, [mbOK], 0);
              end;

            end;  {If not Quit}

        If not Quit
          then
            repeat
              Readln(ImportFile, ImportLine);
              ParseCommaDelimitedStringIntoFields(ImportLine, FieldValuesList, False);

              NumRecordsImported := NumRecordsImported + 1;
              ProgressBar.Position := NumRecordsImported;
              Application.ProcessMessages;

              with Table do
                try
                  If UpdateData
                    then
                      begin
                        FilterString := '';

                        For I := 0 to (KeyFieldsList.Count - 1) do
                          For J := 0 to (FieldNameList.Count - 1) do
                            If _Compare(KeyFieldsList[I], FieldNameList[J], coEqual)
                              then
                                begin
                                  If _Compare(FilterString, coNotBlank)
                                    then FilterString := FilterString + ' and ';

                                  FilterString := FilterString + '(' +
                                                  KeyFieldsList[I] + '=' +
                                                  FormatFilterString(FieldValuesList[J]) + ')';

                                end;  {If _Compare(KeyFieldsList[I],}

                        Filtered := False;
                        Filter := FilterString;
                        Filtered := True;
                        Edit;
                      end
                    else
                      If UpdateDataSequentially
                        then Edit
                        else Append;

                  FieldNumber := 0;

                  while ((FieldNumber <= (FieldNameList.Count - 1)) and
                         (not Quit)) do
                    begin
                      try
                        If (FieldNumber <= (FieldValuesList.Count - 1))
                          then FieldValue := FieldValuesList[FieldNumber]
                          else FieldValue := '';

                        If (FieldByName(FieldNameList[FieldNumber]).DataType <> ftAutoInc)
                          then
                            If (ImportMemosFromFiles and
                                (FieldByName(FieldNameList[FieldNumber]).DataType = ftMemo) and
                                (Trim(FieldValue) <> ''))
                              then TMemoField(FieldByName(FieldNameList[FieldNumber])).LoadFromFile(FieldValue)
                              else
                                begin
(*                                  If (((FieldByName(FieldNameList[FieldNumber]).DataType = ftDateTime) or
                                       (FieldByName(FieldNameList[FieldNumber]).DataType = ftDate)) and
                                      bYYYYMMDDFormat) *)
                                  If ((Pos('Date', FieldNameList[FieldNumber]) > 0) and
                                      bYYYYMMDDFormat)
                                    then FieldByName(FieldNameList[FieldNumber]).AsString := MakeYYYYMMDDSlashed(FieldValue)
                                    else FieldByName(FieldNameList[FieldNumber]).AsString := FieldValue;

                                end;
                      except
                        ErrorMessage := 'Unable to convert field on line ' + IntToStr(NumRecordsImported) + ' - ' +
                                        'Field: ' + FieldNameList[FieldNumber] + '  Field Value: ' + FieldValuesList[FieldNumber];

                        If BreakOnErrors
                          then Quit := (MessageDlg(ErrorMessage + #13 +
                                                   'Do you want to continue the import?',
                                                   mtError, [mbYes, mbNo], 0) = idNo);

                        ErrorMessageList.Add(ErrorMessage);

                      end;

                      Inc(FieldNumber);

                    end;  {while ((FieldNumber <= (FieldNameList.Count - 1) ...}

                  If Quit
                    then Cancel
                    else
                      begin
                        Post;

                        If UpdateDataSequentially
                          then Next;

                      end;  {else of If Quit}

                except
                  on E: Exception do
                    begin
                      Cancel;
                      If BreakOnErrors
                        then Quit := (MessageDlg('The following error occurred on line ' + IntToStr(NumRecordsImported) + ': ' + #13 +
                                                 E.Message + #13 +
                                                 'Do you want to continue the import?',
                                                 mtError, [mbYes, mbNo], 0) = idNo);

                    end;  {on E: Exception do}

                end;

              Done := EOF(ImportFile);

            until (Done or Quit);

        CloseFile(ImportFile);

        try
          ErrorMessageList.SaveToFile('c:\importerrors.txt');
          WinExec('c:\importerrors.txt', SW_SHOW);
        except
        end;

        FieldNameList.Free;
        FieldValuesList.Free;
        ErrorMessageList.Free;

      end;  {If ImportFileOpenDialog.Execute}

  KeyFieldsList.Free;

  If not Quit
    then ModalResult := mrAbort
    else ModalResult := mrOK;
 {$H-}
 
end;  {OKButtonClick}


end.
