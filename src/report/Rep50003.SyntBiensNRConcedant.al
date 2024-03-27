namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.FixedAssets.Setup;
using System.IO;
report 50003 "Synt. Biens NR Concedant"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/SyntBiensNRConcedant.rdl';
    Caption = 'Synthèse des biens non renouvelables apportés par le concedant', Comment = 'FRA="Synthèse des biens non renouvelables apportés par le concedant"';
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
            column(Deb; Deb)
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
            column(Fixed_Asset_Location_Code; "Fixed Asset"."Location Code")
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

            trigger OnAfterGetRecord()
            begin

                if FASubclass.Code <> "FA Subclass Code" then
                    if not FASubclass.GET("FA Subclass Code") then
                        FASubclass.INIT();

                if (GetCessionDate() = 0D) or ((GetCessionDate() >= Deb) and (GetCessionDate() <= Fin)) then begin
                    Montant[1] := Idsp.Vdeeco("Fixed Asset"."No.", Deb, Fin);
                    Montant[2] := Idsp.Veeeco("Fixed Asset"."No.", Deb, Fin);
                    Montant[3] := -1 * Idsp.Veseco("Fixed Asset"."No.", Deb, Fin);

                    Montant[4] := -1 * Idsp.Ddeecot("Fixed Asset"."No.", Deb, Fin);
                    Montant[5] := -1 * Idsp.Dexecot("Fixed Asset"."No.", Deb, Fin);
                    Montant[6] := -1 * Idsp.Dreecot("Fixed Asset"."No.", Deb, Fin);

                    Montant[7] := Montant[1] + Montant[2] + Montant[3];
                    Montant[8] := Montant[4] + Montant[5] - Montant[6];

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

                Filtre[1] := CopyStr("Fixed Asset".GETFILTER("In Conncession By"), 1, 100);
                Filtre[2] := CopyStr("Fixed Asset".GETFILTER(Renewable), 1, 100);
                Filtre[3] := CopyStr("Fixed Asset".GETFILTER("FA Location Code"), 1, 100);
                Filtre[4] := CopyStr("Fixed Asset".GETFILTER("FA Subclass Code"), 1, 100);
                Filtre[5] := CopyStr("Fixed Asset".GETFILTER("Acquisition Date"), 1, 100);

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
        GInConncessionBy := GInConncessionBy::Concédant;
        GRenewable := GRenewable::Non;
    end;

    trigger OnPreReport()
    begin
        EnteteGen[1] := 'Valeur d origine des biens apportés par le concédant';
        EnteteGen[2] := 'Amortissements économiques des  biens apportés  par le concédant';

        EnteteDet[1] := 'Biens non renouvelables présents début d.exercice';
        EnteteDet[2] := 'entrées';
        EnteteDet[3] := 'Biens sortis sur l exercice';
        EnteteDet[4] := 'Biens non renouV. présents fin de l exercice';

        EnteteDet[5] := 'Amortissements en début d.exercice';
        EnteteDet[6] := 'Dotations de l.exercice';
        EnteteDet[7] := 'Reprises de l.exercice';
        EnteteDet[8] := 'Amortissements en Fin d.exercice';
    end;

    var
        FASetup: Record "FA Setup";
        TempExcelBuf: Record "Excel Buffer" temporary;
        FASubclass: Record "FA Subclass";
        Idsp: Codeunit Idsp;
        Montant: array[8] of Decimal;
        Deb: Date;
        Fin: Date;
        GInConncessionBy: Enum "In Connecession By";
        GRenewable: Enum Renewable;
        PrintToExcel: Boolean;
        CurrReport_PAGENOCaptionLbl: Label 'Page', Comment = 'FRA="Page"';
        Text001: Label 'Synthèse des biens non renouvelables apportés par le concedant', Comment = 'FRA="Synthèse des biens non renouvelables apportés par le concedant"';
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
        EnteteGen: array[2] of Text[100];
        EnteteDet: array[8] of Text[100];
        Filtre: array[5] of Text[100];
        Text016: Label 'Exercice Déb/fin', Comment = 'FRA="Exercice Déb/fin"';
        Text026: Label 'Printed by %1', Comment = 'FRA="Imprimé par %1"';
        Text027: Label 'Page %1', Comment = 'FRA="Page %1"';

    procedure MakeExcelInfo()
    begin
        TempExcelBuf.SetUseInfoSheet();
        TempExcelBuf.AddInfoColumn(FORMAT(Text005), false, true, false, false, '', 0);
        TempExcelBuf.AddInfoColumn(COMPANYNAME, false, false, false, false, '', 0);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text007), false, true, false, false, '', 0);
        TempExcelBuf.AddInfoColumn(FORMAT(Text001), false, false, false, false, '', 0);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text006), false, true, false, false, '', 0);
        TempExcelBuf.AddInfoColumn(REPORT::"Synt. Biens NR Concedant", false, false, false, false, '', 0);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text008), false, true, false, false, '', 0);
        TempExcelBuf.AddInfoColumn(USERID, false, false, false, false, '', 0);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text009), false, true, false, false, '', 0);
        TempExcelBuf.AddInfoColumn(TODAY, false, false, false, false, '', 2);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text010), false, true, false, false, '', 0);
        TempExcelBuf.AddInfoColumn(Deb, false, false, false, false, '', 2);
        TempExcelBuf.AddInfoColumn(Fin, false, false, false, false, '', 2);

        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text011), false, true, false, false, '', 0);
        TempExcelBuf.AddInfoColumn(Filtre[1], false, false, false, false, '', 0);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text012), false, true, false, false, '', 0);
        TempExcelBuf.AddInfoColumn(Filtre[2], false, false, false, false, '', 0);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text013), false, true, false, false, '', 0);
        TempExcelBuf.AddInfoColumn(Filtre[3], false, false, false, false, '', 0);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text014), false, true, false, false, '', 0);
        TempExcelBuf.AddInfoColumn(Filtre[4], false, false, false, false, '', 0);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text015), false, true, false, false, '', 0);
        TempExcelBuf.AddInfoColumn(Filtre[5], false, false, false, false, '', 0);

        TempExcelBuf.ClearNewRow();
        MakeExcelDataHeader();
    end;

    local procedure MakeExcelDataHeader()
    begin

        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);

        TempExcelBuf.AddColumn(EnteteGen[1], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);

        TempExcelBuf.AddColumn(EnteteGen[2], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);

        TempExcelBuf.NewRow();

        TempExcelBuf.AddColumn("Fixed Asset".FIELDCAPTION("FA Subclass Code"), false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn("Fixed Asset".FIELDCAPTION("No."), false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn("Fixed Asset".FIELDCAPTION("Acquisition Date"), false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn("Fixed Asset".FIELDCAPTION(Description), false, '', true, false, false, '', 0);

        TempExcelBuf.AddColumn(EnteteDet[1], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn(EnteteDet[2], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn(EnteteDet[3], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn(EnteteDet[4], false, '', true, false, false, '', 0);

        TempExcelBuf.AddColumn(EnteteDet[5], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn(EnteteDet[6], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn(EnteteDet[7], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn(EnteteDet[8], false, '', true, false, false, '', 0);

        TempExcelBuf.NewRow();
    end;

    procedure MakeExcelDataBody()
    begin

        TempExcelBuf.NewRow();
        TempExcelBuf.AddColumn("Fixed Asset"."FA Subclass Code", false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn("Fixed Asset"."No.", false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn("Fixed Asset"."Acquisition Date", false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn("Fixed Asset".Description, false, '', false, false, false, '', 0);

        TempExcelBuf.AddColumn(Montant[1], false, '', false, false, false, '', 1);
        TempExcelBuf.AddColumn(Montant[2], false, '', false, false, false, '', 1);
        TempExcelBuf.AddColumn(Montant[3], false, '', false, false, false, '', 1);
        TempExcelBuf.AddColumn(Montant[7], false, '', false, false, false, '', 1);

        TempExcelBuf.AddColumn(Montant[4], false, '', false, false, false, '', 1);
        TempExcelBuf.AddColumn(Montant[5], false, '', false, false, false, '', 1);
        TempExcelBuf.AddColumn(Montant[6], false, '', false, false, false, '', 1);
        TempExcelBuf.AddColumn(Montant[8], false, '', false, false, false, '', 1);
    end;

    procedure CreateExcelbook()
    begin
        TempExcelBuf.CreateNewBook(Text002);
        TempExcelBuf.WriteSheet(Text001, COMPANYNAME, USERID);
        TempExcelBuf.CloseBook();
        TempExcelBuf.OpenExcel();
    end;
}
