pageextension 50106 "BAL Sales Order Header Ext" extends "Sales Order"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part("Sales Comment Line Factbox";"BAL Sales Comment Line Factbox")
            {
                Provider = SalesLines;
                SubPageLink = "Document Type"=field("Document Type"), "No."=FIELD("Document No."), "Document Line No."=field("Line No.");
                Editable = false;
                ApplicationArea = all;
            }
        } // Add changes to page layout here
    }
    var myInt: Integer;
}
