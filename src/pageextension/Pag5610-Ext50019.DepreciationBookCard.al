namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.Depreciation;
pageextension 50019 "Depreciation Book Card" extends "Depreciation Book Card" //5610
{
    layout
    {
        addafter("Description")
        {
            field(Type; Rec.Type)
            {
                ApplicationArea = All;
            }
        }
    }
}
