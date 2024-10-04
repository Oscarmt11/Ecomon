pageextension 90107 ECOPostedSalesShipment extends "Posted Sales Shipment"
{
    layout
    {
        addafter("Order No.")
        {
            field(ECNSing; REC.ECNSing)
            {
                ApplicationArea = ALL;
            }
        }
    }
}
