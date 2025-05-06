page 90100 Segmentos
{
    ApplicationArea = All;
    Caption = 'Segmentos';
    PageType = List;
    SourceTable = Segmentos;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Código"; Rec."Código")
                {
                    ToolTip = 'Epecifique el código';
                }
                field("Descripción"; Rec."Descripción")
                {
                    ToolTip = 'Epecifique una descripción';
                }
            }
        }
    }
}
