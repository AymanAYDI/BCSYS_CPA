namespace Bcsys.CPA.Basics;

using Microsoft.Purchases.Archive;
using System.Security.User;
tableextension 50014 "Purchase Header Archive" extends "Purchase Header Archive" //5109
{
    fields
    {
        field(50000; "Delivey Time"; Text[50])
        {
            Caption = 'Délai de livraison', comment = 'FRA="Délai de livraison"';
        }
        field(50001; "Quote No"; Text[30])
        {
            Caption = 'N° Devis', comment = 'FRA="N° Devis"';
        }
        field(50002; "Quote Date"; Date)
        {
            Caption = 'Date devis', comment = 'FRA="Date devis"';
        }
        field(50003; Signatory; Code[50])
        {
            Caption = 'Assigned User ID', comment = 'FRA="Signataire"';
            TableRelation = "User Setup";
        }
        field(50004; "Invoice Comment"; Text[80])
        {
            Caption = 'Commentaire facturation', comment = 'FRA="Commentaire facturation"';
        }
    }
}
