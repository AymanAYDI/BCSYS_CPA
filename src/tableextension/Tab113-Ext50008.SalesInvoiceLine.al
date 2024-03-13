namespace Bcsys.CPA.Basics;

using Microsoft.Sales.History;
tableextension 50008 "Sales Invoice Line" extends "Sales Invoice Line" //113
{
    fields
    {
        field(50000; "Name Interface File"; Text[150])
        {
            Caption = 'Nom fichier interface', Comment = 'FRA="Nom fichier interface"';
        }
    }
}
