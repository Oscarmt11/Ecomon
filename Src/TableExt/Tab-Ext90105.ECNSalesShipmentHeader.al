tableextension 90105 ECNSalesShipmentHeader extends "Sales Shipment Header"
{
    fields
    {
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
        field(90110; ECNEmailSentDate; date)
        {
            Caption = 'Email sent', Comment = 'ESP="Email enviado"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(90115; ECNEmailError; text[2000])
        {
            Caption = 'Error enviar email', Comment = 'ESP="Error enviar email"';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(90120; "ECOSendByemail"; Boolean)
        {
            Caption = 'Send by email', Comment = 'ESP="Enviar por email"';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.ECOSendByemail where("No." = field("Bill-to Customer No.")));

        }
        field(90125; "ECOObservations"; Text[100])
        {
            Caption = 'Observaciones', Comment = 'ESP="Observaciones"';
            DataClassification = CustomerContent;

        }
        field(90135; "ECOdeliveryCode"; Code[20])
        {
            Caption = 'Delivery code', Comment = 'ESP="Código  repartidoror"';
            TableRelation = ECOdeliverys.ECODeliveryCode;
            DataClassification = CustomerContent;
        }
    }
    // var
    //     TentMedia: Record "Tenant Media";
    //     procedure SetECODeliverCode(NewECODeliveryCode: Text)
    // var
    //     OutStream: OutStream;
    // begin
    //     Clear(ECOdeliveryCode);
    //     ECOdeliveryCode.CreateOutStream(OutStream, TEXTENCODING::UTF8);
    //     OutStream.WriteText(NewWorkDescription);
    //     Modify;
    // end;
}
