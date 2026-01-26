codeunit 90101 EcoSingMgt
{
    Permissions = tabledata 110 = rm, tabledata 112 = rm;

    trigger OnRun()
    var
    begin
    end;

    var
        Text001: Label 'The product journal line has been posted successfully.', Comment = 'ESP="La línea del diario de productos se ha registrado correctamente."';
        Text002: Label 'The sales and accounts receivable configuration could not be found.', Comment = 'ESP="No se pudo encontrar la configuración de ventas y cuentas a cobrar."';
        Text003: Label 'The product with No. %1 does not exist', Comment = 'ESP="El producto con Nº %1 no existe"';

    // ------------------------------------
    // ALBARÁN: firma y envío por email
    // ------------------------------------
    procedure InsertSing(ShippingNo: Text[20]; SingNo: Text; Observations: Text): Text
    var
        TempBlob: Codeunit "Temp Blob";
        Base64: Codeunit "Base64 Convert";
        OutStr: OutStream;
        InStr: InStream;
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        SalesShipmentHeader.SetRange("No.", ShippingNo);
        if not SalesShipmentHeader.FindFirst() then
            exit('Error: El albarán no existe');

        TempBlob.CreateOutStream(OutStr);
        Base64.FromBase64(SingNo, OutStr);
        TempBlob.CreateInStream(InStr);
        SalesShipmentHeader.ECNSing.ImportStream(InStr, '*.png');
        SalesShipmentHeader.Validate(ECNSinged, true);
        SalesShipmentHeader.Validate(ECOObservations, Observations);
        SalesShipmentHeader.Modify(true);

        SalesShipmentHeader.CalcFields(ECOSendByemail);
        Commit();

        if SalesShipmentHeader.ECOSendByemail then begin
            if SendSalesShipmentHeader(SalesShipmentHeader) then begin
                SalesShipmentHeader.SetRange("No.", ShippingNo);
                if SalesShipmentHeader.FindFirst() then begin
                    SalesShipmentHeader.Validate(ECNSEmailSent, true);
                    SalesShipmentHeader.Validate(ECNEmailError, '');
                    SalesShipmentHeader.Validate("ECNEmailSentDate", Today);
                    SalesShipmentHeader.Modify(true);
                end;
                Commit();
            end;
        end;

        exit('OK');
    end;

    procedure SendSalesShipmentHeader(SalesShipmentHeaderParam: Record "Sales Shipment Header"): Boolean
    var
        SalesSetup: Record "Sales & Receivables Setup";
        InfEmpresa: Record "Company Information";
        Customer: Record Customer;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        ReportParameters, FileName, Base64Result, Logo : Text;
        FileManagment: Codeunit "File Management";
        BASE64: Codeunit "Base64 Convert";
        Inst: InStream;
        RecRef: RecordRef;
        TenantMedia: Record "Tenant Media";
    begin
        if not Customer.Get(SalesShipmentHeaderParam."Sell-to Customer No.") then
            exit(false);

        if not SalesSetup.Get() then
            exit(false);

        SalesSetup.TestField(ECOSubjetEmail);
        SalesSetup.TestField(EcoBodyEmail);

        SalesShipmentHeaderParam.SetRange("No.", SalesShipmentHeaderParam."No.");
        RecRef.GetTable(SalesShipmentHeaderParam);

        TempBlob.CreateOutStream(OutStr);
        if Report.SaveAs(Report::"Sales - Shipment - Ecomon logo", '', ReportFormat::Pdf, OutStr, RecRef) then begin
            TempBlob.CreateInStream(InStr);
            Base64Result := BASE64.ToBase64(InStr, true);

            SalesSetup.ECOSubjetEmail := StrSubstNo(SalesSetup.ECOSubjetEmail, SalesShipmentHeaderParam."No.");
            SalesSetup.EcoBodyEmail := StrSubstNo(SalesSetup.EcoBodyEmail, SalesShipmentHeaderParam."No.");

            EmailMessage.Create(Customer."E-Mail", SalesSetup.ECOSubjetEmail, SalesSetup.EcoBodyEmail, true);
            EmailMessage.AddAttachment(SalesShipmentHeaderParam."No." + '.pdf', 'application/pdf', Base64Result);

            if Email.Send(EmailMessage, Enum::"Email Scenario"::"Sales Order") then
                exit(true);
        end;
    end;

    procedure GetPdfbase64Shipment(ShippingNo: Text[20]): Text
    var
        FileManagment: Codeunit "File Management";
        BASE64: Codeunit "Base64 Convert";
        Inst: InStream;
        RecRef: RecordRef;
        InStr: InStream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        SalesShipmentHeaderParam, SalesShipment2 : Record "Sales Shipment Header";
    begin
        SalesShipmentHeaderParam.SetRange("No.", ShippingNo);
        if SalesShipmentHeaderParam.FindFirst() then
            RecRef.GetTable(SalesShipmentHeaderParam);

        TempBlob.CreateOutStream(OutStr);
        if Report.SaveAs(Report::"Sales - Shipment - Ecomon", '', ReportFormat::Pdf, OutStr, RecRef) then begin
            TempBlob.CreateInStream(InStr);
            exit(BASE64.ToBase64(InStr, true));
        end;
    end;

    // ------------------------------------
    // FACTURA: firma y envío por email
    // (DUPLICADO PARA "Sales Invoice Header")
    // ------------------------------------
    procedure InsertSingInvoice(InvoiceNo: Text[20]; SingNo: Text; Observations: Text): Text
    var
        TempBlob: Codeunit "Temp Blob";
        Base64: Codeunit "Base64 Convert";
        OutStr: OutStream;
        InStr: InStream;
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        SalesInvoiceHeader.SetRange("No.", InvoiceNo);
        if not SalesInvoiceHeader.FindFirst() then
            exit('Error: La factura no existe');

        TempBlob.CreateOutStream(OutStr);
        Base64.FromBase64(SingNo, OutStr);
        TempBlob.CreateInStream(InStr);
        SalesInvoiceHeader.ECNSing.ImportStream(InStr, '*.png');
        SalesInvoiceHeader.Validate(ECNSinged, true);
        SalesInvoiceHeader.Validate(ECOObservations, Observations);
        SalesInvoiceHeader.Modify(true);

        SalesInvoiceHeader.CalcFields(ECOSendByemail);
        Commit();

        if SalesInvoiceHeader.ECOSendByemail then begin
            if SendSalesInvoiceHeader(SalesInvoiceHeader) then begin
                SalesInvoiceHeader.SetRange("No.", InvoiceNo);
                if SalesInvoiceHeader.FindFirst() then begin
                    SalesInvoiceHeader.Validate(ECNSEmailSent, true);
                    SalesInvoiceHeader.Validate(ECNEmailError, '');
                    SalesInvoiceHeader.Validate("ECNEmailSentDate", Today);
                    SalesInvoiceHeader.Modify(true);
                end;
                Commit();
            end;
        end;

        exit('OK');
    end;

    procedure SendSalesInvoiceHeader(SalesInvoiceHeaderParam: Record "Sales Invoice Header"): Boolean
    var
        SalesSetup: Record "Sales & Receivables Setup";
        InfEmpresa: Record "Company Information";
        Customer: Record Customer;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        ReportParameters, FileName, Base64Result, Logo : Text;
        FileManagment: Codeunit "File Management";
        BASE64: Codeunit "Base64 Convert";
        Inst: InStream;
        RecRef: RecordRef;
        TenantMedia: Record "Tenant Media";
    begin
        if not Customer.Get(SalesInvoiceHeaderParam."Sell-to Customer No.") then
            exit(false);

        if not SalesSetup.Get() then
            exit(false);

        SalesSetup.TestField(ECOSubjetEmailInvoices);
        SalesSetup.TestField(EcoBodyEmailInvoices);

        SalesInvoiceHeaderParam.SetRange("No.", SalesInvoiceHeaderParam."No.");
        RecRef.GetTable(SalesInvoiceHeaderParam);

        TempBlob.CreateOutStream(OutStr);
        // Cambia el informe si el nombre es distinto en tu BD
        if Report.SaveAs(Report::"Sales Invoice Ecomon logo", '', ReportFormat::Pdf, OutStr, RecRef) then begin
            TempBlob.CreateInStream(InStr);
            Base64Result := BASE64.ToBase64(InStr, true);

            SalesSetup.ECOSubjetEmailInvoices := StrSubstNo(SalesSetup.ECOSubjetEmailInvoices, SalesInvoiceHeaderParam."No.");
            SalesSetup.EcoBodyEmailInvoices := StrSubstNo(SalesSetup.EcoBodyEmailInvoices, SalesInvoiceHeaderParam."No.");

            EmailMessage.Create(Customer."E-Mail", SalesSetup.ECOSubjetEmailInvoices, SalesSetup.EcoBodyEmailInvoices, true);
            EmailMessage.AddAttachment(SalesInvoiceHeaderParam."No." + '.pdf', 'application/pdf', Base64Result);

            // Para facturas utilizo el escenario de email "Sales Invoice"
            if Email.Send(EmailMessage, Enum::"Email Scenario"::"Sales Invoice") then
                exit(true);
        end;
    end;

    procedure GetPdfbase64Invoice(InvoiceNo: Text[20]): Text
    var
        FileManagment: Codeunit "File Management";
        BASE64: Codeunit "Base64 Convert";
        Inst: InStream;
        RecRef: RecordRef;
        InStr: InStream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        SalesInvoiceHeaderParam, SalesInvoice2 : Record "Sales Invoice Header";
    begin
        SalesInvoiceHeaderParam.SetRange("No.", InvoiceNo);
        if SalesInvoiceHeaderParam.FindFirst() then
            RecRef.GetTable(SalesInvoiceHeaderParam);

        TempBlob.CreateOutStream(OutStr);
        // Cambia el informe si el nombre es distinto en tu BD
        if Report.SaveAs(Report::"Sales Invoice Ecomon", '', ReportFormat::Pdf, OutStr, RecRef) then begin
            TempBlob.CreateInStream(InStr);
            exit(BASE64.ToBase64(InStr, true));
        end;
    end;

    // ------------------------------------
    // TU FUNCIÓN DE AJUSTE DE STOCK
    // ------------------------------------
    procedure CreateAndPostItemJournalLine(ItemNo: Code[20]; Quantity: Decimal; Customer: Code[20])
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

        ItemJournalLine.Reset();
        ItemJournalLine.SetRange("Journal Template Name", SalesReceivablesSetup."Journal Template Name");
        ItemJournalLine.SetRange("Journal Batch Name", SalesReceivablesSetup."Journal Batch Name");
        ItemJournalLine.SetRange("Document No.", 'AjusteAPP');
        ItemJournalLine.SetRange("Item No.", ItemNo);

        if ItemJournalLine.FindLast() then
            if not ItemJournalPost.Run(ItemJournalLine) then
                Error(GetLastErrorText());

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
        ItemJournalLine.Validate("Source Type", ItemJournalLine."Source Type"::Customer);
        ItemJournalLine.Validate("Source No.", Customer);
        ItemJournalLine.Insert(true);

        Commit();

        if ItemJournalPost.Run(ItemJournalLine) then
            if not GuiAllowed then
                Message(Text001)
            else
                Error(GetLastErrorText());
    end;
}
