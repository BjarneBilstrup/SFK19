page 50105 "BAL Get Date To Dialog"
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
            field(leadtxt; leadtxt)
            {
                ApplicationArea = Jobs;
                Caption = '';
                ToolTip = 'Tooltip';
            }
            field(CustomerNo; CustomerNo)
            {
                ApplicationArea = Jobs;
                Caption = 'Angiv startdato';
                ToolTip = 'Tooltip';
                trigger OnValidate()
                begin

                end;
            }
            field(Datefield; Datefield)
            {
                ApplicationArea = Jobs;
                Caption = 'Angiv startdato';
                ToolTip = 'Tooltip';

                trigger OnValidate()
                begin
                end;
            }
            field(DateTofield; DateTofield)
            {
                ApplicationArea = Jobs;
                Caption = 'Slut dato';
                ToolTip = 'Tooltip';

                trigger OnValidate()
                begin
                end;
            }
            field(StartTime; StartTime)
            {
                ApplicationArea = Jobs;
                Caption = 'Starttime';
                ToolTip = 'Start på lokaleudlejning';

                trigger OnValidate()
                begin
                end;
            }
            field(EndTime; EndTime)
            {
                ApplicationArea = Jobs;
                Caption = 'Slut tid';
                ToolTip = 'Slut på udlejning';

                trigger OnValidate()
                begin
                end;
            }
        }
    }
    var
        leadtxt: Text;
        Datefield: Date;
        DateTofield: Date;
        StartTime: Time;
        EndTime: Time;
        CustomerNo: Code[20];

    procedure SetData(PLeadTxt: text)
    begin
        leadtxt := PLeadTxt;
        //Datefield := Pdatefield;
    end;

    procedure Getdata(var pdatefield: Date; pdateTofield: Date; var PStarttime: Time; Var PEndTime: Time; PCustomerNo: code[20])
    begin
        pdatefield := Datefield;
        pdateTofield := DateTofield;
        PStarttime := StartTime;
        PEndTime := EndTime;
        PCustomerNo := CustomerNo;
    end;
}
