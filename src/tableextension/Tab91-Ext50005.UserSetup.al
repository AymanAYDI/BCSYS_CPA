namespace Bcsys.CPA.Basics;

using System.Security.User;
tableextension 50005 "User Setup" extends "User Setup" //91
{
    fields
    {
        field(50000; "Electronic Signature"; BLOB)
        {
            Caption = 'Picture', comment = 'FRA="Signature Electronique"';
            SubType = Bitmap;
        }
        field(50001; "Limit Purchase"; Decimal)
        {
            Caption = 'Seuil Achat', comment = 'FRA="Seuil Achat"';

            trigger OnValidate()
            var
                text001_l: Label 'Le montant doit être positif !', comment = 'FRA="Le montant doit être positif !"';
            begin
                if "Limit Purchase" < 0 then
                    ERROR(text001_l);
            end;
        }
    }
}
