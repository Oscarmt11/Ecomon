codeunit 90100 Eventos
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Customer No.', false, false)]
    local procedure OnAfterValidateCustomer(var Rec: Record "Sales Header")
    var
        Customer: Record Customer;
    begin
        If Customer.Get(rec."Sell-to Customer No.") Then begin
            Rec."Código Responsable" := Customer."Código Responsable";
            Rec."Código Segmentación" := Customer."Código Segmentación";
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnValidateSellToCustomerNoOnBeforeCheckBlockedCustOnDocs, '', false, false)]
    local procedure "Sales Header_OnValidateSellToCustomerNoOnBeforeCheckBlockedCustOnDocs"(var SalesHeader: Record "Sales Header"; var Cust: Record Customer; var IsHandled: Boolean)
    begin
        SalesHeader.Validate(ECOdeliveryCode, Cust.ECOdeliveryCode);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shipment Header - Edit", OnBeforeSalesShptHeaderModify, '', false, false)]
    local procedure "Shipment Header - Edit_OnBeforeSalesShptHeaderModify"(var SalesShptHeader: Record "Sales Shipment Header"; FromSalesShptHeader: Record "Sales Shipment Header")
    begin
        SalesShptHeader.Validate(ECOdeliveryCode, FromSalesShptHeader.ECOdeliveryCode);
    end;


}
