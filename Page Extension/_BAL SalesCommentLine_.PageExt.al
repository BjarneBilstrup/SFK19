pageextension 50113 "BAL SalesCommentLine" extends "Sales Comment List"
//BAL1.0 - 2019-08-14-BB
{
    layout
    {
        addafter(Comment)
        {
            field("Code";rec."code")
            {
                ApplicationArea = all;
            }
        }
    }
}
