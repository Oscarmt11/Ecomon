namespace Ecomon.Ecomon;

using Microsoft.Sales.Document;

pageextension 90112 "ECOSales Cr Memo" extends "Sales Credit Memo"
{
    layout
    {
        addafter("Salesperson Code")
        {
            field("ECORouteCode"; Rec."ECORouteCode")
            {
                ApplicationArea = All;
            }
            field("ECOdeliveryCode"; Rec.ECOdeliveryCode)
            {
                ApplicationArea = All;
            }
        }
    }
}
