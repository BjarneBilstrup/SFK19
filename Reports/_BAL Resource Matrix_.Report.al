report 50102 "BAL Resource Matrix"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Booking detaljer';
    DefaultLayout = Word;
    wordlayout = './layouts/BookingMatrix.docx';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(Dataloop;integer)
        {
            DataItemTableView = Sorting("Number");

            column(Number;Number)
            {
            }
            column(Filters;resource.getfilters + '  ' + format(NoOfWeeks))
            {
            }
            dataitem(Resource;Resource)
            {
                RequestFilterFields = "No.";

                column(No_;resource."no.")
                {
                }
                column(name;resource.Name)
                {
                }
                column(date1;format(startdate + Dataloop.Number * 7))
                {
                }
                column(date2;format(startdate + 1 + Dataloop.Number * 7))
                {
                }
                column(date3;format(startdate + 2 + Dataloop.Number * 7))
                {
                }
                column(date4;format(startdate + 3 + Dataloop.Number * 7))
                {
                }
                column(date5;format(startdate + 4 + Dataloop.Number * 7))
                {
                }
                column(date6;format(startdate + 5 + Dataloop.Number * 7))
                {
                }
                column(date7;format(startdate + 6 + Dataloop.Number * 7))
                {
                }
                column(Textfield1;Textfield[1])
                {
                }
                column(Textfield2;Textfield[2])
                {
                }
                column(Textfield3;Textfield[3])
                {
                }
                column(Textfield4;Textfield[4])
                {
                }
                column(Textfield5;Textfield[5])
                {
                }
                column(Textfield6;Textfield[6])
                {
                }
                column(Textfield7;Textfield[7])
                {
                }
                trigger OnAfterGetRecord()begin
                    clear(Textfield);
                    salesline.setrange("No.", resource."No.");
                    salesline.setrange("shipment date", startdate + Dataloop.Number * 7, startdate + 7 + Dataloop.Number * 7);
                    if not salesline.findset then begin
                        SalesInvoiceline.SetCurrentKey(type, "No.");
                        SalesInvoiceline.SetRange(type, Salesline.type::Resource);
                        salesinvoiceline.setrange("No.", resource."No.");
                        salesinvoiceline.setrange("shipment date", startdate + Dataloop.Number * 7, startdate + 7 + Dataloop.Number * 7);
                        if not SalesInvoiceLine.findset then CurrReport.Skip
                        else
                            repeat case salesinvoiceline."Shipment Date" of startdate + Dataloop.Number * 7: textfield[1]+=SetInvoiceText();
                                startdate + 1 + Dataloop.Number * 7: textfield[2]+=SetInvoiceText();
                                startdate + 2 + Dataloop.Number * 7: textfield[3]+=SetInvoiceText();
                                startdate + 3 + Dataloop.Number * 7: textfield[4]+=SetInvoiceText();
                                startdate + 4 + Dataloop.Number * 7: textfield[5]+=SetInvoiceText();
                                startdate + 5 + Dataloop.Number * 7: textfield[6]+=SetInvoiceText();
                                startdate + 6 + Dataloop.Number * 7: textfield[7]+=SetInvoiceText();
                                end; //case
                            until SalesInvoiceLine.next = 0;
                    end
                    else
                        repeat case salesline."Shipment Date" of startdate + Dataloop.Number * 7: textfield[1]+=SetText();
                            startdate + 1 + Dataloop.Number * 7: textfield[2]+=SetText();
                            startdate + 2 + Dataloop.Number * 7: textfield[3]+=SetText();
                            startdate + 3 + Dataloop.Number * 7: textfield[4]+=SetText();
                            startdate + 4 + Dataloop.Number * 7: textfield[5]+=SetText();
                            startdate + 5 + Dataloop.Number * 7: textfield[6]+=SetText();
                            startdate + 6 + Dataloop.Number * 7: textfield[7]+=SetText();
                            end; //case
                        //   message(salesline.getfilters);
                        until salesline.next = 0;
                end;
            }
            trigger OnPreDataItem()var myInt: Integer;
            begin
                setrange(Number, 0, NoOfWeeks);
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(Start)
                {
                    field(Startdate;Startdate)
                    {
                        ApplicationArea = all;
                        CaptionML = ENU='Startdate', DAN='Startdate';
                    }
                    FIELD(NoOfWeeks;NoOfWeeks)
                    {
                        ApplicationArea = all;
                        Captionml = ENU='Dataloop.Number of weeks', DAN='Antal uger';
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var salesline: record "sales line";
    SalesInvoiceLine: record "Sales Invoice Line";
    startdate: date;
    NoOfWeeks: integer;
    Textfield: array[10]of Text;
    local procedure SetText(): text var cust: Record Customer;
    Resource: Record Resource;
    MessageTxt: text;
    begin
        if not cust.get(SalesLine."Sell-to Customer No.")then clear(cust);
        if Resource.get(salesline."No.") and (Resource.name <> salesline.Description) or (salesline."Description 2" = '')then MessageTxt:=salesline.Description;
        MessageTxt+=SalesLine."Description 2" + ' ' + cust.name + ' ' + SalesLine."Sell-to Customer No.";
        if salesline."BAL Start time" <> 0T then MessageTxt+=' ' + Format(salesline."BAL Start time", 0, '<hours24>.<minutes,2>') + '-' + Format(salesline."BAL ending time", 0, '<hours24>.<minutes,2>') + ' ';
        exit(MessageTxt);
    end;
    local procedure SetInvoiceText(): text var cust: Record Customer;
    Resource: Record Resource;
    MessageTxt: text;
    begin
        if not cust.get(SalesInvoiceLine."Sell-to Customer No.")then clear(cust);
        if Resource.get(salesInvoiceline."No.") and (Resource.name <> salesInvoiceline.Description) or (salesInvoiceline."Description 2" = '')then MessageTxt:=salesInvoiceline.Description;
        MessageTxt+=SalesInvoiceLine."Description 2" + ' ' + cust.name + ' ' + SalesInvoiceLine."Sell-to Customer No.";
        if salesInvoiceline."BAL Start time" <> 0T then MessageTxt+=' ' + Format(salesInvoiceline."BAL Start time", 0, '<hours24>.<minutes,2>') + '-' + Format(salesInvoiceline."BAL ending time", 0, '<hours24>.<minutes,2>') + ' ';
        exit(MessageTxt);
    end;
}
