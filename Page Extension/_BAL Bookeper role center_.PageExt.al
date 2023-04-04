pageextension 50114 "BAL Bookeper role center" extends "9027"
{
    actions
    {
        // Add changes to page actions here
        addafter("Balance Sheet")
        {
            action("Råbalance")
            {
                ApplicationArea = Comments;
                Caption = 'Detaljeret råbalance';
                Image = ViewComments;
                RunObject = report "Detail Trial Balance";
                ToolTip = 'Detaljeret Råbalance';
            }
            action("Trial balance")
            {
                ApplicationArea = Comments;
                Caption = 'Balance m sidste år';
                Image = ViewComments;
                RunObject = report "BAL Trial Balance/PrevYear";
                ToolTip = 'Balance med sidste år 4 kolonner';
            }
        }
    }
    var myInt: Integer;
}
