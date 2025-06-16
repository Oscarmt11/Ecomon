reportextension 90100 "ECOSales - Shipment - Ecomon" extends "Sales - Shipment - Ecomon"
{
    RDLCLayout = './src/reportExtension/Sales Shipment - Ecomon.rdl';
    dataset
    {
        add("Sales Shipment Header")
        {
            column(SingTip; TenatMedia.Content)
            {
            }
            column(ECOObservations; "Sales Shipment Header".ECOObservations)
            {
            }
            column(ECOdeliveryCode; "Sales Shipment Header".ECOdeliveryCode)
            {
            }
            column(ECORouteCode; "Sales Shipment Header".ECORouteCode)
        }
        add("Sales Shipment Line")
        {
            Column(udPrice; "Unit Price")
            {
            }
        }
        modify("Sales Shipment Header")
        {
            trigger OnAfterAfterGetRecord()
            begin
                GetSignImage();
            end;
        }
    }
    VAR
        TenatMedia: Record "Tenant Media";
        SalesShptHeader: Record "Sales Shipment Header";
        SalesHeader: Record "Sales Header";

    local procedure GetSignImage(): text
    begin
        if "Sales Shipment Header".ECNSing.Count > 0 then begin
            if TenatMedia.Get("Sales Shipment Header".ECNSing.Item(1)) then
                TenatMedia.CalcFields(Content);
        end;
    end;

    local procedure GetRoute(OrderNo: Code[20]): Code[20]
    begin
        if SalesHeader.Get(SalesHeader."Document Type"::Order, OrderNo) then
            exit(SalesHeader."ECORouteCode");
    end;

    local procedure Getdelivery(OrderNo: Code[20]): Code[20]
    begin
        if SalesHeader.Get(SalesHeader."Document Type"::Order, OrderNo) then
            exit(SalesHeader."ECOdeliveryCode");
    end;
}
