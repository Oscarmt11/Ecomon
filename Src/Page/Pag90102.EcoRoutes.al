page 90102 EcoRoutes
{
    ApplicationArea = All;
    Caption = 'Routes', Comment = 'ESP="Rutas repartidores"';
    PageType = List;
    SourceTable = EcoRoutes;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(EcoRouteCode; Rec.EcoRouteCode)
                {
                    ToolTip = ' ';
                }
                field(EcoRouteDescription; Rec.EcoRouteDescription)
                {
                    ToolTip = ' ';
                }

            }
        }
    }
}
