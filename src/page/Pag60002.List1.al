namespace Bcsys.CPA.Basics;

using Microsoft.Warehouse.Structure;
page 60002 List1
{
    PageType = ListPlus;
    SourceTable = "Bin Content";
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
            part(""; 60000)
            {
                SubPageLink = "Location Code" = FIELD("Location Code"),
                              "Bin Code" = FIELD("Bin Code");
            }
        }
    }

    actions
    {
    }
}

