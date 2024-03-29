namespace Bcsys.CPA.Basics;

using Microsoft.CRM.Team;
pageextension 50015 Teams extends Teams //5105
{
    layout
    {
        modify(Name)
        {
            Visible = false;
        }
        modify("Next Task Date")
        {
            Visible = false;
        }
        addafter("Code")
        {
            field("Customer No."; Rec."Customer No.")
            {
                ApplicationArea = All;
            }
            field("Item No."; Rec."Item No.")
            {
                ApplicationArea = All;
            }
            field("Type Equipement"; Rec."Type Equipement")
            {
                ApplicationArea = All;
            }
        }
    }
}
