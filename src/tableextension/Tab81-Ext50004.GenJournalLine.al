namespace Bcsys.CPA.Basics;

using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.FixedAssets.Setup;
tableextension 50004 "Gen. Journal Line" extends "Gen. Journal Line" //81
{
    trigger OnBeforeInsert()
    begin
        CheckAcquisition();
    end;

    trigger OnBeforeModify()
    begin
        CheckAcquisition();
    end;

    local procedure CheckAcquisition()
    var
        LFixedAsset: Record "Fixed Asset";
        LFASetup: Record "FA Setup";
    begin
        LFASetup.GET();
        LFASetup.TESTFIELD("Renw.Prov.Deprec. Book Code");

        if ("Account Type" = "Account Type"::"Fixed Asset") and
          ("Depreciation Book Code" <> LFASetup."Renw.Prov.Deprec. Book Code") and
          ("FA Posting Type" = "FA Posting Type"::"Acquisition Cost") then begin
            if LFixedAsset.GET("Account No.") then
                if ("Posting Date" <> 0D) and ("Posting Date" <> LFixedAsset."Acquisition Date") then
                    MESSAGE(Text50000, "Posting Date", LFixedAsset."Acquisition Date");
            if (Amount <> 0) and (Amount <> LFixedAsset."Purchase Amount") then
                MESSAGE(Text50001, Amount, LFixedAsset."Purchase Amount");
        end
    end;

    var
        Text50000: Label 'Date compta %1 différente de la date d''acquisition de l''immobilisation %2', Comment = 'FRA="Date compta %1 différente de la date d''acquisition de l''immobilisation %2"';
        Text50001: Label 'Montant %1 différent du montant achat de l''immobilisation %2', Comment = 'FRA="Montant %1 différent du montant achat de l''immobilisation %2"';
}