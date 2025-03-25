page 90103 ECOdeliverys
{
    ApplicationArea = All;
    Caption = 'Deliverys', Comment = 'ESP="Repartidores"';
    PageType = List;
    SourceTable = ECOdeliverys;
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(ECODeliveryCode; rec.ECODeliveryCode)
                {
                    ApplicationArea = all;
                }
                field(ECODeliveryDescription; rec.ECODeliveryDescription)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
