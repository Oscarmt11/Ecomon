namespace Ecomon.Ecomon;

using Microsoft.Sales.History;

report 90100 ECOChangeECOdeliveryCode
{
    Caption = 'Change delivery Code', Comment = 'ESP="Cambio de código repartidor"';
    Permissions =
     tabledata "Sales Shipment Header" = RM;
    ProcessingOnly = true;
    dataset
    {
        dataitem(SalesShipmentHeader; "Sales Shipment Header")
        {
            trigger OnAfterGetRecord()
            begin
                SalesShipmentHeader.Validate("ECOdeliveryCode", NewecoDeliveryCode);
                SalesShipmentHeader.Modify();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(NewecoDeliveryCode; NewecoDeliveryCode)
                    {
                        ApplicationArea = All;
                        Caption = 'New delivery code', Comment = 'ESP="Nuevo código repartidor"';
                        TableRelation = ECOdeliverys.ECODeliveryCode;
                    }
                }
            }
        }
    }
    VAR
        NewecoDeliveryCode: Code[20];
}
