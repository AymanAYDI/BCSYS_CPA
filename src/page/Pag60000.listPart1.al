namespace Bcsys.CPA.Basics;

using Microsoft.Warehouse.Ledger;
page 60000 listPart1
{
    PageType = ListPart;
    SourceTable = "Warehouse Entry";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Bin Code"; Rec."Bin Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}
