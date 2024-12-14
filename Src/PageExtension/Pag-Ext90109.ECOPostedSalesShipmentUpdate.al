pageextension 90109 "ECOPosted Sales ShipmentUpdate" extends NUBPostedSalesShipmentEdit
{
    layout
    {
        addafter("Ship-to Post Code")
        {
            field(ECOdeliveryCode; REC.ECOdeliveryCode)
            {
                ApplicationArea = ALL;
            }
        }
    }
}
