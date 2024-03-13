namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.Journal;
using Microsoft.FixedAssets.FixedAsset;
tableextension 50021 "FA Journal Line" extends "FA Journal Line" //5621
{
    trigger OnBeforeInsert()
    begin
        CheckAcquisition();
    end;

    trigger OnBeforeModify()
    begin
        CheckAcquisition();
    end;

    procedure CheckAcquisition()
    var
        LFixedAsset: Record "Fixed Asset";
    begin
        if "FA Posting Type" = "FA Posting Type"::"Acquisition Cost" then begin
            if LFixedAsset.GET("FA No.") then
                if ("FA Posting Date" <> 0D) and ("FA Posting Date" <> LFixedAsset."Acquisition Date") then
                    MESSAGE(Text50000, "FA Posting Date", LFixedAsset."Acquisition Date");
            if (Amount <> 0) and (Amount <> LFixedAsset."Purchase Amount") then
                MESSAGE(Text50001, Amount, LFixedAsset."Purchase Amount");
        end
    end;

    var
        Text50000: Label 'Date compta immo  %1 différente de la date d''acquisition de l''immobilisation %2', Comment = 'FRA="Date compta immo  %1 différente de la date d''acquisition de l''immobilisation %2"';
        Text50001: Label 'Montant %1 différent du montant achat de l''immobilisation %2', Comment = 'FRA="Montant %1 différent du montant achat de l''immobilisation %2"';
}
