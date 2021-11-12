page 50102 "BAL Get Date Dialog"
{
    ApplicationArea = Jobs;
    Caption = 'Get date dialog';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = StandardDialog;
    RefreshOnActivate = true;
    SaveValues = false;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(Matrixindstillinger)
            {
                Caption = 'Set values';
            }
            field(leadtxt;leadtxt)
            {
                ApplicationArea = Jobs;
                Caption = '';
                ToolTip = 'Tooltip';
            }
            field(Datefield;Datefield)
            {
                ApplicationArea = Jobs;
                Caption = 'Angiv dato';
                ToolTip = 'Tooltip';

                trigger OnValidate()begin
                end;
            }
            field(RepSelection;RepSelection)
            {
                ApplicationArea = Jobs;
                Caption = 'Angiv antal gange';
                ToolTip = 'Tooltip';

                trigger OnValidate()begin
                end;
            }
        }
    }
    var leadtxt: text;
    Datefield: date;
    RepSelection: integer;
    procedure SetData(PLeadTxt: text)begin
        leadtxt:=PLeadTxt;
    //Datefield := Pdatefield;
    end;
    procedure Getdata(var pdatefield: Date;
    var PRepSelection: integer)begin
        pdatefield:=Datefield;
        PRepSelection:=RepSelection;
    end;
}
