pageextension 50110 "BAL PostedInvoiceine" extends "Posted Sales Invoice Subform"
//BAL1.0 - 2019-08-14-BB
{
    layout
    {
        addbefore("No.")
        {
            field("Bal Line Comments";rec."Bal Line Comments")
            {
                ApplicationArea = all;
                BlankZero = true;

                trigger OnDrillDown()var salescommentline: record "sales comment line";
                begin
                    salescommentline.setrange("Document Type", salescommentline."Document Type"::"Posted Invoice");
                    salescommentline.setrange("No.", rec."Document No.");
                    salescommentline.setrange("Document Line No.", rec."Line No.");
                    page.runmodal(67, salescommentline);
                end;
            }
        }
        addafter(Description)
        {
            field("BAL Description 2";rec."Description 2")
            {
                ApplicationArea = All;
            }
        }
        addlast(Control1)
        {
            field("Start time";rec."BAL Start time")
            {
                ApplicationArea = All;
            }
            field("Ending time";rec."BAL Ending time")
            {
                ApplicationArea = All;
            }
            field("shipment date";rec."Shipment Date")
            {
                ApplicationArea = All;
            }
        }
    }
}
