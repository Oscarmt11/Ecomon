codeunit 90101 EcoSingMgt
{
    Permissions = tabledata 110 = rm;
    trigger OnRun()
    var
    begin

    end;

    var


    procedure InsertSing(ShippingNo: text[20]; SingNo: text; Observations: Text; Invoice: Boolean): text
    var
        TempBlob: codeunit "Temp Blob";
        Base64: Codeunit "Base64 Convert";
        Outstr: OutStream;
        InStr: InStream;
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesinvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesShipmentHeader.SetRange("No.", ShippingNo);
        IF NOT SalesShipmentHeader.FindFirst() THEN
            EXIT('Error: El albarán no existe');

        TempBlob.CreateOutStream(OutStr);
        Base64.FromBase64(SingNo, OutStr);
        TempBlob.CreateInStream(InStr);
        if invoice then begin
            SalesinvoiceHeader.ECNSing.ImportStream(InStr, '*.png');
            SalesinvoiceHeader.Validate(ECNSinged, true);
            SalesinvoiceHeader.Validate(ECOObservations, Observations);
            SalesinvoiceHeader.MODIFY(true);
            SalesinvoiceHeader.CalcFields(ECOSendByemail);
        end else begin
            SalesShipmentHeader.ECNSing.ImportStream(InStr, '*.png');
            SalesShipmentHeader.Validate(ECNSinged, true);
            SalesShipmentHeader.Validate(ECOObservations, Observations);
            SalesShipmentHeader.MODIFY(true);
            SalesShipmentHeader.CalcFields(ECOSendByemail);
        end;


        Commit();
        if SalesShipmentHeader.ECOSendByemail then begin
            if Invoice then begin
                if SendSalesShipmentHeader(SalesShipmentHeader, SalesinvoiceHeader, true) then begin
                    SalesinvoiceHeader.SetRange("No.", ShippingNo);
                    IF SalesinvoiceHeader.FindFirst() THEN begin
                        SalesinvoiceHeader.Validate(SalesinvoiceHeader.ECNSEmailSent, true);
                        SalesinvoiceHeader.Validate(ECNEmailError, '');
                        SalesinvoiceHeader.Validate("ECNEmailSentDate", Today);
                    end;
                    Commit();
                    SalesinvoiceHeader.MODIFY(true);
                end;
            end else begin
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

        end;
        EXIT('OK');
    end;

    procedure SendSalesShipmentHeader(SalesShipmentHeaderParam: Record "Sales Shipment Header"): Boolean
    var
        SalesSetup: Record "Sales & Receivables Setup";
        InfEmpresa: record "Company Information";
        Customer: Record Customer;
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
        if not Customer.get(SalesShipmentHeaderParam."Sell-to Customer No.") then
            exit;

        if not SalesSetup.Get() then
            exit;
        SalesSetup.TestField(ECOSubjetEmail);
        SalesSetup.TestField(EcoBodyEmail);
        //SalesShimpemntHeaderReport.Get(DocumentNo);
        SalesShipmentHeaderParam.SetRange("No.", SalesShipmentHeaderParam."No.");
        recRef.GetTable(SalesShipmentHeaderParam);
        TempBlob.CreateOutStream(OutStr);
        if Report.SaveAs(Report::"Sales - Shipment - Ecomon", '', ReportFormat::Pdf, OutStr, recRef) then begin
            TempBlob.CreateInStream(InStr);
            Base64Result := BASE64.ToBase64(InStr, true);
            SalesSetup.ECOSubjetEmail := StrSubstNo(SalesSetup.ECOSubjetEmail, SalesShipmentHeaderParam."No.");
            SalesSetup.EcoBodyEmail := StrSubstNo(SalesSetup.EcoBodyEmail, SalesShipmentHeaderParam."No.");
            EmailMessage.Create(Customer."E-Mail" + ';it@ecomon.net', SalesSetup.ECOSubjetEmail, SalesSetup.EcoBodyEmail, true);
            EmailMessage.AddAttachment(SalesShipmentHeaderParam."No." + '.pdf', 'application/pdf', Base64Result);
            if Email.Send(EmailMessage, Enum::"Email Scenario"::"Sales Order") then
                exit(true);
        end;
    end;

    procedure SendSalesShipmentHeader(SalesShipmentHeaderParam: Record "Sales Shipment Header"; SalesInvheder: Record "Sales Invoice Header"; Invoice: Boolean): Boolean
    var
        SalesSetup: Record "Sales & Receivables Setup";
        InfEmpresa: record "Company Information";
        Customer: Record Customer;
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
        if not Customer.get(SalesInvheder."Sell-to Customer No.") then
            exit;

        if not SalesSetup.Get() then
            exit;
        SalesSetup.TestField(ECOSubjetEmail);
        SalesSetup.TestField(EcoBodyEmail);
        //SalesShimpemntHeaderReport.Get(DocumentNo);
        SalesInvheder.SetRange("No.", SalesInvheder."No.");
        recRef.GetTable(SalesInvheder);
        TempBlob.CreateOutStream(OutStr);
        if Report.SaveAs(Report::"Sales Invoice Ecomon", '', ReportFormat::Pdf, OutStr, recRef) then begin
            TempBlob.CreateInStream(InStr);
            Base64Result := BASE64.ToBase64(InStr, true);
            SalesSetup.ECOSubjetEmail := StrSubstNo(SalesSetup.ECOSubjetEmail, SalesInvheder."No.");
            SalesSetup.EcoBodyEmail := StrSubstNo(SalesSetup.EcoBodyEmail, SalesInvheder."No.");
            EmailMessage.Create(Customer."E-Mail" + ';it@ecomon.net', SalesSetup.ECOSubjetEmail, SalesSetup.EcoBodyEmail, true);
            EmailMessage.AddAttachment(SalesInvheder."No." + '.pdf', 'application/pdf', Base64Result);
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

    procedure CreateAndPostItemJournalLine(ItemNo: Code[20]; Quantity: Decimal)
    var
        ItemJournalLine: Record "Item Journal Line";
        ItemJournalPost: Codeunit "Item Jnl.-Post Batch";
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        Item: Record Item;
        ItemJnlTemplate: Record "Item Journal Template";
    begin

        if not SalesReceivablesSetup.Get() then
            Error(Text002);
        if not Item.Get(ItemNo) then
            Error(Text003);

        ItemJournalLine.Init();
        ItemJournalLine.Validate("Journal Template Name", SalesReceivablesSetup."Journal Template Name");
        ItemJournalLine.Validate("Journal Batch Name", SalesReceivablesSetup."Journal Batch Name");
        ItemJournalLine.Validate("Item No.", ItemNo);
        ItemJournalLine.Validate("Gen. Prod. Posting Group", Item."Gen. Prod. Posting Group");
        ItemJournalLine.Validate("Document No.", 'AjusteAPP');
        ItemJournalLine.Validate("Posting Date", Today);
        ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.");
        ItemJournalLine.Validate("Location Code", 'ALMACEN');
        ItemJournalLine.Validate(Quantity, Quantity);
        //ItemJournalLine.Validate("Bin Code", 'BAJO')
        // ItemJournalLine.Validate("Quantity (Base)", Quantity);
        // ItemJournalLine.Validate("Invoiced Quantity", Quantity);
        ItemJournalLine.Insert(true);

        Commit();
        //ItemJournalPost.SetPreviewMode(false);
        //ItemJournalPost.SetSuppressCommit(true);
        if ItemJournalPost.Run(ItemJournalLine) then
            if not GuiAllowed then
                Message(Text001)
            else
                Error(GetLastErrorText());
    end;


    var
        Text001: Label 'The product journal line has been posted successfully.', Comment = 'ESP="La línea del diario de productos se ha registrado correctamente."';
        Text002: Label 'The sales and accounts receivable configuration could not be found.', Comment = 'ESP="No se pudo encontrar la configuración de ventas y cuentas a cobrar."';
        Text003: Label 'The product with No. %1 does not exist', Comment = 'ESP="El producto con Nº %1 no existe"';
}
