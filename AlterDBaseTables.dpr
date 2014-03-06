program AlterDBaseTables;

uses
  Forms,
  AlterDBaseTableUnit in 'AlterDBaseTableUnit.pas' {AlterDBaseTableForm},
  DBaseActionObject in 'DBaseActionObject.pas',
  FindRecordsDialogUnit in 'FindRecordsDialogUnit.pas' {FindRecordsDialog},
  ConditionalCommandDialogUnit in 'ConditionalCommandDialogUnit.pas' {ConditionalCommandDialog},
  CopyTableDataUnit in 'CopyTableDataUnit.pas' {CopyTableDataDialog},
  ResultsForm in 'ResultsForm.pas' {ResultsDisplayForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TAlterDBaseTableForm, AlterDBaseTableForm);
  Application.CreateForm(TFindRecordsDialog, FindRecordsDialog);
  Application.CreateForm(TConditionalCommandDialog, ConditionalCommandDialog);
  Application.CreateForm(TCopyTableDataDialog, CopyTableDataDialog);
  Application.Run;
end.
