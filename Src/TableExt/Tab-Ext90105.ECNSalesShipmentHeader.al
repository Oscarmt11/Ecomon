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
            Caption = 'Email sent', Comment = 'ESP="Email enviado"';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
    var
        TentMedia: Record "Tenant Media";

    procedure SetWorkDescription(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Work Description");
        "Work Description".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify();
    end;
}
