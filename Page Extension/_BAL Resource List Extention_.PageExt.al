pageextension 50101 "BAL Resource List Extention" extends "Resource List"
{
    layout
    {
        addafter(Name)
        {
            field("BAL SalesQuote Quantity"; rec."BAL SalesQuote Quantity")
            {
                ApplicationArea = all;
            }
            field("BAL Salesorder Quantity"; rec."BAL Salesorder Quantity")
            {
                ApplicationArea = all;
            }
            field("BAL Archive Quote Qty"; rec."BAL Archive Quote Qty")
            {
                ApplicationArea = All;
            }
            field("BAL Archive Order Qty"; rec."BAL Archive Order Qty")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Resource")
        {
            action("Create booking order")
            {
                ApplicationArea = Jobs;
                Caption = 'Create Booking Order';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Booking Matrix ';

                trigger OnAction()
                var
                    Resource2: record Resource;
                    SalesHeader: record "Sales Header";
                    Salesline: Record "Sales Line";
                    BALGetDateToDialog: page "BAL Get Date To Dialog";
                    Datefield: Date;
                    DateTofield: Date;
                    StartTime: Time;
                    EndTime: Time;
                    CustomerNo: Code[20];
                    SalesHeaderNo: Code[20];

                begin
                    CurrPage.SetSelectionFilter(Resource2);
                    BALGetDateToDialog.runmodal;
                    BALGetDateToDialog.Getdata(datefield, dateTofield, Starttime, EndTime, CustomerNo, SalesheaderNo);


                    if SalesHeaderNo <> '' then
                        SalesHeader.get(SalesHeader."Document Type"::Order, SalesHeaderNo)
                    else begin
                        SalesHeader.init;
                        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
                        SalesHeader."Shipment Date" := Datefield;
                        salesheader.insert(true);
                        SalesHeader.Validate("Sell-to Customer No.", customerno);
                        SalesHeader.modify;
                    end;

                    Salesline.setrange("Document Type", SalesHeader."Document Type");
                    Salesline.setrange("Document No.", SalesHeader."No.");
                    if not salesline.findlast then begin
                        Salesline."Document Type" := SalesHeader."Document Type";
                        Salesline."Document No." := SalesHeader."No.";
                    end;
                    repeat
                        Resource2.FindFirst();
                        repeat
                            Salesline."Line No." += 10000;
                            Salesline.validate(type, Salesline.type::Resource);
                            Salesline.validate("No.", Resource2."No.");
                            Salesline.validate(Quantity, 1);
                            Salesline."Shipment Date" := Datefield;
                            if Salesline."No." > 'EX' then begin
                                Salesline."BAL Start time" := StartTime;
                                Salesline."BAL ending time" := EndTime;
                            end;
                            salesline.insert;
                        until Resource2.next = 0;
                        Datefield := CalcDate('<1D>', Datefield);
                    until Datefield > DateTofield;
                    page.run(42, SalesHeader);
                end;
            }
        }
    }

    var
        myInt: Integer;
}
