pageextension 90108 "ECOSales & Receivables Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Logo Position on Documents")
        {
            field(EcoBodyEmail; rec.EcoBodyEmail)
            {
                ApplicationArea = all;
            }
            field(ECOSubjetEmail; rec.ECOSubjetEmail)
            {
                ApplicationArea = all;
            }
        }
        addlast(General)
        {
            field("Journal Template Name"; Rec."Journal Template Name")
            {
                ApplicationArea = All;
            }
            field("Journal Batch Name"; Rec."Journal Batch Name")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addbefore(Payment)
        {
            group(CreateItemJournalLine)
            {
                Caption = 'Create and Post Item Journal Line', Comment = 'ESP="Crear e Insertar líneas en Diario de Productos"';
                action(CreateAndPostItemJournalLine)
                {
                    ApplicationArea = all;
                    Caption = 'Create and Post Item Journal Line', Comment = 'ESP="Crear e Insertar líneas en Diario de Productos"';
                    Image = ActionCreateDocument;

                    trigger OnAction()
                    var
                        EcoSingMgt: Codeunit EcoSingMgt;
                    begin
                        EcoSingMgt.CreateAndPostItemJournalLine('ALMACEN', 'ITEM001', 10);
                    end;
                }
            }
        }
    }
}
