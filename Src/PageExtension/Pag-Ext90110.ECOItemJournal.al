pageextension 90110 ECOItemJournal extends "Item Journal"
{
    actions
    {
        addbefore("&Line")
        {
            group(CreateItemJournalLine)
            {
                Caption = 'Create and Post Item Journal Line', Comment = 'ESP="Crear e Insertar líneas en Diario de Productos"';
                Image = CreateDocuments;
                action(CreateAndPostItemJournalLine)
                {
                    ApplicationArea = all;
                    Caption = 'Create and Post Item Journal Line', Comment = 'ESP="Crear e Insertar líneas en Diario de Productos"';
                    Image = CreateDocument;

                    trigger OnAction()
                    var
                        EcoSingMgt: Codeunit EcoSingMgt;
                    begin
                        EcoSingMgt.CreateAndPostItemJournalLine('ALMACEN', '0000990-05', 1);
                    end;
                }
            }
        }
    }
}
