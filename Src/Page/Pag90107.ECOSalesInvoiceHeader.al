page 90107 ECOSalesInvoiceHeader
{
    ApplicationArea = All;
    Caption = 'ECOSalesInvoiceHeader';
    PageType = List;
    SourceTable = "Sales invoice Header";

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
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Amount"; Rec.Amount)
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
                field("ECOSendByemail"; Rec."ECOSendByemail")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Address 2"; Rec."Sell-to Address 2")
                {
                    ApplicationArea = all;
                }
                field(ECOdeliveryCode; REC.ECOdeliveryCode)
                {
                    ApplicationArea = ALL;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
