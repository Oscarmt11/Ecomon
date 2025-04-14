namespace Ecomon.Ecomon;

reportextension 90103 "ECOSales - Invoice - Ecomon l" extends "Sales Invoice Ecomon logo"
{
    RDLCLayout = './src/reportExtension/Sales Invoice - Ecomon logo.rdl';
    dataset
    {
        add("Sales Invoice Header")
        {
            column(ECOdeliveryCode; ECOdeliveryCode)
            {
            }
            column(ECORouteCode; ECORouteCode)
            {
            }
        }
    }
}
