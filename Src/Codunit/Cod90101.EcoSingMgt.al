codeunit 90101 EcoSingMgt
{
    trigger OnRun()
    var
    begin

    end;

    procedure InsertSing(ShippingNo: code[20]; SingNo: text; EmailAdress: Text): text
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        TempBlob: codeunit "Temp Blob";
        Base64: Codeunit "Base64 Convert";
        Outstr: OutStream;
        InStr: InStream;
    begin
        IF NOT SalesShipmentHeader.GET(ShippingNo) THEN
            EXIT('Error: El albarán no existe');

        SalesShipmentHeader.CALCFIELDS(ECNSing);
        //MemoryStream := MemoryStream.MemoryStream(Base64.FromBase64String(firma));
        TempBlob.CreateOutStream(OutStr);
        Base64.FromBase64(SingNo, OutStr);
        TempBlob.CreateInStream(InStr);
        SalesShipmentHeader.ECNSing.ImportStream(InStr, '*.png');

        SalesShipmentHeader.MODIFY;
        EXIT('OK');
    end;

}
