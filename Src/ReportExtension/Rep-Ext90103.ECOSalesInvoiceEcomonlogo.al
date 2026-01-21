namespace Ecomon.Ecomon;
using System.Environment;

reportextension 90103 "ECOSales - Invoice - Ecomon l" extends "Sales Invoice Ecomon logo"
{
    RDLCLayout = './src/reportExtension/Sales Invoice Ecomon logo.rdl';
    dataset
    {
        add("Sales Invoice Header")
        {
            column(SingTip; TenatMedia.Content)
            {
            }
            column(ECOdeliveryCode; ECOdeliveryCode)
            {
            }
            column(ECORouteCode; ECORouteCode)
            {
            }
        }
        modify("Sales Invoice Header")
        {
            trigger OnAfterAfterGetRecord()
            begin
                GetSignImage();
            end;
        }
    }
    var
        TenatMedia: Record "Tenant Media";

    local procedure GetSignImage(): text
    begin

        if "Sales Invoice Header".ECNSing.Count > 0 then begin
            if TenatMedia.Get("Sales Invoice Header".ECNSing.Item(1)) then
                TenatMedia.CalcFields(Content);
        end;
    end;
}
