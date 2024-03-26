namespace Bcsys.CPA.Basics;

using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Foundation.Period;
using System.Utilities;
report 50026 "G/L Detail Trial Balance Grp"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/GLDetailTrialBalanceGrp.rdl';
    Caption = 'G/L Detail Trial Balance Grp', Comment = 'FRA="Grand livre comptes généraux GRP"';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Date Filter";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(STRSUBSTNO_Text003_USERID_; STRSUBSTNO(Text003, USERID))
            {
            }
            column(STRSUBSTNO_Text004_PreviousStartDate_; STRSUBSTNO(Text004, PreviousStartDate))
            {
            }
            column(PageCaption; STRSUBSTNO(Text005, ' '))
            {
            }
            column(UserCaption; STRSUBSTNO(Text003, ''))
            {
            }
            column(G_L_Account__TABLECAPTION__________Filter; "G/L Account".TABLECAPTION + ': ' + Filter)
            {
            }
            column("Filter"; Filter)
            {
            }
            column(FiscalYearStatusText; FiscalYearStatusText)
            {
            }
            column(Text009; Text009Lbl)
            {
            }
            column(GLAccountTypeFilter; GLAccountTypeFilter)
            {
            }
            column(G_L_Account__No__; "No.")
            {
            }
            column(G_L_Account_Name; Name)
            {
            }
            column(G_L_Account__G_L_Account___Debit_Amount_; "G/L Account"."Debit Amount")
            {
            }
            column(G_L_Account__G_L_Account___Credit_Amount_; "G/L Account"."Credit Amount")
            {
            }
            column(G_L_Account___Debit_Amount_____G_L_Account___Credit_Amount_; "G/L Account"."Debit Amount" - "G/L Account"."Credit Amount")
            {
            }
            column(STRSUBSTNO_Text006_PreviousEndDate_; STRSUBSTNO(Text006, PreviousEndDate))
            {
            }
            column(GLAccount2__Debit_Amount_; GLAccount2."Debit Amount")
            {
            }
            column(GLAccount2__Credit_Amount_; GLAccount2."Credit Amount")
            {
            }
            column(GLAccount2__Debit_Amount____GLAccount2__Credit_Amount_; GLAccount2."Debit Amount" - GLAccount2."Credit Amount")
            {
            }
            column(STRSUBSTNO_Text006_EndDate_; STRSUBSTNO(Text006, EndDate))
            {
            }
            column(G_L_Account__G_L_Account___Debit_Amount__Control1120054; "G/L Account"."Debit Amount")
            {
            }
            column(G_L_Account__G_L_Account___Credit_Amount__Control1120056; "G/L Account"."Credit Amount")
            {
            }
            column(G_L_Account___Debit_Amount_____G_L_Account___Credit_Amount__Control1120058; "G/L Account"."Debit Amount" - "G/L Account"."Credit Amount")
            {
            }
            column(ShowBodyGLAccount; ShowBodyGLAccount)
            {
            }
            column(G_L_Account__G_L_Account___Debit_Amount__Control1120062; "G/L Account"."Debit Amount")
            {
            }
            column(G_L_Account__G_L_Account___Credit_Amount__Control1120064; "G/L Account"."Credit Amount")
            {
            }
            column(G_L_Account___Debit_Amount_____G_L_Account___Credit_Amount__Control1120066; "G/L Account"."Debit Amount" - "G/L Account"."Credit Amount")
            {
            }
            column(G_L_Entry___Debit_Amount__Control1120070; "G/L Entry"."Debit Amount")
            {
            }
            column(G_L_Entry___Credit_Amount__Control1120072; "G/L Entry"."Credit Amount")
            {
            }
            column(G_L_Account___Debit_Amount_____G_L_Account___Credit_Amount____GLAccount2__Debit_Amount____GLAccount2__Credit_Amount_; "G/L Account"."Debit Amount" - "G/L Account"."Credit Amount" + GLAccount2."Debit Amount" - GLAccount2."Credit Amount")
            {
            }
            column(G_L_Account_Global_Dimension_1_Filter; "Global Dimension 1 Filter")
            {
            }
            column(G_L_Account_Global_Dimension_2_Filter; "Global Dimension 2 Filter")
            {
            }
            column(G_L_Detail_Trial_BalanceCaption; G_L_Detail_Trial_BalanceCaptionLbl)
            {
            }
            column(Posting_DateCaption; Posting_DateCaptionLbl)
            {
            }
            column(Source_CodeCaption; Source_CodeCaptionLbl)
            {
            }
            column(Document_No_Caption; Document_No_CaptionLbl)
            {
            }
            column(External_Document_No_Caption; External_Document_No_CaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(DebitCaption; DebitCaptionLbl)
            {
            }
            column(CreditCaption; CreditCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(ContinuedCaption; ContinuedCaptionLbl)
            {
            }
            column(To_be_continuedCaption; To_be_continuedCaptionLbl)
            {
            }
            column(Grand_TotalCaption; Grand_TotalCaptionLbl)
            {
            }
            dataitem(Date; 2000000007)
            {
                DataItemTableView = sorting("Period Type");
                PrintOnlyIfDetail = true;
                column(STRSUBSTNO_Text007_EndDate_; STRSUBSTNO(Text007, EndDate))
                {
                }
                column(G_L_Entry___Debit_Amount__Control1120080; "G/L Entry"."Debit Amount")
                {
                }
                column(G_L_Entry___Debit_Amount____GLAccount2__Debit_Amount_; "G/L Entry"."Debit Amount" + GLAccount2."Debit Amount")
                {
                }
                column(G_L_Entry___Credit_Amount__Control1120084; "G/L Entry"."Credit Amount")
                {
                }
                column(G_L_Entry___Credit_Amount____GLAccount2__Credit_Amount_; "G/L Entry"."Credit Amount" + GLAccount2."Credit Amount")
                {
                }
                column(G_L_Entry___Debit_Amount_____G_L_Entry___Credit_Amount__Control1120088; "G/L Entry"."Debit Amount" - "G/L Entry"."Credit Amount")
                {
                }
                column(G_L_Entry___Debit_Amount____GLAccount2__Debit_Amount_______G_L_Entry___Credit_Amount____GLAccount2__Credit_Amount__; ("G/L Entry"."Debit Amount" + GLAccount2."Debit Amount") - ("G/L Entry"."Credit Amount" + GLAccount2."Credit Amount"))
                {
                }
                column(Date__Period_Name_; Date."Period Name")
                {
                }
                column(Date__Period_No__; Date."Period No.")
                {
                }
                column(Year; DATE2DMY("G/L Entry"."Posting Date", 3))
                {
                }
                column(Date_Period_Type; "Period Type")
                {
                }
                column(Date_Period_Start; "Period Start")
                {
                }
                column(Total_Date_RangeCaption; Total_Date_RangeCaptionLbl)
                {
                }
                dataitem("G/L Entry"; 17)
                {
                    DataItemLink = "G/L Account No." = field("No."),
                                   "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                   "Global Dimension 2 Code" = field("Global Dimension 2 Filter");
                    DataItemLinkReference = "G/L Account";
                    DataItemTableView = sorting("G/L Account No.");
                    column(G_L_Entry__Debit_Amount_; "Debit Amount")
                    {
                    }
                    column(G_L_Entry__Credit_Amount_; "Credit Amount")
                    {
                    }
                    column(Debit_Amount_____Credit_Amount_; "Debit Amount" - "Credit Amount")
                    {
                    }
                    column(G_L_Entry__Posting_Date_; FORMAT("Posting Date"))
                    {
                    }
                    column(G_L_Entry__Source_Code_; "Source Code")
                    {
                    }
                    column(G_L_Entry__Document_No__; "Document No.")
                    {
                    }
                    column(G_L_Entry__External_Document_No__; "External Document No.")
                    {
                    }
                    column(G_L_Entry_Description; Description)
                    {
                    }
                    column(G_L_Entry__Debit_Amount__Control1120116; "Debit Amount")
                    {
                    }
                    column(G_L_Entry__Credit_Amount__Control1120119; "Credit Amount")
                    {
                    }
                    column(Solde; Solde)
                    {
                    }
                    column(G_L_Entry___Entry_No__; "G/L Entry"."Entry No.")
                    {
                    }
                    column(G_L_Entry__Debit_Amount__Control1120126; "Debit Amount")
                    {
                    }
                    column(G_L_Entry__Credit_Amount__Control1120128; "Credit Amount")
                    {
                    }
                    column(Debit_Amount_____Credit_Amount__Control1120130; "Debit Amount" - "Credit Amount")
                    {
                    }
                    column(Text008_________FORMAT_Date__Period_Type___________Date__Period_Name_; Text008 + ' ' + FORMAT(Date."Period Type") + ' ' + Date."Period Name")
                    {
                    }
                    column(G_L_Entry__Debit_Amount__Control1120136; "Debit Amount")
                    {
                    }
                    column(G_L_Entry__Credit_Amount__Control1120139; "Credit Amount")
                    {
                    }
                    column(Solde_Control1120142; Solde)
                    {
                    }
                    column(TotalByInt; TotalByInt)
                    {
                    }
                    column(G_L_Entry_G_L_Account_No_; "G/L Account No.")
                    {
                    }
                    column(G_L_Entry_Global_Dimension_1_Code; "Global Dimension 1 Code")
                    {
                    }
                    column(G_L_Entry_Global_Dimension_2_Code; "Global Dimension 2 Code")
                    {
                    }
                    column(Previous_pageCaption; Previous_pageCaptionLbl)
                    {
                    }
                    column(Current_pageCaption; Current_pageCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if ("Debit Amount" = 0) and
                           ("Credit Amount" = 0)
                        then
                            CurrReport.SKIP();
                        Solde := Solde + "Debit Amount" - "Credit Amount";
                    end;

                    trigger OnPreDataItem()
                    begin
                        if DocNumSort then
                            SETCURRENTKEY("G/L Account No.", "Document No.", "Posting Date");
                        SETRANGE("Posting Date", Date."Period Start", Date."Period End");
                    end;
                }

                trigger OnPreDataItem()
                begin
                    SETRANGE("Period Type", TotalBy);
                    SETRANGE("Period Start", StartDate, CLOSINGDATE(EndDate));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                GLAccount2.COPY("G/L Account");
                if GLAccount2."Income/Balance" = 0 then
                    GLAccount2.SETRANGE("Date Filter", PreviousStartDate, PreviousEndDate)
                else
                    GLAccount2.SETRANGE("Date Filter", 0D, PreviousEndDate);
                GLAccount2.CALCFIELDS("Debit Amount", "Credit Amount");
                Solde := GLAccount2."Debit Amount" - GLAccount2."Credit Amount";
                if "Income/Balance" = 0 then
                    SETRANGE("Date Filter", StartDate, EndDate)
                else
                    SETRANGE("Date Filter", 0D, EndDate);
                CALCFIELDS("Debit Amount", "Credit Amount");
                if ("Debit Amount" = 0) and ("Credit Amount" = 0) then
                    CurrReport.SKIP();

                ShowBodyGLAccount := ((GLAccount2."Debit Amount" = "Debit Amount") and (GLAccount2."Credit Amount" = "Credit Amount"))
                  or ("Account Type".AsInteger() <> 0);
            end;

            trigger OnPreDataItem()
            begin
                if GETFILTER("Date Filter") = '' then
                    ERROR(Text001, FIELDCAPTION("Date Filter"));
                if COPYSTR(GETFILTER("Date Filter"), 1, 1) = '.' then
                    ERROR(Text002);
                StartDate := GETRANGEMIN("Date Filter");
                Period.SETRANGE("Period Start", StartDate);
                case TotalBy of
                    TotalBy::" ":
                        Period.SETRANGE("Period Type", Period."Period Type"::Date);
                    TotalBy::Week:
                        Period.SETRANGE("Period Type", Period."Period Type"::Week);
                    TotalBy::Month:
                        Period.SETRANGE("Period Type", Period."Period Type"::Month);
                    TotalBy::Quarter:
                        Period.SETRANGE("Period Type", Period."Period Type"::Quarter);
                    TotalBy::Year:
                        Period.SETRANGE("Period Type", Period."Period Type"::Year);
                end;
                if not Period.FINDFIRST() then
                    ERROR(Text010, StartDate, Period.GETFILTER("Period Type"));
                PreviousEndDate := CLOSINGDATE(StartDate - 1);
                FiltreDateCalc.CreateFiscalYearFilter(TextDate, TextDate, StartDate, 0);
                TextDate := CONVERTSTR(TextDate, '.', ',');
                FctMgt.VerifiyDateFilter(TextDate);
                TextDate := COPYSTR(TextDate, 1, 8);
                EVALUATE(PreviousStartDate, TextDate);
                if COPYSTR(GETFILTER("Date Filter"), STRLEN(GETFILTER("Date Filter")), 1) = '.' then
                    EndDate := 0D
                else
                    EndDate := GETRANGEMAX("Date Filter");
                CLEAR(Period);
                Period.SETRANGE("Period End", CLOSINGDATE(EndDate));
                case TotalBy of
                    TotalBy::" ":
                        Period.SETRANGE("Period Type", Period."Period Type"::Date);
                    TotalBy::Week:
                        Period.SETRANGE("Period Type", Period."Period Type"::Week);
                    TotalBy::Month:
                        Period.SETRANGE("Period Type", Period."Period Type"::Month);
                    TotalBy::Quarter:
                        Period.SETRANGE("Period Type", Period."Period Type"::Quarter);
                    TotalBy::Year:
                        Period.SETRANGE("Period Type", Period."Period Type"::Year);
                end;
                if not Period.FINDFIRST() then
                    ERROR(Text011, EndDate, Period.GETFILTER("Period Type"));
                FiscalYearStatusText := STRSUBSTNO(Text012, FctMgt.CheckFiscalYearStatus(CopyStr(GETFILTER("Date Filter"), 1, 30)));
                TotalByInt := TotalBy.AsInteger();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options', Comment = 'FRA="Options"';
                    field(TotalByF; TotalBy)
                    {
                        Caption = 'Centralized by', Comment = 'FRA="Centralisé par"';
                        ApplicationArea = All;
                    }
                    field(DocNumSortF; DocNumSort)
                    {
                        Caption = 'Sorted by Document No.', Comment = 'FRA="Trié par n° document"';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        TotalBy := TotalBy::Month
    end;

    trigger OnPreReport()
    begin
        Filter := CopyStr("G/L Account".GETFILTERS, 1, MaxStrLen(Filter));
    end;

    var
        GLAccount2: Record "G/L Account";
        Period: Record Date;
        FiltreDateCalc: Codeunit "DateFilter-Calc";
        FctMgt: Codeunit "CPA Function Mgt";
        StartDate: Date;
        EndDate: Date;
        PreviousStartDate: Date;
        PreviousEndDate: Date;
        TextDate: Text[30];
        Solde: Decimal;
        TotalBy: Enum TotalBy;
        DocNumSort: Boolean;
        ShowBodyGLAccount: Boolean;
        "Filter": Text[250];
        GLAccountTypeFilter: Text[250];
        Text001: Label 'You must fill in the %1 field.', Comment = 'FRA="Vous devez renseigner le champ %1."';
        Text002: Label 'You must specify a Starting Date.', Comment = 'FRA="Vous devez spécifier une date de début."';
        Text003: Label 'Printed by %1', Comment = 'FRA="Imprimé par %1"';
        Text004: Label 'Fiscal Year Start Date : %1', Comment = 'FRA="Début exercice comptable : %1"';
        Text005: Label 'Page %1', Comment = 'FRA="Page %1"';
        Text006: Label 'Balance at %1 ', Comment = 'FRA="Solde au %1 "';
        Text007: Label 'Balance at %1', Comment = 'FRA="Solde au %1"';
        Text008: Label 'Total', Comment = 'FRA="Total"';
        Text010: Label 'The selected starting date %1 is not the start of a %2.', Comment = 'FRA="La date de début choisie (%1) ne correspond pas au début de %2."';
        Text011: Label 'The selected ending date %1 is not the end of a %2.', Comment = 'FRA="La date de fin choisie (%1) ne correspond pas à la fin de %2."';
        FiscalYearStatusText: Text[80];
        Text012: Label 'Fiscal-Year Status: %1', Comment = 'FRA="Statut de l''exercice comptable : %1"';
        TotalByInt: Integer;
        Text009Lbl: Label 'This report includes simulation entries.', Comment = 'FRA="Cet état inclut des écritures de simulation."';
        G_L_Detail_Trial_BalanceCaptionLbl: Label 'G/L Detail Trial Balance', Comment = 'FRA="Grand livre comptes généraux"';
        Posting_DateCaptionLbl: Label 'Posting Date', Comment = 'FRA="Date comptabilisation"';
        Source_CodeCaptionLbl: Label 'Source Code', Comment = 'FRA="Code journal"';
        Document_No_CaptionLbl: Label 'Document No.', Comment = 'FRA="N° document"';
        External_Document_No_CaptionLbl: Label 'External Document No.', Comment = 'FRA="N° doc. externe"';
        DescriptionCaptionLbl: Label 'Description', Comment = 'FRA="Désignation"';
        DebitCaptionLbl: Label 'Debit', Comment = 'FRA="Débit"';
        CreditCaptionLbl: Label 'Credit', Comment = 'FRA="Crédit"';
        BalanceCaptionLbl: Label 'Balance', Comment = 'FRA="Solde"';
        ContinuedCaptionLbl: Label 'Continued', Comment = 'FRA="Suite"';
        To_be_continuedCaptionLbl: Label 'To be continued', Comment = 'FRA="À suivre"';
        Grand_TotalCaptionLbl: Label 'Grand Total', Comment = 'FRA="Total général"';
        Total_Date_RangeCaptionLbl: Label 'Total Date Range', Comment = 'FRA="Total plage de dates"';
        Previous_pageCaptionLbl: Label 'Previous page', Comment = 'FRA="Page précédente"';
        Current_pageCaptionLbl: Label 'Current page', Comment = 'FRA="Page courante"';
}
