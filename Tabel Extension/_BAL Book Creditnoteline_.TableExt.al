tableextension 50105 "BAL Book Creditnoteline" extends "Sales Cr.Memo Line"
//BAL1.00 - 2019-08-14- BB
{
    fields
    {
        field(50100; "BAL Start time"; Time)
        {
            DataClassification = CustomerContent;
            //FieldPropertyName = FieldPropertyValue;
            CaptionML = ENU = 'Start time', DAN = 'Start kl.';
        }
        field(50101; "BAL ending time"; Time)
        {
            DataClassification = CustomerContent;
            //FieldPropertyName = FieldPropertyValue;
            CaptionML = ENU = 'Ending time', DAN = 'Slut kl.';
        }
        field(50102; "Bal Line Comments"; boolean)
        {
            CaptionML = ENU = 'Line Comments', DAN = 'Linje noter';
            FieldClass = FlowField;
            Editable = False;
            CalcFormula = exist("Sales Comment Line" where("Document Type" = CONST("Posted Credit Memo"), "No." = field("Document No."), "Document Line No." = field("Line No.")));
        }
    }
}
