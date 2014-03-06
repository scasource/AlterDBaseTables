unit SpecialFilterDialogUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DB, DBTables;

const
  sfNone = -1;
  sfStartsWith = 0;
  sfContains = 1;
  sfEndsWith = 2;

type
  TSpecialFilterDialog = class(TForm)
    ChooseFieldLabel: TLabel;
    FieldListBox: TListBox;
    StringFilterValueLabel: TLabel;
    OKButton: TBitBtn;
    CancelButton: TBitBtn;
    StringFilterValueEdit: TEdit;
    CaseSensitiveCheckBox: TCheckBox;
    procedure FieldListBoxClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    SpecialFilterMethod : Integer;
    TempQuery : TQuery;
    Table : TTable;
    FieldName, StringFilterValue : String;
    CaseSensitive : Boolean;
    Procedure TableFilterRecord(    DataSet: TDataSet;
                                var Accept: Boolean);

  end;

Function ExecuteSpecialFilterDialog(    _SpecialFilterMethod : Integer;
                                        _Table : TTable;
                                    var Operation : String;
                                    var LastResult : String) : Boolean;

var
  SpecialFilterDialog: TSpecialFilterDialog;

implementation

{$R *.DFM}

{===================================================}
Function ExecuteSpecialFilterDialog(    _SpecialFilterMethod : Integer;
                                        _Table : TTable;
                                    var Operation : String;
                                    var LastResult : String) : Boolean;

var
  ReturnResult : Integer;

begin
  try
    SpecialFilterDialog := TSpecialFilterDialog.Create(nil);

    with SpecialFilterDialog do
      begin
        SpecialFilterMethod := _SpecialFilterMethod;
        Table := _Table;
        Table.GetFieldNames(FieldListBox.Items);

        case SpecialFilterMethod of
          sfStartsWith :
            begin
              Caption := 'Filter on String Starting Value';
              StringFilterValueLabel.Caption := 'Starting value:';
            end;

          sfContains :
            begin
              Caption := 'Filter on Substring Value';
              StringFilterValueLabel.Caption := 'Substring:';
            end;

          sfEndsWith :
            begin
              Caption := 'Filter on String Starting Value';
              StringFilterValueLabel.Caption := 'Starting value:';
            end;

        end;  {case FindRecordMethod of}

        ReturnResult := ShowModal;

        Result := (ReturnResult = mrOK);

        case SpecialFilterMethod of
          sfStartsWith : Operation := 'Filter on field ' + FieldName +
                                      ' -> starts with ' + StringFilterValue + '.';
          sfContains : Operation := 'Filter on field ' + FieldName +
                                    ' -> contains ' + StringFilterValue + '.';
          sfEndsWith : Operation := 'Filter on field ' + FieldName +
                                    ' -> ends with ' + StringFilterValue + '.';

        end;  {case SpecialFilterMethod of}

        LastResult := 'Successful'

      end;  {with ConditionalCommandDialog do}

  finally
    SpecialFilterDialog.Free;
  end;

end;  {ExecuteSpecialFilterDialog}

{======================================================}
Procedure TSpecialFilterDialog.FieldListBoxClick(Sender: TObject);

begin
  FieldName := FieldListBox.Items[FieldListBox.ItemIndex];

  case SpecialFilterMethod of
    sfStartsWith : StringFilterValueLabel.Caption := 'Match the following starting value for field "' + FieldName + '":';
    sfContains : StringFilterValueLabel.Caption := 'Match the following substring value for field "' + FieldName + '":';
    sfEndsWith : StringFilterValueLabel.Caption := 'Match the following ending value for field "' + FieldName + '":';

  end;  {case SpecialFilterMethod of}

end;  {FieldListBoxClick}

{======================================================}
Procedure TSpecialFilterDialog.TableFilterRecord(    DataSet: TDataSet;
                                                 var Accept: Boolean);

var
  TempFieldValue : String;

begin
  Accept := False;

  TempFieldValue := Trim(DataSet.FieldByName(FieldName).Text);

  If not CaseSensitive
    then TempFieldValue := ANSIUpperCase(TempFieldValue);

  try
    case SpecialFilterMethod of
      sfStartsWith : Accept := (Pos(StringFilterValue, TempFieldValue) = 1);
      sfContains : Accept := (Pos(StringFilterValue, TempFieldValue) > 0);
      sfEndsWith : Accept := (Pos(StringFilterValue, TempFieldValue) =
                              (Length(TempFieldValue) - Length(StringFilterValue) + 1));
    end;

  except
  end;

end;  {TableFilterRecord}

{======================================================}
Procedure TSpecialFilterDialog.OKButtonClick(Sender: TObject);

var
  TempStr : String;
  I : Integer;
  Error : Boolean;

begin
  Error := False;

  Table.Filtered := False;

  FieldName := FieldListBox.Items[FieldListBox.ItemIndex];
  StringFilterValue := Trim(StringFilterValueEdit.Text);
  CaseSensitive := CaseSensitiveCheckBox.Checked;

  If not CaseSensitive
    then StringFilterValue := ANSIUpperCase(StringFilterValue);

  Table.OnFilterRecord := TableFilterRecord;
  Table.Filtered := True;

  If Error
    then ModalResult := mrAbort
    else ModalResult := mrOK;

end;  {OKButtonClick}

end.
