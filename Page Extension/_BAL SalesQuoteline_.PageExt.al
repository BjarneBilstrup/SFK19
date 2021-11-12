pageextension 50104 "BAL SalesQuoteline" extends "Sales quote Subform"
//BAL1.0 - 2019-08-14-BB
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
            //FieldPropertyName = FieldPropertyValue;
            }
        }
    }
    var myInt: Integer;
}
