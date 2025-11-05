namespace Ecomon.Ecomon;

using Microsoft.Inventory.Item;

tableextension 90107 ECoItem extends Item
{
    fields
    {
        field(90100; "Off-season stock"; Decimal)
        {
            Caption = 'Off-season stock', Comment = 'ESP="Stock temporada baja"';
            DataClassification = CustomerContent;
        }
        field(90105; "Up-season stock"; Decimal)
        {
            Caption = 'Off-season stock', Comment = 'ESP="Stock temporada alta"';
            DataClassification = CustomerContent;
        }
    }
}
