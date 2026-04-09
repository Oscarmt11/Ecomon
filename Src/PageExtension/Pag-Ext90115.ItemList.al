pageextension 90115 ItemListExt extends "Item List"
{

    actions
    {
        addafter("&Units of Measure")
        {

            //Borar Productos seleccionados
            action("Borrar Productos seleccionados")
            {
                ApplicationArea = All;
                Image = Delete;
                Visible = false;
                trigger OnAction()
                var
                    Item: Record Item;

                begin
                    //solo empresa GESAM
                    if CompanyName <> 'GESAM' then
                        Error('Esta acción solo está disponible en la empresa GESAM');
                    Currpage.SetSelectionFilter(Item);
                    Item.DeleteAll();
                end;
            }
            action("Copy Stock to Company")
            {
                Caption = 'Copiar Stock a Empresa';
                Image = CopyItem;
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Copia el stock actual de productos no bloqueados como entrada positiva en otra empresa';
                trigger OnAction()
                var
                    Company: Record Company;
                    Sincroniza: Codeunit "Eventos";
                    EmpresaDestino: Text[30];
                begin
                    // Mostrar diálogo para seleccionar empresa destino
                    If Page.RunModal(357, Company) = Action::LookupOK Then begin
                        EmpresaDestino := Company.Name;

                        // Confirmar acción
                        If Confirm(
                            StrSubstNo('¿Desea copiar el stock actual de productos no bloqueados a la empresa %1?', EmpresaDestino),
                            false) Then begin

                            // Llamar a la función de copiar stock
                            Sincroniza.CopiarStockActual(EmpresaDestino);
                            Message('Stock copiado correctamente a la empresa %1. Revise el diario de artículos para registrar las entradas.', EmpresaDestino);
                        end;
                    end;
                end;
            }
            action("Empty Stock")
            {
                Caption = 'Vaciar Stock';
                Image = ClearLog;
                ApplicationArea = All;
                ToolTip = 'Borra el stock actual de productos no bloqueados como negativa';
                trigger OnAction()
                var
                    Company: Record Company;
                    Sincroniza: Codeunit "Eventos";
                    EmpresaDestino: Text[30];
                begin


                    // Confirmar acción
                    If Confirm(
                        StrSubstNo('¿Desea borrar el stock actual de productos no bloqueados'),
                        false) Then begin

                        // Llamar a la función de copiar stock
                        Sincroniza.VaciarStock();
                        Message('Stock copiado correctamente a la empresa %1. Revise el diario de artículos para registrar las entradas.', EmpresaDestino);
                    end;
                end;

            }
        }
    }


}
