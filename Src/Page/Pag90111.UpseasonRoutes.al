namespace Ecomon.Ecomon;
using Microsoft.Sales.Customer;

page 90111 "Up-season Routes"
{
    ApplicationArea = All;
    Caption = 'Up-season Routes', Comment = 'ESP="Fechas Temporada alta (rutas)"';
    PageType = List;
    SourceTable = "Up-season";
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
            action(UpdateUpSeasonRoutes)
            {
                Caption = 'Update up-season routes', Comment = 'ESP="Actualizar rutas de temporada alta"';
                ApplicationArea = All;
                Image = Update;

                trigger OnAction()
                var
                    Cust: Record Customer;
                    Updated: Integer;
                begin
                    Cust.SetFilter(ECORouteCode, '<>%1', '');
                    if Cust.FindFirst() then
                        repeat
                            if (WorkDate() >= Rec.InitDate) and (WorkDate() <= Rec.EndingDate) then begin
                                // Guardar la ruta actual (baja) en Off-season
                                Cust.Validate("Off-season Route Code", Cust.ECORouteCode);
                                // Poner la ruta de temporada alta
                                Cust.Validate(ECORouteCode, Cust."Up-season Route Code");
                                Cust.Modify();
                                Updated += 1;
                            end;
                        until Cust.Next() = 0;

                    Message('%1 clientes actualizados a ruta de temporada alta.', Updated);
                end;
            }
        }
    }
}
