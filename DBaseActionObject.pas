unit DBaseActionObject;

interface

uses DB, Classes, SysUtils, DBTables, BDE, Forms, ResultsForm, Dialogs, StdCtrls;

const
  acAddField = 0;
  acDropField = 1;
  acAddIndex = 2;
  acDropIndex = 3;
  acPack = 4;
  acReindex = 5;
  acExportTable = 6;
  acImportTable = 7;
  acSetConfigParameter = 8;
  acCreateBDEAlias = 9;
  acEmptyTable = 10;
  acPackReindexTable = 11;
  acEmptyPackReindexTable = 12;
  acChangeField = 13;
  acReplaceValueFromFile = 14;

    {Config parameter constants}

  DBASEVERSION = '\DRIVERS\DBASE\INIT\;VERSION';
  DBASETYPE = '\DRIVERS\DBASE\INIT\;TYPE';
  DBASELANGDRIVER = '\DRIVERS\DBASE\INIT\;LANGDRIVER';
  DBASELEVEL = '\DRIVERS\DBASE\TABLE CREATE\;LEVEL';
  DBASEMDXBLOCKSIZE = '\DRIVERS\DBASE\TABLE CREATE\;MDX BLOCK SIZE';
  DBASEMEMOFILEBLOCKSIZE = '\DRIVERS\DBASE\TABLE CREATE\;MEMO FILE BLOCK SIZE';
  AUTOODBC = '\SYSTEM\INIT\;AUTO ODBC';
  DATAREPOSITORY = '\SYSTEM\INIT\;DATA REPOSITORY';
  DEFAULTDRIVER = '\SYSTEM\INIT\;DEFAULT DRIVER';
  LANGDRIVER = '\SYSTEM\INIT\;LANGDRIVER';
  LOCALSHARE = '\SYSTEM\INIT\;LOCAL SHARE';
  LOWMEMORYUSAGELIMIT = '\SYSTEM\INIT\;LOW MEMORY USAGE LIMIT';
  MAXBUFSIZE = '\SYSTEM\INIT\;MAXBUFSIZE';
  MAXFILEHANDLES = '\SYSTEM\INIT\;MAXFILEHANDLES';
  MEMSIZE = '\SYSTEM\INIT\;MEMSIZE';
  MINBUFSIZE = '\SYSTEM\INIT\;MINBUFSIZE';
  MTSPOOLING = '\SYSTEM\INIT\;MTS POOLING';
  SHAREDMEMLOCATION = '\SYSTEM\INIT\;SHAREDMEMLOCATION';
  SHAREDMEMSIZE = '\SYSTEM\INIT\;SHAREDMEMSIZE';
  SQLQRYMODE = '\SYSTEM\INIT\;SQLQRYMODE';
  SYSFLAGS = '\SYSTEM\INIT\;SYSFLAGS';
  VERSION = '\SYSTEM\INIT\;VERSION';


type
  ActionRecord = record
    DatabaseName : String;
    TableName : String;
    ActionType : Integer;
    FieldName : String;
    FieldType : Integer;
    FieldLength : Integer;
    IndexName : String;
    IndexExpression : String;
    IndexOptions : TIndexOptions;
    FileName : String;
    ParameterName : String;
    ParameterValue : String;
    AliasName : String;
    AliasPath : String;
    HeadersOnFirstLine : Boolean;
    ClearTablePriorToImport : Boolean;

  end;  {ActionRecord}

  ActionRecordPointer = ^ActionRecord;

  TDBaseActionObject = Class
  private
    Function GetActionCount : Integer;
  public
    ActionList : TList;
    SuccessfulResultList,
    UnsuccessfulResultList : TStringList;
    ActionRecordSize : Integer;
    property Count : Integer read GetActionCount;

    Constructor Create;
    Function GetActionNameForActionType(ActionType : Integer) : String;
    Function GetMainValueForActionType(ActionRec : ActionRecord) : String;
    Procedure AddAction(ActionRec : ActionRecord;
                        Index : Integer);  {Where to insert}
    Procedure DeleteAction(Index : Integer);
    Procedure UpdateAction(ActionRec : ActionRecord;
                           Index : Integer);  {Which action to update.}
    Function GetAction(Index : Integer) : ActionRecord;
    Procedure ClearActions;
    Procedure SwitchActions(Index1 : Integer;
                            Index2 : Integer);
    Function WriteActionsToFile(FileName : String) : Boolean;
    Function LoadActionsFromFile(FileName : String) : Boolean;
    Procedure DisplayResults(SuccessfulResultList,
                             UnsuccessfulResultList : TStringList);
    Function ExecuteAction(Index : Integer;
                           RunHidden : Boolean;
                           ProgressLabel : TLabel) : Boolean;
    Procedure ExecuteAll(RunHidden : Boolean;
                         ResultFileName : String;
                         ProgressLabel : TLabel);
    Procedure AddResult(ActionRec : ActionRecord;
                        ResultMsg : String;
                        Successful : Boolean);
    Destructor Destroy; override;

  end;  {DBaseActionObject}

  Function GetEmptyActionRecord : ActionRecord;

implementation

const
  MaxNumChars = 5000;
Type
//  LineStringType = Array[1..MaxNumChars] of Char;

  LineStringType = String;

  ChangeRecord = packed record
      szName: DBINAME;
      iType: word;
      iSubType: word;
      iLength: word;
      iPrecision: byte;
    end;

{===================================================================}
Function Take(Len : Integer;
              Vec : String): String;

begin
  vec:=copy(vec,1,len);
  while length(vec)<len do vec:=concat(vec,' ');
  take:=vec;
end;

{=================================================================}
Function DeBlank(S : String) : String;

begin
  repeat
   delete(s,pos(' ',s),1)
  until (0 = pos(' ',s));
  deblank:=s;
end;  {of DeBlank}

{=======================================================================================}
Procedure ClearTList(List : TList;
                     Size : Integer);

{Clear all the objects in a TList, but leave the list around.
 Note that the size of the pointer record must be passed in since Delphi
 has no way of knowing the size of the pointer.}

var
  I, Count : Integer;

begin
  Count := List.Count - 1;

  For I := Count downto 0 do
    FreeMem(List[I], Size);

  List.Clear;

end;  {ClearTList}

{=======================================================================================}
Procedure FreeTList(List : TList;
                    Size : Integer);

{Free all the objects in a TList and then free the whole list.
 Note that the size of the pointer record must be passed in since Delphi
 has no way of knowing the size of the pointer.}

begin
  ClearTList(List, Size);
  List.Free;

end;  {FreeTList}

{==========================================================}
Function IndexOptionsToStr(IndexOptions : TIndexOptions) : String;

begin
  Result := '';

  If (ixPrimary in IndexOptions)
    then Result := 'Primary';

  If (ixUnique in IndexOptions)
    then
      begin
        If (Result <> '')
          then Result := Result + ';';

        Result := Result + 'Unique';

      end;  {If (ixUnique in IndexOptions)}

  If (ixDescending in IndexOptions)
    then
      begin
        If (Result <> '')
          then Result := Result + ';';

        Result := Result + 'Descending';

      end;  {If (ixDescending in IndexOptions)}

end;  {IndexOptionsToStr}

{==============================================================}
Function StrToIndexOptions(TempStr : String) : TIndexOptions;

begin
  Result := [];

  If (Pos('Primary', TempStr) > 0)
    then Result := Result + [ixPrimary];

  If (Pos('Unique', TempStr) > 0)
    then Result := Result + [ixUnique];

  If (Pos('Descending', TempStr) > 0)
    then Result := Result + [ixDescending];

end;  {StrToIndexOptions}

{====================================================================}
Function FieldTypeToStr(FieldType : LongInt) : String;

