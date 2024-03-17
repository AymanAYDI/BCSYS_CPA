namespace Bcsys.CPA.Basics;

using Microsoft.Purchases.Document;
pageextension 50007 "Purchase Invoice" extends "Purchase Invoice" //51
{
    layout
    {
        addafter("VAT Bus. Posting Group")
        {
            field("Invoice Comment"; Rec."Invoice Comment")
            {
                ApplicationArea = All;
            }
        }
    }
}
