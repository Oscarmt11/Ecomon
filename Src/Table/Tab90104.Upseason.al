table 90104 "Up-season"
{
    Caption = 'up-season', Comment = 'ESP="Fechas Temporada alta"';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EntryNo; Integer)
        {
            Caption = 'Entry No', Comment = 'ESP="Entrada No"';
        }
        field(5; InitDate; Date)
        {
            Caption = 'Init Date', Comment = 'ESP="Fecha de inicio temporada alta"';
        }
        field(10; EndingDate; Date)
        {
            Caption = 'Ending Date', Comment = 'ESP="Fecha de fin temporada alta"';
        }
    }
    keys
    {
        key(PK; EntryNo)
        {
            Clustered = true;
        }
    }
}
