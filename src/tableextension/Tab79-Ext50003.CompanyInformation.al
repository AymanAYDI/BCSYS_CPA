namespace Bcsys.CPA.Basics;

using Microsoft.Foundation.Company;
using Microsoft.Utilities;
tableextension 50003 "Company Information" extends "Company Information" //79
{
    fields
    {
        field(50000; "General Condition Purchase"; Text[20])
        {
            Caption = 'Condition générale achat', comment = 'FRA="Condition générale achat"';
            TableRelation = "Standard Text".Code;
        }
        field(50001; "Comment Order Purchase"; Text[20])
        {
            Caption = 'Texte commande achat', comment = 'FRA="Texte commande achat"';
            TableRelation = "Standard Text".Code;
        }
        field(50002; "Special warranty"; Text[20])
        {
            Caption = 'Garantie particulière', comment = 'FRA="Garantie particulière"';
            TableRelation = "Standard Text".Code;
        }
        field(50003; "Late penalty"; Text[20])
        {
            Caption = 'Pénalités de retard', comment = 'FRA="Pénalités de retard"';
            TableRelation = "Standard Text".Code;
        }
    }
}