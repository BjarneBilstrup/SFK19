page 50101 "BAL Resource Booking Matrix"
{
    Caption = 'Booking';
    Editable = false;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = Resource;

    layout
    {
        area(content)
        {
            repeater(Capacity)
            {
                field("No.";rec."No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Name;rec.Name)
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies a description of the resource.';
                }
                field(Field1;MATRIX_CellData[1])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[1];

                    trigger OnDrillDown()begin
                        MatrixOnDrillDown(1)end;
                }
                field(Field2;MATRIX_CellData[2])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[2];

                    trigger OnDrillDown()begin
                        MatrixOnDrillDown(2)end;
                }
                field(Field3;MATRIX_CellData[3])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[3];

                    trigger OnDrillDown()begin
                        MatrixOnDrillDown(3)end;
                }
                field(Field4;MATRIX_CellData[4])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[4];

                    trigger OnDrillDown()begin
                        MatrixOnDrillDown(4)end;
                }
                field(Field5;MATRIX_CellData[5])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[5];

                    trigger OnDrillDown()begin
                        MatrixOnDrillDown(5)end;
                }
                field(Field6;MATRIX_CellData[6])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[6];

                    trigger OnDrillDown()begin
                        MatrixOnDrillDown(6)end;
                }
                field(Field7;MATRIX_CellData[7])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[7];

                    trigger OnDrillDown()begin
                        MatrixOnDrillDown(7)end;
                } /*
                field(Field8; MATRIX_CellData[8])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[8];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(8)
                    end;

                }
                field(Field9; MATRIX_CellData[9])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[9];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(9)
                    end;

                }
                field(Field10; MATRIX_CellData[10])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[10];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(10)
                    end;

                }
                field(Field11; MATRIX_CellData[11])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[11];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(11)
                    end;

                }
                field(Field12; MATRIX_CellData[12])
                {
                    ApplicationArea = Jobs;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[12];

                    trigger OnDrillDown()
                    begin
                        MatrixOnDrillDown(12)
                    end;

                }*/
            }
        }
    }
    actions
    {
        area(processing)
        {
            //           group("R&essource")
            //           {
            //Caption = '&Resource';
            //Image = Resource;
            action(Kort)
            {
                ApplicationArea = Jobs;
                Caption = 'Ressource List';
                Image = EditLines;
                RunObject = Page 76;
                RunPageLink = "No."=FIELD("No."), "Date Filter"=FIELD("Date Filter"), "Unit of Measure Filter"=FIELD("Unit of Measure Filter"), "Chargeable Filter"=FIELD("Chargeable Filter");
                ShortCutKey = 'Shift+F7';
                ToolTip = 'View or change detailed information about the record on the document or journal line.';
            }
            action("Report1")
            {
                ApplicationArea = Jobs;
                Caption = 'Booking rapport';
                Image = Report;
                //                Promoted = true;
                //                PromotedCategory = Report;
                ToolTip = 'Booking Rapport ';

                trigger OnAction()begin
                    Report.run(50100);
                end;
            }
        }
    }
    // }
    trigger OnAfterGetRecord()var MATRIX_CurrentColumnOrdinal: Integer;
    begin
        MATRIX_CurrentColumnOrdinal:=0;
        WHILE MATRIX_CurrentColumnOrdinal < MATRIX_NoOfMatrixColumns DO BEGIN
            MATRIX_CurrentColumnOrdinal:=MATRIX_CurrentColumnOrdinal + 1;
            MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);
        END;
        if OnlyFree then begin
            rec.SETRANGE("Date Filter", MatrixRecords[1]."Period End");
            rec.setrange("BAL Salesorder Quantity", 0);
        end
        else
            rec.setrange("BAL Salesorder Quantity");
    end;
    var MatrixRecords: array[7]of Record Date;
    MATRIX_NoOfMatrixColumns: Integer;
    MATRIX_CellData: array[7]of text;
    MATRIX_ColumnCaption: array[7]of Text[1024];
    OnlyFree: Boolean;
    local procedure SetDateFilter(ColumnID: Integer)begin
        rec.SETRANGE("Date Filter", MatrixRecords[ColumnID]."Period End");
    end;
    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)var salesheader: Record "Sales Header";
    Salesline: Record "Sales Line";
    SalesInvoiceHeader: Record "Sales Invoice Header";
    SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        MATRIX_CellData[ColumnID]:=' ';
        rec.SetRange("Date Filter", MatrixRecords[ColumnID]."Period Start");
        rec.CALCFIELDS("BAL SalesQuote Quantity", "BAL Salesorder Quantity", "BAL SalesInvoice Qty");
        Salesline.setrange("No.", Rec."No.");
        salesline.setrange("Shipment Date", MatrixRecords[ColumnID]."Period Start");
        if salesline.findset then;
        if salesheader.get(Salesline."Document Type", Salesline."Document No.")then;
        IF(rec."BAL Salesquote Quantity" <> 0) or (rec."BAL Salesorder Quantity" <> 0) or (rec."BAL SalesInvoice Qty" <> 0)THEN begin
            if(rec."BAL Salesquote Quantity" <> 0)then MATRIX_CellData[ColumnID]:='#' + format(rec."BAL SalesQuote Quantity") + ' ' + salesline.Description + ' ' + Salesline."Description 2" + ' Kunde ' + salesheader."Sell-to Customer Name" + ' ' + format(Salesline."Document Type") + ' ' + Salesline."Document No.";
            if(rec."BAL Salesorder Quantity" <> 0)then begin
                if MATRIX_CellData[ColumnID] <> ' ' then MATRIX_CellData[ColumnID]+='/';
                MATRIX_CellData[ColumnID]+=format(rec."BAL Salesorder Quantity") + ' ' + salesline.Description + ' ' + Salesline."Description 2" + ' Kunde ' + salesheader."Sell-to Customer Name" + ' ' + format(Salesline."Document Type") + ' ' + Salesline."Document No.";
            end;
            if(rec."BAL SalesInvoice Qty" <> 0)then begin
                if MATRIX_CellData[ColumnID] <> ' ' then MATRIX_CellData[ColumnID]+='/';
                Salesinvoiceline.setrange("No.", Rec."No.");
                salesinvoiceline.setrange("Shipment Date", MatrixRecords[ColumnID]."Period Start");
                if salesinvoiceline.findset then if salesinvoiceheader.get(salesinvoiceline."Document No.")then MATRIX_CellData[ColumnID]+=format(rec."BAL Salesinvoice Qty") + ' ' + salesinvoiceline.Description + ' ' + Salesinvoiceline."Description 2" + ' Kunde ' + salesinvoiceheader."Sell-to Customer Name" + ' ' + Salesinvoiceline."Document No.";
            end;
        end;
    end;
    //[Scope('Personalization')]
    procedure Load(MatrixColumns1: array[7]of Text[1024];
    var MatrixRecords1: array[7]of Record Date;
    NoOfMatrixColumns1: Integer)var i: Integer;
    begin
        COPYARRAY(MATRIX_ColumnCaption, MatrixColumns1, 1);
        FOR i:=1 TO ARRAYLEN(MatrixRecords)DO MatrixRecords[i].COPY(MatrixRecords1[i]);
        MATRIX_NoOfMatrixColumns:=NoOfMatrixColumns1;
    end;
    local procedure MatrixOnDrillDown(ColumnID: Integer)var ResCapacityEntries: Record "Res. Capacity Entry";
    Salesline: Record "Sales Line";
    SalesInvoiceline: Record "Sales Invoice Line";
    begin
        Salesline.SetCurrentKey(type, "Document No.", type, "No.");
        Salesline.SetRange("Document Type", Salesline."Document Type"::Quote, Salesline."Document Type"::Order);
        Salesline.SetRange(type, Salesline.type::Resource);
        Salesline.SetRange("No.", rec."no.");
        Salesline.Setrange("Shipment Date", MatrixRecords[ColumnID]."Period Start");
        if salesline.count > 0 then page.runmodal(516, salesline)
        else
        begin
            SalesInvoiceline.SetCurrentKey(type, "Document No.", type, "No.");
            SalesInvoiceline.SetRange(type, Salesline.type::Resource);
            SalesInvoiceline.SetRange("No.", rec."no.");
            SalesInvoiceline.Setrange("Shipment Date", MatrixRecords[ColumnID]."Period Start");
            if salesinvoiceline.count > 0 then page.runmodal(526, salesinvoiceline)end;
    end;
    procedure SetOnlyfree(Lonlyfree: boolean)var begin
        onlyfree:=Lonlyfree;
    end;
}
