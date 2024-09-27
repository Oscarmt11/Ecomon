codeunit 90100 Eventos
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Customer No.', false, false)]
    local procedure OnAfterValidateCustomer(var Rec: Record "Sales Header")
    var
        Customer: Record Customer;
    begin
        If Customer.Get(rec."Sell-to Customer No.")Then begin
            Rec."Código Responsable":=Customer."Código Responsable";
            Rec."Código Segmentación":=Customer."Código Segmentación";
        end;
    end;
}
