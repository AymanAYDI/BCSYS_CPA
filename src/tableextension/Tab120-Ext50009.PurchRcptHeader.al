namespace Bcsys.CPA.Basics;

using Microsoft.Purchases.History;
using System.Security.User;
tableextension 50009 "Purch. Rcpt. Header" extends "Purch. Rcpt. Header" //120
{
    fields
    {
        field(50000; "Delivey Time"; Text[50])
        {
            Caption = 'Délai de livraison', Comment = 'FRA="Délai de livraison"';
        }
        field(50001; "Quote No"; Text[30])
        {
            Caption = 'N° Devis', Comment = 'FRA="N° Devis"';
        }
        field(50002; "Quote Date"; Date)
        {
            Caption = 'Date devis', Comment = 'FRA="Date devis"';
        }
        field(50003; Signatory; Code[50])
        {
            Caption = 'Assigned User ID', Comment = 'FRA="Signataire"';
            TableRelation = "User Setup";
        }
        field(50004; "Invoice Comment"; Text[80])
        {
            Caption = 'Commentaire facturation', Comment = 'FRA="Commentaire facturation"';
        }
    }
}
