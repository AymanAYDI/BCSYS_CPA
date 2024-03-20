namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.FixedAsset;
pageextension 50017 "Fixed Asset List" extends "Fixed Asset List" //5601
{
    layout
    {
        addafter("No.")
        {
            field("Attachment Asset"; Rec."Attachment Asset")
            {
                ApplicationArea = All;
            }
            field("Acquisition Date"; Rec."Acquisition Date")
            {
                ApplicationArea = All;
            }
            field("Last Asset In Concession"; Rec."Last Asset In Concession")
            {
                ApplicationArea = All;
            }
        }
        addafter("Description")
        {
            field("Main Asset/Component"; Rec."Main Asset/Component")
            {
                ApplicationArea = All;
            }
            field("Acquisition Index"; Rec."Acquisition Index")
            {
                ApplicationArea = All;
            }
            field("In Conncession By"; Rec."In Conncession By")
            {
                ApplicationArea = All;
            }
        }
        addafter("Vendor No.")
        {
            field(Renewable; Rec.Renewable)
            {
                ApplicationArea = All;
            }
            field("Purchase Amount"; Rec."Purchase Amount")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify("Projected Value")
        {
            Visible = false;
        }
        addafter("Register")
        {
            separator(Idsp)
            {
                Caption = 'Idsp', Comment = 'FRA="Idsp"';
                IsHeader = true;
            }
            action("Synt. Biens Ren. Conces.")
            {
                Caption = 'Synt. Biens Ren. Conces.', Comment = 'FRA="1- Biens Ren. conces."';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Report "Synt. Biens Ren Concessionaire";
                ApplicationArea = All;
            }
            action("<2- Biens Ren. concéd.>")
            {
                Caption = '2- Biens Ren. concéd.', Comment = 'FRA="2- Biens Ren. concéd."';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Report "Synt. Biens Ren Concedant";
                ApplicationArea = All;
            }
            action("<3- Biens N.R. concéd.>")
            {
                Caption = '3- Biens N.R. concéd.', Comment = 'FRA="3- Biens N.R. concéd."';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Report "Synt. Biens NR Concedant";
                ApplicationArea = All;
            }
            action("Synt. Biens NR Conces.")
            {
                Caption = 'Synt. Biens NR Conces.', Comment = 'FRA="4- Biens N.R. conces."';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Report "Synt. Biens NR Concessionnaire";
                ApplicationArea = All;
            }
            action("Etat des Immobilisations")
            {
                Caption = 'Etat des Immobilisations', Comment = 'FRA="5- Immobilisations"';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Report "Etat des Immobilisations";
                ApplicationArea = All;
            }
            action("<6- Dot. Amortisse.>")
            {
                Caption = '6- Dot. Amortisse.', Comment = 'FRA="6- Dot. Amortisse."';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Report "Etat des dotations amort.";
                ApplicationArea = All;
            }
            action("<7- Amort. de caducité>")
            {
                Caption = '7- Amort. de caducité', Comment = 'FRA="7- Amort. de caducité"';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Report "Etat des amort. caducité";
                ApplicationArea = All;
            }
            action("<8- Provisions renouvel.>")
            {
                Caption = '8- Provisions renouvel.', Comment = 'FRA="8- Provisions renouvel."';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Report "Etat des provisions renouvel";
                ApplicationArea = All;
            }
            action("<9- Mvts de l' exercice>")
            {
                Caption = '9- Mvts de l'' exercice', Comment = 'FRA="9- Mvts de l'' exercice"';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Report "Etat des mouvts exercice";
                ApplicationArea = All;
            }
            action("<10- Amortissements>")
            {
                Caption = '10- Amortissements', Comment = 'FRA="10- Amortissements"';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Report "Etat des amortissements";
                ApplicationArea = All;
            }
            action("<11- Valeurs nettes comptables>")
            {
                Caption = '11- Valeurs nettes comptables', Comment = 'FRA="11- Valeurs nettes comptables"';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                RunObject = Report "Etat des valeurs nettes compta";
                ApplicationArea = All;
            }
        }
    }
}