begin
  case FieldType of
    fldDBCHAR : Result := 'String';

    fldDBLONG : Result := 'Integer';

    fldDBDOUBLE : Result := 'Float';

    fldDBBOOL : Result := 'Boolean';

    fldDBAUTOINC : Result := 'AutoIncrement';

    fldDBMEMO : Result := 'Memo';

  end;  {case FieldType of}

end;  {FieldTypeToStr}

{=======================================================================}
Function StrToFieldType(FieldTypeStr : String) : LongInt;

begin
  If (FieldTypeStr = 'String')
    then Result := fldDBCHAR;

  If (FieldTypeStr = 'Integer')
    then Result := fldDBLONG;

  If (FieldTypeStr = 'Float')
    then Result := fldDBDOUBLE;

  If (FieldTypeStr = 'Boolean')
    then Result := fldDBBOOL;

  If (FieldTypeStr = 'AutoIncrement')
    then Result := fldDBAUTOINC;

  If (FieldTypeStr = 'Memo')
    then Result := fldDBMEMO;

end;  {StrToFieldType}

{=======================================================================}
Function BoolToStr(TempBoolean : Boolean) : String;

begin
  If TempBoolean
    then Result := 'TRUE'
    else Result := 'FALSE';

end;  {BoolToStr}

{=======================================================================}
Function StrToBool(TempStr : String) : Boolean;


begin
  Result := (TempStr = 'TRUE');
end;

{=======================================================================}
Procedure ReadLine(var TempFile : Text;
                   var TempStr : LineStringType);

var
  I, Index : Integer;
  TempChar : Char;

