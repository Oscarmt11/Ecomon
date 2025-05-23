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
        addbefore(ECOObservations)
        {
            field(AutoInvoicing; Rec.AutoInvoicing)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("F&unctions")
        {
            action(ChangeDeliveryCode)
            {
                ApplicationArea = All;
                Caption = 'Change delivery Code', Comment = 'ESP="Cambio de código repartidor"';
                Image = Change;
                trigger OnAction()
                var
                    ChangeDeliveryCode: Report ECOChangeECOdeliveryCode;
                    SalesShimp: Record "Sales Shipment Header";
                begin
                    SalesShimp := Rec;
                    CurrPage.SetSelectionFilter(SalesShimp);
                    ChangeDeliveryCode.SetTableView(SalesShimp);
                    ChangeDeliveryCode.RunModal();
                end;
            }
        }
    }
}
