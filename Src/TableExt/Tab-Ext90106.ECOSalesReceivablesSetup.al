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
        field(90105; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name', Comment = 'ESP="Nombre del libro diario"';
            DataClassification = ToBeClassified;
        }
        field(90110; "Journal Batch Name"; Code[20])
        {
            Caption = 'Journal Batch Name', Comment = 'ESP="Nombre de la plantilla de diario"';
            DataClassification = ToBeClassified;
        }
    }
}
