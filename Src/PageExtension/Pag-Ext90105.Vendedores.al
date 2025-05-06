pageextension 90105 Vendedores extends "Salesperson/Purchaser Card"
{
    layout
    {
        addafter("E-Mail")
        {
            field(Responsable; Rec.Responsable)
            {
                ApplicationArea = All;
            }
        }
    }
}
