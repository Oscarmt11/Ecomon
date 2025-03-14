pageextension 90109 "ECOPosted Sales ShipmentUpdate" extends "Posted Sales Shipment - Update"
{
    layout
    {
        addafter("Posting Date")
        {
            field(ECOdeliveryCode; REC.ECOdeliveryCode)
            {
                ApplicationArea = ALL;
            }
        }
    }
}
