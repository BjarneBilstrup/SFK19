table 50100 "BAL SMS Nos"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1;"Mobil No.";Code[20])
        {
            DataClassification = CustomerContent;
        //            FieldPropertyName = FieldPropertyValue;
        }
        field(10;Name;Text[50])
        {
            DataClassification = CustomerContent;
        //            FieldPropertyName = FieldPropertyValue;
        }
    }
    keys
    {
        key(PK;"Mobil No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()begin
    end;
    trigger OnModify()begin
    end;
    trigger OnDelete()begin
    end;
    trigger OnRename()begin
    end;
}
