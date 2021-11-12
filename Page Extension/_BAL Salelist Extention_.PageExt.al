pageextension 50102 "BAL Salelist Extention" extends "Sales Lines"
{
    layout
    {
        addbefore("No.")
        {
            field("Bal Line Comments";rec."Bal Line Comments")
            {
                ApplicationArea = all;
                //BlankZero = true;

                trigger OnDrillDown()var salescommentline: record "sales comment line";
                begin
                    salescommentline.setrange("Document Type", rec."Document Type");
                    salescommentline.setrange("No.", rec."Document No.");
                    salescommentline.setrange("Document Line No.", rec."Line No.");
                    page.runmodal(67, salescommentline);
                end;
            }
        }
        addafter(description)
        {
            field("BAL Description 2";rec."Description 2")
            {
                ApplicationArea = all;
            }
            field("BAL Start time";rec."BAL Start time")
            {
                ApplicationArea = all;
            }
            field("BAL ending time";rec."BAL ending time")
            {
                ApplicationArea = all;
            }
        }
        addfirst(FactBoxes)
        {
            part("Sales Comment Line Factbox";"BAL Sales Comment Line Factbox")
            {
                SubPageLink = "Document Type"=field("Document Type"), "No."=FIELD("Document No."), "Document Line No."=field("Line No.");
                Editable = false;
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        // Add changes to page actions here
        addbefore("Show Document")
        {
            action("Be&mærkninger")
            {
                ApplicationArea = Comments;
                Caption = 'N&ote';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ViewComments;
                RunObject = Page 67;
                RunPageLink = "Document Type"=field("Document Type"), "No."=FIELD("Document No."), "Document Line No."=field("Line No.");
                ToolTip = 'View comments for the record.';
            }
            action("Report2")
            {
                ApplicationArea = Jobs;
                Caption = 'Booking detalje';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Booking detalje med noter ';

                trigger OnAction()var SalesHeader: record "Sales Header";
                begin
                    SalesHeader.SetRange("Document Type", rec."Document type");
                    salesheader.SetRange("No.", rec."Document No.");
                    Report.run(50101, true, false, SalesHeader);
                end;
            }
        }
    }
    var myInt: Integer;
}
