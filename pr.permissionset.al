namespace pr;

permissionset 90100 pr
{
    Assignable = true;
    Permissions = tabledata ECOdeliverys=RIMD,
        tabledata EcoRoutes=RIMD,
        tabledata Segmentos=RIMD,
        table ECOdeliverys=X,
        table EcoRoutes=X,
        table Segmentos=X,
        codeunit EcoSingMgt=X,
        codeunit Eventos=X,
        page ECOdeliverys=X,
        page ECOPostedSalesShipmentEdit=X,
        page EcoRoutes=X,
        page ECOSalesShipmentHeader=X,
        page Segmentos=X;
}