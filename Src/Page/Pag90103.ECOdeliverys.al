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
    actions
    {
        area(Processing)
        {
            action(CopyAtachment)
            {
                Caption = 'Update valyues for off-season items', Comment = 'ESP="Actualizar valores para artículos fuera de temporada"';
                ApplicationArea = all;
                Image = update;
                trigger OnAction()
                var
                    SourceAttachment, DestAttachment : Record 1173;
                begin
                    //SourceAttachment.ChangeCompany('Balears Ecomón S.L.U');
                    DestAttachment.ChangeCompany('Ecomon Logistica');
                    SourceAttachment.SetRange("Table ID", 27);
                    if SourceAttachment.FindSet() then
                        repeat
                            DestAttachment := SourceAttachment;
                            DestAttachment.Insert(true);
                            Commit();
                        until SourceAttachment.Next() = 0;


                end;
            }
        }

    }
}
