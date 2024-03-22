namespace Bcsys.CPA.Basics;

using Microsoft.Finance.GeneralLedger.Journal;
pageextension 50013 "Sales Journal" extends "Sales Journal" //253
{
    actions
    {
        addafter("Insert Conv. LCY Rndg. Lines")
        {
            action(ImportSubscribers)
            {
                Caption = 'Import Subscribers', Comment = 'FRA="Import abonnés"';
                Image = Import;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    G_ImportSubscribers.InitJournalTemplate(Rec."Journal Template Name", Rec."Journal Batch Name");
                    G_ImportSubscribers.RUN();
                    CurrPage.UPDATE();
                end;
            }
        }
    }

    var
        G_ImportSubscribers: Report "Import Subscribers";
}
