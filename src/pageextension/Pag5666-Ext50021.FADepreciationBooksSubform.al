namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.Depreciation;
pageextension 50021 "FA Depreciation Books Subform" extends "FA Depreciation Books Subform" //5666
{
    layout
    {
        addafter("Temp. Fixed Depr. Amount")
        {
            field("Acquisition Cost"; Rec."Acquisition Cost")
            {
                ApplicationArea = All;
            }
            field("Disposal Date"; Rec."Disposal Date")
            {
                ApplicationArea = All;
            }
        }
    }
}
