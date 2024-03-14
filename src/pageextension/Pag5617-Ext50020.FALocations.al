namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.Setup;
pageextension 50020 "FA Locations" extends "FA Locations" //5617
{
    layout
    {
        addafter("Name")
        {
            field("Concession Start Date"; Rec."Concession Start Date")
            {
                ApplicationArea = All;
            }
            field("Concession End Date"; Rec."Concession End Date")
            {
                ApplicationArea = All;
            }
            field("Year Number"; Rec."Year Number")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst(processing)
        {
            action("End Of FA Location")
            {
                Caption = 'Fin de concession', Comment = 'FRA="Fin de concession"';
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
            }
            action("Renew Of FA Location")
            {
                Caption = 'Renouvellement de concession', Comment = 'FRA="Renouvellement de concession"';
                Ellipsis = true;
                Image = CopyFixedAssets;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
            }
        }
    }
}
