reportextension 90101 "ECOSalesShipmentEcomon l" extends "Sales - Shipment - Ecomon logo"
{
    RDLCLayout = './src/reportExtension/Sales Shipment - Ecomon logo.rdl';
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
            column(ECOdeliveryCode; ECOdeliveryCode)
            {
            }
            column(ECORouteCode; ECORouteCode)
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

    local procedure GetSignImage(): text
    var

    begin
        if "Sales Shipment Header".ECNSing.Count > 0 then begin
            if TenatMedia.Get("Sales Shipment Header".ECNSing.Item(1)) then
                TenatMedia.CalcFields(Content);
        end;
    end;
}
