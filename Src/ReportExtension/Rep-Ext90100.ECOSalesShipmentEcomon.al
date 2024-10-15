reportextension 90100 "ECOSales - Shipment - Ecomon" extends "Sales - Shipment - Ecomon"
{
    RDLCLayout = './src/reportExtension/Sales Shipment - Ecomon.rdl';
    dataset
    {
        add("Sales Shipment Header")
        {
            column(SingTip; TenatMedia.Content) { }
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
    begin
        if "Sales Shipment Header".ECNSing.Count > 0 then begin
            if TenatMedia.Get("Sales Shipment Header".ECNSing.Item(1)) then
                TenatMedia.CalcFields(Content);
        end;


    end;
}
