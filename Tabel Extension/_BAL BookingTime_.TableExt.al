tableextension 50100 "BAL BookingTime" extends "Sales Line"
//BAL1.00 - 2019-08-14- BB
{
    fields
    {
        field(50100;"BAL Start time";Time)
        {
            DataClassification = CustomerContent;
            //FieldPropertyName = FieldPropertyValue;
            CaptionML = ENU='Start time', DAN='Start kl.';
        }
        field(50101;"BAL ending time";Time)
        {
            DataClassification = CustomerContent;
            //FieldPropertyName = FieldPropertyValue;
            CaptionML = ENU='Ending time', DAN='Slut kl.';
        }
        field(50102;"Bal Line Comments";boolean)
        {
            CaptionML = ENU='Line Comments', DAN='Linje noter';
            FieldClass = FlowField;
            Editable = False;
            CalcFormula = exist("Sales Comment Line" where("Document Type"=field("Document Type"), "No."=field("Document No."), "Document Line No."=field("Line No.")));
        }
    }
    trigger OnInsert()begin
        if("Document Type" = "Document Type"::Order) and (type = Type::Resource) and ("no." <> '')then begin
            Resource.get("No.");
            SalesHeader.Get("Document Type", "Document No.");
            if SalesHeader."Sell-to Customer Name" = 'Gamle bookinger' then SalesHeader."Sell-to Customer Name":='.';
            if WebService.HttpRequestBooking('BookingModify', "Document No.", "Line No.", format("Shipment Date", 0, '<year4><month,2><day,2>'), format("BAL Start time"), format("BAL ending time"), "no.", Resource.Name, SalesHeader."Sell-to Customer Name" + ' ' + "Description 2") = '' then;
        end;
    end;
    trigger OnModify()begin
        if("Document Type" = "Document Type"::Order) and (type = Type::Resource) and ("no." <> '')then begin
            Resource.get("No.");
            SalesHeader.Get("Document Type", "Document No.");
            if SalesHeader."Sell-to Customer Name" = 'Gamle bookinger' then SalesHeader."Sell-to Customer Name":='';
            if WebService.HttpRequestBooking('BookingModify', "Document No.", "Line No.", format("Shipment Date", 0, '<year4><month,2><day,2>'), format("BAL Start time"), format("BAL ending time"), "no.", Resource.Name, SalesHeader."Sell-to Customer Name" + ' ' + "Description 2") = '' then;
        end;
    end;
    trigger OnDelete()begin
        if("Document Type" = "Document Type"::Order) and (type = Type::Resource) and ("no." <> '')then begin
            Resource.get("No.");
            SalesHeader.Get("Document Type", "Document No.");
            if WebService.HttpRequestBooking('BookingDelete', "Document No.", "Line No.", format("Shipment Date", 0, '<year4><month,2><day,2>'), format("BAL Start time"), format("BAL ending time"), "no.", Resource.Name, SalesHeader."Sell-to Customer Name" + ' ' + "Description 2") = '' then;
        end;
    end;
    var Resource: record resource;
    SalesHeader: Record "Sales Header";
    WebService: Codeunit "BAL Booking Webservice";
}
