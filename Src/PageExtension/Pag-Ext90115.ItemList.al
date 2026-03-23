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
        }
    }


}
