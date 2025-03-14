pageextension 90109 ECOPostedSalesShptUpdate extends "Posted Sales Shipment - Update"
{
    layout
    {
        addafter("Shipping Agent Service Code")
        {
            field(ECOdeliveryCode; REC.ECOdeliveryCode)
            {
                ApplicationArea = ALL;
            }
        }
    }
}
