table 50101 "BAL SMS Message"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1;Code;code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(10;Message;Text[50])
        {
            DataClassification = CustomerContent;
            //            FieldPropertyName = FieldPropertyValue;
            Caption = 'Message';
        }
        field(20;Messagetype;Option)
        {
            caption = 'Message type';
            OptionMembers = "Food", "Info", "General";
            OptionCaption = 'Food,Info,General';
        }
        field(30;Created;DateTime)
        {
            DataClassification = CustomerContent;
            //            FieldPropertyName = FieldPropertyValue;
            Caption = 'Created';
            Editable = false;
        }
    }
    keys
    {
        key(PK;Code)
        {
            Clustered = true;
        }
    }
    var myInt: Integer;
    trigger OnInsert()begin
        Created:=CreateDateTime(today, time)end;
    trigger OnModify()begin
    end;
    trigger OnDelete()begin
    end;
    trigger OnRename()begin
    end;
}
