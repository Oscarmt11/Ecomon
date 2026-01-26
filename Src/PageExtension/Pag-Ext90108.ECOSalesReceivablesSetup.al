pageextension 90108 "ECOSales & Receivables Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Logo Position on Documents")
        {
            field(EcoBodyEmail; rec.EcoBodyEmail)
            {
                ApplicationArea = all;
            }
            field(ECOSubjetEmail; rec.ECOSubjetEmail)
            {
                ApplicationArea = all;
            }
            field(EcoBodyEmailInvoices; rec.EcoBodyEmailInvoices)
            {
                ApplicationArea = all;
            }
            field(ECOSubjetEmailInvoices; rec.ECOSubjetEmailInvoices)
            {
                ApplicationArea = all;
            }
        }
        addlast(General)
        {
            field("Journal Template Name"; Rec."Journal Template Name")
            {
                ApplicationArea = All;
            }
            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
