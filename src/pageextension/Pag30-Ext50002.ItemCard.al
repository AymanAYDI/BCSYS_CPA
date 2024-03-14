namespace Bcsys.CPA.Basics;

using Microsoft.Inventory.Item;
pageextension 50002 "Item Card" extends "Item Card" //30
{
    layout
    {
        addlast(content)
        {
            group("")
            {
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
