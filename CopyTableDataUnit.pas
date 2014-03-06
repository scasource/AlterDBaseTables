unit CopyTableDataUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DB, DBTables;

type
  TCopyTableDataDialog = class(TForm)
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    SourceDatabaseComboBox: TComboBox;
    Label9: TLabel;
    SourceTableComboBox: TComboBox;
    RecCountLabel: TLabel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    DestinationDatabaseComboBox: TComboBox;
    DestinationTableComboBox: TComboBox;
    procedure OKButtonClick(Sender: TObject);
    procedure DatabaseComboBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DestinationTableName,
    SourceTableName : String;
  end;

Function ExecuteCopyTableDataDialog(var Operation : String;
                                    var LastResult : String) : Boolean;

var
  CopyTableDataDialog: TCopyTableDataDialog;

implementation

{$R *.DFM}

{===================================================}
Function ExecuteCopyTableDataDialog(var Operation : String;
                                    var LastResult : String) : Boolean;

var
  ReturnResult : Integer;

begin
  try
    CopyTableDataDialog := TCopyTableDataDialog.Create(nil);

    with CopyTableDataDialog do
      begin
        Session.GetDatabaseNames(SourceDatabaseComboBox.Items);
        Session.GetDatabaseNames(DestinationDatabaseComboBox.Items);

        ReturnResult := ShowModal;

        Result := (ReturnResult = mrOK);

          {Compose the last operation and the result.}

        Operation := 'Copy data from ' + SourceTableName +
                     ' to ' + DestinationTableName + '.';

        If Result
          then LastResult := 'Successful'
          else LastResult := 'Not Successful';

      end;  {with CopyTableDataDialog do}

  finally
    CopyTableDataDialog.Free;
  end;

end;  {ExecuteCopyTableDataDialog}

{======================================================}
Procedure TCopyTableDataDialog.DatabaseComboBoxChange(Sender: TObject);

var
  TempTableComboBox : TComboBox;

begin
  If (Pos('Source', TComboBox(Sender).Name) > 0)
    then TempTableComboBox := SourceTableComboBox
    else TempTableComboBox := DestinationTableComboBox;

  with Sender as TComboBox do
    If (Items.IndexOf(Text) > -1)  {Is it a whole database name?}
      then Session.GetTableNames(Items[ItemIndex],
                                 '*.*', False, False, TempTableComboBox.Items);

end;  {DatabaseComboBoxChange}

{======================================================}
Procedure TCopyTableDataDialog.OKButtonClick(Sender: TObject);

var
  FirstTimeThrough, Done, Error : Boolean;
  DestinationTable, SourceTable : TTable;
  DestinationTableDatabaseName,
  SourceTableDatabaseName : String;
  I, RecCount : Integer;

begin
  Error := False;
  Done := False;
  FirstTimeThrough := True;
  RecCount := 0;

  SourceTableName := SourceTableComboBox.Items[SourceTableComboBox.ItemIndex];
  SourceTableDatabaseName := SourceDatabaseComboBox.Items[SourceDatabaseComboBox.ItemIndex];
  DestinationTableName := DestinationTableComboBox.Items[DestinationTableComboBox.ItemIndex];
  DestinationTableDatabaseName := DestinationDatabaseComboBox.Items[DestinationDatabaseComboBox.ItemIndex];

  SourceTable := TTable.Create(nil);

  with SourceTable do
    begin
      DatabaseName := SourceTableDatabaseName;
      TableType := ttDBase;
      TableName := SourceTableName;
    end;

  try
    SourceTable.Open;
  except
    MessageDlg('Error opening source table ' + SourceTableName + '.',
                mtError, [mbOK], 0);
  end;

  DestinationTable := TTable.Create(nil);

  with DestinationTable do
    begin
      DatabaseName := DestinationTableDatabaseName;
      TableType := ttDBase;
      TableName := DestinationTableName;
    end;

  try
    DestinationTable.Open;
  except
    MessageDlg('Error opening Destination table ' + DestinationTableName + '.',
                mtError, [mbOK], 0);
  end;

  SourceTable.First;

  repeat
    If FirstTimeThrough
      then FirstTimeThrough := False
      else SourceTable.Next;

    If SourceTable.EOF
      then Done := True;

    RecCount := RecCount + 1;
    RecCountLabel.Caption := IntToStr(RecCount);
    Application.ProcessMessages;

    If not Done
      then
        with DestinationTable do
          try
            Insert;

            For I := 0 to (SourceTable.Fields.Count - 1) do
              try
                FieldByName(SourceTable.Fields[I].FieldName).Text :=
                      SourceTable.FieldByName(SourceTable.Fields[I].FieldName).Text;
              except
              end;

            Post;
          except
            Error := True;
            Cancel;
            MessageDlg('Error inserting record into table ' + DestinationTable.TableName + '.',
                       mtError, [mbOK], 0);
          end;

  until Done;

  If Error
    then ModalResult := mrAbort
    else ModalResult := mrOK;

  SourceTable.Close;
  SourceTable.Free;

  DestinationTable.Close;
  DestinationTable.Free;

end;  {OKButtonClick}


end.
