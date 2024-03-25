namespace Microsoft.FixedAssets.FixedAsset;

using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.FixedAssets.Journal;
using Microsoft.FixedAssets.Ledger;
using Microsoft.FixedAssets.Maintenance;
using Microsoft.FixedAssets.Setup;

report 50036 "CPA Index Fixed Assets"
{
    ApplicationArea = FixedAssets;
    Caption = 'Index Fixed Assets', Comment = 'FRA="Actualiser immobilisations"';
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            RequestFilterFields = "No.", "FA Class Code", "FA Subclass Code", "Budgeted Asset";

            trigger OnAfterGetRecord()
            begin
                if not FADeprBook.Get("No.", DeprBookCode) then
                    CurrReport.Skip();
                Window.Update(1, "No.");

                if Inactive or
                   Blocked or
                   (FADeprBook."Disposal Date" > 0D) or
                   (FADeprBook."Acquisition Date" = 0D) or
                   (FADeprBook."Acquisition Date" > FAPostingDate)
                then
                    CurrReport.Skip();

                FALedgEntry.SetRange("FA No.", "No.");
                MaintenanceLedgEntry.SetRange("FA No.", "No.");

                i := 0;
                while i < 13 do begin
                    i := i + 1;
                    if i = 7 then
                        i := 8;
                    IndexAmount := 0;
                    if IndexChoices[i] then begin
                        if i = 1 then
                            FALedgEntry.SetRange("FA Posting Type", FALedgEntry."FA Posting Type"::"Acquisition Cost");
                        if i = 2 then
                            FALedgEntry.SetRange("FA Posting Type", FALedgEntry."FA Posting Type"::Depreciation);
                        if i = 3 then
                            FALedgEntry.SetRange("FA Posting Type", FALedgEntry."FA Posting Type"::"Write-Down");
                        if i = 4 then
                            FALedgEntry.SetRange("FA Posting Type", FALedgEntry."FA Posting Type"::Appreciation);
                        if i = 5 then
                            FALedgEntry.SetRange("FA Posting Type", FALedgEntry."FA Posting Type"::"Custom 1");
                        if i = 6 then
                            FALedgEntry.SetRange("FA Posting Type", FALedgEntry."FA Posting Type"::"Custom 2");
                        if i = 9 then
                            FALedgEntry.SetRange("FA Posting Type", FALedgEntry."FA Posting Type"::"Salvage Value");
                        if (i = 13) then
                            FALedgEntry.SetRange("FA Posting Type", FALedgEntry."FA Posting Type"::Derogatory);
                        if i = 8 then begin
                            MaintenanceLedgEntry.CalcSums(Amount);
                            IndexAmount := MaintenanceLedgEntry.Amount;
                        end else begin
                            FALedgEntry.CalcSums(Amount);
                            IndexAmount := FALedgEntry.Amount;
                        end;
                        IndexAmount :=
                          DepreciationCalc.CalcRounding(DeprBookCode, IndexAmount * (IndexFigure / 100 - 1));
                        InsertJournalLine("Fixed Asset");
                    end;
                end;
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
                    field(DepreciationBook; DeprBookCode)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Depreciation Book', Comment = 'FRA=" Loi d''amortissement"';
                        TableRelation = "Depreciation Book";
                    }
                    field(IndexFigure; IndexFigure)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Index Figure', Comment = 'FRA="Taux réévaluation"';
                        MinValue = 0;
                    }
                    field(FAPostingDate; FAPostingDate)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'FA Posting Date', Comment = 'FRA="Date compta. immo."';
                    }
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Posting Date', Comment = 'FRA="Date compta."';
                    }
                    field(DocumentNo; DocumentNo)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Document No.', Comment = 'FRA="N° document"';
                    }
                    field(PostingDescription; PostingDescription)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Posting Description', Comment = 'FRA="Libellé écriture"';
                    }
                    field(InsertBalAccount; BalAccount)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Insert Bal. Account', Comment = 'FRA="Insérer compte contrepartie"';
                    }
                    group(Index)
                    {
                        Caption = 'Index', Comment = 'FRA="Réévaluer"';
                        field("IndexChoices[1]"; IndexChoices[1])
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Acquisition Cost', Comment = 'FRA="Coût acquisition"';
                        }
                        field("IndexChoices[2]"; IndexChoices[2])
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Depreciation', Comment = 'FRA="Amortissement"';
                        }
                        field("IndexChoices[3]"; IndexChoices[3])
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Write-Down', Comment = 'FRA="Dépréciation"';
                        }
                        field("IndexChoices[4]"; IndexChoices[4])
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Appreciation', Comment = 'FRA="Réévaluation"';
                        }
                        field("IndexChoices[5]"; IndexChoices[5])
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Custom 1', Comment = 'FRA="Param. 1"';
                        }
                        field("IndexChoices[6]"; IndexChoices[6])
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Custom 2', Comment = 'FRA="Param. 2"';
                        }
                        field("IndexChoices[9]"; IndexChoices[9])
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Salvage Value', Comment = 'FRA="Valeur résiduelle"';
                        }
                        field("IndexChoices[8]"; IndexChoices[8])
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Maintenance', Comment = 'FRA="Maintenance"';
                        }
                        field(Derogatory; IndexChoices[13])
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Derogatory', Comment = 'FRA="Dérogatoire"';
                        }
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            if DeprBookCode = '' then begin
                FASetup.Get();
                DeprBookCode := FASetup."Default Depr. Book";
            end;
        end;
    }

    trigger OnPreReport()
    begin
        DerogDeprBook.SetRange(Code, DeprBookCode);
        if DerogDeprBook.Find('-') then
            if DerogDeprBook."Derogatory Calculation" <> '' then
                Error(Text10800);
        if FAPostingDate = 0D then
            Error(Text000, FAJnlLine.FieldCaption("FA Posting Date"));
        if FAPostingDate <> NormalDate(FAPostingDate) then
            Error(Text001);

        if PostingDate = 0D then
            PostingDate := FAPostingDate;
        DeprBook.Get(DeprBookCode);
        DeprBook.TestField("Allow Indexation", true);
        if DeprBook."Use Same FA+G/L Posting Dates" and (FAPostingDate <> PostingDate) then
            Error(
              Text002,
              FAJnlLine.FieldCaption("FA Posting Date"),
              FAJnlLine.FieldCaption("Posting Date"),
              DeprBook.FieldCaption("Use Same FA+G/L Posting Dates"),
              false,
              DeprBook.TableCaption(),
              DeprBook.FieldCaption(Code),
              DeprBook.Code);

        DeprBook.IndexGLIntegration(GLIntegration);
        FirstGenJnl := true;
        FirstFAJnl := true;

        FALedgEntry.SetCurrentKey(
          "FA No.", "Depreciation Book Code", "FA Posting Category", "FA Posting Type", "FA Posting Date");
        FALedgEntry.SetRange("Depreciation Book Code", DeprBookCode);
        FALedgEntry.SetRange("FA Posting Category", FALedgEntry."FA Posting Category"::" ");
        FALedgEntry.SetRange("FA Posting Date", 0D, FAPostingDate);

        MaintenanceLedgEntry.SetCurrentKey(
          "FA No.", "Depreciation Book Code", "FA Posting Date");
        MaintenanceLedgEntry.SetRange("Depreciation Book Code", DeprBookCode);
        MaintenanceLedgEntry.SetRange("FA Posting Date", 0D, FAPostingDate);

        Window.Open(Text003);
    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
        FASetup: Record "FA Setup";
        FAJnlLine: Record "FA Journal Line";
        DeprBook: Record "Depreciation Book";
        FADeprBook: Record "FA Depreciation Book";
        FALedgEntry: Record "FA Ledger Entry";
        MaintenanceLedgEntry: Record "Maintenance Ledger Entry";
        FAJnlSetup: Record "FA Journal Setup";
        DerogDeprBook: Record "Depreciation Book";
        DepreciationCalc: Codeunit "Depreciation Calculation";
        Window: Dialog;
        IndexChoices: array[13] of Boolean;
        IndexAmount: Decimal;
        GLIntegration: array[13] of Boolean;
        FirstGenJnl: Boolean;
        FirstFAJnl: Boolean;
        PostingDate: Date;
        DocumentNo: Code[20];
        DocumentNo2: Code[20];
        DocumentNo3: Code[20];
        NoSeries2: Code[20];
        Noseries3: Code[20];
        BalAccount: Boolean;
        FAJnlNextLineNo: Integer;
        GenJnlNextLineNo: Integer;
        i: Integer;
        Text10800: Label 'You cannot index fixed assets in a derogatory depreciation book. Instead you must\index them in the depreciation book integrated with G/L.', Comment = 'FRA="Vous ne pouvez pas indexer des immobilisations dans des lois d''amortissement dérogatoires. Vous devez les\indexer dans les lois d''amortissement intégrées à la comptabilité."';

        Text000: Label 'You must specify %1.', Comment = 'FRA="Vous devez spécifier une valeur %1."';
        Text001: Label 'FA Posting Date must not be a closing date.', Comment = 'FRA="La date compta. immo. ne doit pas être une date de clôture."';
        Text002: Label '%1 and %2 must be identical. %3 must be %4 in %5 %6 = %7.', Comment = 'FRA="%1 et %2 doivent être identiques. %3 doit être %4 dans %5 %6 = %7."';
        Text003: Label 'Indexing fixed asset   #1##########', Comment = 'FRA="Réévaluation immobilisation     #1########"';
        FAPostingDate: Date;
        IndexFigure: Decimal;
        PostingDescription: Text[100];
        DeprBookCode: Code[10];

    procedure InsertGenJnlLine(FANo: Code[20]; IndexAmount: Decimal; PostingType: Enum "FA Journal Line FA Posting Type")
    var
        FAInsertGLAcc: Codeunit "FA Insert G/L Account";
    begin
        if IndexAmount = 0 then
            exit;
        if FirstGenJnl then begin
            GenJnlLine.LockTable();
            FAJnlSetup.GenJnlName(DeprBook, GenJnlLine, GenJnlNextLineNo);
            NoSeries2 := FAJnlSetup.GetGenNoSeries(GenJnlLine);
            if DocumentNo = '' then
                DocumentNo2 := FAJnlSetup.GetGenJnlDocumentNo(GenJnlLine, FAPostingDate, true)
            else
                DocumentNo2 := DocumentNo;
            FirstGenJnl := false;
        end;

        GenJnlLine.Init();
        GenJnlLine."Line No." := 0;
        FAJnlSetup.SetGenJnlTrailCodes(GenJnlLine);
        GenJnlLine."FA Posting Date" := FAPostingDate;
        GenJnlLine."Posting Date" := PostingDate;
        if GenJnlLine."Posting Date" = GenJnlLine."FA Posting Date" then
            GenJnlLine."FA Posting Date" := 0D;
        GenJnlLine."FA Posting Type" := "Gen. Journal Line FA Posting Type".FromInteger(PostingType.AsInteger() + 1);
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Fixed Asset";
        GenJnlLine.Validate("Account No.", FANo);
        GenJnlLine."Document No." := DocumentNo2;
        GenJnlLine."Posting No. Series" := NoSeries2;
        GenJnlLine.Description := PostingDescription;
        GenJnlLine.Validate("Depreciation Book Code", DeprBookCode);
        GenJnlLine.Validate(Amount, IndexAmount);
        GenJnlLine."Index Entry" := true;
        GenJnlNextLineNo := GenJnlNextLineNo + 10000;
        GenJnlLine."Line No." := GenJnlNextLineNo;
        GenJnlLine.Insert(true);
        if BalAccount then begin
            FAInsertGLAcc.GetBalAcc(GenJnlLine);
            if GenJnlLine.FindLast() then;
            GenJnlNextLineNo := GenJnlLine."Line No.";
        end;
    end;

    procedure InsertFAJnlLine(FANo: Code[20]; IndexAmount: Decimal; PostingType: Enum "FA Journal Line FA Posting Type")
    begin
        if IndexAmount = 0 then
            exit;
        if FirstFAJnl then begin
            FAJnlLine.LockTable();
            FAJnlSetup.FAJnlName(DeprBook, FAJnlLine, FAJnlNextLineNo);
            Noseries3 := FAJnlSetup.GetFANoSeries(FAJnlLine);
            if DocumentNo = '' then
                DocumentNo3 := FAJnlSetup.GetFAJnlDocumentNo(FAJnlLine, FAPostingDate, true)
            else
                DocumentNo3 := DocumentNo;
            FirstFAJnl := false;
        end;
        FAJnlLine.Init();
        FAJnlLine."Line No." := 0;
        FAJnlSetup.SetFAJnlTrailCodes(FAJnlLine);
        FAJnlLine."Posting Date" := PostingDate;
        FAJnlLine."FA Posting Date" := FAPostingDate;
        if FAJnlLine."Posting Date" = FAJnlLine."FA Posting Date" then
            FAJnlLine."Posting Date" := 0D;
        FAJnlLine."FA Posting Type" := PostingType;
        FAJnlLine.Validate("FA No.", FANo);
        FAJnlLine."Document No." := DocumentNo3;
        FAJnlLine."Posting No. Series" := Noseries3;
        FAJnlLine.Description := PostingDescription;
        FAJnlLine.Validate("Depreciation Book Code", DeprBookCode);
        FAJnlLine.Validate(Amount, IndexAmount);
        FAJnlLine."Index Entry" := true;
        FAJnlNextLineNo := FAJnlNextLineNo + 10000;
        FAJnlLine."Line No." := FAJnlNextLineNo;
        FAJnlLine.Insert(true);
    end;

    local procedure InsertJournalLine(FixedAsset: Record "Fixed Asset")
    begin
        if not GLIntegration[i] or FixedAsset."Budgeted Asset" then
            InsertFAJnlLine(FixedAsset."No.", IndexAmount, "FA Journal Line FA Posting Type".FromInteger(i - 1))
        else
            InsertGenJnlLine(FixedAsset."No.", IndexAmount, "FA Journal Line FA Posting Type".FromInteger(i - 1));
    end;

    procedure InitializeRequest(DeprBookCodeFrom: Code[10]; IndexFigureFrom: Decimal; FAPostingDateFrom: Date; PostingDateFrom: Date; DocumentNoFrom: Code[20]; PostingDescriptionFrom: Text[100]; BalAccountFrom: Boolean)
    begin
        DeprBookCode := DeprBookCodeFrom;
        IndexFigure := IndexFigureFrom;
        FAPostingDate := FAPostingDateFrom;
        PostingDate := PostingDateFrom;
        DocumentNo := DocumentNoFrom;
        PostingDescription := PostingDescriptionFrom;
        BalAccount := BalAccountFrom;
    end;

    procedure SetIndexAcquisitionCost(IndexChoice: Boolean)
    begin
        IndexChoices[1] := IndexChoice;
    end;

    procedure SetIndexDepreciation(IndexChoice: Boolean)
    begin
        IndexChoices[2] := IndexChoice;
    end;

    procedure InitBatch(LFANo: Code[20]; LDeprBookCode: Code[10]; LIndexFigure: Decimal);
    begin
        FASetup.GET();
        FASetup.TESTFIELD(FASetup."Provision Doc No");
        FASetup.TESTFIELD("Provision Posting Description");

        DeprBookCode := LDeprBookCode;
        IndexFigure := LIndexFigure;
        FAPostingDate := WORKDATE();
        PostingDate := WORKDATE();
        DocumentNo := FASetup."Provision Doc No";
        PostingDescription := FASetup."Provision Posting Description";
        IndexChoices[1] := true;
        IndexChoices[2] := true;
    end;
}
