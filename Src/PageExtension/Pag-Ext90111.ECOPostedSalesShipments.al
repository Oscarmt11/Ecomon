namespace Ecomon.Ecomon;

using Microsoft.Sales.History;

pageextension 90111 "ECOPostedSalesShipments" extends "Posted Sales Shipments"
{
    layout
    {
        addafter("No.")
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
    }
}
