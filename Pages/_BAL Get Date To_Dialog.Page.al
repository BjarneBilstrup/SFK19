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
                var

                begin
                    if CustomerNo <> '' then
                        Customer.get(CustomerNo);
                end;

                trigger onlookup(var text: text): boolean
                var
                begin
                    if page.runmodal(Page::"Customer List", Customer) = Action::LookupOK THEN
                        customerno := customer."No.";
                end;
            }
            field(SalesheaderNo; Salesheader."no.")
            {
                ApplicationArea = all;
                Caption = 'Tilføj ordre';
                ToolTip = 'Tooltip';

                trigger OnValidate()
                var
                begin
                    if Salesheader."No." <> '' then
                        Salesheader.get(salesheader."Document Type", Salesheader."No.");
                end;

                trigger onlookup(var text: text): boolean
                var
                begin
                    Salesheader.setrange("Document Type", Salesheader."Document Type"::Order);
                    Salesheader.setrange("Sell-to Customer No.", CustomerNo);
                    if page.runmodal(Page::"Sales Order List", salesheader) = Action::LookupOK THEN
                        Salesheader."No." := Salesheader."No.";
                end;
            }
            field(Fromdate; Fromdate)
            {
                ApplicationArea = all;
                Caption = 'Angiv startdato';
                ToolTip = 'Tooltip';

                trigger OnValidate()
                begin
                end;
            }
            field(Todate; Todate)
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
        leadtxt: Label 'Angiv oprettelses faktorer i felterne herunder';
        Fromdate: Date;
        Todate: Date;
        StartTime: Time;
        EndTime: Time;
        Customer: Record customer;
        CustomerNo: code[20];
        Salesheader: Record "Sales Header";

    procedure SetData(PLeadTxt: text)
    begin
        //leadtxt := PLeadTxt;
        //Fromdate := PFromdate;
    end;

    procedure Getdata(var pFromdate: Date; var pTodate: Date; var PStarttime: Time; Var PEndTime: Time; var PCustomerNo: code[20]; var PSalesheaderNo: code[20])
    begin
        pFromdate := Fromdate;
        pTodate := Todate;
        PStarttime := StartTime;
        PEndTime := EndTime;
        PCustomerNo := CustomerNo;
        PSalesheaderNo := Salesheader."No.";
    end;
}
