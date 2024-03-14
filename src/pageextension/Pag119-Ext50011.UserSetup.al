namespace Bcsys.CPA.Basics;

using System.Security.User;
pageextension 50011 "User Setup" extends "User Setup" //119
{
    layout
    {
        addafter("Time Sheet Admin.")
        {
            field("Electronic Signature"; Rec."Electronic Signature")
            {
                ApplicationArea = All;
            }
            field("Limit Purchase"; Rec."Limit Purchase")
            {
                ApplicationArea = All;
            }
        }
    }
}
