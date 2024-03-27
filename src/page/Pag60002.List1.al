namespace Bcsys.CPA.Basics;

using Microsoft.Warehouse.Structure;
page 60002 List1
{
    PageType = ListPlus;
    SourceTable = "Bin Content";
    UsageCategory = None;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater("Général")
            {
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Bin Code"; Rec."Bin Code")
                {
                }
            }
            part(""; listPart1)
            {
                SubPageLink = "Location Code" = field("Location Code"),
                              "Bin Code" = field("Bin Code");
            }
        }
    }
}
