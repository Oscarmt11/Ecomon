tableextension 90101 ECOSalesHeader extends "Sales Header"
{
    fields
    {
        field(90100; "Código Responsable"; Code[20])
        {
            Caption = 'Código Responsable';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser" where(Responsable = const(true));
        }
        field(90101; "Código Segmentación"; Code[20])
        {
            Caption = 'Código Segmentación';
            DataClassification = ToBeClassified;
            TableRelation = Segmentos;
        }
        field(90110; "ECORouteCode"; Code[20])
        {
            Caption = 'Routes', Comment = 'ESP="Rutas repartidores"';
        }
        field(90135; "ECOdeliveryCode"; Code[20])
        {
            Caption = 'Delivery code', Comment = 'ESP="Código  repartidor"';
            TableRelation = ECOdeliverys.ECODeliveryCode;
            DataClassification = CustomerContent;
        }
    }
}
