pageextension 90103 PostCrMemo extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field("Código Responsable"; Rec."Código Responsable")
            {
                ApplicationArea = All;
            }
            field("Código Segmentación"; Rec."Código Segmentación")
            {
                ApplicationArea = All;
            }
        }
    }
}
