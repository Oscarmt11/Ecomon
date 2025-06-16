pageextension 90104 Customer extends "Customer Card"
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
            field("ECOSendByemail"; Rec."ECOSendByemail")
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
