namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.Depreciation;
using Microsoft.FixedAssets.Setup;
using Microsoft.FixedAssets.FixedAsset;
tableextension 50020 "FA Depreciation Book" extends "FA Depreciation Book" //5612
{
    fields
    {
        modify("Depreciation Book Code")
        {
            trigger OnBeforeValidate()
            var
                LDepreciationBook: Record "Depreciation Book";
                LFixedAsset: Record "Fixed Asset";
                LFALocation: Record "FA Location";
            begin
                LDepreciationBook.GET("Depreciation Book Code");
                if LDepreciationBook.Type = LDepreciationBook.Type::Caducity then begin
                    LFixedAsset.GET("FA No.");
                    LFixedAsset.TESTFIELD("Acquisition Date");
                    LFALocation.GET(LFixedAsset."FA Location Code");
                    LFALocation.TESTFIELD("Concession End Date");
                    VALIDATE("Depreciation Starting Date", LFixedAsset."Acquisition Date");
                    VALIDATE("Depreciation Ending Date", LFALocation."Concession End Date");
                end;
            end;
        }
    }
}
