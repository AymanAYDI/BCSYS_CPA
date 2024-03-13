namespace Bcsys.CPA.Basics;

using Microsoft.Sales.Document;
tableextension 50000 "Sales Header" extends "Sales Header" //36
{
    fields
    {
        field(50000; "Name Interface File"; Text[150])
        {
            Caption = 'Nom fichier interface', Comment = 'FRA="Nom fichier interface"';
        }
    }
}
