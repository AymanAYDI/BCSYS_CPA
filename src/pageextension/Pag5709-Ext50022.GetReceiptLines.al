namespace Bcsys.CPA.Basics;

using Microsoft.Purchases.History;
pageextension 50022 "Get Receipt Lines" extends "Get Receipt Lines" //5709
{
    layout
    {
        addafter("Quantity")
        {
            field("Order No."; Rec."Order No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
