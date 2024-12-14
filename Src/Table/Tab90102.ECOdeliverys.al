table 90102 ECOdeliverys
{
    Caption = 'Deliverys', Comment = 'ESP="Repartidores"';
    DataClassification = ToBeClassified;
    LookupPageId = ECOdeliverys;
    DrillDownPageId = ECOdeliverys;

    fields
    {
        field(1; ECODeliveryCode; Code[20])
        {
            Caption = 'Delivery Code', Comment = 'ESP="Código repartidor"';
        }
        field(5; ECODeliveryDescription; Text[100])
        {
            Caption = 'Delivery Description', Comment = 'ESP="Descripción repartidor"';
        }
    }
    keys
    {
        key(PK; ECODeliveryCode)
        {
            Clustered = true;
        }
    }
}
