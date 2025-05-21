pageextension 90102 PostSalesInvoice extends "Posted Sales Invoice"
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
            field("ECORouteCode"; Rec."ECORouteCode")
            {
                ApplicationArea = All;
            }
            field("ECOdeliveryCode"; Rec."ECOdeliveryCode")
            {
                ApplicationArea = All;
            }
        }
    }
}
