namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.FixedAssets.Setup;
using System.IO;
report 50001 "Synt. Biens Ren Concessionaire"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/SyntBiensRenConcessionaire.rdl';
    Caption = 'Synthèse des biens renouvelables apportés par le concessionnaire', Comment = 'FRA="Synthèse des biens renouvelables apportés par le concessionnaire"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            DataItemTableView = sorting("FA Subclass Code");
            RequestFilterFields = "FA Subclass Code", "FA Location Code", "Acquisition Date";
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column("Page"; STRSUBSTNO(Text027, ''))
            {
            }
            column(PrintedBy; STRSUBSTNO(Text026, ''))
            {
            }
            column(CompanyName_Caption; Text005)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(ReportName_Caption; Text007)
            {
            }
            column(ReportName; Text001)
            {
            }
            column(ReportNo_Caption; Text006)
            {
            }
            column(ReportNo_; REPORT::"Synt. Biens Ren Concessionaire")
            {
            }
            column(FiltreDate_Caption; Text010)
            {
            }
            column(FiltreRenouv_Caption; Text012)
            {
            }
            column(FiltreSite_Caption; Text013)
            {
            }
            column(FiltreExercice_Caption; Text016)
            {
            }
            column(deb; Deb)
            {
            }
            column(Fin; Fin)
            {
            }
            column(Filtre_1; Filtre[1])
            {
            }
            column(Filtre_2; Filtre[2])
            {
            }
            column(Filtre_3; Filtre[3])
            {
            }
            column(Filtre_4; Filtre[4])
            {
            }
            column(Filtre_5; Filtre[5])
            {
            }
            column(EnteteGen_1; EnteteGen[1])
            {
            }
            column(EnteteGen_2; EnteteGen[2])
            {
            }
            column(EnteteGen_3; EnteteGen[3])
            {
            }
            column(EnteteGen_4; EnteteGen[4])
            {
            }
            column(EnteteGen_5; EnteteGen[5])
            {
            }
            column(EnteteDet_1; EnteteDet[1])
            {
            }
            column(EnteteDet_2; EnteteDet[2])
            {
            }
            column(EnteteDet_3; EnteteDet[3])
            {
            }
            column(EnteteDet_4; EnteteDet[4])
            {
            }
            column(EnteteDet_5; EnteteDet[5])
            {
            }
            column(EnteteDet_6; EnteteDet[6])
            {
            }
            column(EnteteDet_7; EnteteDet[7])
            {
            }
            column(EnteteDet_8; EnteteDet[8])
            {
            }
            column(EnteteDet_9; EnteteDet[9])
            {
            }
            column(EnteteDet_10; EnteteDet[10])
            {
            }
            column(EnteteDet_11; EnteteDet[11])
            {
            }
            column(EnteteDet_12; EnteteDet[12])
            {
            }
            column(EnteteDet_13; EnteteDet[13])
            {
            }
            column(FASubclass_Name; FASubclass.Name)
            {
            }
            column(Fixed_Asset_No; "Fixed Asset"."No.")
            {
                IncludeCaption = true;
            }
            column(Fixed_Asset_Description; "Fixed Asset".Description)
            {
                IncludeCaption = true;
            }
            column(Fixed_Asset_FA_Subclass_Code; "Fixed Asset"."FA Subclass Code")
            {
                IncludeCaption = true;
            }
            column(Fixed_Asset_No_Acquisition_Date; "Fixed Asset"."Acquisition Date")
            {
                IncludeCaption = true;
            }
            column(Fixed_Asset_FA_Location_Code; "Fixed Asset"."FA Location Code")
            {
                IncludeCaption = true;
            }
            column(Montant_1; Montant[1])
            {
            }
            column(Montant_2; Montant[2])
            {
            }
            column(Montant_3; Montant[3])
            {
            }
            column(Montant_4; Montant[4])
            {
            }
            column(Montant_5; Montant[5])
            {
            }
            column(Montant_6; Montant[6])
            {
            }
            column(Montant_7; Montant[7])
            {
            }
            column(Montant_8; Montant[8])
            {
            }
            column(Montant_9; Montant[9])
            {
            }
            column(Montant_10; Montant[10])
            {
            }
            column(Montant_11; Montant[11])
            {
            }
            column(Montant_12; Montant[12])
            {
            }
            column(Montant_13; Montant[13])
            {
            }
            column(Montant_14; Montant[14])
            {
            }
            column(Montant_15; Montant[15])
            {
            }
            column(Montant_16; Montant[16])
            {
            }
            column(Montant_17; Montant[17])
            {
            }
            column(Montant_18; Montant[18])
            {
            }
            column(Montant_19; Montant[19])
            {
            }
            column(Montant_20; Montant[20])
            {
            }
            column(Montant_21; Montant[21])
            {
            }

            trigger OnAfterGetRecord()
            begin

                if FASubclass.Code <> "FA Subclass Code" then
                    if not FASubclass.GET("FA Subclass Code") then
                        FASubclass.INIT();

                RecOk := false;
                CLEAR(Montant);

                if (GetCessionDate() = 0D) or ((GetCessionDate() >= Deb) and (GetCessionDate() <= Fin)) then begin
                    Montant[1] := Idsp.Vdeeco("Fixed Asset"."No.", Deb, Fin);
                    if "Fixed Asset"."Attachment Asset" <> '' then
                        Montant[2] := Idsp.Veeeco("Fixed Asset"."No.", Deb, Fin)
                    else
                        Montant[3] := Idsp.Veeeco("Fixed Asset"."No.", Deb, Fin);
                    Montant[4] := -1 * Idsp.Veseco("Fixed Asset"."No.", Deb, Fin);

                    Montant[5] := -1 * Idsp.Ddeprv("Fixed Asset"."No.", Deb, Fin);
                    Montant[6] := -1 * Idsp.Dexprv("Fixed Asset"."No.", Deb, Fin);
                    Montant[7] := -1 * Idsp.Dreprv("Fixed Asset"."No.", Deb, Fin);

                    Montant[11] := -1 * Idsp.Ddeecop("Fixed Asset"."No.", Deb, Fin);
                    Montant[12] := -1 * Idsp.Dexecop("Fixed Asset"."No.", Deb, Fin);
                    Montant[13] := -1 * Idsp.Dreecop("Fixed Asset"."No.", Deb, Fin);

                    Montant[14] := -1 * Idsp.Ddeecod("Fixed Asset"."No.", Deb, Fin);
                    Montant[15] := -1 * Idsp.Dexecod("Fixed Asset"."No.", Deb, Fin);
                    Montant[16] := -1 * Idsp.Dreecod("Fixed Asset"."No.", Deb, Fin);

                    Montant[17] := Montant[1] + Montant[2] + Montant[3] + Montant[4];
                    Montant[18] := Montant[5] + Montant[6] - Montant[7];

                    if Montant[6] < 0 then begin
                        Montant[7] += (-1 * Montant[6]);
                        Montant[6] := 0;
                    end;

                    Montant[20] := Montant[11] + Montant[12] - Montant[13];
                    Montant[21] := Montant[14] + Montant[15] - Montant[16];

                    RecOk := true;
                end;

                if CaducityExist() then begin
                    Montant[8] := -1 * Idsp.Ddecad("Fixed Asset"."No.", Deb, Fin);
                    Montant[9] := -1 * Idsp.Dexcad("Fixed Asset"."No.", Deb, Fin);
                    Montant[10] := -1 * Idsp.Drecad("Fixed Asset"."No.", Deb, Fin);

                    Montant[19] := Montant[8] + Montant[9] - Montant[10];

                    RecOk := true;
                end;

                if RecOk then begin
                    if PrintToExcel then
                        MakeExcelDataBody();
                end else
                    CurrReport.SKIP();
            end;

            trigger OnPostDataItem()
            begin
                if PrintToExcel then
                    CreateExcelbook();
            end;

            trigger OnPreDataItem()
            begin

                if GInConncessionBy = GInConncessionBy::Concessionaire then
                    SETRANGE("In Conncession By", "In Conncession By"::Concessionaire);
                if GInConncessionBy = GInConncessionBy::Concédant then
                    SETRANGE("In Conncession By", "In Conncession By"::Concédant);

                SETRANGE(Renewable, GRenewable);

                if GETFILTER("Acquisition Date") = '' then
                    SETRANGE("Acquisition Date", 0D, Fin);

                Filtre[1] := CopyStr(GETFILTER("In Conncession By"), 1, 100);
                Filtre[2] := CopyStr(GETFILTER(Renewable), 1, 100);
                Filtre[3] := CopyStr(GETFILTER("FA Location Code"), 1, 100);
                Filtre[4] := CopyStr(GETFILTER("FA Subclass Code"), 1, 100);
                Filtre[5] := CopyStr(GETFILTER("Acquisition Date"), 1, 100);

                if PrintToExcel then
                    MakeExcelInfo();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(DebF; Deb)
                {
                    Caption = 'Date Début Exercice', Comment = 'FRA="Date Début Exercice"';
                    ApplicationArea = All;
                }
                field(FinF; Fin)
                {
                    Caption = 'Date Fin Exercice', Comment = 'FRA="Date Fin Exercice"';
                    ApplicationArea = All;
                }
                field(GInConncessionByF; GInConncessionBy)
                {
                    Caption = 'Mise en concession par', Comment = 'FRA="Mise en concession par"';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(GRenewableF; GRenewable)
                {
                    Caption = 'Renouvelable', Comment = 'FRA="Renouvelable"';
                    Editable = false;
                    ApplicationArea = All;
                }
                field(PrintToExcelF; PrintToExcel)
                {
                    Caption = 'Print to Excel', Comment = 'FRA="Imprimer dans Excel"';
                    ApplicationArea = All;
                }
            }
        }
    }

    labels
    {
        TotalCompteCaption = 'Total Compte', Comment = 'FRA="Total Compte"';
        TOTALCaption = 'TOTAL', Comment = 'FRA="TOTAL"';
    }

    trigger OnInitReport()
    begin
        FASetup.GET();
        Deb := FASetup."Allow FA Posting From";
        Fin := FASetup."Allow FA Posting To";
        GInConncessionBy := GInConncessionBy::Concessionaire;
        GRenewable := GRenewable::Oui;
    end;

    trigger OnPreReport()
    begin
        EnteteGen[1] := 'Valeur d origine des biens renouvelables apportés par le concessionnaire';
        EnteteGen[2] := 'Provisions pour renouvellement biens provenant du concessionnaire';
        EnteteGen[3] := 'Amortissements de caducité des biens financés par le concesionnaire';
        EnteteGen[4] := 'Amortissements économiques des  biens apportés  par le concessionnaire sauf dernier bien';
        EnteteGen[5] := 'Amortissements économiques des  biens apportés  par le concessionnaire pour dernier bien';

        EnteteDet[1] := 'Biens renouvelables présents début ex.';
        EnteteDet[2] := 'Biens entrés sur l.exercice';
        EnteteDet[3] := 'Bien entrés sur l.exercice 1er bien de la';
        EnteteDet[4] := 'Biens sortis sur l.exercice';
        EnteteDet[5] := 'Biens renouV. Et présents à la fin de l exercice';

        EnteteDet[6] := 'Provisions en début d exercice';
        EnteteDet[7] := 'Dotations de l.exercice';
        EnteteDet[8] := 'Reprises de l.exercice';
        EnteteDet[9] := 'Provisions en fin d exercice';

        EnteteDet[10] := 'Amortissements en début d exercice';
        EnteteDet[11] := 'Dotations de l.exercice';
        EnteteDet[12] := 'Reprises de l.exercice';
        EnteteDet[13] := 'Amortissements en Fin d exercice';
    end;

    var
        FASetup: Record "FA Setup";
        FASubclass: Record "FA Subclass";
        TempExcelBuf: Record "Excel Buffer" temporary;
        Idsp: Codeunit Idsp;
        Deb: Date;
        Fin: Date;
        Montant: array[21] of Decimal;
        GInConncessionBy: Enum "In Connecession By";
        GRenewable: Enum Renewable;
        PrintToExcel: Boolean;
        RecOk: Boolean;
        CurrReport_PAGENOCaptionLbl: Label 'Page', Comment = 'FRA="Page"';
        Text001: Label 'Trial Balance', Comment = 'FRA="Synthèse des biens renouvelables apportés par le concessionnaire"';
        Text002: Label 'Data', Comment = 'FRA="Données"';
        Text005: Label 'Company Name', Comment = 'FRA="Nom de la société"';
        Text006: Label 'Report No.', Comment = 'FRA="N° état"';
        Text007: Label 'Report Name', Comment = 'FRA="Nom état"';
        Text008: Label 'User ID', Comment = 'FRA="Code utilisateur"';
        Text009: Label 'Date', Comment = 'FRA="Date état"';
        Text010: Label 'G/L Filter', Comment = 'FRA="Exercice"';
        Text011: Label 'Mise en concession par', Comment = 'FRA="Mise en concession par"';
        Text012: Label 'Renouvelable', Comment = 'FRA="Renouvelable"';
        Text013: Label 'Site début/fin', Comment = 'FRA="Site début/fin"';
        Text014: Label 'Compte au Compte', Comment = 'FRA="Compte au Compte"';
        Text015: Label 'Date Acquisition Déb/fin', Comment = 'FRA="Date Acquisition Déb/fin"';
        Text016: Label 'Exercice Déb/fin', Comment = 'FRA="Exercice Déb/fin"';
        Text026: Label 'Printed by %1', Comment = 'FRA="Imprimé par %1"';
        Text027: Label 'Page %1', Comment = 'FRA="Page %1"';
        EnteteGen: array[5] of Text[100];
        EnteteDet: array[21] of Text[100];
        Filtre: array[5] of Text[100];

    procedure MakeExcelInfo()
    begin
        TempExcelBuf.SetUseInfoSheet();
        TempExcelBuf.AddInfoColumn(FORMAT(Text005), false, true, false, false, '', 1);
        TempExcelBuf.AddInfoColumn(COMPANYNAME, false, false, false, false, '', 1);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text007), false, true, false, false, '', 1);
        TempExcelBuf.AddInfoColumn(FORMAT(Text001), false, false, false, false, '', 1);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text006), false, true, false, false, '', 1);
        TempExcelBuf.AddInfoColumn(REPORT::"Synt. Biens Ren Concessionaire", false, false, false, false, '', 1);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text008), false, true, false, false, '', 1);
        TempExcelBuf.AddInfoColumn(USERID, false, false, false, false, '', 1);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text009), false, true, false, false, '', 1);
        TempExcelBuf.AddInfoColumn(TODAY, false, false, false, false, '', 2);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text010), false, true, false, false, '', 1);
        TempExcelBuf.AddInfoColumn(Deb, false, false, false, false, '', 2);
        TempExcelBuf.AddInfoColumn(Fin, false, false, false, false, '', 2);

        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text011), false, true, false, false, '', 1);
        TempExcelBuf.AddInfoColumn(Filtre[1], false, false, false, false, '', 1);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text012), false, true, false, false, '', 1);
        TempExcelBuf.AddInfoColumn(Filtre[2], false, false, false, false, '', 1);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text013), false, true, false, false, '', 1);
        TempExcelBuf.AddInfoColumn(Filtre[3], false, false, false, false, '', 1);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text014), false, true, false, false, '', 1);
        TempExcelBuf.AddInfoColumn(Filtre[4], false, false, false, false, '', 1);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text015), false, true, false, false, '', 1);
        TempExcelBuf.AddInfoColumn(Filtre[5], false, false, false, false, '', 1);

        TempExcelBuf.ClearNewRow();
        MakeExcelDataHeader();
    end;

    local procedure MakeExcelDataHeader()
    begin

        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);

        TempExcelBuf.AddColumn(EnteteGen[1], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);

        TempExcelBuf.AddColumn(EnteteGen[2], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);

        TempExcelBuf.AddColumn(EnteteGen[3], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);

        TempExcelBuf.AddColumn(EnteteGen[4], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);

        TempExcelBuf.AddColumn(EnteteGen[5], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 1);

        TempExcelBuf.NewRow();

        TempExcelBuf.AddColumn("Fixed Asset".FIELDCAPTION("FA Subclass Code"), false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn("Fixed Asset".FIELDCAPTION("No."), false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn("Fixed Asset".FIELDCAPTION("FA Location Code"), false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn("Fixed Asset".FIELDCAPTION("Acquisition Date"), false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn("Fixed Asset".FIELDCAPTION(Description), false, '', true, false, false, '', 1);

        TempExcelBuf.AddColumn(EnteteDet[1], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn(EnteteDet[2], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn(EnteteDet[3], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn(EnteteDet[4], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn(EnteteDet[5], false, '', true, false, false, '', 1);

        TempExcelBuf.AddColumn(EnteteDet[6], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn(EnteteDet[7], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn(EnteteDet[8], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn(EnteteDet[9], false, '', true, false, false, '', 1);

        TempExcelBuf.AddColumn(EnteteDet[10], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn(EnteteDet[11], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn(EnteteDet[12], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn(EnteteDet[13], false, '', true, false, false, '', 1);

        TempExcelBuf.AddColumn(EnteteDet[10], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn(EnteteDet[11], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn(EnteteDet[12], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn(EnteteDet[13], false, '', true, false, false, '', 1);

        TempExcelBuf.AddColumn(EnteteDet[10], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn(EnteteDet[11], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn(EnteteDet[12], false, '', true, false, false, '', 1);
        TempExcelBuf.AddColumn(EnteteDet[13], false, '', true, false, false, '', 1);

        TempExcelBuf.NewRow();
    end;

    procedure MakeExcelDataBody()
    begin

        TempExcelBuf.NewRow();
        TempExcelBuf.AddColumn("Fixed Asset"."FA Subclass Code", false, '', false, false, false, '', 1);
        TempExcelBuf.AddColumn("Fixed Asset"."No.", false, '', false, false, false, '', 1);
        TempExcelBuf.AddColumn("Fixed Asset"."FA Location Code", false, '', false, false, false, '', 1);
        TempExcelBuf.AddColumn("Fixed Asset"."Acquisition Date", false, '', false, false, false, '', 2);
        TempExcelBuf.AddColumn("Fixed Asset".Description, false, '', false, false, false, '', 1);

        TempExcelBuf.AddColumn(Montant[1], false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn(Montant[2], false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn(Montant[3], false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn(Montant[4], false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn(Montant[17], false, '', false, false, false, '', 0);

        TempExcelBuf.AddColumn(Montant[5], false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn(Montant[6], false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn(Montant[7], false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn(Montant[18], false, '', false, false, false, '', 0);

        TempExcelBuf.AddColumn(Montant[8], false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn(Montant[9], false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn(Montant[10], false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn(Montant[19], false, '', false, false, false, '', 0);

        TempExcelBuf.AddColumn(Montant[11], false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn(Montant[12], false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn(Montant[13], false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn(Montant[20], false, '', false, false, false, '', 0);

        TempExcelBuf.AddColumn(Montant[14], false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn(Montant[15], false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn(Montant[16], false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn(Montant[21], false, '', false, false, false, '', 0);
    end;

    procedure CreateExcelbook()
    begin
        TempExcelBuf.CreateNewBook(Text002);
        TempExcelBuf.WriteSheet(Text001, COMPANYNAME, USERID);
        TempExcelBuf.CloseBook();
        TempExcelBuf.OpenExcel();
    end;
}
