pageextension 90116 VendorList extends "Vendor List"
{
    actions
    {
        addfirst(Processing)
        {
            action("Borrar Proveedores seleccionados")
            {
                ApplicationArea = All;
                Image = Delete;
                trigger OnAction()
                var
                    Vendor: Record Vendor;
                begin
                    // solo empresa GESAM
                    if CompanyName <> 'GESAM' then
                        Error('Esta acción solo está disponible en la empresa GESAM');

                    CurrPage.SetSelectionFilter(Vendor);
                    Vendor.DeleteAll();
                end;
            }
        }
    }
}
