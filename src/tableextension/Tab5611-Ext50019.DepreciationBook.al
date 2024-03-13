namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.Depreciation;
tableextension 50019 "Depreciation Book" extends "Depreciation Book" //5611
{
    fields
    {
        field(50000; Type; Enum Type)
        {
            Caption = 'Type de loi', comment = 'FRA="Type de loi"';
        }
    }
}
