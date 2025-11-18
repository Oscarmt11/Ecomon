namespace Ecomon.Ecomon;
using Microsoft.Inventory.Item;

page 90107 "Up-season"
{
    ApplicationArea = All;
    Caption = 'Off-season', Comment = 'ESP="Fechas Temporada alta"';
    PageType = List;
    SourceTable = "Up-season";
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
                Caption = 'Update values for up-season items', Comment = 'ESP="Actualizar valores para artículos en temporada alta"';
                ApplicationArea = all;
                Image = update;
                trigger OnAction()
                var
                    Item: Record Item;
                begin
                    item.SetFilter("Safety Stock Quantity", '<>0');
                    if item.FindFirst() then
                        repeat
                            if (WorkDate() >= Rec.InitDate) and (WorkDate() <= Rec.EndingDate) then begin
                                Item.Validate("Off-season stock", Item."Safety Stock Quantity");
                                item.Validate(item."Safety Stock Quantity", item."Up-season stock");
                                item.Modify();
                            end;
                        until item.Next() = 0;


                end;
            }
        }
    }
}
