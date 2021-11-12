pageextension 50105 "BAL Company Info" extends "Company Information"
{
    layout
    {
        addafter("User Experience")
        {
            group("Booking")
            {
                CaptionML = ENU='Booking', DAN='Booking';

                field("BAL BookingURL";rec."BAL BookingURL")
                {
                    ApplicationArea = all;
                }
                field("BAL Username";rec."BAL Username")
                {
                    ApplicationArea = all;
                }
                field("BAL Password";rec."BAL Password")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        addbefore(Setup)
        {
            action("Update Web")
            {
                ApplicationArea = Comments;
                Caption = 'Update Web';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ViewComments;
                ToolTip = 'Update Web with all records';

                trigger OnAction()var BALBookingWebservice: Codeunit "BAL Booking Webservice";
                begin
                    BALBookingWebservice.WebTotalUpdate();
                end;
            }
        }
    }
    var
}
