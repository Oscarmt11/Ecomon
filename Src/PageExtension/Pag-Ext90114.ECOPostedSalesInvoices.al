namespace Ecomon.Ecomon;

using Microsoft.Sales.History;

pageextension 90114 ECOPostedSalesInvoices extends "Posted Sales Invoices"
{
    layout
    {
        addafter("Order No.")
        {
            field(ECNSing; REC.ECNSing)
            {
                ApplicationArea = ALL;
            }
            field(ECOObservations; REC.ECOObservations)
            {
                ApplicationArea = ALL;
            }
            field(ECNSEmailSent; REC.ECNSEmailSent)
            {
                ApplicationArea = ALL;
            }
            field(ECNEmailSentDate; REC.ECNEmailSentDate)
            {
                ApplicationArea = ALL;
            }
            field(ECNEmailError; REC.ECNEmailError)
            {
                ApplicationArea = ALL;
            }
        }
        addafter("Ship-to Post Code")
        {
            field("ECORouteCode"; Rec."ECORouteCode")
            {
                ApplicationArea = All;
            }
            field(ECOdeliveryCode; REC.ECOdeliveryCode)
            {
                ApplicationArea = ALL;
            }
        }
    }
}
