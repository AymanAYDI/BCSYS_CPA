namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.FixedAssets.Setup;
pageextension 50016 "Fixed Asset Card" extends "Fixed Asset Card" //5600
{
    layout
    {
        addafter("Blocked")
        {
            field("Acquisition Date"; Rec."Acquisition Date")
            {
                ApplicationArea = All;
            }
            field("Purchase Amount"; Rec."Purchase Amount")
            {
                ApplicationArea = All;
            }
            field("Acquisition Index"; Rec."Acquisition Index")
            {
                ApplicationArea = All;
            }
            field("Replacement Value"; Rec."Replacement Value")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    if Rec."Replacement Value" = 0 then
                        AppldateEnable := false
                    else
                        AppldateEnable := true;
                    ProvisionEnable := Rec.CheckMakeProvision();
                end;
            }
            field("Replacement Value Appl. Date"; Rec."Replacement Value Appl. Date")
            {
                Enabled = AppldateEnable;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    ProvisionEnable := REc.CheckMakeProvision();
                end;
            }
            field("Funding Method"; Rec."Funding Method")
            {
                ApplicationArea = All;
            }
            field("In Conncession By"; Rec."In Conncession By")
            {
                ApplicationArea = All;
            }
            field(Renewable; Rec.Renewable)
            {
                ApplicationArea = All;
            }
            field("Last Asset In Concession"; Rec."Last Asset In Concession")
            {
                ApplicationArea = All;
            }
            field(FAAllocationName; FALocation.Name)
            {
                Caption = '.', Comment = 'FRA="."';
                Editable = false;
                ApplicationArea = All;
            }
            field("Attachment Asset"; Rec."Attachment Asset")
            {
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    if not AttFixedAsset.GET(Rec."Attachment Asset") then
                        AttFixedAsset.INIT();
                end;
            }
            field(FixedAssetDescription; AttFixedAsset.Description)
            {
                Caption = '.', Comment = 'FRA="."';
                Editable = false;
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
        addafter("Co&mments")
        {
            action("Asset links")
            {
                Caption = 'Asset links', Comment = 'FRA="Liens Immobilisation"';
                Image = Links;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Fixed Asset List";
                RunPageLink = "Attachment Asset" = field("No.");
                ApplicationArea = All;
            }
        }
        addlast(processing)
        {
            action("Génération auto des lois")
            {
                Caption = 'Génération auto des lois', Comment = 'FRA="Génération auto des lois"';
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.FADepreciationBookInit();
                end;
            }
            action("Génération des feuilles d'acquisition")
            {
                Caption = 'Génération des feuilles d''acquisition', Comment = 'FRA="Génération des feuilles d''acquisition"';
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.AcquisitionGeneration(false);
                end;
            }
            action("Traitement des Provisions")
            {
                Caption = 'Traitement des Provisions', Comment = 'FRA="Traitement des Provisions"';
                Enabled = ProvisionEnable;
                Image = GetEntries;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.MakeProvision();
                end;
            }
        }
    }

    var
        AttFixedAsset: Record "Fixed Asset";
        FALocation: Record "FA Location";

        AppldateEnable: Boolean;

        ProvisionEnable: Boolean;

    trigger OnAfterGetRecord()
    begin
        if not AttFixedAsset.GET(Rec."Attachment Asset") then
            AttFixedAsset.INIT();
        if not FALocation.GET(Rec."FA Location Code") then
            FALocation.INIT();
        if Rec."Replacement Value" = 0 then
            AppldateEnable := false
        else
            AppldateEnable := true;
        ProvisionEnable := Rec.CheckMakeProvision();
    end;
}

