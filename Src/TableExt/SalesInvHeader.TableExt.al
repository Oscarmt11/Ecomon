tableextension 90102 SalesInvHeader extends "Sales Invoice Header"
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
        field(90135; "ECOdeliveryCode"; Code[20])
        {
            Caption = 'Delivery code', Comment = 'ESP="Código  repartidoror"';
            TableRelation = ECOdeliverys.ECODeliveryCode;
            DataClassification = CustomerContent;
        }
    }
}
