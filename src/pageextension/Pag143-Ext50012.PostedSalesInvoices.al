namespace Bcsys.CPA.Basics;

using Microsoft.Sales.History;
pageextension 50012 "Posted Sales Invoices" extends "Posted Sales Invoices" //143
{
    layout
    {
        addfirst(content)
        {
            field("Name Interface File"; Rec."Name Interface File")
            {
                Enabled = false;
                ApplicationArea = All;
            }
        }
    }
}
