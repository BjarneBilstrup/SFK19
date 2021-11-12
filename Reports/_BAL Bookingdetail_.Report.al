report 50101 "BAL Bookingdetail"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Booking detaljer';
    DefaultLayout = Word;
    wordlayout = './layouts/bookingdetail.docx';

    dataset
    {
        dataitem("Sales header";"Sales Header")
        {
            RequestFilterFields = "Shipment Date", "No.", "Sell-to Customer No.";

            column(order_No_;"No.")
            {
            }
            column(Order_Sell_to_Customer_No_;"Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name;"Sell-to Customer Name")
            {
            }
            column(Order_Shipment_Date;format("Shipment Date"))
            {
            }
            dataitem("SalesCommentLine";"Sales Comment Line")
            {
                DataItemLink = "Document Type"=field("Document Type"), "No."=field("No.");
                DataItemTableView = sorting("Document Type", "No.", "Document Line No.")where("Document Line No."=filter(0));

                column(NoteDescrip;NoteDescrip)
                {
                }
                column(HeaderComment;Comment)
                {
                IncludeCaption = true;
                }
                column(HeaderDate;format(noteDate))
                {
                }
                column(HeaderCode;Code)
                {
                IncludeCaption = true;
                }
                trigger OnAfterGetRecord()begin
                    if prevNoteDate <> date then NoteDate:=date
                    else
                        notedate:=0D;
                    prevNoteDate:=date;
                    if not firstline then NoteDescrip:='Bemærk'
                    else
                        NoteDescrip:='';
                    firstline:=true;
                end;
            }
            dataitem("Sales Line";"sales line")
            {
                DataItemLink = "Document Type"=field("Document Type"), "document No."=field("No.");
                DataItemTableView = Sorting("shipment date", "No.")WHERE(Type=FILTER(Resource), "No."=FILTER(<>''));

                column(filtre;"Sales Line".getfilters)
                {
                }
                column(Sell_to_Customer_No_;"Sell-to Customer No.")
                {
                IncludeCaption = true;
                }
                column(SalesHeaderSelltoCustomerName;"Sales Header"."Sell-to Customer Name")
                {
                IncludeCaption = true;
                }
                column(No_;"No.")
                {
                IncludeCaption = true;
                }
                column(Description;Description)
                {
                IncludeCaption = true;
                }
                column(Description_2;"Description 2")
                {
                IncludeCaption = true;
                }
                column(BAL_Start_time;format("BAL Start time", 0, '<Hours,2>.<Min,2>'))
                {
                //                IncludeCaption = true;
                }
                column(BAL_ending_time;format("BAL ending time", 0, '<Hours,2>.<Min,2>'))
                {
                //                IncludeCaption = true;
                }
                column(Shipment_Date;format("Shipment Date", 0, '<Day,2>.<Month,2>.<Year,2>'))
                {
                }
                column(Document_No_;"Document No.")
                {
                }
                dataitem("Sales Comment Line";"Sales Comment Line")
                {
                    DataItemLink = "Document Type"=field("Document Type"), "No."=field("Document No."), "Document Line No."=field("line no.");
                    DataItemTableView = sorting("Document Type", "No.", "Document Line No.");

                    column(Comment;Comment)
                    {
                    IncludeCaption = true;
                    }
                    column(Date;format(Date))
                    {
                    }
                    column(Code;Code)
                    {
                    }
                    trigger OnAfterGetRecord()begin
                    end;
                }
                trigger OnAfterGetRecord()begin
                end;
            }
            trigger OnAfterGetRecord()begin
                firstline:=false;
                prevNoteDate:=0D;
            end;
        }
    }
    requestpage
    {
        savevalues = true;

        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
    }
    var prevNoteDate: Date;
    NoteDescrip: Text;
    NoteDate: Date;
    Firstline: Boolean;
}