begin
  Index := 1;
  For I := 1 to MaxNumChars do
    TempStr[I] := #0;

  repeat
    Read(TempFile, TempChar);

    If not (TempChar in [#10, #13, #26])
      then
        begin
          TempStr[Index] := TempChar;
          Index := Index + 1;
        end;

  until (TempChar in [#10, #26]);  {LF or EOF}

end;  {ReadLine}

{=======================================================================}
Function StripChar(Text : String;
                   CharToRemove,
                   ReplacementChar : Char;
                   ReplaceChar : Boolean) : String;

{Strip out any occurrences of CharToRemove in Text and replace it with
 ReplacementChar.
 -- Only replace if ReplaceChar is True}

var
  I, Position, Len : Integer;

begin
  Len := Length(Text);
  Position := -1;

  For I := 1 to Len do
    If (Text[I] = CharToRemove)
      then Position := I;

  If (Position > 0)
    then
      If ReplaceChar
        then Text[Position] := ReplacementChar
        else Delete(Text, Position, 1);

  Result := Text;

end;  {StripChar}

{=======================================================}
Function FindOccurrence(var TempStr : LineStringType;
                            StringToFind : String;
                            OccurrenceNo : Integer) : Integer;

var
  StrLength, I, J, NumFound : Integer;
  Matched : Boolean;

begin
  Result := 0;
  NumFound := 0;
  I := 1;
  StrLength := Length(StringToFind);

  while ((I <= (MaxNumChars - StrLength + 1)) and
         (NumFound < OccurrenceNo)) do
    begin
      Matched := True;

      For J := 0 to (StrLength - 1) do
        If (TempStr[I + J] <> StringToFind[J + 1])
          then Matched := False;

      If Matched
        then NumFound := NumFound + 1;

      If (NumFound = OccurrenceNo)
        then Result := I;

      I := I + 1;

    end;  {while ((I <= MaxNumChars) and ...}

end;  {FindOccurrence}

{===============================================================}
Function LineLength(var TempStr : LineStringType) : Integer;

var
  I : Integer;

begin
  For I := 1 to MaxNumChars do
    If (TempStr[I] <> #0)
      then Result := I;

end;  {LineLength}

{=======================================================}
Function ParseField(var TempStr : LineStringType;
                        FieldNo : Integer) : String;

{Return the FieldNo(th) field in a comma seperated string.}

var
  StartPos, EndPos, TempPos, I : Integer;

begin
  StartPos := 0;
  Result := '';

  If (FieldNo = 1)
    then
      begin
        If (TempStr[1] = '"')
          then StartPos := 2
          else StartPos := 1;

      end
    else
      begin
        StartPos := FindOccurrence(TempStr, '",', (FieldNo - 1));

          {Skip the comma and ".}

        If (StartPos > 0)
          then StartPos := StartPos + 3;

      end;  {If (FieldNo = 1)}

  If (StartPos > 0)
    then
      begin
        EndPos := FindOccurrence(TempStr, '",', FieldNo);  {Find the next comma.}

        If (EndPos = 0)
          then EndPos := LineLength(TempStr) - 1
          else EndPos := EndPos - 1;

        Result := '';

        For I := StartPos to EndPos do
          Result := Result + TempStr[I];

      end;  {If (StartPos > 0)}

end;  {ParseField}

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
            CurrentField := StringReplace(CurrentField, #255, '', [rfReplaceAll]);
            CurrentField := '';

          end
        else CurrentField := CurrentField + TempStr[I];

    end;  {For I := 1 to Length(TempStr) do}

  CurrentField := StripLeadingAndEndingDuplicateChar(CurrentField, '"');

  If CapitalizeStrings
    then CurrentField := ANSIUpperCase(Trim(CurrentField));

  CurrentField := StringReplace(CurrentField, #255, '', [rfReplaceAll]);

  FieldList.Add(Trim(CurrentField));

end;  {ParseCommaDelimitedStringIntoFields}

{===================================================}
Procedure AddBDEField(Table: TTable;
                      NewField: ChangeRecord);

var
  Props: CURProps;
  hDb: hDBIDb;
  TableDesc: CRTblDesc;
  pFlds: pFLDDesc;
  pOp: pCROpType;
  B: byte;

begin
  // Get the table properties to determine table type...
  Check(DbiSetProp(hDBIObj(Table.Handle), curxltMODE, integer(xltNONE)));
  Check(DbiGetCursorProps(Table.Handle, Props));
  pFlds := AllocMem((Table.FieldCount + 1) * sizeof(FLDDesc));
  FillChar(pFlds^, (Table.FieldCount + 1) * sizeof(FLDDesc), 0);
  Check(DbiGetFieldDescs(Table.handle, pFlds));

  for B := 1 to Table.FieldCount do begin
    pFlds^.iFldNum := B;
    Inc(pFlds, 1);
  end;
  try
    StrCopy(pFlds^.szName, NewField.szName);
    pFlds^.iFldType := NewField.iType;
    pFlds^.iSubType := NewField.iSubType;
    pFlds^.iUnits1  := NewField.iLength;
    pFlds^.iUnits2  := NewField.iPrecision;
    pFlds^.iFldNum  := Table.FieldCount + 1;
  finally
    Dec(pFlds, Table.FieldCount);
  end;

  pOp := AllocMem((Table.FieldCount + 1) * sizeof(CROpType));
  Inc(pOp, Table.FieldCount);
  pOp^ := crADD;
  Dec(pOp, Table.FieldCount);

  // Blank out the structure...
  FillChar(TableDesc, sizeof(TableDesc), 0);
  //  Get the database handle from the table's cursor handle...
  Check(DbiGetObjFromObj(hDBIObj(Table.Handle), objDATABASE, hDBIObj(hDb)));
  // Put the table name in the table descriptor...
  StrPCopy(TableDesc.szTblName, Table.TableName);
  // Put the table type in the table descriptor...
  StrPCopy(TableDesc.szTblType, Props.szTableType);
  // Close the table so the restructure can complete...
  TableDesc.iFldCount := Table.FieldCount + 1;
  Tabledesc.pfldDesc := pFlds;
  TableDesc.pecrFldOp := pOp;
  Table.Close;
  // Call DbiDoRestructure...
  try
    Check(DbiDoRestructure(hDb, 1, @TableDesc, nil, nil, nil, FALSE));
  finally
    FreeMem(pFlds);
    FreeMem(pOp);
    Table.Open;
  end;

end;  {AddBDEField}

{===================================================}
Procedure ChangeBDEField(Table: TTable;
                         FieldName : String;
                         Rec: ChangeRecord);

var
  Props: CURProps;
  hDb: hDBIDb;
  TableDesc: CRTblDesc;
  pFields: pFLDDesc;
  pOp: pCROpType;
  B: byte;
  Field : TField;

begin
  Field := Table.FieldByName(FieldName);

  // Initialize the pointers...
  pFields := nil; pOp := nil;
  // Make sure the table is open exclusively so we can get the db handle...
  if Table.Active = False then
    raise EDatabaseError.Create('Table must be opened to restructure');
  if Table.Exclusive = False then
    raise EDatabaseError.Create('Table must be opened exclusively to restructure');

  Check(DbiSetProp(hDBIObj(Table.Handle), curxltMODE, integer(xltNONE)));
  // Get the table properties to determine table type...
  Check(DbiGetCursorProps(Table.Handle, Props));
  // Make sure the table is either Paradox or dBASE...
  if (Props.szTableType <> szPARADOX) and (Props.szTableType <> szDBASE) then
    raise EDatabaseError.Create('Field altering can only occur on Paradox' +
                ' or dBASE tables');
  // Allocate memory for the field descriptor...
  pFields := AllocMem(Table.FieldCount * sizeof(FLDDesc));
  // Allocate memory for the operation descriptor...
  pOp := AllocMem(Table.FieldCount * sizeof(CROpType));
  try
    // Set the pointer to the index in the operation descriptor to put
    // crMODIFY (This means a modification to the record is going to happen)...
    Inc(pOp, Field.Index);
    pOp^ := crMODIFY;
    Dec(pOp, Field.Index);
    // Fill the field descriptor with the existing field information...
    Check(DbiGetFieldDescs(Table.Handle, pFields));
    // Set the pointer to the index in the field descriptor to make the
    // midifications to the field
    Inc(pFields, Field.Index);

    // If the szName portion of the ChangeRec has something in it, change it...
    if StrLen(Rec.szName) > 0 then
      pFields^.szName := Rec.szName;
    // If the iType portion of the ChangeRec has something in it, change it...
    if Rec.iType > 0 then
      pFields^.iFldType := Rec.iType;
    // If the iSubType portion of the ChangeRec has something in it, change it...
    if Rec.iSubType > 0 then
      pFields^.iSubType := Rec.iSubType;
    // If the iLength portion of the ChangeRec has something in it, change it...
    if Rec.iLength > 0 then
      pFields^.iUnits1 := Rec.iLength;
    // If the iPrecision portion of the ChangeRec has something in it, change it...
    if Rec.iPrecision > 0 then
      pFields^.iUnits2 := Rec.iPrecision;
    Dec(pFields, Field.Index);

    for B := 1 to Table.FieldCount do begin
      pFields^.iFldNum := B;
      Inc(pFields, 1);
    end;
    Dec(pFields, Table.FieldCount);

    // Blank out the structure...
    FillChar(TableDesc, sizeof(TableDesc), 0);
    //  Get the database handle from the table's cursor handle...
    Check(DbiGetObjFromObj(hDBIObj(Table.Handle), objDATABASE, hDBIObj(hDb)));
    // Put the table name in the table descriptor...
    StrPCopy(TableDesc.szTblName, Table.TableName);
    // Put the table type in the table descriptor...
    StrPCopy(TableDesc.szTblType, Props.szTableType);
    // The following three lines are necessary when doing any field restructure
    // operations on a table...

    // Set the field count for the table
    TableDesc.iFldCount := Table.FieldCount;
    // Link the operation descriptor to the table descriptor...
    TableDesc.pecrFldOp := pOp;
    // Link the field descriptor to the table descriptor...
    TableDesc.pFldDesc := pFields;
    // Close the table so the restructure can complete...
    Table.Close;
    // Call DbiDoRestructure...
    Check(DbiDoRestructure(hDb, 1, @TableDesc, nil, nil, nil, FALSE));
  finally
    if pFields <> nil then
      FreeMem(pFields);
    if pOp <> nil then
      FreeMem(pOp);
  end;
end;

{===================================================}
Function SetConfigParameter(    Param : string;
                                Value : string;
                            var ResultMsg : String) : Boolean;

var
  hCur: hDBICur;
  rslt: DBIResult;
  Config: CFGDesc;
  Path, Option: String;
  Temp: array[0..255] of char;
  TempStr, TempValue : String;
  I : Integer;
  Successful : Boolean;

begin
  hCur := nil;

  try
    If (Pos(';', Param) = 0)
      then
        raise EDatabaseError.Create('Invalid parameter passed to' +
                                    'function.  There must be a semicolon delimited sting passed');

    Path := Copy(Param, 0, Pos(';', Param) - 1);
    Option := Copy(Param, Pos(';', Param) + 1, Length(Param) - Pos(';', Param));

    Check(DbiOpenCfgInfoList(nil, dbiREADWRITE, cfgPERSISTENT,
                             StrPCopy(Temp, Path), hCur));

    Check(DbiSetToBegin(hCur));

    repeat
      rslt := DbiGetNextRecord(hCur, dbiNOLOCK, @Config, nil);

      If (rslt = DBIERR_NONE)
        then
          begin
            TempStr := StrPas(Config.szNodeName);

            If (StrPas(Config.szNodeName) = Option)
              then
                begin
                    {To set the value, copy in byte by byte and make the following
                     byte null.}

                  For I := 0 to (Length(Value) - 1) do
                    Config.szValue[I] := Value[I + 1];

                  Config.szValue[Length(Value)] := #0;

                  rslt := dbiModifyRecord(hCur, @Config, True);

                  Successful := (Rslt = DBIERR_NONE);

                end;  {If (StrPas(Config.szNodeName) = Option)}

          end
        else
          If (rslt <> DBIERR_EOF)
            then Check(rslt);

    until (rslt <> DBIERR_NONE);

  finally
    If (hCur <> nil)
      then Check(DbiCloseCursor(hCur));
  end;

  If Successful
    then TempStr := 'was'
    else TempStr := 'was not';

  ResultMsg := 'The BDE parameter ' + Option + ' ' +
               TempStr + ' successfully set to ' +
               Value;

  Result := Successful;

end;  {SetConfigParameter}

(*
{===================================================}
Procedure SetConfigParameter(Param : string;
                             Value : string);

var
  hCfg: hDBICfg;
  Config: SYSConfig;
  Path, Option: string;
  ParamCount, I: word;
  pFields, pFld: pFLDDesc;
  pRecBuf, pRec: pBYTEArray;
  Found, SelfInitialized: boolean;
  rslt: DBIResult;

begin

     {$Ifdef WIN32}
  hCfg := nil;
  pFld := nil;
  pRec := nil;
  Found := False;
  SelfInitialized := False;

  try
    If (Pos(';', Param) = 0)
      then raise EDatabaseError.Create('Invalid parameter passed to function.  There must ' +
                                       'be a semi-colon delimited sting passed');

    Path := Copy(Param, 0, Pos(';', Param) - 1);
    Option := Copy(Param, Pos(';', Param) + 1, Length(Param) - Pos(';', Param));

    rslt := DbiGetSysConfig(Config);

    If (rslt <> DBIERR_NONE)
      then
        begin
          If (rslt = DBIERR_NOTINITIALIZED)
            then
              begin
                SelfInitialized := True;
                DbiInit(nil);
                Check(DbiGetSysConfig(Config));
              end
          else Check(rslt);

        end;

    Check(DbiOpenConfigFile(Config.szIniFile, FALSE, hCfg));

        { Call it without the field and record buffer to get the count... }

    Check(DbiCfgGetRecord(hCfg, PChar(Path), ParamCount, nil, nil));

    pFields := AllocMem(ParamCount * sizeof(FLDDesc));
    pFld := pFields;
    pRecBuf := AllocMem(10000);
    pRec := pRecBuf;

         { Get the node values... }

    Check(DbiCfgGetRecord(hCfg, PChar(Path), ParamCount, pFields, pRecBuf));

    For I := 0 to (ParamCount - 1) do
      begin
        If (pFields^.szName = Option)
          then
            begin
              StrPCopy(PChar(pRecBuf), Value);
              Check(DbiCfgModifyRecord(hCfg,  PChar(Path), ParamCount, pFld, pRec));
              Found := True;

           end;

        Inc(pFields);
        Inc(pRecBuf, 128);

      end;

    If not Found
      then raise EDatabaseError.Create(Param + ' entry was not found in configuration file');

  finally
    if (pFld <> nil)
      then FreeMem(pFld);

    if (pRec <> nil)
      then FreeMem(pRec);

      { Close and save the config file... }

    if (hCfg <> nil)
      then Check(DbiCloseConfigFile(hCfg, TRUE, TRUE, FALSE));

    if SelfInitialized = True
      then DbiExit;

  end;

    {$Else}

  raise EDatabaseError.Create('Non supported function in 16 bit');

    {$EndIf}

end;  {SetConfigParameter} *)

{===================================================}
Function GetEmptyActionRecord : ActionRecord;

begin
  with Result do
    begin
      DatabaseName := '';
      TableName := '';
      ActionType := -1;
      FieldName := '';
      FieldType := 0;
      FieldLength := 0;
      IndexName := '';
      IndexExpression := '';
      IndexOptions := [];
      FileName := '';
      ParameterName := '';
      ParameterValue := '';
      AliasName := '';
      AliasPath := '';
      HeadersOnFirstLine := False;
      ClearTablePriorToImport := False;

    end;  {with Result do}

end;  {GetEmptyActionRecord}

{===================================================}
Function AddField(    Table : TTable;
                      FieldName : String;
                      FieldType,
                      FieldLength : Integer;
                  var ResultMsg : String) : Boolean;

var
  NewField : ChangeRecord;
  I, Len : Integer;

begin
  FieldName := Trim(FieldName);
  Len := Length(FieldName);

  with NewField do
    begin
      For I := 1 to DBIMAXNAMELEN do
        If (I <= Len)
          then szName[I - 1] := FieldName[I]
          else szName[I] := #0;

      iType := FieldType;
      iSubType := 0;
      iLength := FieldLength;
      iPrecision := 0;

    end;  {with NewField do}

  AddBDEField(Table, NewField);

  If (Table.FindField(FieldName) = nil)
    then
      begin
        Result := False;
        ResultMsg := 'The field ' + FieldName + ' for table ' +
                     Table.TableName + ' was not created successfully.';
      end
    else
      begin
        Result := True;
        ResultMsg := 'The field ' + FieldName + ' for table ' +
                     Table.TableName + ' was created successfully.';

      end;  {else of If (Table.FindField(FieldName) = nil)}

end;  {AddField}

{===================================================}
Function DropField(    Table : TTable;
                       FieldName : String;
                   var ResultMsg : String) : Boolean;

var
  UpdateSQL : TUpdateSQL;
  Query : TQuery;

begin
  Query := TQuery.Create(nil);
  Query.DatabaseName := Table.DatabaseName;

  UpdateSQL := TUpdateSQL.Create(nil);
  UpdateSQL.ModifySQL.Clear;
  UpdateSQL.ModifySQL.Add('ALTER TABLE ' + Table.TableName + '.DBF DROP ' +
                          FieldName);

  UpdateSQL.DataSet := Query;
  Query.UpdateObject := UpdateSQL;

  try
    UpdateSQL.ExecSQL(ukModify);
  except
  end;

  Query.Close;
  Query.Free;
  UpdateSQL.Free;

  If (Table.FindField(FieldName) = nil)
    then
      begin
        Result := True;
        ResultMsg := 'The field ' + FieldName + ' for table ' +
                     Table.TableName + ' was dropped successfully.';
      end
    else
      begin
        Result := False;
        ResultMsg := 'The field ' + FieldName + ' for table ' +
                     Table.TableName + ' was not dropped successfully.';

      end;  {else of If (Table.FindField(FieldName) = nil)}

end;  {DropField}

{===================================================}
Function AddIndex(    Table : TTable;
                      IndexName : String;
                      IndexExpression : String;
                      IndexOptions : TIndexOptions;
                  var ResultMsg : String) : Boolean;

begin
  Result := True;
  ResultMsg := 'The index ' + IndexName +
               ' was added successfully.';

  try
    Table.AddIndex(IndexName, IndexExpression, IndexOptions);
  except
    Result := False;
    ResultMsg := 'The index ' + IndexName +
                 ' was not added successfully.';
  end;

end;  {AddIndex}

{===================================================}
Function DropIndex(    Table : TTable;
                       IndexName : String;
                   var ResultMsg : String) : Boolean;

begin
  Result := True;
  ResultMsg := 'The index ' + IndexName +
               ' was dropped successfully.';

  try
    Table.DeleteIndex(IndexName);
  except
    Result := False;
    ResultMsg := 'The index ' + IndexName +
                 ' was not deleted successfully.';
  end;

end;  {DropIndex}

{===================================================}
Function PackTable(    Table : TTable;
                   var ResultMsg : String) : Boolean;

var
  ActionResult : DBIResult;

begin
  ActionResult := dbiPackTable(Table.DBHandle, Table.Handle, nil, szDBASE, True);

  If (ActionResult = DBIERR_NONE)
    then
      begin
        Result := True;
        ResultMsg := 'Table ' + Table.TableName + ' packed successfully.';
      end
    else
      begin
        Result := False;
        ResultMsg := 'Table ' + Table.TableName + ' was not packed successfully: ';

        case ActionResult of
          DBIERR_INVALIDHNDL : ResultMsg := ResultMsg +
                                            'The table handle is not valid.  It probably does not point to a real table.';

          DBIERR_NEEDEXCLACCESS : ResultMsg := ResultMsg +
                                               'The table must be opened exclusive.  Please make sure not one else is using the table.';

          DBIERR_INVALIDPARAM : ResultMsg := ResultMsg +
                                            'The table name or pointer to the table name is NULL.';

          DBIERR_UNKNOWNTBLTYPE : ResultMsg := ResultMsg +
                                               'Unknown table type.';

          DBIERR_NOSUCHTABLE : ResultMsg := ResultMsg +
                                            'The table does not exist.';

        end;  {case ActionResult of}

      end;  {else of If (ActionResult = DBIERR_NONE)}

end;  {PackTable}

{===================================================}
Function ReindexTable(    Table : TTable;
                      var ResultMsg : String) : Boolean;

var
  ActionResult : DBIResult;

begin
  ActionResult := dbiRegenIndexes(Table.Handle);

  If (ActionResult = DBIERR_NONE)
    then
      begin
        Result := True;
        ResultMsg := 'Table ' + Table.TableName + ' was reindexed successfully.';
      end
    else
      begin
        Result := False;
        ResultMsg := 'Table ' + Table.TableName + ' was not reindexed successfully: ';

        case ActionResult of
          DBIERR_INVALIDHNDL : ResultMsg := ResultMsg +
                                            'The table handle is not valid.  It probably does not point to a real table.';

          DBIERR_NEEDEXCLACCESS : ResultMsg := ResultMsg +
                                               'The table must be opened exclusive.  Please make sure not one else is using the table.';

          DBIERR_NOTSUPPORTED : ResultMsg := ResultMsg +
                                             'Can not regenerate the indexes - they are not supported.';

        end;  {case ActionResult of}

      end;  {else of If (ActionResult = DBIERR_NONE)}

end;  {ReindexTable}

{===================================================}
Function _EmptyTable(    Table : TTable;
                     var ResultMsg : String) : Boolean;

begin
  Result := True;
  ResultMsg := 'Table ' + Table.TableName + ' was emptied successfully.';

  try
    Table.EmptyTable;
  except
    Result := False;
    ResultMsg := 'Table ' + Table.TableName + ' was NOT emptied successfully.';
  end;

end;  {_EmptyTable}

{================================================================}
Function PackAndReindex(    Table : TTable;
                        var ResultMsg : String) : Boolean;

begin
  Result := PackTable(Table, ResultMsg);

  If Result
    then Result := ReindexTable(Table, ResultMsg);

  If Result
    then ResultMsg := 'Table ' + Table.TableName + ' was packed and reindexed successfully.';

end;  {PackAndReindex}

{================================================================}
Function Empty_Pack_And_Reindex(    Table : TTable;
                                var ResultMsg : String) : Boolean;

begin
  Result := _EmptyTable(Table, ResultMsg);

  If Result
    then Result := PackTable(Table, ResultMsg);

  If Result
    then Result := ReindexTable(Table, ResultMsg);

  If Result
    then ResultMsg := 'Table ' + Table.TableName + ' was emptied, packed and reindexed successfully.';

end;  {Empty_Pack_And_Reindex}

{===================================================}
Function ExportTable(    Table : TTable;
                         FileName : String;
                         HeadersOnFirstLine : Boolean;
                     var ResultMsg : String) : Boolean;

var
  Done, FirstTimeThrough : Boolean;
  I : Integer;
  ExportFile : TextFile;
  RecsExported : LongInt;

begin
  Done := False;
  FirstTimeThrough := True;
  RecsExported := 0;
  FileName := 'c:\temp3\' + Table.TableName + '.txt';

  AssignFile(ExportFile, FileName);
  Rewrite(ExportFile);

  If HeadersOnFirstLine
    then
      begin
        with Table do
          For I := 0 to (FieldDefs.Count - 1) do
            begin
              If (I > 0)
                then Write(ExportFile, ',');

              Write(ExportFile, '"', FieldDefs[I].Name, '"');

            end;  {For I := 0 to (FieldDefs.Count - 1) do}

        Writeln(ExportFile);

      end;  {If HeadersOnFirstLine}

  Table.First;

  repeat
    If FirstTimeThrough
      then FirstTimeThrough := False
      else Table.Next;

    If Table.EOF
      then Done := True;

    If not Done
      then
        begin
          with Table do
            For I := 0 to (FieldDefs.Count - 1) do
              begin
                If (I > 0)
                  then Write(ExportFile, ',');

                Write(ExportFile, '"', FieldByName(FieldDefs[I].Name).Text, '"');

              end;  {For I := 0 to (FieldDefs.Count - 1) do}

          Writeln(ExportFile);
          RecsExported := RecsExported + 1;

        end;  {If not Done}

  until Done;

  CloseFile(ExportFile);

  ResultMsg := 'The table ' + Table.TableName + ' was successfully exported to the file ' +
               FileName + '.  There were ' + IntToStr(RecsExported) + ' records exported.';

end;  {ExportTable}

{===================================================}
Function ImportTable(    Table : TTable;
                         FileName : String;
                         ClearTablePriorToImport : Boolean;
                         ProgressLabel : TLabel;
                     var ResultMsg : String) : Boolean;

var
  ErrorFile, ImportFile : TextFile;
  Done, PostedOK : Boolean;
  TempStr : LineStringType;
  PostedCount, RecNumber, ErrorCount : LongInt;
  Field_List, Field_Values : TStringList;
  J, I, ErrorPos : Integer;
  TempStr1, TableName,
  FieldName, FieldValue, MemoFieldName : String;

begin
  RecNumber := 1;
  ErrorCount := 0;
  PostedCount := 0;
  ProgressLabel.Visible := True;
  Field_List := TStringList.Create;
  Field_Values := TStringList.Create;

  Done := False;
  AssignFile(ImportFile, FileName);
  Reset(ImportFile);
  AssignFile(ErrorFile, 'c:\error.txt');
  Rewrite(ErrorFile);

  If not EOF(ImportFile)
    then
      begin
        If ClearTablePriorToImport
          then
            try
              Empty_Pack_And_Reindex(Table, ResultMsg);
            except
              MessageDlg('The table could not be opened exclusively in order to empty it prior to the import.',
                         mtError, [mbOK], 0);
            end;

           {Get the field names and positions.}

        ReadLine(ImportFile, TempStr);
        RecNumber := RecNumber + 1;

        ParseCommaDelimitedStringIntoFields(TempStr, Field_List, False);
(*        Field_List.Clear;
        FieldPosition.Clear;

        I := 1;
        FieldName := ParseField(TempStr, I);

        while (Deblank(FieldName) <> '') do
          begin
            If (Table.FindField(FieldName) <> nil)
              then
                begin
                  Field_List.Add(FieldName);
                  FieldPosition.Add(IntToStr(I));
                end;

            I := I + 1;
            FieldName := ParseField(TempStr, I);

          end;  {while (Deblank(FieldName) <> '') do} *)

        repeat
          ReadLine(ImportFile, TempStr);

          If EOF(ImportFile)
            then Done := True;

          PostedOK := False;
          MemoFieldName := '';

          with Table do
            try
              Insert;

              ParseCommaDelimitedStringIntoFields(TempStr, Field_Values, False);

              For I := 0 to (Field_List.Count - 1) do
                If ((FindField(Field_List[I]) <> nil) and
                    (Field_Values.Count > I))
                  then
                    begin
                      FieldValue := Field_Values[I];
                      FieldName := Field_List[I];

                      If ((AnsiUpperCase(Field_List[I]) <> 'AUTOINCREMENTID') and
                          ((AnsiUpperCase(Field_List[I]) <> 'SWISSBLKEY') or
                           (FieldValue <> '')))
                        then
                          case FieldByName(FieldName).DataType of
                            ftDate,
                            ftDateTime : If ((Deblank(FieldValue) <> '') and
                                             (FieldValue <> '0/0/00'))
                                           then
                                             try
                                               FieldByName(FieldName).Text := FieldValue;
                                             except
                                               FieldByName(FieldName).AsDateTime := 0;
                                               ErrorCount := ErrorCount + 1;
                                               Writeln(ErrorFile, 'Error converting date or time field ' + FieldName +
                                                                  ' in table ' + Table.TableName + '.' +
                                                                  '  Record = ' + IntToStr(RecNumber) + '.' +
                                                                  '  Value = ' + FieldValue);
                                             end;

                            ftString : If (Deblank(FieldByName(FieldName).Text) = '')
                                         then FieldByName(FieldName).Text := Take(FieldByName(FieldName).DataSize,
                                                                                  FieldValue)
                                         else FieldByName(FieldName).Text :=
                                                 FieldByName(FieldName).Text +
                                                 Take(FieldByName(FieldName).DataSize,
                                                      FieldValue);

                            ftMemo :  If (Trim(FieldValue) <> '')
                                        then
                                          try
                                            TMemoField(FieldByName(FieldName)).LoadFromFile(FieldValue);  {FieldValue is actually a file name.}
                                          except
                                            try
                                              TMemoField(FieldByName(FieldName)).AsString := FieldValue;
                                            except
                                            end;

                                          end;

                            ftBoolean: FieldByName(FieldName).Text := FieldValue;

                            ftInteger: try
                                         FieldByName(FieldName).AsInteger := Round(StrToFloat(FieldValue));
                                       except
                                         FieldByName(FieldName).AsInteger := 0;
                                         ErrorCount := ErrorCount + 1;
                                         Writeln(ErrorFile, 'Error converting integer field ' + FieldName +
                                                            ' in table ' + Table.TableName + '.' +
                                                            '  Record = ' + IntToStr(RecNumber) + '.' +
                                                            '  Value = ' + FieldValue);
                                       end;

                            else
                              try
                                FieldByName(FieldName).Text := FieldValue;
                              except
                                ErrorCount := ErrorCount + 1;
                                Writeln(ErrorFile, 'Error converting field ' + FieldName +
                                                   ' in table ' + Table.TableName + '.' +
                                                   '  Record = ' + IntToStr(RecNumber) + '.' +
                                                   '  Value = ' + FieldValue);
                              end;

                          end;  {case FieldByName(FieldName).DataType of}

                    end  {If (Table.FindField(Field_List[I]) <> nil)}
                  else
                    begin
                      ErrorCount := ErrorCount + 1;
                      Writeln(ErrorFile, 'Could not find field = ' +
                                          Field_List[I] + ' in table ' +
                                          Table.TableName);
                    end;

              PostedOK := True;
              Post;

            except
              ErrorCount := ErrorCount + 1;
              PostedOK := False;
              Table.Cancel;
              Writeln(ErrorFile, 'Error posting record ' +
                                 IntToStr(RecNumber) + '.' +
                                 ' For The ' + Table.TableName + ' Table');
            end;

          If PostedOK
            then PostedCount := PostedCount + 1;

          ProgressLabel.Caption := 'Imported = ' + IntToStr(PostedCount);

          (*RecCountLabel.Caption := 'Record = ' + IntToStr(RecNumber);
          ErrorCountLabel.Caption := 'Error Count = ' + IntToStr(ErrorCount);
          PostedCountLabel.Caption := 'Posted Count = ' + IntToStr(Posted);*)
          Application.ProcessMessages;
          RecNumber := RecNumber + 1;

        until Done;

      end;  {If not EOF(ImportFile)}

  CloseFile(ImportFile);
  CloseFile(ErrorFile);

  Field_List.Free;
  Field_Values.Free;
  ProgressLabel.Visible := False;

  Result := True;
  ResultMsg := 'The table ' + Table.TableName + ' was successfully imported from the file ' +
               FileName + '.  There were ' + IntToStr(PostedCount) + ' records imported.';

end;  {ImportTable}

{===================================================}
Function ReplaceValueFromFile(    Table : TTable;
                                  FileName : String;
                                  ProgressLabel : TLabel;
                              var ResultMsg : String) : Boolean;

var
  ErrorFile, ImportFile, flCodes, flLog : TextFile;
  RecNumber : LongInt;
  Field_Values, slReplacementValues, slOriginalValues : TStringList;
  sTableName, sFieldName, sFieldValue, sCodeFileName : String;
  TempStr : String;
  iPos : Integer;

begin
  RecNumber := 1;
  ProgressLabel.Visible := True;
  Field_Values := TStringList.Create;

  AssignFile(ImportFile, FileName);
  Reset(ImportFile);
  AssignFile(ErrorFile, 'c:\error.txt');
  Rewrite(ErrorFile);

  while not EOF(ImportFile) do
  begin
    Readln(ImportFile, TempStr);
    ParseCommaDelimitedStringIntoFields(TempStr, Field_Values, False);

    If (Field_Values[0] = 'TABLE')
    then sTableName := Field_Values[1];

    If (Field_Values[0] = 'FIELD')
    then sFieldName := Field_Values[1];

    If (Field_Values[0] = 'REPLACEMENTLIST')
    then
    begin
      sCodeFileName := Field_Values[1];
      AssignFile(flCodes, sCodeFileName);
      Reset(flCodes);

      slOriginalValues := TStringList.Create;
      slReplacementValues := TStringList.Create;

      while not EOF(flCodes) do
      begin
        Readln(flCodes, TempStr);
        ParseCommaDelimitedStringIntoFields(TempStr, Field_Values, False);
        slOriginalValues.Add(Field_Values[0]);
        slReplacementValues.Add(Field_Values[1]);
      end;  {while not EOF(flCodes) do}

      CloseFile(flCodes);

      AssignFile(flLog, 'c:\temp\log\' + sTableName + '_' + sFieldName + '.txt');
      Rewrite(flLog);

      with Table do
      try
        Close;
        TableName := sTableName;
        Open;
        First;

        while not EOF do
        begin
          sFieldValue := FieldByName(sFieldName).AsString;
          iPos := slOriginalValues.IndexOf(sFieldValue);

          If (iPos > -1)
          then
          try
            Edit;
            FieldByName(sFieldName).AsString := slReplacementValues[iPos];
            Writeln(flLog, FieldByName('SwisSBLKey').AsString, ',', slOriginalValues[iPos], ',', slReplacementValues[iPos]);
            Post;
          except
          end;

          ProgressLabel.Caption := 'Imported (' + sTableName + ')= ' + IntToStr(RecNumber);

          Application.ProcessMessages;
          RecNumber := RecNumber + 1;
          Next;

        end;  {If _Compare(Field_Values[0], 'REPLACEMENTLIST')}

      except
        MessageDlg('Error opening table ' + sTableName + '.', mtError, [mbOK], 0);
      end;

      slReplacementValues.Free;
      slOriginalValues.Free;
      CloseFile(flLog);

    end;  {slReplacementValues}

  end;  {If not EOF(ImportFile)}

  CloseFile(ImportFile);
  CloseFile(ErrorFile);

  Field_Values.Free;
  ProgressLabel.Visible := False;

  Result := True;
  ResultMsg := 'The table ' + Table.TableName + ' was successfully imported from the file ' +
               FileName + '.  There were ' + IntToStr(RecNumber) + ' records imported.';

end;  {ImportTable}


{===================================================}
Function SetBDEConfigParameter(    ParameterName : String;
                                   ParameterValue : String;
                               var ResultMsg : String) : Boolean;

var
  ParameterPath : String;

begin
  If (ParameterName = 'DBASEVERSION')
    then ParameterPath := DBASEVERSION;
  If (ParameterName = 'DBASETYPE')
    then ParameterPath := DBASETYPE;
  If (ParameterName = 'DBASELANGDRIVER')
    then ParameterPath := DBASELANGDRIVER;
  If (ParameterName = 'DBASELEVEL')
    then ParameterPath := DBASELEVEL;
  If (ParameterName = 'DBASEMDXBLOCKSIZE')
    then ParameterPath := DBASEMDXBLOCKSIZE;
  If (ParameterName = 'DBASEMEMOFILEBLOCKSIZE')
    then ParameterPath := DBASEMEMOFILEBLOCKSIZE;
  If (ParameterName = 'AUTOODBC')
    then ParameterPath := AUTOODBC;
  If (ParameterName = 'DATAREPOSITORY')
    then ParameterPath := DATAREPOSITORY;
  If (ParameterName = 'DEFAULTDRIVER')
    then ParameterPath := DEFAULTDRIVER;
  If (ParameterName = 'LANGDRIVER')
    then ParameterPath := LANGDRIVER;
  If (ParameterName = 'LOCALSHARE')
    then ParameterPath := LOCALSHARE;
  If (ParameterName = 'LOWMEMORYUSAGELIMIT')
    then ParameterPath := LOWMEMORYUSAGELIMIT;
  If (ParameterName = 'MAXBUFSIZE')
    then ParameterPath := MAXBUFSIZE;
  If (ParameterName = 'MAXFILEHANDLES')
    then ParameterPath := MAXFILEHANDLES;
  If (ParameterName = 'MEMSIZE')
    then ParameterPath := MEMSIZE;
  If (ParameterName = 'MINBUFSIZE')
    then ParameterPath := MINBUFSIZE;
  If (ParameterName = 'MTSPOOLING')
    then ParameterPath := MTSPOOLING;
  If (ParameterName = 'SHAREDMEMLOCATION')
    then ParameterPath := SHAREDMEMLOCATION;
  If (ParameterName = 'SHAREDMEMSIZE')
    then ParameterPath := SHAREDMEMSIZE;
  If (ParameterName = 'SQLQRYMODE')
    then ParameterPath := SQLQRYMODE;
  If (ParameterName = 'SYSFLAGS')
    then ParameterPath := SYSFLAGS;
  If (ParameterName = 'VERSION')
    then ParameterPath := VERSION;

  Result := SetConfigParameter(ParameterPath, ParameterValue, ResultMsg);

end;  {SetBDEConfigParameter}

{===================================================}
Function CreateBDEAlias(    AliasName : String;
                            AliasPath : String;
                        var ResultMsg : String) : Boolean;

var
  Error : Boolean;

begin
  Error := False;

  with Session do
    try
      ConfigMode := cmPersistent;
      AddStandardAlias(AliasName, AliasPath, 'DBASE');
      SaveConfigFile;
    except
      Error := True;
      ResultMsg := 'Alias ' + AliasName + ' was NOT added successfully.';
      Result := False;
    end;

  If not Error
    then
      begin
        Result := True;
        ResultMsg := 'Alias ' + AliasName + ' was added successfully.'
      end;

end;  {CreateBDEAlias}

{===================================================}
{===================================================}
Constructor TDBaseActionObject.Create;

begin
  inherited Create;
  ActionList := TList.Create;
  SuccessfulResultList := TStringList.Create;
  UnsuccessfulResultList := TStringList.Create;
  ActionRecordSize := SizeOf(ActionRecord);

end;  {Create}

{===================================================}
Function TDBaseActionObject.GetActionCount : Integer;

begin
  Result := ActionList.Count;
end;

{===================================================}
Function TDBaseActionObject.GetActionNameForActionType(ActionType : Integer) : String;

begin
  case ActionType of
    acAddField : Result := 'Add Field';
    acDropField : Result := 'Drop Field';
    acAddIndex : Result := 'Add Index';
    acDropIndex : Result := 'Drop Index';
    acPack : Result := 'Pack';
    acReindex : Result := 'Reindex';
    acExportTable : Result := 'Export Table';
    acImportTable : Result := 'Import Table';
    acSetConfigParameter : Result := 'Set Parameter';
    acCreateBDEAlias : Result := 'Create Alias';
    acEmptyTable : Result := 'Empty Table';
    acPackReindexTable : Result := 'Pack & Reindex';
    acEmptyPackReindexTable : Result := 'Empty, Pack & Reindex';
    acReplaceValueFromFile : Result := 'Replace Value from File';

  end;  {case ActionType of}

end;  {GetActionNameForActionType}

{===================================================}
Function TDBaseActionObject.GetMainValueForActionType(ActionRec : ActionRecord) : String;

begin
  with ActionRec do
    case ActionType of
      acAddField : Result := FieldName;
      acDropField : Result := FieldName;
      acAddIndex : Result := IndexName;
      acDropIndex : Result := IndexName;
      acPack : Result := '';
      acReindex : Result := '';
      acExportTable : Result := FileName;
      acImportTable : Result := FileName;
      acSetConfigParameter : Result := ParameterName + '=' + ParameterValue;
      acCreateBDEAlias : Result := AliasName;
      acEmptyTable : Result := '';
      acPackReindexTable : Result := '';
      acEmptyPackReindexTable : Result := '';
      acReplaceValueFromFile : Result := '';

    end;  {case ActionType of}

end;  {GetMainValueForActionType}

{===================================================}
Procedure TDBaseActionObject.AddAction(ActionRec : ActionRecord;
                                       Index : Integer);  {Where to insert}

var
  TempPtr : ActionRecordPointer;

begin
  New(TempPtr);

  with TempPtr^ do
    begin
      DatabaseName := ActionRec.DatabaseName;
      TableName := ActionRec.TableName;
      ActionType := ActionRec.ActionType;
      FieldName := ActionRec.FieldName;
      FieldType := ActionRec.FieldType;
      FieldLength := ActionRec.FieldLength;
      IndexName := ActionRec.IndexName;
      IndexExpression := ActionRec.IndexExpression;
      IndexOptions := ActionRec.IndexOptions;
      FileName := ActionRec.FileName;
      ParameterName := ActionRec.ParameterName;
      ParameterValue := ActionRec.ParameterValue;
      AliasName := ActionRec.AliasName;
      AliasPath := ActionRec.AliasPath;
      HeadersOnFirstLine := ActionRec.HeadersOnFirstLine;
      ClearTablePriorToImport := ActionRec.ClearTablePriorToImport;

    end;  {with TempPtr^ do}

  ActionList.Insert(Index, TempPtr);

end;  {AddAction}

{===================================================}
Procedure TDBaseActionObject.DeleteAction(Index : Integer);

var
  TempCount : Integer;

begin
(*  FreeMem(ActionList[Index], ActionRecordSize);
  ActionList.Pack; *)
  TempCount := ActionList.Count;
  ActionList.Delete(Index);
  ActionList.Capacity := TempCount - 1;
  
end;  {DeleteAction}

{===================================================}
Procedure TDBaseActionObject.UpdateAction(ActionRec : ActionRecord;
                                          Index : Integer);  {Which action to update.}

begin
  DeleteAction(Index);
  AddAction(ActionRec, Index);
end;  {UpdateAction}

{===================================================}
Function TDBaseActionObject.GetAction(Index : Integer) : ActionRecord;

begin
  Result := ActionRecordPointer(ActionList[Index])^;
end;  {GetAction}

{===================================================}
Procedure TDBaseActionObject.SwitchActions(Index1 : Integer;
                                           Index2 : Integer);

var
  TempAction : ActionRecordPointer;

begin
  TempAction := ActionList[Index1];
  ActionList[Index1] := ActionList[Index2];
  ActionList[Index2] := TempAction;

end;  {SwitchActions}

{===================================================}
Procedure TDBaseActionObject.ClearActions;

begin
  ClearTList(ActionList, ActionRecordSize);
end;  {ClearActions}

{===================================================}
Function TDBaseActionObject.WriteActionsToFile(FileName : String) : Boolean;

var
  I : Integer;
  ActionRec : ActionRecord;
  ActionFile : TextFile;

begin
  AssignFile(ActionFile, FileName);
  Rewrite(ActionFile);

  For I := 0 to (ActionList.Count - 1) do
    begin
      ActionRec := GetAction(I);

      with ActionRec do
        Writeln(ActionFile, '"', DatabaseName, '",',
                            '"', TableName, '",',
                            '"', ActionType, '",',
                            '"', FieldName, '",',
                            '"', FieldTypeToStr(FieldType), '",',
                            '"', IntToStr(FieldLength), '",',
                            '"', IndexName, '",',
                            '"', IndexExpression, '",',
                            '"', IndexOptionsToStr(IndexOptions), '",',
                            '"', FileName, '",',
                            '"', ParameterName, '",',
                            '"', ParameterValue, '",',
                            '"', AliasName, '",',
                            '"', AliasPath, '",',
                            '"', BoolToStr(HeadersOnFirstLine), '",',
                            '"', BoolToStr(ClearTablePriorToImport), '"');

    end;  {For I := 0 to (ActionList.Count - 1) do}

  CloseFile(ActionFile);

end;  {WriteActionsToFile}

{===================================================}
Function TDBaseActionObject.LoadActionsFromFile(FileName : String) : Boolean;

var
  Done : Boolean;
  ActionFile : Text;
  TempStr : String;
  ActionNumber : Integer;
  ActionRec : ActionRecord;

begin
  Done := False;
  AssignFile(ActionFile, FileName);
  Reset(ActionFile);
  ActionNumber := 0;
  ClearActions;

  repeat
    Readln(ActionFile, TempStr);

    If EOF(ActionFile)
      then Done := True;

    ActionRec := GetEmptyActionRecord;

    with ActionRec do
      begin
        DatabaseName := ParseField(TempStr, 1);
        TableName := ParseField(TempStr, 2);

        try
          ActionType := StrToInt(ParseField(TempStr, 3));
        except
        end;

        FieldName := ParseField(TempStr, 4);

        try
          FieldType := StrToFieldType(ParseField(TempStr, 5));
        except
        end;

        try
          FieldLength := StrToInt(ParseField(TempStr, 6));
        except
        end;

        IndexName := ParseField(TempStr, 7);
        IndexExpression := ParseField(TempStr, 8);

        try
          IndexOptions := StrToIndexOptions(ParseField(TempStr, 9));
        except
        end;

        FileName := ParseField(TempStr, 10);
        ParameterName := ParseField(TempStr, 11);
        ParameterValue := ParseField(TempStr, 12);
        AliasName := ParseField(TempStr, 13);
        AliasPath := ParseField(TempStr, 14);
        HeadersOnFirstLine := StrToBool(ParseField(TempStr, 15));
        ClearTablePriorToImport := StrToBool(ParseField(TempStr, 16));

      end;  {with ActionRec do}

    AddAction(ActionRec, ActionNumber);

    ActionNumber := ActionNumber + 1;

  until Done;

  CloseFile(ActionFile);

end;  {LoadActionsFromFile}

{===================================================}
Procedure TDBaseActionObject.AddResult(ActionRec : ActionRecord;
                                       ResultMsg : String;
                                       Successful : Boolean);

begin
  If Successful
    then SuccessfulResultList.Add(ResultMsg)
    else UnsuccessfulResultList.Add(ResultMsg);

end;  {AddResult}

{===================================================}
Function TDBaseActionObject.ExecuteAction(Index : Integer;
                                          RunHidden : Boolean;
                                          ProgressLabel : TLabel) : Boolean;

var
  ActionRec : ActionRecord;
  Table : TTable;
  ResultMsg : String;
  Successful : Boolean;

begin
  ActionRec := GetAction(Index);
  Table := TTable.Create(nil);
  Successful := True;

    {If a table is needed for this action, open it exclusive.}

  If ((ActionRec.TableName <> '') and
      (ActionRec.DatabaseName <> ''))
    then
      try
        Table.DatabaseName := ActionRec.DatabaseName;
        Table.TableName := ActionRec.TableName;
        Table.TableType := ttDBase;
        If (ActionRec.ActionType = acReplaceValueFromFile)
        then Table.Exclusive := False
        else Table.Exclusive := True;
        Table.Open;
      except
        Successful := False;
        ResultMsg := 'Could not open table exclusive.';
      end;

  with ActionRec do
    case ActionType of
      acAddField : If (Table.FindField(ActionRec.FieldName) = nil)
                     then Successful := AddField(Table, ActionRec.FieldName,
                                                 ActionRec.FieldType,
                                                 ActionRec.FieldLength,
                                                 ResultMsg)
                     else
                       begin
                         Successful := False;
                         ResultMsg := 'Field ' + ActionRec.FieldName +
                                      ' already exists in the table' +
                                      ActionRec.TableName + '.';
                       end;

      acDropField :  If (Table.FindField(ActionRec.FieldName) = nil)
                       then
                         begin
                           Successful := False;
                           ResultMsg := 'Field does not exist in the table.';
                         end
                       else Successful := DropField(Table, ActionRec.FieldName, ResultMsg);

      acAddIndex : If (Table.IndexDefs.IndexOf(ActionRec.IndexName) > -1)
                     then
                       begin
                         Successful := False;
                         ResultMsg := 'Index already exists in the table.';
                       end
                     else Successful := AddIndex(Table, ActionRec.IndexName,
                                                 ActionRec.IndexExpression, ActionRec.IndexOptions,
                                                 ResultMsg);

      acDropIndex : begin
                      Table.IndexDefs.Update;

                      If (Table.IndexDefs.IndexOf(ActionRec.IndexName) > -1)
                        then Successful := DropIndex(Table, ActionRec.IndexName, ResultMsg)
                        else
                          begin
                            Successful := False;
                            ResultMsg := 'Index does not exist in the table.';
                          end;

                    end;  {acDropIndex}

      acPack : Successful := PackTable(Table, ResultMsg);
      acReindex : Successful := ReindexTable(Table, ResultMsg);
      acExportTable : Successful := ExportTable(Table, ActionRec.FileName,
                                                ActionRec.HeadersOnFirstLine,
                                                ResultMsg);
      acImportTable : Successful := ImportTable(Table, ActionRec.FileName,
                                                ActionRec.ClearTablePriorToImport,
                                                ProgressLabel, ResultMsg);
      acSetConfigParameter : Successful := SetBDEConfigParameter(ActionRec.ParameterName,
                                                                 ActionRec.ParameterValue,
                                                                 ResultMsg);
      acCreateBDEAlias : Successful := CreateBDEAlias(ActionRec.AliasName,
                                                      ActionRec.AliasPath,
                                                      ResultMsg);

      acEmptyTable : Successful := _EmptyTable(Table, ResultMsg);

      acPackReindexTable : Successful := PackAndReindex(Table, ResultMsg);

      acEmptyPackReindexTable : Successful := Empty_Pack_And_Reindex(Table, ResultMsg);

(*      acChangeField : If (Table.FindField(ActionRec.FieldName) = nil)
                        then Successful := ChangeField(Table, ActionRec.FieldName,
                                                       ActionRec.FieldType,
                                                       ActionRec.FieldLength,
                                                       ResultMsg)
                        else
                          begin
                            Successful := False;
                            ResultMsg := 'Field ' + ActionRec.FieldName +
                                         ' was not changed.' +
                                         ActionRec.TableName + '.';
                          end; *)

      acReplaceValueFromFile : Successful := ReplaceValueFromFile(Table, ActionRec.FileName,
                                                                  ProgressLabel, ResultMsg);

    end;  {case ActionType of}

  AddResult(ActionRec, ResultMsg, Successful);

  Table.Close;
  Table.Free;

end;  {ExecuteAction}

{===================================================}
Procedure TDBaseActionObject.DisplayResults(SuccessfulResultList,
                                            UnsuccessfulResultList : TStringList);

begin
  try
    ResultsDisplayForm := TResultsDisplayForm.Create(nil);

    with ResultsDisplayForm do
      begin
        SuccessfulListBox.Items.Assign(SuccessfulResultList);
        UnsuccessfulListBox.Items.Assign(UnsuccessfulResultList);
        ShowModal;

      end;  {with ResultsDisplayForm do}

  finally
    ResultsDisplayForm.Free;
  end;

end;  {DisplayResults}

{===================================================}
Procedure TDBaseActionObject.ExecuteAll(RunHidden : Boolean;
                                        ResultFileName : String;
                                        ProgressLabel : TLabel);

var
  I : Integer;
  ResultFile : TextFile;

begin
  SuccessfulResultList.Clear;
  UnsuccessfulResultList.Clear;

  If (ResultFileName = '')
    then ResultFileName := 'RESULTS.TXT';

  AssignFile(ResultFile, ResultFileName);
  Rewrite(ResultFile);

  For I := 0 to (ActionList.Count - 1) do
    ExecuteAction(I, RunHidden, ProgressLabel);

  If not RunHidden
    then DisplayResults(SuccessfulResultList,
                        UnsuccessfulResultList);

    {Now store the results in the results file.}

  Writeln(ResultFile, 'Successful:');
  For I := 0 to (SuccessfulResultList.Count - 1) do
    Writeln(ResultFile, '  ', SuccessfulResultList[I]);

  Writeln(ResultFile);

  Writeln(ResultFile, 'Unsuccessful:');
  For I := 0 to (UnsuccessfulResultList.Count - 1) do
    Writeln(ResultFile, '  ', UnsuccessfulResultList[I]);

  CloseFile(ResultFile);

end;  {ExecuteAll}

{===================================================}
Destructor TDBaseActionObject.Destroy;

begin
  FreeTList(ActionList, ActionRecordSize);
  SuccessfulResultList.Free;
  UnsuccessfulResultList.Free;
  inherited Destroy;

end;  {Destroy}

end.