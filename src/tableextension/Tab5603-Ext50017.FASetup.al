namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.Setup;
using Microsoft.Finance.Dimension;
using Microsoft.FixedAssets.Depreciation;
tableextension 50017 "FA Setup" extends "FA Setup" //5603
{
    fields
    {
        field(50000; "Global Dimension Site Code"; Code[20])
        {
            Caption = 'Global Dimension Site Code', comment = 'FRA="Code axe analytique site"';
            Editable = true;
            TableRelation = Dimension;
        }
        field(50001; "1st Asset Deprec. Book Code"; Code[10])
        {
            Caption = '1st Asset Deprec. Book Code', comment = 'FRA="Code loi d''amort. 1ere immo."';
            NotBlank = true;
            TableRelation = "Depreciation Book" where(Type = filter(Caducity));
        }
        field(50002; "Renewable Deprec. Book Code"; Code[10])
        {
            Caption = 'Renewable Deprec. Book Code', comment = 'FRA="Code loi d''amort. bien renouvelable"';
            NotBlank = true;
            TableRelation = "Depreciation Book";
        }
        field(50003; "Renw.Prov.Deprec. Book Code"; Code[10])
        {
            Caption = 'Renw.Prov.Deprec. Book Code', comment = 'FRA="Code loi d''amort. provision bien renouvelable"';
            NotBlank = true;
            TableRelation = "Depreciation Book" where(Type = filter(Provision));
        }
        field(50004; "Non Renew.Deprec. Book Code"; Code[10])
        {
            Caption = 'Non Renew.Deprec. Book Code', comment = 'FRA="Code loi d''amort. bien non renouvelable"';
            NotBlank = true;
            TableRelation = "Depreciation Book";
        }
        field(50005; "Deprec.Method 1st Asset"; Enum "Deprec Method")
        {
            Caption = 'Deprec.Method 1st Asset', comment = 'FRA="Méthode amort. 1ere immo."';
            InitValue = "Straight-Line";
        }
        field(50007; "Deprec.Method Renewable"; Enum "Deprec Method")
        {
            Caption = 'Deprec.Method Renewable', comment = 'FRA="Méthode amort. bien renouvelable"';
            InitValue = "Straight-Line";
        }
        field(50008; "Deprec.Method Renw.Prov."; Enum "Deprec Method")
        {
            Caption = 'Deprec.Method Renw.Prov.', comment = 'FRA="Méthode amort. provision bien renouvelable"';
            InitValue = "Straight-Line";
        }
        field(50009; "Deprec.Method Non Renew."; Enum "Deprec Method")
        {
            Caption = 'Deprec.Method Non Renew.', comment = 'FRA="Méthode amort. bien non renouvelable"';
            InitValue = "Straight-Line";
        }
        field(50010; "Text 1st Asset"; Text[100])
        {
            Caption = 'Deprec.Method 1st Asset', comment = 'FRA="Texte 1ere immobilisation"';
            InitValue = 'Straight-Line';
        }
        field(50011; "Text  Renewable"; Text[100])
        {
            Caption = 'Deprec.Method Renewable', comment = 'FRA="Texte bien renouvelable"';
            InitValue = 'Straight-Line';
        }
        field(50012; "Text  Non Renewable"; Text[100])
        {
            Caption = 'Deprec.Method Non Renew.', comment = 'FRA="Texte non renouvelable"';
            InitValue = 'Straight-Line';
        }
        field(50015; "Acquisition Doc No"; Code[20])
        {
            Caption = 'N°du document acquisition', comment = 'FRA="N°du document acquisition"';
        }
        field(50016; "Provision Doc No"; Code[20])
        {
            Caption = 'N°du document provision', comment = 'FRA="N°du document provision"';
        }
        field(50017; "Provision Posting Description"; Text[50])
        {
            Caption = 'Libellé écriture provision', comment = 'FRA="Libellé écriture provision"';
        }
    }
}
