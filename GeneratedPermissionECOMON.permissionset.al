namespace ECOMON;

permissionset 90100 PermissionECOMON
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
        page EcoRoutes = X,
        page ECOSalesShipmentHeader = X,
        page Segmentos = X;
}