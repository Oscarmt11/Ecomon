namespace Ecomon.Ecomon;
using Microsoft.Sales.Customer;

page 90108 "Off-season Routes"
{
    ApplicationArea = All;
    Caption = 'Off-season Routes', Comment = 'ESP="Fechas Temporada baja (rutas)"';
    PageType = List;
    SourceTable = "Off-season";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(InitDate; Rec.InitDate) { ApplicationArea = All; }
                field(EndingDate; Rec.EndingDate) { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(UpdateOffSeasonRoutes)
            {
                Caption = 'Update off-season routes', Comment = 'ESP="Actualizar rutas de temporada baja"';
                ApplicationArea = All;
                Image = Update;

                trigger OnAction()
                var
                    Cust: Record Customer;
                    Updated: Integer;
                begin
                    Cust.SetFilter(ECORouteCode, '<>%1', ''); // solo clientes con ruta
                    if Cust.FindFirst() then
                        repeat
                            if (WorkDate() >= Rec.InitDate) and (WorkDate() <= Rec.EndingDate) then begin
                                // Guardar la ruta actual (alta) en Up-season
                                Cust.Validate("Up-season Route Code", Cust.ECORouteCode);
                                // Poner la ruta de temporada baja
                                Cust.Validate(ECORouteCode, Cust."Off-season Route Code");
                                Cust.Modify();
                                Updated += 1;
                            end;
                        until Cust.Next() = 0;

                    Message('%1 clientes actualizados a ruta de temporada baja.', Updated);
                end;
            }
        }
    }
}
