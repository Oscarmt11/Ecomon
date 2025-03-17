namespace Ecomon.Ecomon;

reportextension 90101 "ECOSalesShipmentEcomon l" extends "Sales - Shipment - Ecomon logo"
{
    RDLCLayout = './src/reportExtension/Sales Shipment - Ecomon logo.rdl';
    dataset
    {
        add("Sales Shipment Header")
        {
            column(ECOObservations; "Sales Shipment Header".ECOObservations) { }
        }
    }
}
