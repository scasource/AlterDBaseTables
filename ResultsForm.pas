unit ResultsForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TResultsDisplayForm = class(TForm)
    SuccessfulListBox: TListBox;
    OKButton: TBitBtn;
    UnsuccessfulListBox: TListBox;
    Label1: TLabel;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ResultsDisplayForm: TResultsDisplayForm;

implementation

{$R *.DFM}

end.
