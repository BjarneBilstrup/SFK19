pageextension 50108 "BAL Salesorderline" extends "Sales Order Subform"
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
            }
        }
    }
    actions
    {
        addbefore("F&unctions")
        {
            action("Be&mærkninger")
            {
                ApplicationArea = Comments;
                Caption = 'N&ote';
                Image = ViewComments;
                RunObject = Page 67;
                RunPageLink = "Document Type"=field("Document Type"), "No."=FIELD("Document No."), "Document Line No."=field("Line No.");
                ToolTip = 'View comments for the record.';
            }
            action("Copy to date")
            {
                ApplicationArea = Comments;
                Caption = 'Kopier til dato(er)';
                Image = Copy;
                ToolTipML = ENU='View comments for the record.', DAN='Kopier valgte linjer frem';

                trigger OnAction()var salesline: Record "sales line";
                salesline2: Record "sales line";
                SalesCommentLine: record "Sales Comment Line";
                SalesCommentLine2: record "Sales Comment Line";
                NextlineNo: integer;
                Selection: Integer;
                RepSelection: Integer;
                Datecalc: DateFormula;
                i: Integer;
                getdatedialog: Page "BAL Get Date Dialog";
                Endingdate: date;
                begin
                    selection:=Strmenu('1 Dag,2 Dage,3 Dage,4 Dage,5 Dage,6 Dage,Uge,Måned,År', 7, 'Hvor langt frem vil du have kopieret?');
                    getdatedialog.SetData('Angiv slutdato');
                    getdatedialog.runmodal;
                    getdatedialog.Getdata(Endingdate, RepSelection);
                    if(endingdate = 0D) and (RepSelection = 0)then begin
                        Message('Der var ikke angivet dato eller antal gentagelser!');
                        exit;
                    end;
                    currpage.setselectionfilter(salesline);
                    salesline2.setrange("Document Type", rec."Document Type");
                    salesline2.SetRange("Document no.", rec."Document no.");
                    salesline2.findlast;
                    NextlineNo:=salesline2."Line No.";
                    salesline.findset;
                    if RepSelection = 0 then case selection of 1: RepSelection:=endingdate - salesline2."Shipment Date";
                        2: RepSelection:=round((endingdate - salesline."Shipment Date") / 2, 1);
                        3: RepSelection:=round((endingdate - salesline."Shipment Date") / 3 - 0.49, 1);
                        4: RepSelection:=round((endingdate - salesline."Shipment Date") / 4 - 0.49, 1);
                        5: RepSelection:=round((endingdate - salesline."Shipment Date") / 5 - 0.49, 1);
                        6: RepSelection:=round((endingdate - salesline."Shipment Date") / 6 - 0.49, 1);
                        7: RepSelection:=round((endingdate - salesline."Shipment Date") / 7 - 0.49, 1);
                        8: RepSelection:=round((endingdate - salesline."Shipment Date") / 30 - 0.49, 1);
                        9: RepSelection:=round((endingdate - salesline."Shipment Date") / 365 - 0.49, 1);
                        end;
                    if(Selection = 0) or (RepSelection = 0)then exit;
                    SalesCommentLine.setrange("Document Type", rec."Document Type");
                    SalesCommentLine.SetRange("No.", rec."Document No.");
                    repeat salesline2:=salesline;
                        for i:=1 to repselection do begin
                            salesline2."Line No.":=NextlineNo + 10000;
                            nextlineno:=salesline2."Line No.";
                            salesline2.insert;
                            SalesCommentLine.SetRange("Document Line No.", salesline."Line No.");
                            if SalesCommentLine.findset then repeat SalesCommentLine2:=SalesCommentLine;
                                    SalesCommentLine2."Document Line No.":=salesline2."Line No.";
                                    SalesCommentLine2.insert;
                                until SalesCommentLine.next = 0;
                            case selection of 1: salesline2.validate("Shipment Date", calcdate('1D', salesline2."Shipment Date"));
                            2: salesline2.validate("Shipment Date", calcdate('2D', salesline2."Shipment Date"));
                            3: salesline2.validate("Shipment Date", calcdate('3D', salesline2."Shipment Date"));
                            4: salesline2.validate("Shipment Date", calcdate('4D', salesline2."Shipment Date"));
                            5: salesline2.validate("Shipment Date", calcdate('5D', salesline2."Shipment Date"));
                            6: salesline2.validate("Shipment Date", calcdate('6D', salesline2."Shipment Date"));
                            7: salesline2.validate("Shipment Date", calcdate('<1W>', salesline2."Shipment Date"));
                            8: salesline2.validate("Shipment Date", calcdate('1M', salesline2."Shipment Date"));
                            9: salesline2.validate("Shipment Date", calcdate('<1Y>', salesline2."Shipment Date"));
                            end;
                            salesline2.modify;
                        end;
                    until salesline.next = 0;
                end;
            }
        }
    }
}
