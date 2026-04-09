codeunit 90100 Eventos
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Customer No.', false, false)]
    local procedure OnAfterValidateCustomer(var Rec: Record "Sales Header")
    var
        Customer: Record Customer;
    begin
        If Customer.Get(rec."Sell-to Customer No.") Then begin
            Rec."Código Responsable" := Customer."Código Responsable";
            Rec."Código Segmentación" := Customer."Código Segmentación";
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnValidateSellToCustomerNoOnBeforeCheckBlockedCustOnDocs, '', false, false)]
    local procedure "Sales Header_OnValidateSellToCustomerNoOnBeforeCheckBlockedCustOnDocs"(var SalesHeader: Record "Sales Header"; var Cust: Record Customer; var IsHandled: Boolean)
    begin
        SalesHeader.Validate(ECOdeliveryCode, Cust.ECOdeliveryCode);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Shipment - Update", OnAfterRecordChanged, '', false, false)]
    local procedure "Posted Sales Shipment - Update_OnAfterRecordChanged"(var SalesShipmentHeader: Record "Sales Shipment Header"; xSalesShipmentHeader: Record "Sales Shipment Header"; var IsChanged: Boolean)
    begin
        IsChanged := (SalesShipmentHeader.ECOdeliveryCode <> xSalesShipmentHeader.ECOdeliveryCode);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Shipment Header - Edit", OnBeforeSalesShptHeaderModify, '', false, false)]
    local procedure "Shipment Header - Edit_OnBeforeSalesShptHeaderModify"(var SalesShptHeader: Record "Sales Shipment Header"; FromSalesShptHeader: Record "Sales Shipment Header")
    begin
        SalesShptHeader.Validate(ECOdeliveryCode, FromSalesShptHeader.ECOdeliveryCode);
    end;
    // <summary>
    // Copia el stock actual de productos no bloqueados como entrada positiva en otra empresa.
    // </summary>
    // <param name="EmpresaDestino">Nombre de la empresa destino donde se creará la entrada de stock.</param>
    procedure CopiarStockActual(EmpresaDestino: Text[30])
    var
        Item: Record Item;
        ItemDestino: Record Item;
        ItemJournalLine: Record "Item Journal Line";
        MovAlmacen: Record "Warehouse Entry";
        ItemJournalTemplate: Record "Item Journal Template";
        ItemJournalBatch: Record "Item Journal Batch";
        Company: Record Company;
        StockActual: Decimal;
        LineNo: Integer;
        EmpresaOrigen: Text[30];
    begin
        // Validaciones
        If EmpresaDestino = '' Then
            Error('No se puede dejar la empresa destino en blanco');

        EmpresaOrigen := CompanyName;
        If EmpresaOrigen = EmpresaDestino Then
            Error('La empresa origen y la destino no pueden ser la misma');

        // Verificar que existe la empresa destino
        If Not Company.Get(EmpresaDestino) Then
            Error('La empresa destino %1 no existe', EmpresaDestino);

        // Obtener plantilla y lote de diario de artículos (usando la primera disponible)
        ItemJournalTemplate.ChangeCompany(EmpresaDestino);
        ItemJournalTemplate.SetRange(Type, ItemJournalTemplate.Type::Item);
        ItemJournalTemplate.SetRange(Recurring, false);
        If Not ItemJournalTemplate.FindFirst() Then
            Error('No se encontró una plantilla de diario de artículos en la empresa destino');

        ItemJournalBatch.ChangeCompany(EmpresaDestino);
        ItemJournalBatch.SetRange("Journal Template Name", ItemJournalTemplate.Name);
        If Not ItemJournalBatch.FindFirst() Then
            Error('No se encontró un lote de diario de artículos en la empresa destino');

        // Recorrer productos no bloqueados de la empresa origen
        Item.SetRange(Blocked, false);
        If Item.FindSet() Then begin
            repeat
                // Calcular y obtener stock actual del producto
                Item.CalcFields(Inventory);
                StockActual := Item.Inventory;

                // Solo procesar si hay stock
                If StockActual > 0 Then begin
                    // Verificar que el producto existe en la empresa destino
                    ItemDestino.ChangeCompany(EmpresaDestino);
                    If ItemDestino.Get(Item."No.") Then begin
                        // Obtener siguiente número de línea
                        ItemJournalLine.ChangeCompany(EmpresaDestino);
                        ItemJournalLine.SetRange("Journal Template Name", ItemJournalTemplate.Name);
                        ItemJournalLine.SetRange("Journal Batch Name", ItemJournalBatch.Name);
                        If ItemJournalLine.FindLast() Then
                            LineNo := ItemJournalLine."Line No." + 10000
                        Else
                            LineNo := 10000;

                        // Crear línea de diario de entrada positiva
                        ItemJournalLine.Init();
                        ItemJournalLine."Journal Template Name" := ItemJournalTemplate.Name;
                        ItemJournalLine."Journal Batch Name" := ItemJournalBatch.Name;
                        ItemJournalLine."Line No." := LineNo;
                        ItemJournalLine."Posting Date" := Today;
                        ItemJournalLine."Document Date" := Today;
                        ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Positive Adjmt.";
                        ItemJournalLine.Validate("Item No.", Item."No.");
                        ItemJournalLine.Validate("Location Code", 'ALMACEN');
                        //Bin Code Item
                        MovAlmacen.SetRange("Item No.", Item."No.");
                        MovAlmacen.SetRange("Location Code", 'ALMACEN');
                        if MovAlmacen.FindLast() then
                            ItemJournalLine.Validate("Bin Code", MovAlmacen."Bin Code");

                        ItemJournalLine.Validate(Quantity, StockActual);
                        ItemJournalLine."Document No." := 'COPIA-STOCK-' + Format(Today, 0, '<Year4><Month,2><Day,2>');
                        ItemJournalLine.Description := 'Copia de stock desde ' + EmpresaOrigen + ' - ' + Format(Today);
                        ItemJournalLine.Insert(true);
                    end;
                end;
            until Item.Next() = 0;
        end;
    end;

    // <summary>
    // Copia el stock actual de productos no bloqueados como entrada positiva en otra empresa.
    // </summary>
    // <param name="EmpresaDestino">Nombre de la empresa destino donde se creará la entrada de stock.</param>
    procedure VaciarStock()
    var
        Item: Record Item;
        ItemDestino: Record Item;
        ItemJournalLine: Record "Item Journal Line";
        MovAlmacen: Record "Warehouse Entry";
        ItemJournalTemplate: Record "Item Journal Template";
        ItemJournalBatch: Record "Item Journal Batch";
        StockActual: Decimal;
        LineNo: Integer;
        EmpresaOrigen: Text[30];
    begin
        // Obtener plantilla y lote de diario de artículos (usando la primera disponible)
        ItemJournalTemplate.SetRange(Type, ItemJournalTemplate.Type::Item);
        ItemJournalTemplate.SetRange(Recurring, false);
        If Not ItemJournalTemplate.FindFirst() Then
            Error('No se encontró una plantilla de diario de artículos en la empresa destino');

        ItemJournalBatch.SetRange("Journal Template Name", ItemJournalTemplate.Name);
        If Not ItemJournalBatch.FindFirst() Then
            Error('No se encontró un lote de diario de artículos en la empresa destino');

        // Recorrer productos no bloqueados de la empresa origen
        If Item.FindSet() Then begin
            repeat
                // Calcular y obtener stock actual del producto
                Item.CalcFields(Inventory);
                StockActual := Item.Inventory;

                // Solo procesar si hay stock
                If StockActual > 0 Then begin
                    If Item.Blocked Then begin
                        Item.Blocked := false;
                        Item.Modify();
                    end;
                    // Verificar que el producto existe en la empresa destino
                    If ItemDestino.Get(Item."No.") Then begin
                        // Obtener siguiente número de línea
                        ItemJournalLine.SetRange("Journal Template Name", ItemJournalTemplate.Name);
                        ItemJournalLine.SetRange("Journal Batch Name", ItemJournalBatch.Name);
                        If ItemJournalLine.FindLast() Then
                            LineNo := ItemJournalLine."Line No." + 10000
                        Else
                            LineNo := 10000;

                        // Crear línea de diario de entrada positiva
                        ItemJournalLine.Init();
                        ItemJournalLine."Journal Template Name" := ItemJournalTemplate.Name;
                        ItemJournalLine."Journal Batch Name" := ItemJournalBatch.Name;
                        ItemJournalLine."Line No." := LineNo;
                        ItemJournalLine."Posting Date" := Today;
                        ItemJournalLine."Document Date" := Today;
                        ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
                        ItemJournalLine.Validate("Item No.", Item."No.");
                        ItemJournalLine.Validate("Location Code", 'ALMACEN');
                        //Bin Code Item
                        MovAlmacen.SetRange("Item No.", Item."No.");
                        MovAlmacen.SetRange("Location Code", 'ALMACEN');
                        if MovAlmacen.FindLast() then
                            ItemJournalLine.Validate("Bin Code", MovAlmacen."Bin Code");

                        ItemJournalLine.Validate(Quantity, StockActual);
                        ItemJournalLine."Document No." := Format(Today, 0, '<Year4><Month,2><Day,2>');
                        ItemJournalLine.Description := 'Vaciar stock desde' + ' - ' + Format(Today);
                        ItemJournalLine.Insert(true);
                    end;
                end;
            until Item.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnInsertItemLedgEntryOnBeforeVerifyOnInventory', '', false, false)]
    local procedure OnInsertItemLedgEntryOnBeforeVerifyOnInventory(ItemJnlLine: Record "Item Journal Line"; ItemLedgEntry: Record "Item Ledger Entry"; var IsHandled: Boolean)
    begin
        If ItemJnlLine.Description = 'Vaciar stock desde' + ' - ' + Format(Today) then
            IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Jnl.-Register Line", 'OnDeleteFromBinContentOnBeforeFieldError', '', false, false)]
    local procedure OnDeleteFromBinContentOnBeforeFieldError(BinContent: Record "Bin Content"; WarehouseEntry: Record "Warehouse Entry"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Jnl.-Register Line", 'OnBeforeDeleteFromBinContent', '', false, false)]
    local procedure OnBeforeDeleteFromBinContent(var WarehouseEntry: Record "Warehouse Entry"; var IsHandled: Boolean)
    var
        FromBinContent: Record "Bin Content";
    begin
        FromBinContent.ReadIsolation(IsolationLevel::Readcommitted);
        if not FromBinContent.Get(
            WarehouseEntry."Location Code", WarehouseEntry."Bin Code", WarehouseEntry."Item No.", WarehouseEntry."Variant Code",
            WarehouseEntry."Unit of Measure Code") then begin
            FromBinContent.Init;
            FromBinContent."Location Code" := WarehouseEntry."Location Code";
            FromBinContent."Bin Code" := WarehouseEntry."Bin Code";
            FromBinContent."Item No." := WarehouseEntry."Item No.";
            FromBinContent."Variant Code" := WarehouseEntry."Variant Code";
            FromBinContent."Unit of Measure Code" := WarehouseEntry."Unit of Measure Code";
            FromBinContent.Insert();
            commit;
        end
    end;
}
