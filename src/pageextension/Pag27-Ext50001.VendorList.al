namespace Bcsys.CPA.Basics;

using Microsoft.Purchases.Vendor;
pageextension 50001 "Vendor List" extends "Vendor List" //27
{
    layout
    {
        addafter("Location Code")
        {
            field(Address; Rec.Address)
            {
                ApplicationArea = All;
            }
            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
            }
            field(City; Rec.City)
            {
                ApplicationArea = All;
            }
        }
    }
}
