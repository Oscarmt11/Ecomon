table 90100 Segmentos
{
    LookupPageId = Segmentos;
    DrillDownPageId = Segmentos;
    Caption = 'Segmentos';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Código"; Code[20])
        {
            Caption = 'Código';
            DataClassification = ToBeClassified;
        }
        field(2; "Descripción"; Text[100])
        {
            Caption = 'Descripción';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Código")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Código", "Descripción")
        {
        }
        fieldgroup(Brick; "Código", "Descripción")
        {
        }
    }
}
