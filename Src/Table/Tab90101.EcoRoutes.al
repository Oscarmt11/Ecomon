table 90101 EcoRoutes
{
    Caption = 'Routes', Comment = 'ESP="Rutas repartidores"';
    DataClassification = CustomerContent;
    LookupPageId = EcoRoutes;
    DrillDownPageId = EcoRoutes;
    fields
    {
        field(1; EcoRouteCode; Code[20])
        {
            Caption = 'Route Code', Comment = 'ESP="Código de la ruta"';
            DataClassification = CustomerContent;
        }
        field(5; EcoRouteDescription; Text[80])
        {
            Caption = 'Route Description', Comment = 'ESP="Descripción de la ruta"';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; EcoRouteCode)
        {
            Clustered = true;
        }
    }
}
