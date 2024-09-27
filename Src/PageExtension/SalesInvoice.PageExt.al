pageextension 90101 SalesInvoice extends "Sales Invoice"
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
