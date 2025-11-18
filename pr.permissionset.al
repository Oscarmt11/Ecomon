namespace pr;

using Ecomon.Ecomon;

permissionset 90100 pr
{
    Assignable = true;
    Permissions = tabledata ECOdeliverys = RIMD,
        tabledata EcoRoutes = RIMD,
        tabledata Segmentos = RIMD,
        table ECOdeliverys = X,
        table EcoRoutes = X,
        table Segmentos = X,
        codeunit EcoSingMgt = X,
        codeunit Eventos = X,
        page ECOdeliverys = X,
        page ECOPostedSalesShipmentEdit = X,
        page EcoRoutes = X,
        page ECOSalesShipmentHeader = X,
        page Segmentos = X,
        tabledata "Off-season" = RIMD,
        tabledata "Up-season" = RIMD,
        table "Off-season" = X,
        table "Up-season" = X,
        report ECOChangeECOdeliveryCode = X,
        page ECOdeliverysApi = X,
        page "Off-season" = X,
        page "Off-season Routes" = X,
        page "Up-season" = X,
        page "Up-season Routes" = X;
}