namespace Bcsys.CPA.Basics;

using Microsoft.Sales.Document;
tableextension 50001 "Sales Line" extends "Sales Line" //37
{
    fields
    {
        field(50000; "Name Interface File"; Text[150])
        {
            Caption = 'Nom fichier interface', Comment = 'FRA="Nom fichier interface"';
        }
    }
}
