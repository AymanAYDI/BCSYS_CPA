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
            }
            field("Address 2"; Rec."Address 2")
            {
            }
            field(City; Rec.City)
            {
            }
        }
    }
}
