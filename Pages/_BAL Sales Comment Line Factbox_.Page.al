page 50107 "BAL Sales Comment Line Factbox"
{
    PageType = Listpart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Comment Line";
    CaptionML = ENU='Sales Comment Line', DAN='Salgslinje bemærkninger';

    layout
    {
        area(Content)
        {
            repeater(Comments)
            {
                field(Comment;rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
