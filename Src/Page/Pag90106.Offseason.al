namespace Ecomon.Ecomon;
using Microsoft.Inventory.Item;

page 90106 "Off-season"
{
    ApplicationArea = All;
    Caption = 'Off-season', Comment = 'ESP="Fechas Temporada baja"';
    PageType = List;
    SourceTable = "Off-season";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(InitDate; Rec.InitDate)
                {
                    ApplicationArea = all;
                }
                field(EndingDate; Rec.EndingDate)
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
            action(ActionName)
            {
                Caption = 'Update valyues for off-season items', Comment = 'ESP="Actualizar valores para artículos fuera de temporada"';
                ApplicationArea = all;
                Image = update;
                trigger OnAction()
                var
                    Item: Record Item;
                begin
                    if (WorkDate() >= Rec.InitDate) and (WorkDate() <= Rec.EndingDate) then begin
                        item.setfilter("Safety Stock Quantity", '<>0');
                        if item.FindFirst() then
                            repeat
                                Item.Validate("Up-season stock", Item."Safety Stock Quantity");
                                item.Validate(item."Safety Stock Quantity", item."Off-season stock");
                                item.Modify();
                            until item.Next() = 0;
                    end;

                end;
            }
        }
    }
}
