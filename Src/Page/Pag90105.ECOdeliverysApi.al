namespace Ecomon.Ecomon;

page 90105 ECOdeliverysApi
{
    APIGroup = 'apiGroup';
    APIPublisher = 'Tpdata';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'ecOdeliverysApi';
    DelayedInsert = true;
    EntityName = 'ecOdelivery';
    EntitySetName = 'ecOdeliverys';
    PageType = API;
    SourceTable = ECOdeliverys;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ecoDeliveryCode; Rec.ECODeliveryCode)
                {
                    Caption = 'Delivery Code', Comment = 'ESP="Código repartidor"';
                }
                field(ECODeliveryDescription; Rec.ECODeliveryDescription)
                {
                    Caption = 'Delivery Code', Comment = 'ESP="Descripcion repartidor"';
                }
            }
        }
    }
}
