pageextension 50103 "BAL Accountant role center" extends "9006"
{
    actions
    {
        // Add changes to page actions here
        addafter("Transfer Orders")
        {
            action("Booking")
            {
                ApplicationArea = Comments;
                Caption = 'Boo&king';
                Image = ViewComments;
                RunObject = Page 50100;
                ToolTip = 'Booking Matrix';
            }
            action("BAL Detailbalance")
            {
                ApplicationArea = Comments;
                Caption = 'Detaljeret råbalance';
                Image = ViewComments;
                RunObject = report "Detail Trial Balance";
                ToolTip = 'Booking Matrix';
            }
        }
    }
    var myInt: Integer;
}
