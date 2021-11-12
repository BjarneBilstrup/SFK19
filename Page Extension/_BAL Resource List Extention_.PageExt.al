pageextension 50101 "BAL Resource List Extention" extends "Resource List"
{
    layout
    {
        addafter(Name)
        {
            field("BAL SalesQuote Quantity";rec."BAL SalesQuote Quantity")
            {
                ApplicationArea = all;
            }
            field("BAL Salesorder Quantity";rec."BAL Salesorder Quantity")
            {
                ApplicationArea = all;
            }
        }
    }
    var myInt: Integer;
}
