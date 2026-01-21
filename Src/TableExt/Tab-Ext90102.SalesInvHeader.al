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
        field(90104; ECNSing; MediaSet)
        {
            Caption = 'ECNSing';
            DataClassification = CustomerContent;
        }
        field(90105; ECNSinged; Boolean)
        {
            Caption = 'Signed', Comment = 'ESP="Firmado"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(90106; ECNSEmailSent; Boolean)
        {
            Caption = 'Email sent', Comment = 'ESP="Email enviado"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(90110; ECNEmailSentDate; Date)
        {
            Caption = 'Email sent', Comment = 'ESP="Email enviado"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(90115; ECNEmailError; Text[2000])
        {
            Caption = 'Error enviar email', Comment = 'ESP="Error enviar email"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(90120; ECOSendByemail; Boolean)
        {
            Caption = 'Send by email', Comment = 'ESP="Enviar por email"';
            FieldClass = FlowField;
            CalcFormula = lookup(
                Customer.ECOSendByemail
                where("No." = field("Bill-to Customer No."))
            );
        }
        field(90125; ECOObservations; Text[100])
        {
            Caption = 'Observaciones', Comment = 'ESP="Observaciones"';
            DataClassification = CustomerContent;
        }
        field(90101; "Código Segmentación"; Code[20])
        {
            Caption = 'Código Segmentación';
            DataClassification = ToBeClassified;
            TableRelation = Segmentos;
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
    }
}
