namespace Ecomon.Ecomon;

using Microsoft.Inventory.Item;

pageextension 90113 ECOItemCard extends "Item Card"
{
    layout
    {
        addafter("Safety Stock Quantity")
        {
            field("Off-season stock"; rec."Off-season stock")
            {
                ApplicationArea = all;
            }
            field("Up-season stock"; rec."Up-season stock")
            {
                ApplicationArea = all;
            }

        }
    }
}
