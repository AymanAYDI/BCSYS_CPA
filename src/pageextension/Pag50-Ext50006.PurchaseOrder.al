namespace Bcsys.CPA.Basics;

using Microsoft.Purchases.Document;
pageextension 50006 "Purchase Order" extends "Purchase Order" //50
{
    layout
    {
        modify("Quote No.")
        {
            Visible = false;
        }
        addafter("Quote No.")
        {
            field("Quote No"; Rec."Quote No")
            {
            }
            field("Quote Date"; Rec."Quote Date")
            {
            }
        }
        addafter("Assigned User ID")
        {
            field(Signatory; Rec.Signatory)
            {
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field("Invoice Comment"; Rec."Invoice Comment")
            {
            }
        }
        addafter("Ship-to Code")
        {
            field("Delivey Time"; Rec."Delivey Time")
            {
            }
        }
    }
}
