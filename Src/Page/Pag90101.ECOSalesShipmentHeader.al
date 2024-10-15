page 90101 ECOSalesShipmentHeader
{
    ApplicationArea = All;
    Caption = 'ECOSalesShipmentHeader';
    PageType = List;
    SourceTable = "Sales Shipment Header";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(ECNSinged; Rec.ECNSinged)
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Address"; Rec."Sell-to Address")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
