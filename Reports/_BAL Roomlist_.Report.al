report 50100 "BAL Roomlist"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Værelses oversigt';
    DefaultLayout = Word;
    wordlayout = './layouts/roomlist.docx';

    dataset
    {
        dataitem("Sales Line";"sales line")
        {
            RequestFilterFields = "Shipment Date", "no.", "Sell-to Customer No.";
            DataItemTableView = Sorting("shipment date", "No.")WHERE(Type=FILTER(Resource), "No."=FILTER(<>''));

            column(filtre;"Sales Line".getfilters)
            {
            }
            column(Sell_to_Customer_No_;"Sell-to Customer No.")
            {
            IncludeCaption = true;
            }
            column(SalesHeaderSelltoCustomerName;SalesHeader."Sell-to Customer Name")
            {
            IncludeCaption = true;
            }
            column(No_;"No.")
            {
            IncludeCaption = true;
            }
            column(Description;Description)
            {
            IncludeCaption = true;
            }
            column(Description_2;"Description 2")
            {
            IncludeCaption = true;
            }
            column(BAL_Start_time;format("BAL Start time", 0, '<Hours,2>.<Min,2>'))
            {
            //                IncludeCaption = true;
            }
            column(BAL_ending_time;format("BAL ending time", 0, '<Hours,2>.<Min,2>'))
            {
            //                IncludeCaption = true;
            }
            column(Shipment_Date;format("Shipment Date", 0, '<Day,2>.<Month,2>.<Year,2>'))
            {
            }
            column(Document_No_;"Document No.")
            {
            }
            dataitem("Sales Comment Line";"Sales Comment Line")
            {
                DataItemLink = "Document Type"=field("Document Type"), "No."=field("Document No."), "Document Line No."=field("line no.");
                DataItemTableView = sorting("Document Type", "No.", "Document Line No.");

                column(Comment;Comment)
                {
                }
                column(Date;format(Date))
                {
                }
                column(Code;Code)
                {
                }
            }
            trigger OnAfterGetRecord()begin
                SalesHeader.get("Document Type", "Document No.")end;
        }
    }
    requestpage
    {
        savevalues = true;

        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
    }
    var SalesHeader: Record "Sales Header";
}
