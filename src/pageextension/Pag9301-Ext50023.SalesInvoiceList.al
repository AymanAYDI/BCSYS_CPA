namespace Bcsys.CPA.Basics;

using Microsoft.Sales.Document;
pageextension 50023 "Sales Invoice List" extends "Sales Invoice List" //9301
{
    layout
    {
        addfirst(Control1)
        {
            field("Name Interface File"; Rec."Name Interface File")
            {
                Enabled = false;
                ApplicationArea = All;
            }
        }
    }
}
