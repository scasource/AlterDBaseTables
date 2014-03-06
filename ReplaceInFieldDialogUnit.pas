unit ReplaceInFieldDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DB, DBTables, ComCtrls;

type
  TReplaceInFieldDialog = class(TForm)
    ChooseFieldLabel: TLabel;
    FieldListBox: TListBox;
    ConditionalMemoLabel: TLabel;
    ConditionalCommandMemo: TMemo;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    NewValueLabel: TLabel;
    TextToFindEdit: TEdit;
    ReplaceWithEdit: TEdit;
    Label1: TLabel;
    ProgressBar: TProgressBar;
    cbExactMatchOnly: TCheckBox;
    procedure FieldListBoxClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Table : TTable;
    FieldName : String;
    NumberOfFieldsReplaced : LongInt;
  end;

Function ExecuteReplaceInFieldDialog(    _Table : TTable;
                                     var Operation : String;
                                     var LastResult : String) : Boolean;

var
  ReplaceInFieldDialog: TReplaceInFieldDialog;

implementation

{$R *.DFM}

{===================================================}
Function ExecuteReplaceInFieldDialog(    _Table : TTable;
                                     var Operation : String;
                                     var LastResult : String) : Boolean;

var
  I, ReturnResult : Integer;

begin
  try
    ReplaceInFieldDialog := TReplaceInFieldDialog.Create(nil);

    with ReplaceInFieldDialog do
      begin
        Table := _Table;
        Table.GetFieldNames(FieldListBox.Items);

        ReturnResult := ShowModal;

        Result := (ReturnResult = mrOK);

          {Compose the last operation and the result.}

        Operation := 'Replace text ' + TextToFindEdit.Text + ' in field ' + FieldName +
                     ' with ' + ReplaceWithEdit.Text;

        If (ConditionalCommandMemo.Lines.Count > 0)
          then
            begin
              Operation := Operation + ' where';

              For I := 0 to (ConditionalCommandMemo.Lines.Count - 1) do
                Operation := Operation + ' ' + ConditionalCommandMemo.Lines[I];
            end
          else Operation := Operation + ' for all rows.';

        If Result
          then LastResult := IntToStr(NumberOfFieldsReplaced) + ' fields replaced.';

      end;  {with ConditionalCommandDialog do}

  finally
    ReplaceInFieldDialog.Free;
  end;

end;  {ExecuteReplaceInFieldDialog}

{======================================================}
Procedure TReplaceInFieldDialog.FieldListBoxClick(Sender: TObject);

begin
  FieldName := FieldListBox.Items[FieldListBox.ItemIndex];
end;  {FieldListBoxClick}

{======================================================}
Procedure TReplaceInFieldDialog.OKButtonClick(Sender: TObject);

var
  Done, FirstTimeThrough : Boolean;
  FindTextStr, ReplacementStr, FieldName, FieldValue : String;
  FindTextLength, SubstrPos : Integer;
  Error, bExactMatchOnly, bFound : Boolean;

begin
  Error := False;
  FindTextStr := Trim(TextToFindEdit.Text);
  FindTextLength := Length(FindTextStr);
  ReplacementStr := ReplaceWithEdit.Text;
  FieldName := FieldListBox.Items[FieldListBox.ItemIndex];
  bExactMatchOnly := cbExactMatchOnly.Checked;

  NumberOfFieldsReplaced := 0;

  Table.Filtered := False;
  Table.Filter := ConditionalCommandMemo.Text;

  If (Trim(Table.Filter) <> '')
    then
      try
        Table.Filtered := True;
      except
        Error := True;
        MessageDlg('The filter you entered is not valid.' + #13 +
                   'Please re-enter.', mtError, [mbOK], 0);
        Abort;
      end;

  Done := False;
  FirstTimeThrough := True;
  Table.First;
  ProgressBar.Max := Table.RecordCount;

  repeat
    If FirstTimeThrough
      then FirstTimeThrough := False
      else Table.Next;

    If Table.EOF
      then Done := True;

    ProgressBar.Position := ProgressBar.Position + 1;
    Application.ProcessMessages;

    If not Done
      then
        begin
          FieldValue := Table.FieldByName(FieldName).Text;
          bFound := False;

          If bExactMatchOnly
          then
          begin
            If (Trim(FindTextStr) = Trim(FieldValue))
            then
            begin
              bFound := True;
              FieldValue := ReplacementStr;
            end;
          end
          else
          begin
            SubstrPos := Pos(FindTextStr, FieldValue);

            If (SubStrPos > 0)
            then
            begin
              bFound := True;
              Delete(FieldValue, SubStrPos, FindTextLength);
              FieldValue := Copy(FieldValue, 1, (SubstrPos - 1)) + ReplacementStr +
                            Copy(FieldValue, SubstrPos, 10000);
            end;  {If (SubStrPos > 0)}

          end;  {else of If bExactMatchOnly}

          If bFound
          then
            with Table do
              try
                Inc(NumberOfFieldsReplaced);
                Edit;

                (*If (FieldByName(FieldName).DataType = ftMemo)
                then TMemoField(FieldByName(FieldName)).
                else FieldByName(FieldName).Text := FieldValue; *)

                FieldByName(FieldName).AsString := FieldValue;

                Post;
              except
              end;

        end;  {If not Done}

  until Done;

  If Error
    then ModalResult := mrAbort
    else ModalResult := mrOK;

end;  {OKButtonClick}

end.
