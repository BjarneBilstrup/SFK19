tableextension 50102 "BAL CompanyInfo" extends "Company Information"
{
    fields
    {
        field(50100;"BAL BookingURL";Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Booking URL';
        }
        field(50101;"BAL Username";Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Username';
        }
        field(50102;"BAL Password";Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Password';
        }
        field(50103; "BAL Web Active"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption= 'Web update active';
        }
    }
}
