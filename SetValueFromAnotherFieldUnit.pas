unit SetValueFromAnotherFieldUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DB, DBTables;

type
  TSetValueFromAnotherFieldDialog = class(TForm)
    ChooseFieldLabel: TLabel;
    FieldListBox: TListBox;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    DatabaseComboBox: TComboBox;
    Label9: TLabel;
    TableComboBox: TComboBox;
    FieldComboBox: TComboBox;
    Label1: TLabel;
    RecCountLabel: TLabel;
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DestinationTableName,
    DestinationTableDatabaseName,
    DestinationFieldName,
    SourceFieldName : String;
    DestinationTable : TTable;
  end;

Function ExecuteSetValueFromAnotherFieldDialog(    _Table : TTable;
                                               var Operation : String;
                                               var LastResult : String) : Boolean;

var
  SetValueFromAnotherFieldDialog: TSetValueFromAnotherFieldDialog;

implementation

{$R *.DFM}

{===================================================}
Function ExecuteSetValueFromAnotherFieldDialog(    _Table : TTable;
                                               var Operation : String;
                                               var LastResult : String) : Boolean;

var
  ReturnResult : Integer;

begin
  try
    SetValueFromAnotherFieldDialog := TSetValueFromAnotherFieldDialog.Create(nil);

    with SetValueFromAnotherFieldDialog do
      begin
        DestinationTable := _Table;
        DestinationTable.GetFieldNames(FieldListBox.Items);
        DestinationTable.GetFieldNames(FieldComboBox.Items);

        ReturnResult := ShowModal;

        Result := (ReturnResult = mrOK);

          {Compose the last operation and the result.}

        Operation := 'Set field ' + DestinationFieldName +
                     ' from field ' + SourceFieldName;

        If Result
          then LastResult := 'Successful'
          else LastResult := 'Not Successful';

      end;  {with ConditionalCommandDialog do}

  finally
    SetValueFromAnotherFieldDialog.Free;
  end;

end;  {ExecuteSetValueFromAnotherFieldDialog}

{======================================================}
Procedure TSetValueFromAnotherFieldDialog.OKButtonClick(Sender: TObject);

var
  FirstTimeThrough, Done, Error : Boolean;
(*  DestinationTable, SourceTable : TTable;*)
  SourceTableName, SourceTableDatabaseName : String;
  RecCount : Integer;

begin
  Error := False;
  Done := False;
  FirstTimeThrough := True;
  RecCount := 0;

  SourceTableName := TableComboBox.Items[TableComboBox.ItemIndex];
  SourceTableDatabaseName := DatabaseComboBox.Items[DatabaseComboBox.ItemIndex];
  SourceFieldName := FieldComboBox.Items[FieldComboBox.ItemIndex];
  DestinationFieldName := FieldListBox.Items[FieldListBox.ItemIndex];

(*  DestinationTable := TTable.Create(nil);

  with DestinationTable do
    begin
      DatabaseName := DestinationTableDatabaseName;
      TableType := ttDBase;
      TableName := DestinationTableName;
    end; *)

(*  SourceTable := TTable.Create(nil);

  with SourceTable do
    begin
      DatabaseName := SourceTableDatabaseName;
      TableType := ttDBase;
      TableName := SourceTableName;
    end; *)

  DestinationTable.First;

  repeat
    If FirstTimeThrough
      then FirstTimeThrough := False
      else DestinationTable.Next;

    If DestinationTable.EOF
      then Done := True;

    RecCount := RecCount + 1;
    RecCountLabel.Caption := IntToStr(RecCount);
    Application.ProcessMessages;

    If not Done
      then
        with DestinationTable do
          try
            Edit;
            FieldByName(DestinationFieldName).Text := FieldByName(SourceFieldName).Text;
            Post;
          except
            Error := True;
            MessageDlg('Error updating field for table ' + DestinationTable.TableName + '.',
                       mtError, [mbOK], 0);
          end;

  until Done;

  If Error
    then ModalResult := mrAbort
    else ModalResult := mrOK;

end;  {OKButtonClick}

end.
