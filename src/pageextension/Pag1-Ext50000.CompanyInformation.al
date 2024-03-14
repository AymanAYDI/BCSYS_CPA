namespace Bcsys.CPA.Basics;

using Microsoft.Foundation.Company;
pageextension 50000 "Company Information" extends "Company Information" //1
{
    layout
    {
        addlast(content)
        {
            group("Commentaires divers")
            {
                Caption = 'Commentaires divers', comment = 'FRA="Commentaires divers"';
                field("General Condition Purchase"; Rec."General Condition Purchase")
                {
                    ApplicationArea = All;
                }
                field("Comment Order Purchase"; Rec."Comment Order Purchase")
                {
                    ApplicationArea = All;
                }
                field("Special warranty"; Rec."Special warranty")
                {
                    ApplicationArea = All;
                }
                field("Late penalty"; Rec."Late penalty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
