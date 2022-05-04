page 50105 "BAL Get Date To Dialog"
{
    ApplicationArea = Jobs;
    Caption = 'Get dates dialog';
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
                ApplicationArea = all;
                Caption = '';
                ToolTip = 'Tooltip';
            }
            field(CustomerNo; CustomerNo)
            {
                ApplicationArea = all;
                Caption = 'Angiv Kundenr';
                ToolTip = 'Tooltip';
                trigger OnValidate()
                begin

                end;
            }
            field(SalesheaderNo; Salesheader."no.")
            {
                ApplicationArea = all;
                Caption = 'Tilføj ordre';
                ToolTip = 'Tooltip';

                trigger OnValidate()
                begin

                end;

            }
            field(Datefield; Datefield)
            {
                ApplicationArea = all;
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
        Customer: Record customer;
        CustomerNo: code[20];
        Salesheader: Record "Sales Header";

    procedure SetData(PLeadTxt: text)
    begin
        leadtxt := PLeadTxt;
        //Datefield := Pdatefield;
    end;

    procedure Getdata(var pdatefield: Date; var pdateTofield: Date; var PStarttime: Time; Var PEndTime: Time; var PCustomerNo: code[20]; var PSalesheaderNo: code[20])
    begin
        pdatefield := Datefield;
        pdateTofield := DateTofield;
        PStarttime := StartTime;
        PEndTime := EndTime;
        PCustomerNo := CustomerNo;
        PSalesheaderNo := Salesheader."No.";
    end;
}
