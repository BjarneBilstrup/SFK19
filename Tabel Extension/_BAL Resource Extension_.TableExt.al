tableextension 50101 "BAL Resource Extension" extends resource
{
    fields
    {
        field(50100;"BAL SalesQuote Quantity";integer)
        {
            Caption = 'Salesquote Quantity';
            FieldClass = FlowField;
            //            CalcFormula = sum ("Sales Line".Quantity where ("Document Type" = filter (Quote), type = filter (Resource),
            //                                "no." = field ("no."), "Shipment Date" = field ("date filter")));
            CalcFormula = count("Sales Line" where("Document Type"=filter(Quote), type=filter(Resource), "no."=field("no."), "Shipment Date"=field("date filter")));
        //FieldPropertyName = FieldPropertyValue;
        }
        field(50101;"BAL Salesorder Quantity";integer)
        {
            Caption = 'Salesorder Quantity';
            FieldClass = FlowField;
            CalcFormula = count("Sales Line" where("Document Type"=filter(Order), type=filter(Resource), "no."=field("no."), "Shipment Date"=field("date filter")));
        //FieldPropertyName = FieldPropertyValue;
        }
        field(50102;"BAL SalesInvoice Qty";integer)
        {
            Caption = 'Sales Invoice Quantity';
            FieldClass = FlowField;
            CalcFormula = count("Sales invoice Line" where(type=filter(Resource), "no."=field("no."), "Shipment Date"=field("date filter")));
        //FieldPropertyName = FieldPropertyValue;
        }
    }
    var myInt: Integer;
}
