namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.FixedAssets.Setup;
using System.IO;
report 50006 "Etat des dotations amort."
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/Etatdesdotationsamort.rdl';
    Caption = 'Etat des dotations aux amortissements', Comment = 'FRA="Etat des dotations aux amortissements"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            DataItemTableView = sorting("FA Subclass Code")
                                where("In Conncession By" = filter(Concessionaire | Concédant));
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
            column(ReportNo_; REPORT::"Etat des dotations amort.")
            {
            }
            column(FiltreDate_Caption; Text010)
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
            column(EnteteGen_1; EnteteGen[1])
            {
            }
            column(EnteteGen_2; EnteteGen[2])
            {
            }
            column(EnteteGen_3; EnteteGen[3])
            {
            }
            column(EnteteInt_1; EnteteInt[1])
            {
            }
            column(EnteteInt_2; EnteteInt[2])
            {
            }
            column(EnteteInt_3; EnteteInt[3])
            {
            }
            column(EnteteInt_4; EnteteInt[4])
            {
            }
            column(EnteteInt_5; EnteteInt[5])
            {
            }
            column(EnteteInt_6; EnteteInt[6])
            {
            }
            column(EnteteInt_7; EnteteInt[7])
            {
            }
            column(EnteteDet_1; EnteteDet[1])
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

            trigger OnAfterGetRecord()
            begin

                if FASubclass.Code <> "FA Subclass Code" then
                    if not FASubclass.GET("FA Subclass Code") then
                        FASubclass.INIT();

                if (GetCessionDate() = 0D) or ((GetCessionDate() >= Deb) and (GetCessionDate() <= Fin)) then begin
                    case "In Conncession By" of
                        "In Conncession By"::Concédant:
                            begin
                                if Renewable = Renewable::Oui then
                                    Montant[1] := -1 * Idsp.Dexecot("Fixed Asset"."No.", Deb, Fin);
                                if Renewable = Renewable::Non then
                                    Montant[2] := -1 * Idsp.Dexecot("Fixed Asset"."No.", Deb, Fin);
                            end;

                        "In Conncession By"::Concessionaire:
                            begin
                                if Renewable = Renewable::Oui then
                                    Montant[3] := -1 * Idsp.Dexecot("Fixed Asset"."No.", Deb, Fin);
                                if Renewable = Renewable::Non then
                                    Montant[4] := -1 * Idsp.Dexecot("Fixed Asset"."No.", Deb, Fin);
                            end;
                    end;

                    Montant[5] := Montant[1] + Montant[2];
                    Montant[6] := Montant[3] + Montant[4];
                    Montant[7] := Montant[5] + Montant[6];

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

                if GETFILTER("Acquisition Date") = '' then
                    SETRANGE("Acquisition Date", 0D, Fin);

                Filtre[1] := CopyStr("Fixed Asset".GETFILTER("FA Location Code"), 1, 100);
                Filtre[2] := CopyStr("Fixed Asset".GETFILTER("FA Subclass Code"), 1, 100);
                Filtre[3] := CopyStr("Fixed Asset".GETFILTER("Acquisition Date"), 1, 100);

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
                field(Deb; Deb)
                {
                    Caption = 'Date Début Exercice', Comment = 'FRA="Date Début Exercice"';
                    ApplicationArea = All;
                }
                field(Fin; Fin)
                {
                    Caption = 'Date Début Exercice', Comment = 'FRA="Date Fin Exercice"';
                    ApplicationArea = All;
                }
                field(PrintToExcel; PrintToExcel)
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
    end;

    trigger OnPreReport()
    begin
        EnteteGen[1] := 'BIENS APPORTES PAR LE CONCEDANT';
        EnteteGen[2] := 'BIENS APPORTES PAR LE CONCESSIONNAIRE';
        EnteteGen[3] := 'TOTAL GENERAL';

        EnteteInt[1] := 'Renouvelable';
        EnteteInt[2] := 'Non renouvelable';
        EnteteInt[3] := 'Renouvelable Sauf dernier bien';
        EnteteInt[4] := 'Non renouvelable';
        EnteteInt[5] := 'Biens du concedant';
        EnteteInt[6] := 'Biens du concesionnaire';
        EnteteInt[7] := 'TOTAL';

        EnteteDet[1] := 'Dotations de l.exercice';
    end;

    var
        FASetup: Record "FA Setup";
        FASubclass: Record "FA Subclass";
        TempExcelBuf: Record "Excel Buffer" temporary;
        Idsp: Codeunit Idsp;
        Montant: array[7] of Decimal;
        Deb: Date;
        Fin: Date;
        PrintToExcel: Boolean;
        CurrReport_PAGENOCaptionLbl: Label 'Page', Comment = 'FRA="Page"';
        Text001: Label 'Etat des dotations aux amortissements', Comment = 'FRA="Etat des dotations aux amortissements"';
        Text002: Label 'Data', Comment = 'FRA="Données"';
        Text005: Label 'Company Name', Comment = 'FRA="Nom de la société"';
        Text006: Label 'Report No.', Comment = 'FRA="N° état"';
        Text007: Label 'Report Name', Comment = 'FRA="Nom état"';
        Text008: Label 'User ID', Comment = 'FRA="Code utilisateur"';
        Text009: Label 'Date', Comment = 'FRA="Date"';
        Text010: Label 'G/L Filter', Comment = 'FRA="Exercice"';
        Text013: Label 'Site début/fin', Comment = 'FRA="Site début/fin"';
        Text014: Label 'Compte au Compte', Comment = 'FRA="Compte au Compte"';
        Text015: Label 'Date Acquisition Déb/fin', Comment = 'FRA="Date Acquisition Déb/fin"';
        EnteteGen: array[3] of Text[100];
        EnteteInt: array[7] of Text[100];
        EnteteDet: array[1] of Text[100];
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
        TempExcelBuf.AddInfoColumn(REPORT::"Etat des dotations amort.", false, false, false, false, '', 0);
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
        TempExcelBuf.AddInfoColumn(FORMAT(Text013), false, true, false, false, '', 0);
        TempExcelBuf.AddInfoColumn(Filtre[1], false, false, false, false, '', 0);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text014), false, true, false, false, '', 0);
        TempExcelBuf.AddInfoColumn(Filtre[2], false, false, false, false, '', 0);
        TempExcelBuf.NewRow();
        TempExcelBuf.AddInfoColumn(FORMAT(Text015), false, true, false, false, '', 0);
        TempExcelBuf.AddInfoColumn(Filtre[3], false, false, false, false, '', 0);

        TempExcelBuf.ClearNewRow();
        MakeExcelDataHeader();
    end;

    procedure CreateExcelbook()
    begin
        TempExcelBuf.CreateNewBook(Text002);
        TempExcelBuf.WriteSheet(Text001, COMPANYNAME, USERID);
        TempExcelBuf.CloseBook();
        TempExcelBuf.OpenExcel();
    end;

    local procedure MakeExcelDataHeader()
    begin

        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);

        TempExcelBuf.AddColumn(EnteteGen[1], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);

        TempExcelBuf.AddColumn(EnteteGen[2], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);

        TempExcelBuf.AddColumn(EnteteGen[3], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);

        TempExcelBuf.NewRow();

        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn('', false, '', true, false, false, '', 0);

        TempExcelBuf.AddColumn(EnteteInt[1], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn(EnteteInt[2], false, '', true, false, false, '', 0);

        TempExcelBuf.AddColumn(EnteteInt[3], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn(EnteteInt[4], false, '', true, false, false, '', 0);

        TempExcelBuf.AddColumn(EnteteInt[5], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn(EnteteInt[6], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn(EnteteInt[7], false, '', true, false, false, '', 0);

        TempExcelBuf.NewRow();

        TempExcelBuf.AddColumn("Fixed Asset".FIELDCAPTION("FA Subclass Code"), false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn("Fixed Asset".FIELDCAPTION("No."), false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn("Fixed Asset".FIELDCAPTION("FA Location Code"), false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn("Fixed Asset".FIELDCAPTION("Acquisition Date"), false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn("Fixed Asset".FIELDCAPTION(Description), false, '', true, false, false, '', 0);

        TempExcelBuf.AddColumn(EnteteDet[1], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn(EnteteDet[1], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn(EnteteDet[1], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn(EnteteDet[1], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn(EnteteDet[1], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn(EnteteDet[1], false, '', true, false, false, '', 0);
        TempExcelBuf.AddColumn(EnteteDet[1], false, '', true, false, false, '', 0);

        TempExcelBuf.NewRow();
    end;

    procedure MakeExcelDataBody()
    begin

        TempExcelBuf.NewRow();
        TempExcelBuf.AddColumn("Fixed Asset"."FA Subclass Code", false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn("Fixed Asset"."No.", false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn("Fixed Asset"."FA Location Code", false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn("Fixed Asset"."Acquisition Date", false, '', false, false, false, '', 0);
        TempExcelBuf.AddColumn("Fixed Asset".Description, false, '', false, false, false, '', 0);

        TempExcelBuf.AddColumn(Montant[1], false, '', false, false, false, '', 1);
        TempExcelBuf.AddColumn(Montant[2], false, '', false, false, false, '', 1);

        TempExcelBuf.AddColumn(Montant[3], false, '', false, false, false, '', 1);
        TempExcelBuf.AddColumn(Montant[4], false, '', false, false, false, '', 1);

        TempExcelBuf.AddColumn(Montant[5], false, '', false, false, false, '', 1);
        TempExcelBuf.AddColumn(Montant[6], false, '', false, false, false, '', 1);
        TempExcelBuf.AddColumn(Montant[7], false, '', false, false, false, '', 1);
    end;
}
