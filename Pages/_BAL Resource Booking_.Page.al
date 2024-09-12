page 50100 "BAL Resource Booking"
{
    ApplicationArea = Jobs;
    Caption = 'Booking';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = ListPlus;
    RefreshOnActivate = true;
    SaveValues = false;
    SourceTable = Resource;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            group(Matrixindstillinger)
            {
                Caption = 'Matrix Options';
            }
            field(StartDate; StartDate)
            {
                ApplicationArea = Jobs;
                CaptionMl = ENU = 'Startdate', DAN = 'Startdato';
                ToolTip = 'Specifies the startdate of the matrix.';

                trigger OnValidate()
                begin
                    SetColumnsStartDate(SetWanted::Same);
                    UpdateMatrixSubform;
                    //OnlyFree := false;
                    //UpdateOnlyfreeMatrixSubform;
                end;
            }
            field(OnlyFree; OnlyFree)
            {
                ApplicationArea = Jobs;
                CaptionML = ENU = 'Only Free', DAN = 'Kun ledige';
                ToolTip = 'Viser kun ressourcder som er ledige på "Startdato"/Første dato i visningen';

                trigger OnValidate()
                begin
                    UpdateOnlyfreeMatrixSubform;
                end;
            }
            part(MatrixForm; "BAL Resource Booking Matrix")
            {
                ApplicationArea = Jobs;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Previous Set")
            {
                ApplicationArea = Jobs;
                CaptionML = ENU = 'Previous set', DAN = 'Forrige datoer';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the previous set of data.';

                trigger OnAction()
                begin
                    SetColumns(SetWanted::Previous);
                    UpdateMatrixSubform;
                end;
            }
            action("Previous Column")
            {
                ApplicationArea = Jobs;
                CaptionML = ENU = 'Previous column', DAN = 'Forrige kolonne';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the previous column.';

                trigger OnAction()
                begin
                    SetColumns(SetWanted::PreviousColumn);
                    UpdateMatrixSubform;
                end;
            }
            action("Next Column")
            {
                ApplicationArea = Jobs;
                CaptionML = ENU = 'Next column', DAN = 'Næste kolonne';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the next column.';

                trigger OnAction()
                begin
                    SetColumns(SetWanted::NextColumn);
                    UpdateMatrixSubform;
                end;
            }
            action("Next Set")
            {
                ApplicationArea = Jobs;
                CaptionML = ENU = 'Next set', DAN = 'Næste datoer';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the next set of data.';

                trigger OnAction()
                begin
                    SetColumns(SetWanted::Next);
                    UpdateMatrixSubform;
                end;
            }
            action("Report1")
            {
                ApplicationArea = Jobs;
                Caption = 'Booking rapport';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Booking Rapport ';

                trigger OnAction()
                begin
                    Report.run(50100);
                end;
            }
            action("Report2")
            {
                ApplicationArea = Jobs;
                Caption = 'Booking detalje';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Booking detalje med noter ';

                trigger OnAction()
                begin
                    Report.run(50101);
                end;
            }
            action("Booking Matrix")
            {
                ApplicationArea = Jobs;
                Caption = 'Booking Matrix';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Booking Matrix ';

                trigger OnAction()
                begin
                    Report.run(50102);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        SetColumns(SetWanted::Initial);
        UpdateMatrixSubform;
    end;

    var
        MatrixRecords: array[7] of Record Date;
        PeriodType: Enum "Analysis Period Type";
        MatrixColumnCaptions: array[7] of Text[1024];
        ColumnSet: Text[1024];
        SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn;
        PKFirstRecInCurrSet: Text[100];
        CurrSetLength: Integer;
        StartDate: Date;
        OnlyFree: Boolean;

    procedure SetColumns(SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit "Matrix Management";
        i: Integer;
    begin
        MatrixMgt.GeneratePeriodMatrixData(SetWanted, 7, true, PeriodType, '', PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, MatrixRecords);
        for i := 1 to ARRAYLEN(MatrixRecords) do begin
            MatrixColumnCaptions[i] := format(matrixrecords[i]."Period Start") + ' ' + MatrixColumnCaptions[i];
        end;
    end;

    procedure SetColumnsStartDate(SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit "Matrix Management";
        i: Integer;
    begin
        PKFirstRecInCurrSet := 'Period Type=CONST(Date),Period Start=CONST(' + Format(StartDate) + ')';
        MatrixMgt.GeneratePeriodMatrixData(SetWanted, 7, True, PeriodType, '', PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, MatrixRecords);
        for i := 1 to ARRAYLEN(MatrixRecords) do begin
            MatrixColumnCaptions[i] := format(matrixrecords[i]."Period Start") + ' ' + MatrixColumnCaptions[i];
        end;
    end;

    local procedure UpdateMatrixSubform()
    begin
        CurrPage.MatrixForm.PAGE.Load(MatrixColumnCaptions, MatrixRecords, CurrSetLength);
        CurrPage.UPDATE(FALSE);
    end;

    local procedure UpdateOnlyfreeMatrixSubform()
    begin
        CurrPage.MatrixForm.PAGE.SetOnlyfree(OnlyFree);
        CurrPage.UPDATE(FALSE);
    end;
}
