tableextension 90100 Cust extends Customer
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
        field(90105; "ECOSendByemail"; Boolean)
        {
            Caption = 'Send by email', Comment = 'ESP="Enviar por email"';
            DataClassification = CustomerContent;
        }
        field(90130; "ECORouteCode"; Code[20])
        {
            Caption = 'Routes', Comment = 'ESP="Rutas repartidores"';
            TableRelation = EcoRoutes.EcoRouteCode;
            DataClassification = CustomerContent;
        }
        field(90135; "ECOdeliveryCode"; Code[20])
        {
            Caption = 'Delivery code', Comment = 'ESP="Código  repartidor"';
            TableRelation = ECOdeliverys.ECODeliveryCode;
            DataClassification = CustomerContent;
        }
        field(90140; "Off-season Route Code"; Code[20])
        {
            Caption = 'Off-season Route Code', Comment = 'ESP="Código ruta temporada baja"';
            TableRelation = EcoRoutes.EcoRouteCode;
        }
        field(90145; "Up-season Route Code"; Code[20])
        {
            Caption = 'Up-season Route Code', Comment = 'ESP="Código ruta temporada alta"';
            TableRelation = EcoRoutes.EcoRouteCode;
        }

    }
}
