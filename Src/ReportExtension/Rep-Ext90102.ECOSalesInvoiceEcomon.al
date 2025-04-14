namespace Ecomon.Ecomon;

reportextension 90102 "ECOSales - Invoice - Ecomon" extends "Sales Invoice Ecomon"
{
    RDLCLayout = './src/reportExtension/Sales Invoice - Ecomon.rdl';
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
        add("Sales Invoice Line")
        {
            Column(udPrice; "Unit Price")
            {
            }
        }
    }

}
