namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.Ledger;
using Microsoft.FixedAssets.Depreciation;
tableextension 50016 "FA Ledger Entry" extends "FA Ledger Entry" //5601
{
    fields
    {
        field(50000; "Book Code Type"; Enum "Book Code Type")
        {
            CalcFormula = lookup("Depreciation Book".Type where(Code = field("Depreciation Book Code")));
            Caption = 'Type de loi', Comment = 'FRA="Type de loi"';
            FieldClass = FlowField;
        }
    }
}
