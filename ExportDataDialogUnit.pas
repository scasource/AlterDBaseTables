unit ExportDataDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DB, DBTables, ComCtrls, Excel97;


type
  NameAddrArray = Array[1..6] of ShortString;

  TExportDataDialog = class(TForm)
    ChooseFieldLabel: TLabel;
    FieldListBox: TListBox;
    ConditionalMemoLabel: TLabel;
    ConditionalCommandMemo: TMemo;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    SaveDialog: TSaveDialog;
    FirstLineIsHeadersCheckBox: TCheckBox;
    ProgressBar: TProgressBar;
    ExtractToExcelCheckBox: TCheckBox;
    ExportMemosAsFilesCheckBox: TCheckBox;
    cb_ExtractMailingAddress: TCheckBox;
    cbCombineYears: TCheckBox;
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    TempQuery : TQuery;
    Table : TTable;
    NumRecordsExported : LongInt;
    FileName : String;
    bCombineYears : Boolean;

    Procedure ExtractOneTable(    _TableName : String;
                                  FileName : String;
                                  ExtractMemosAsFiles : Boolean;
                                  ExtractMailingAddress : Boolean;
                                  FirstLineIsHeaders : Boolean;
                                  bCreateNewFile : Boolean;
                              var MemoNumber : Integer);

  end;

Function ExecuteExportDataDialog(    _Table : TTable;
                                 var Operation : String;
                                 var LastResult : String) : Boolean;

var
  ExportDataDialog: TExportDataDialog;

implementation

{$R *.DFM}

{==================================================================}
Function FormatExtractField(TempStr : String) : String;

begin
    {If there is an embedded quote, surrond the field in double quotes.}

  If (Pos(',', TempStr) > 0)
    then TempStr := '"' + TempStr + '"';

  Result := ',' + TempStr;

end;  {FormatExtractField}

{==================================================================}
Procedure WriteCommaDelimitedLine(var ExtractFile : TextFile;
                                      Fields : Array of const);

const
  BoolChars : Array[Boolean] of Char = ('F', 'T');

var
  I : Integer;
  TempStr : String;

begin
  For I := 0 to High(Fields) do
    begin
      TempStr := '';

      with Fields[I] do
        case VType of
          vtInteger    : TempStr := IntToStr(VInteger);
          vtBoolean    : TempStr := BoolChars[VBoolean];
          vtChar       : TempStr := VChar;
          vtExtended   : TempStr := FloatToStr(VExtended^);
          vtString     : TempStr := VString^;
          vtPChar      : TempStr := VPChar;
          vtObject     : TempStr := VObject.ClassName;
          vtClass      : TempStr := VClass.ClassName;
          //vtAnsiString : TempStr := string(VANSIString);
          vtCurrency   : TempStr := CurrToStr(VCurrency^);
          vtVariant    : TempStr := string(VVariant^);
          vtInt64      : TempStr := IntToStr(VInt64^);

        end;  {case VType of}

      If (I = 0)
        then Write(ExtractFile, TempStr)
        else Write(ExtractFile, FormatExtractField(TempStr));

    end;  {For I := 0 to High(Fields) do}

end;  {WriteCommaDelimitedLine}

{==================================================================}
Procedure WritelnCommaDelimitedLine(var ExtractFile : TextFile;
                                      Fields : Array of const);

begin
  WriteCommaDelimitedLine(ExtractFile, Fields);
  Writeln(ExtractFile);

end;  {WritelnCommaDelimitedLine}

{===========================================================================}
Procedure SendTextFileToExcelSpreadsheet(FileName : String;
                                         MakeVisible : Boolean;
                                         AutomaticallySaveFile : Boolean;
                                         AutomaticSaveFileName : String);

var
  TempFile : TextFile;
  Continue : Boolean;
  ExcelApplication: TExcelApplication;
  Wbk : _Workbook;
  lcID : Integer;  {Reference ID number for created Excel worksheet.}
  TempFileName : OLEVariant;

