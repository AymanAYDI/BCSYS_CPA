namespace Bcsys.CPA.Basics;

using Microsoft.Finance.GeneralLedger.Journal;
pageextension 50014 "Purchase Journal" extends "Purchase Journal" //254
{
    layout
    {
        addafter("VAT Prod. Posting Group")
        {
            field("VAT Base Amount"; Rec."VAT Base Amount")
            {
                Caption = 'VAT Base Amount', Comment = 'FRA="Montant HT"';
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
}
