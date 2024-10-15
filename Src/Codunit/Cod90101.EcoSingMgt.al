codeunit 90101 EcoSingMgt
{
    Permissions = tabledata 110 = rm;
    trigger OnRun()
    var
    begin

    end;

    var
        SalesShipmentHeader: Record "Sales Shipment Header";

    procedure InsertSing(ShippingNo: text[20]; SingNo: text; Observations: Text): text
    var
        TempBlob: codeunit "Temp Blob";
        Base64: Codeunit "Base64 Convert";
        Outstr: OutStream;
        InStr: InStream;
    begin
        IF NOT SalesShipmentHeader.GET(ShippingNo) THEN
            EXIT('Error: El albarán no existe');

        TempBlob.CreateOutStream(OutStr);
        Base64.FromBase64(SingNo, OutStr);
        TempBlob.CreateInStream(InStr);
        SalesShipmentHeader.ECNSing.ImportStream(InStr, '*.png');
        SalesShipmentHeader.Validate(ECNSinged, true);
        //SalesShipmentHeader.Validate(NUBObservations, Observations);        
        SendSalesShipmentHeader(SalesShipmentHeader);
        Commit();
        SalesShipmentHeader.MODIFY(true);
        EXIT('OK');
    end;

    procedure SendSalesShipmentHeader(var SalesShipmentHeader: Record "Sales Shipment Header")
    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesShimpemntHeaderReport: Record "Sales Shipment Header";
        InfEmpresa: record "Company Information";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        InStr: Instream;
        OutStr: OutStream;
        ReportParameters, FileName, Base64Result, logo : Text;
        FileManagment: codeunit "File Management";
        BASE64: Codeunit "Base64 Convert";
        inst: InStream;
        recRef: RecordRef;
        TenantMedia: Record "Tenant Media";
    begin
        if not SalesSetup.Get() then
            exit;
        SalesSetup.Get;
        SalesShimpemntHeaderReport.Get(SalesShipmentHeader."No.");
        SalesShimpemntHeaderReport.SetRange("No.", SalesShipmentHeader."No.");
        recRef.GetTable(SalesShimpemntHeaderReport);
        TempBlob.CreateOutStream(OutStr);
        if Report.SaveAs(Report::"Sales - Shipment - Ecomon", '', ReportFormat::Pdf, OutStr, recRef) then begin
            TempBlob.CreateInStream(InStr);
            Base64Result := BASE64.ToBase64(InStr, true);
            EmailMessage.Create('oscarmingte@gmail.com', 'prueba asunto', 'texto', true);
            EmailMessage.AddAttachment(SalesShipmentHeader."No." + '.pdf', 'application/pdf', Base64Result);
            if Email.Send(EmailMessage, Enum::"Email Scenario"::"Sales Order") then begin
                SalesShipmentHeader.Validate(ECNSEmailSent, true);
                SalesShipmentHeader.Validate("ECNEmailSentDate", Today);
            end else
                SalesShipmentHeader.Validate(ECNEmailError, GetLastErrorText());
        end else
            SalesShipmentHeader.Validate(ECNEmailError, GetLastErrorText());
        Message(GetLastErrorText());

    end;

}
