codeunit 90101 EcoSingMgt
{
    Permissions = tabledata 110 = rm;
    trigger OnRun()
    var
    begin

    end;

    procedure InsertSing(ShippingNo: text[20]; SingNo: text; Observations: Text): text
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
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
        SalesShipmentHeader.Validate(NUBObservations, Observations);
        SalesShipmentHeader.MODIFY(true);
        EXIT('OK');
    end;
    // procedure SendEmail(iscCreditMemo: Boolean)
    // var
    //     SalesSetup: Record "Sales & Receivables Setup";
    //     SalesShipmentHeader: Record "Sales Shipment Header";
    //     InfEmpresa: record "Company Information";
    //     Email: Codeunit Email;
    //     EmailMessage: Codeunit "Email Message";
    //     TempBlob: Codeunit "Temp Blob";
    //     InStr: Instream;
    //     OutStr: OutStream;
    //     ReportParameters, FileName, Base64Result, logo : Text;
    //     FileManagment: codeunit "File Management";
    //     BASE64: Codeunit "Base64 Convert";
    //     inst: InStream;
    //     recRef: RecordRef;
    //     TenantMedia: Record "Tenant Media";
    // begin
    //     if not SalesSetup.Get() then
    //         exit;
    //     SalesSetup.Get;
    //     SalesSetup.CalcFields(ECNSing);
    //     FileName := 'C:\firmatip.jpg';
    //     SalesSetup.ECNSing.Export(FileName);
    //     SalesShipmentHeader := Invoices;
    //     SalesShipmentHeader.Get(SalesShipmentHeader."No.");
    //     SalesShipmentHeader.SetRange("No.", SalesShipmentHeader."No.");
    //     recRef.GetTable(SalesShipmentHeader);
    //     TempBlob.CreateOutStream(OutStr);

    //     TempBlob.FromRecord(SalesSetup, SalesSetup.FieldNo(logo));
    //     TempBlob.CreateInStream(InStr);
    //     Base64Result := BASE64.ToBase64(InStr);
    //     logo := '<IMG style="HEIGHT: 153px; WIDTH: 445px" src="data:image/jpg;base64,' + Base64Result + '"' + 'width=100 height=100>';

    //         if Report.SaveAs(Report::"Sales - Shipment - Ecomon", '', ReportFormat::Pdf, OutStr, recRef) then begin
    //             TempBlob.CreateInStream(InStr);
    //             Base64Result := BASE64.ToBase64(InStr, true);



    //     logo := SalesSetup.Body + logo + SalesSetup.Lopd;
    //     //if  StrPos(SalesSetup.Body,'%') then
    //     //StrSubstNo(SalesSetup.Body,sell-to customer name)
    //     EmailMessage.Create('oscar@toniconsult.com', SalesSetup.Subject, logo, true);
    //     EmailMessage.AddAttachment(SalesShipmentHeader."No." + '.pdf', 'application/pdf', Base64Result);
    //     if Email.Send(EmailMessage, Enum::"Email Scenario"::"Sales Invoice") then begin
    //         if not iscCreditMemo then begin
    //             Invoices.Validate("Sent Invoice", true);
    //             Invoices.Validate("Sent Invoice Date", Today);
    //         end;

    //     end else begin
    //         if not iscCreditMemo then
    //             Invoices.Validate(Error, GetLastErrorText());
    //     end;

    // end;

}
