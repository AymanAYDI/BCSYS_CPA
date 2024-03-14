namespace Bcsys.CPA.Basics;

using Microsoft.Finance.GeneralLedger.Journal;
pageextension 50003 "General Journal" extends "General Journal" //39
{
    layout
    {
        addafter("Amount")
        {
            field("VAT Base Amount"; Rec."VAT Base Amount")
            {
                Caption = 'VAT Base Amount', Comment = 'FRA="Montant HT"';
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("Payro&ll")
        {
            group("OD Paie")
            {
                Caption = 'OD Paie', Comment = 'FRA="OD Paie"';
                action(ImportExcel)
                {
                    Caption = 'Importer fichier Excel', comment = 'FRA="Importer fichier Excel"';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ImportODPaie: Report "Import OD Paie";
                    begin
                        CLEAR(ImportODPaie);
                        ImportODPaie.SetParam(Rec."Journal Template Name", Rec."Journal Batch Name");
                        ImportODPaie.RUNMODAL();
                    end;
                }
            }
        }
    }
}
