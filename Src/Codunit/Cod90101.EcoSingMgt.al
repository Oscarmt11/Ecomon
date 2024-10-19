codeunit 90101 EcoSingMgt
{
    Permissions = tabledata 110 = rm;
    trigger OnRun()
    var
    begin

    end;

    var


    procedure InsertSing(ShippingNo: text[20]; SingNo: text; Observations: Text): text
    var
        TempBlob: codeunit "Temp Blob";
        Base64: Codeunit "Base64 Convert";
        Outstr: OutStream;
        InStr: InStream;
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        SalesShipmentHeader.SetRange("No.", ShippingNo);
        IF NOT SalesShipmentHeader.FindFirst() THEN
            EXIT('Error: El albarán no existe');

        TempBlob.CreateOutStream(OutStr);
        Base64.FromBase64(SingNo, OutStr);
        TempBlob.CreateInStream(InStr);
        SalesShipmentHeader.ECNSing.ImportStream(InStr, '*.png');
        SalesShipmentHeader.Validate(ECNSinged, true);
        SalesShipmentHeader.Validate(ECOObservations, Observations);
        SalesShipmentHeader.CalcFields(ECOSendByemail);
        if SalesShipmentHeader.ECOSendByemail then begin
            if SendSalesShipmentHeader(SalesShipmentHeader) then begin
                SalesShipmentHeader.SetRange("No.", ShippingNo);
                IF SalesShipmentHeader.FindFirst() THEN begin
                    SalesShipmentHeader.Validate(SalesShipmentHeader.ECNSEmailSent, true);
                    SalesShipmentHeader.Validate(ECNEmailError, '');
                    SalesShipmentHeader.Validate("ECNEmailSentDate", Today);
                end;
                Commit();
                SalesShipmentHeader.MODIFY(true);
            end;
        end;
        EXIT('OK');
    end;

    procedure SendSalesShipmentHeader(SalesShipmentHeaderParam: Record "Sales Shipment Header"): Boolean
    var
        SalesSetup: Record "Sales & Receivables Setup";
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
        //SalesShimpemntHeaderReport.Get(DocumentNo);
        SalesShipmentHeaderParam.SetRange("No.", SalesShipmentHeaderParam."No.");
        recRef.GetTable(SalesShipmentHeaderParam);
        TempBlob.CreateOutStream(OutStr);
        if Report.SaveAs(Report::"Sales - Shipment - Ecomon", '', ReportFormat::Pdf, OutStr, recRef) then begin
            TempBlob.CreateInStream(InStr);
            Base64Result := BASE64.ToBase64(InStr, true);
            EmailMessage.Create('oscarmingte@gmail.com', 'prueba asunto', 'texto', true);
            EmailMessage.AddAttachment(SalesShipmentHeaderParam."No." + '.pdf', 'application/pdf', Base64Result);
            if Email.Send(EmailMessage, Enum::"Email Scenario"::"Sales Order") then
                exit(true);
        end;
    end;

    procedure GetPdfbase64Shipment(ShippingNo: text[20]): Text
    var
        FileManagment: codeunit "File Management";
        BASE64: Codeunit "Base64 Convert";
        inst: InStream;
        recRef: RecordRef;
        InStr: Instream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        SalesShipmentHeaderParam, salesShipment2 : Record "Sales Shipment Header";
    begin
        SalesShipmentHeaderParam.SetRange("No.", ShippingNo);
        if SalesShipmentHeaderParam.FindFirst() then
            recRef.GetTable(SalesShipmentHeaderParam);
        TempBlob.CreateOutStream(OutStr);
        if Report.SaveAs(Report::"Sales - Shipment - Ecomon", '', ReportFormat::Pdf, OutStr, recRef) then begin
            TempBlob.CreateInStream(InStr);
            exit(BASE64.ToBase64(InStr, true));
        end;
    end;

}