begin
  Continue := True;
  TempFileName := FileName;

  try
    AssignFile(TempFile, FileName);
    Reset(TempFile);
  except
    Continue := False;
    MessageDlg('Error opening file ' + FileName + '.' + #13 +
               'The file can not be brought into Excel.',
               mtError, [mbOK], 0);
  end;

  If Continue
    then
      try
        CloseFile(TempFile);
        ExcelApplication := TExcelApplication.Create(nil);
        lcID := GetUserDefaultLCID;
        Wbk := ExcelApplication.Workbooks.Open(TempFileName,
                                               0,  {Don't update links}
                                               False,  {Not read only}
                                               2,  {Comma delimited}
                                               EmptyParam,  {Password}
                                               EmptyParam, {Write pswd}
                                               True,  {Ignore read only msgs}
                                               EmptyParam, {Origin}
                                               EmptyParam, {Delimiter}
                                               EmptyParam, {Editable}
                                               EmptyParam, {Notify}
                                               EmptyParam, {Converter}
                                               True, {AddToMru}
                                               lcID);

        If MakeVisible
          then
            begin
              Wbk.Activate(lcID);
              ExcelApplication.Visible[lcID] := True;
            end;

        If AutomaticallySaveFile
          then
            begin
              TempFileName := AutomaticSaveFileName;
              Wbk.SaveAs(TempFileName, xlWorkbookNormal,
                         EmptyParam, EmptyParam,
                         EmptyParam, EmptyParam,
                         xlNoChange, EmptyParam, EmptyParam,
                         EmptyParam, EmptyParam, lcid);

              If not MakeVisible
                then Wbk.Close(False, EmptyParam, EmptyParam, lcID);

            end;  {If AutomaticallySaveFile}

      finally
        ExcelApplication.Disconnect;
        ExcelApplication.Free;
      end;

end;  {SendTextFileToExcelSpreadsheet}

{===================================================}
Function ExecuteExportDataDialog(    _Table : TTable;
                                 var Operation : String;
                                 var LastResult : String) : Boolean;

var
  ReturnResult : Integer;

begin
  try
    ExportDataDialog := TExportDataDialog.Create(nil);

    with ExportDataDialog do
      begin
        TempQuery := TQuery.Create(nil);
        Table := _Table;
        TempQuery.DatabaseName := Table.DatabaseName;
        Table.GetFieldNames(FieldListBox.Items);

        ReturnResult := ShowModal;

        Result := (ReturnResult = mrOK);

          {Compose the last operation and the result.}

        Operation := 'Export Data.';
        LastResult := IntToStr(NumRecordsExported) + ' records exported to ' + FileName + '.';

        TempQuery.Free;

      end;  {with ConditionalCommandDialog do}

  finally
    ExportDataDialog.Free;
  end;

end;  {ExecuteExportDataDialog}

{======================================================}
Function FormatFieldForExtract(TempStr : String;
                               FieldNumber : Integer) : String;

begin
  Result := TempStr;

(*  If (Pos(',', TempStr) > 0)
    then Result := '"' + Result + '"'; *)

  If (FieldNumber > 0)
    then Result := '|' + Result;

end;  {FormatFieldForExtract}

{=================================================================}
Function DeBlank(s: String): String;

begin
  repeat
   delete(s,pos(' ',s),1)
  until (0 = pos(' ',s));
  deblank:=s;
end;  {of DeBlank}

{=====================================================================}
Procedure FillInNameAddrArray(    Name1,
                                  Name2,
                                  Address1,
                                  Address2,
                                  Street,
                                  City : String;
                                  State : String;
                                  Zip : String;
                                  ZipPlus4 : String;
                                  IncludeZipPlus4 : Boolean;
                              var NAddrArray : NameAddrArray);

{FXX05191998-5: Make the name address routine common for letters.}

var
  I : Integer;
  TempStr, FullZipCode : String;
  AddComma, IncludeZipOnCityStateLine : Boolean;

begin
  For I := 1 to 6 do
    NAddrArray[I] := '';

  I := 1;

  If (Deblank(Name1) <> '')
    then
      begin
        NAddrArray[I] := Name1;
        I := I + 1;
      end;

  If (Deblank(Name2) <> '')
    then
      begin
        NAddrArray[I] := Name2;
        I := I + 1;
      end;

   If (Deblank(Address1) <> '')
     then
       begin
         NAddrArray[I] := Address1;
         I := I + 1;
       end;

   If (Deblank(Address2) <> '')
     then
       begin
         NAddrArray[I] := Address2;
         I := I + 1;
       end;

   If (Deblank(Street) <> '')
     then
       begin
         NAddrArray[I] := Street;
         I := I + 1;
       end;

     {FXX05191998-4: Don't print the comma between city and state if city
                     is blank or the dash between zip and plus 4 if the
                     zip or plus 4 is blank.}

   If (Deblank(City) <> '')
     then
       begin
         TempStr := Trim(City);

           {FXX08182003-1(2.07h): If there is a comma at the end of the city, don't add another one.}

         AddComma := not (City[Length(City)] = ',');

         If (Deblank(State) <> '')
           then
             begin
               If AddComma
                 then TempStr := TempStr + ',';

                TempStr := TempStr + ' ' + Trim(State);

             end;  {If (Deblank(State) <> '')}

       end  {If (Deblank(City).Text <> ')}
     else TempStr := Trim(State);

     {Blank space before zip.}

   If (Deblank(TempStr) <> '')
     then TempStr := TempStr + ' ';

   FullZipCode := '';
   IncludeZipOnCityStateLine := True;

   If (Deblank(Zip) <> '')
     then
       begin
         FullZipCode := Trim(Zip);

         If (IncludeZipPlus4 and
             (Deblank(ZipPlus4) <> ''))
           then FullZipCode := FullZipCode + '-' + Trim(ZipPlus4);

           {FXX03202005-1(2.8.3.12)[2082]: If the city, state, zip, zip + 4 line exceeds 30 characters,
                                           move the zip code to the next line (unless we are already on
                                           the 6th line in which case we will omit the zip+4.}

         If (Length(TempStr + FullZipCode) > 30)
           then
             If (I = 6)
               then FullZipCode := Trim(Zip)
               else IncludeZipOnCityStateLine := False;

       end;  {If (Deblank(Zip) <> ')}

   If IncludeZipOnCityStateLine
     then TempStr := TempStr + FullZipCode;

     {FXX05201998-2: Need to add city and zip to name addr array.}

   If (Deblank(TempStr) <> '')
     then
       begin
         NAddrArray[I] := TempStr;
         I := I + 1;
       end;

  If ((Deblank(FullZipCode) <> '') and
      (not IncludeZipOnCityStateLine) and
      (I <= 6))
    then NAddrArray[I] := '       ' + FullZipCode;

end;  {FillInNameAddrArray}

{=================================================================================}
Procedure GetNameAddress(    Table : TTable;
                         var NAddrArray : NameAddrArray);

{Given a parcel in the parcel table, return the name and address in an array.}

begin
  with Table do
    FillInNameAddrArray(FieldByName('Name1').Text,
                        FieldByName('Name2').Text,
                        FieldByName('Address1').Text,
                        FieldByName('Address2').Text,
                        FieldByName('Street').Text,
                        FieldByName('City').Text,
                        FieldByName('State').Text,
                        FieldByName('Zip').Text,
                        FieldByName('ZipPlus4').Text,
                        True,
                        NAddrArray);

end;  {GetNameAddress}

{======================================================}
Procedure TExportDataDialog.ExtractOneTable(    _TableName : String;
                                                FileName : String;
                                                ExtractMemosAsFiles : Boolean;
                                                ExtractMailingAddress : Boolean;
                                                FirstLineIsHeaders : Boolean;
                                                bCreateNewFile : Boolean;
                                            var MemoNumber : Integer);

var
  TempFileName : String;
  I : Integer;
  Done, FirstTimeThrough, ProcessThisRecord : Boolean;
  FieldList : TStringList;
  TempFile : TextFile;
  NAddrArray : NameAddrArray;

begin
  AssignFile(TempFile, FileName);

  If bCreateNewFile
  then Rewrite(TempFile)
  else Append(TempFile);

  FieldList := TStringList.Create;

  with FieldListBox do
    For I := 0 to (Items.Count - 1) do
      If Selected[I]
        then FieldList.Add(Items[I]);

  If (bCreateNewFile and
      FirstLineIsHeaders)
    then
      begin
        For I := 0 to (FieldList.Count - 1) do
          Write(TempFile, FormatFieldForExtract(FieldList[I], I));

        Writeln(TempFile);

      end;  {If FirstLineIsHeadersCheckBox.Checked}

  NumRecordsExported := 0;
  Done := False;
  FirstTimeThrough := True;
  ProcessThisRecord := True;

  with Table do
  try
    Close;
    TableName := _TableName;
    Open;
    First;
  except
    ProcessThisRecord := False;
  end;

  ProgressBar.Max := Table.RecordCount;
  ProgressBar.Position := 0;

  repeat
    If FirstTimeThrough
      then FirstTimeThrough := False
      else
        try
          ProcessThisRecord := True;
          Table.Next;
        except
          ProcessThisRecord := False;
        end;

    If Table.EOF
      then Done := True;

    NumRecordsExported := NumRecordsExported + 1;
    ProgressBar.Position := NumRecordsExported;
    Application.ProcessMessages;

    If (ProcessThisRecord and
        (not Done))
      then
        If ExtractMailingAddress
          then
            begin
              GetNameAddress(Table, NAddrArray);

              For I := 1 to 6 do
                Write(TempFile, FormatFieldForExtract(NAddrArray[I], (I - 1)));

              Writeln(TempFile);
            end
          else
            begin
              For I := 0 to (FieldList.Count - 1) do
                If ((Table.FindField(FieldList[I]).DataType = ftMemo) and
                     ExtractMemosAsFiles and
                    (not Table.FindField(FieldList[I]).IsNull))
                  then
                    begin
                      MemoNumber := MemoNumber + 1;
                      TempFileName := 'MEMO' + IntToStr(MemoNumber) + '.MEM';
                      TMemoField(Table.FindField(FieldList[I])).SaveToFile(TempFileName);
                      Write(TempFile, FormatFieldForExtract(TempFileName, I));

                    end
                  else
                  If ((Table.FindField(FieldList[I]).DataType = ftDateTime) or
                      (Table.FindField(FieldList[I]).DataType = ftDate))
                  then Write(TempFile, FormatFieldForExtract(FormatDateTime('mm/dd/yyyy', Table.FindField(FieldList[I]).AsDateTime), I))
                  else Write(TempFile, FormatFieldForExtract(Table.FindField(FieldList[I]).AsString, I));


              Writeln(TempFile);

            end;  {If ExtractMailingAddress}

  until Done;

  CloseFile(TempFile);

end;  {ExtractOneTable}

{======================================================}
Procedure TExportDataDialog.OKButtonClick(Sender: TObject);

var
  sTableName : String;
  MemoNumber : LongInt;
  ExtractMailingAddress,
  bFirstLineIsHeaders, ExtractMemosAsFiles, bCombineYears : Boolean;

begin
  MemoNumber := 0;
  ExtractMemosAsFiles := ExportMemosAsFilesCheckBox.Checked;
  ExtractMailingAddress := cb_ExtractMailingAddress.Checked;
  bCombineYears := cbCombineYears.Checked;
  sTableName := Table.TableName;
  bFirstLineIsHeaders := FirstLineIsHeadersCheckBox.Checked;

  If SaveDialog.Execute
    then
      begin
        FileName := SaveDialog.FileName;

        If (bCombineYears and
            (sTableName[1] in ['H', 'T', 'N', 'h', 't', 'n']))
        then
        begin
          (*sTableName := 'H' + Copy(sTableName, 2, 255);
          ExtractOneTable(sTableName, FileName, ExtractMemosAsFiles, ExtractMailingAddress,
                          bFirstLineIsHeaders, True, MemoNumber); *)

          sTableName := 'T' + Copy(sTableName, 2, 255);
          ExtractOneTable(sTableName, FileName, ExtractMemosAsFiles, ExtractMailingAddress,
                          bFirstLineIsHeaders, True, MemoNumber);

          sTableName := 'N' + Copy(sTableName, 2, 255);
          ExtractOneTable(sTableName, FileName, ExtractMemosAsFiles, ExtractMailingAddress,
                          bFirstLineIsHeaders, False, MemoNumber);
        end
        else ExtractOneTable(sTableName, FileName, ExtractMemosAsFiles, ExtractMailingAddress,
                             bFirstLineIsHeaders, True, MemoNumber);

        ModalResult := mrOK;

      end;  {If SaveDialog.Execute}

end;  {OKButtonClick}

end.
