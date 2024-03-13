namespace Bcsys.CPA.Basics;

using Microsoft.Sales.History;
tableextension 50007 "Sales Invoice Header" extends "Sales Invoice Header" //112
{
    fields
    {
        field(50000; "Name Interface File"; Text[150])
        {
            Caption = 'Nom fichier interface', Comment = 'FRA="Nom fichier interface"';
        }
    }
}
