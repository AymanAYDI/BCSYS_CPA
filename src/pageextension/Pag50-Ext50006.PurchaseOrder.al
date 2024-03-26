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
                ApplicationArea = All;
            }
            field("Quote Date"; Rec."Quote Date")
            {
                ApplicationArea = All;
            }
        }
        addafter("Assigned User ID")
        {
            field(Signatory; Rec.Signatory)
            {
                ApplicationArea = All;
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field("Invoice Comment"; Rec."Invoice Comment")
            {
                ApplicationArea = All;
            }
        }
        addafter("Ship-to Code")
        {
            field("Delivey Time"; Rec."Delivey Time")
            {
                ApplicationArea = All;
            }
        }
    }
}
