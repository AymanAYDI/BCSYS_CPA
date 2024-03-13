namespace Bcsys.CPA.Basics;
table 50001 "Intégration facture vente"
{
    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = false;
            Caption = 'Entry No.', Comment = 'FRA="N° séquence"';
        }
        field(100; Parc; Text[100])
        {
            Caption = 'Parc', Comment = 'FRA="Parc"';
        }
        field(101; "Fin Période"; Text[70])
        {
            Caption = 'Fin Période', Comment = 'FRA="Fin Période"';
        }
        field(102; "Type Borne"; Text[100])
        {
            Caption = 'Type Borne', Comment = 'FRA="Type Borne"';
        }
        field(103; "Total Fin"; Text[100])
        {
            Caption = 'Total Fin', Comment = 'FRA="Total Fin"';
        }
        field(200; "Type Equipement"; Enum "Type Equipement")
        {
            Caption = 'Type Equipement', Comment = 'FRA="Type Equipement"';
        }
        field(201; Client; Code[20])
        {
            Caption = 'Client', Comment = 'FRA="Client"';
        }
        field(202; "Date Facture"; Date)
        {
            Caption = 'Date Facture', Comment = 'FRA="Date Facture"';
        }
        field(203; Article; Code[20])
        {
            Caption = 'Article', Comment = 'FRA="Article"';
        }
        field(204; Designation; Text[50])
        {
            Caption = 'Designation', Comment = 'FRA="Designation"';
        }
        field(205; "Montant TTC"; Decimal)
        {
            Caption = 'Montant TTC', Comment = 'FRA="Montant TTC"';
        }
        field(206; "Axe Analytique"; Code[20])
        {
            Caption = 'Axe Analytique', Comment = 'FRA="Axe Analytique"';
        }
        field(300; Erreur; Text[250])
        {
            Caption = 'Erreur', Comment = 'FRA="Erreur"';
        }
        field(301; invoiceNo; Code[20])
        {
            Caption = 'N° Facture', Comment = 'FRA="N° Facture"';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; Client, "Type Equipement", "Date Facture")
        {
        }
    }
}
