namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.Setup;
page 50003 "Selection Site"
{
    PageType = StandardDialog;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field(Site; Site)
            {
                Caption = 'Nouveau Site', Comment = 'FRA="Nouveau Site"';
                TableRelation = "FA Location";
            }
            field(CopieNum; CopieNum)
            {
                Caption = 'Copier la numérotation', Comment = 'FRA="Copier la numérotation"';
                Visible = AffCopieNum;

                trigger OnValidate()
                begin
                    AffNumDeb := not CopieNum;
                end;
            }
            field(NumDeb; NumDeb)
            {
                Caption = 'N° de début', Comment = 'FRA="N° de début"';
                Editable = AffNumDeb;
                Enabled = AffNumDeb;
                Visible = AffNumDeb;
            }
        }
    }
    trigger OnOpenPage()
    begin
        AffCopieNum := false;
        AffNumDeb := true;
    end;

    var
        Site: Code[20];
        CopieNum: Boolean;
        NumDeb: Integer;
        AffNumDeb: Boolean;
        AffCopieNum: Boolean;

    procedure GetParam(var pSite: Code[20]; var pNumDeb: Integer)
    begin
        pSite := Site;
        if CopieNum = true then
            pNumDeb := -1
        else
            pNumDeb := NumDeb;
    end;
}
