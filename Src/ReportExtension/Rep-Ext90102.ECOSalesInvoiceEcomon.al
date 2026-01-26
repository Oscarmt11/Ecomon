namespace Ecomon.Ecomon;
using System.Environment;

reportextension 90102 "ECOSales - Invoice - Ecomon" extends "Sales Invoice Ecomon"
{
    RDLCLayout = './src/reportExtension/Sales Invoice Ecomon.rdl';
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
        add("Sales Invoice Line")
        {
            Column(udPrice; "Unit Price")
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
