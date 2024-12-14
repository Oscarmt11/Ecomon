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
        }
    }
}
