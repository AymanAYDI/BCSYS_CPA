namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.Setup;
pageextension 50018 "Fixed Asset Setup" extends "Fixed Asset Setup" //5607
{
    layout
    {
        addafter("Numbering")
        {
            group(IDSP)
            {
                Caption = 'IDSP', Comment = 'FRA="IDSP"';
                group("Code Loi d'amortissement")
                {
                    Caption = 'Code Loi d''amortissement', Comment = 'FRA="Code Loi d''amortissement"';
                    field("1st Asset Deprec. Book Code"; Rec."1st Asset Deprec. Book Code")
                    {
                        Caption = '1st Asset Deprec. Book Code', comment = 'FRA="1ere immoblisation"';
                        ApplicationArea = All;
                    }
                    field("Renewable Deprec. Book Code"; Rec."Renewable Deprec. Book Code")
                    {
                        Caption = 'Renewable Deprec. Book Code', Comment = 'FRA="Bien renouvelable"';
                        ApplicationArea = All;
                    }
                    field("Renw.Prov.Deprec. Book Code"; Rec."Renw.Prov.Deprec. Book Code")
                    {
                        Caption = 'Renw.Prov.Deprec. Book Code', Comment = 'FRA="Provision bien renouvelable"';
                        ApplicationArea = All;
                    }
                    field("Non Renew.Deprec. Book Code"; Rec."Non Renew.Deprec. Book Code")
                    {
                        Caption = 'Non Renew.Deprec. Book Code', Comment = 'FRA="Bien non renouvelable"';
                        ApplicationArea = All;
                    }
                }
                group("Méthode d'amortissement")
                {
                    Caption = 'Méthode d''amortissement', Comment = 'FRA="Méthode d''amortissement"';
                    field("Deprec.Method 1st Asset"; Rec."Deprec.Method 1st Asset")
                    {
                        Caption = 'Deprec.Method 1st Asset', Comment = 'FRA="1ere immoblisation"';
                        ApplicationArea = All;
                    }
                    field("Deprec.Method Renewable"; Rec."Deprec.Method Renewable")
                    {
                        Caption = 'Deprec.Method Renewable', Comment = 'FRA="Bien renouvelable"';
                        ApplicationArea = All;
                    }
                    field("Deprec.Method Renw.Prov."; Rec."Deprec.Method Renw.Prov.")
                    {
                        Caption = 'Deprec.Method Renw.Prov.', Comment = 'FRA="Provision bien renouvelable"';
                        ApplicationArea = All;
                    }
                    field("Deprec.Method Non Renew."; Rec."Deprec.Method Non Renew.")
                    {
                        Caption = 'Deprec.Method Non Renew.', Comment = 'FRA="Bien non renouvelable"';
                        ApplicationArea = All;
                    }
                }
                group(Texte)
                {
                    Caption = 'Texte', Comment = 'FRA="Texte"';
                    field("Text 1st Asset"; Rec."Text 1st Asset")
                    {
                        Caption = '1st Asset', Comment = 'FRA="1ere immoblisation"';
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Text  Renewable"; Rec."Text  Renewable")
                    {
                        Caption = 'Renewable', Comment = 'FRA="Bien renouvelable"';
                        Editable = false;
                        ApplicationArea = All;
                    }
                    field("Text  Non Renewable"; Rec."Text  Non Renewable")
                    {
                        Caption = 'Bien non renouvelable', Comment = 'FRA="Bien non renouvelable"';
                        Editable = false;
                        ApplicationArea = All;
                    }
                }
                group(Shipment)
                {
                    Caption = 'Shipment', Comment = 'FRA="Code axe analytique"';
                    field("Global Dimension Site Code"; Rec."Global Dimension Site Code")
                    {
                        Caption = 'Global Dimension Site Code', Comment = 'FRA="Site"';
                        ApplicationArea = All;
                    }
                }
                group("Acquisition Generation")
                {
                    Caption = 'Acquisition Generation', Comment = 'FRA="Génération acquisitions"';
                    field("Acquisition Doc No"; Rec."Acquisition Doc No")
                    {
                        ApplicationArea = All;
                    }
                    field("Provision Doc No"; Rec."Provision Doc No")
                    {
                        ApplicationArea = All;
                    }
                    field("Provision Posting Description"; Rec."Provision Posting Description")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
}
