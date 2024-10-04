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
    }
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
