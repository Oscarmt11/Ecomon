tableextension 90106 "ECOSales & Receivables Setup " extends "Sales & Receivables Setup"
{
    fields
    {
        field(90100; ECOSubjetEmail; Text[100])
        {
            Caption = 'Subjet Email', Comment = 'ESP="Cuerpo email"';
            DataClassification = ToBeClassified;
        }
        field(90101; EcoBodyEmail; Text[2000])
        {
            Caption = 'Body', Comment = 'ESP="Cuerpo del mensaje"';
            DataClassification = ToBeClassified;
        }
    }
}
