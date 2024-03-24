namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.FixedAssets.Setup;
using Microsoft.FixedAssets.Ledger;
using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.FixedAssets.Posting;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.Finance.Dimension;
using Microsoft.FixedAssets.Journal;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Foundation.Period;
using Microsoft.Finance.GeneralLedger.Setup;
tableextension 50015 "Fixed Asset" extends "Fixed Asset" //5600
{
    fields
    {
        modify("No.")
        {
            Caption = 'No.', Comment = 'FRA="N° Immo"';
        }
        modify(Description)
        {
            Caption = 'Description', Comment = 'FRA="Nature"';
        }
        modify("FA Subclass Code")
        {
            Caption = 'FA Subclass Code', Comment = 'FRA="Compte"';
        }
        modify("FA Location Code")
        {
            Caption = 'FA Location Code', comment = 'FRA="Site"';
            trigger OnAfterValidate()
            var
                LGeneralLedgerSetup: Record "General Ledger Setup";
                LDefaultDimension: Record "Default Dimension";
                FASetup: Record "FA Setup";
            begin
                FASetup.GET();
                FASetup.TESTFIELD("Global Dimension Site Code");

                LGeneralLedgerSetup.GET();
                if LGeneralLedgerSetup."Global Dimension 1 Code" = FASetup."Global Dimension Site Code" then
                    VALIDATE("Global Dimension 1 Code", "FA Location Code")
                else
                    if LGeneralLedgerSetup."Global Dimension 2 Code" = FASetup."Global Dimension Site Code" then
                        VALIDATE("Global Dimension 2 Code", "FA Location Code")
                    else begin
                        LDefaultDimension.INIT();
                        LDefaultDimension.VALIDATE("Table ID", DATABASE::"Fixed Asset");
                        LDefaultDimension.VALIDATE("No.", "No.");
                        LDefaultDimension.VALIDATE("Dimension Code", FASetup."Global Dimension Site Code");
                        LDefaultDimension.VALIDATE("Dimension Value Code", "FA Location Code");
                        if not LDefaultDimension.INSERT(true) then
                            LDefaultDimension.MODIFY(true);
                    end;
            end;
        }
        field(50000; "Acquisition Date"; Date)
        {
            Caption = 'Date acquisition', Comment = 'FRA="Date acquisition"';

            trigger OnValidate()
            begin
                if xRec."Acquisition Date" <> "Acquisition Date" then begin
                    Indice.RESET();
                    Indice.SETFILTER(Date, '<=%1', "Acquisition Date");
                    if Indice.FINDLAST() then
                        VALIDATE("Acquisition Index", Indice.Indice)
                    else
                        VALIDATE("Acquisition Index", 0);
                end;
            end;
        }
        field(50001; "Acquisition Index"; Decimal)
        {
            Caption = 'Indice acquisition', Comment = 'FRA="Indice acquisition"';
            DecimalPlaces = 2 : 2;
        }
        field(50002; "Funding Method"; Enum "Funding Method")
        {
            Caption = 'Mode de financement', Comment = 'FRA="Mode de financement"';
        }
        field(50003; "In Conncession By"; Enum "In Connecession By")
        {
            Caption = 'Mise en concession par', Comment = 'FRA="Mise en concession par"';
        }
        field(50004; Renewable; Enum Renewable)
        {
            Caption = 'Renouvelable', Comment = 'FRA="Renouvelable"';
        }
        field(50005; "Last Asset In Concession"; Enum Renewable)
        {
            Caption = 'Dernier bien mis en conce.', Comment = 'FRA="Dernier bien mis en conce."';
        }
        field(50006; "Attachment Asset"; Code[20])
        {
            Caption = 'Bien de rattachement', Comment = 'FRA="Bien de rattachement"';
            TableRelation = "Fixed Asset" where("FA Location Code" = field("FA Location Code"));

            trigger OnValidate()
            begin
                if "Attachment Asset" = "No." then
                    ERROR(Text5000);
            end;
        }
        field(50007; "Purchase Amount"; Decimal)
        {
            Caption = 'Montant achat', Comment = 'FRA="Montant achat"';
            DecimalPlaces = 2 : 2;
        }
        field(50008; "Replacement Value"; Decimal)
        {
            Caption = 'Valeur de remplacement', Comment = 'FRA="Valeur de remplacement"';
        }
        field(50009; "Replacement Value Appl. Date"; Date)
        {
            Caption = 'Date application valeur de rempl.', Comment = 'FRA="Date application valeur de rempl."';
        }
        field(50010; "Book Value"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("FA Ledger Entry".Amount where("FA No." = field("No."),
                                                              "Part of Book Value" = const(true),
                                                              "FA Posting Date" = field("FA Posting Date Filter"),
                                                              "Exclude Derogatory" = const(false),
                                                              "Book Code Type" = filter(Economic)));
            Caption = 'Book Value', Comment = 'FRA="Valeur comptable"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Book Value PROV"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("FA Ledger Entry".Amount where("FA No." = field("No."),
                                                              "Part of Book Value" = const(true),
                                                              "FA Posting Date" = field("FA Posting Date Filter"),
                                                              "Exclude Derogatory" = const(false),
                                                              "Book Code Type" = filter(Provision)));
            Caption = 'Book Value', Comment = 'FRA="Valeur comptable"';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    var
        FASetup: Record "FA Setup";

    procedure GetCessionDate(): Date
    var
        LFADepreciationBook: Record "FA Depreciation Book";
    begin
        FASetup.GET();
        LFADepreciationBook.RESET();
        LFADepreciationBook.SETFILTER("FA No.", "No.");

        case Renewable of
            Renewable::Oui:
                LFADepreciationBook.SETFILTER("Depreciation Book Code", '<>%1', FASetup."Non Renew.Deprec. Book Code");
            Renewable::Non:
                LFADepreciationBook.SETFILTER("Depreciation Book Code", '<>%1', FASetup."Renewable Deprec. Book Code");
        end;

        LFADepreciationBook.SETFILTER("Disposal Date", '<>%1', 0D);
        if LFADepreciationBook.FINDLAST() then
            exit(LFADepreciationBook."Disposal Date")
        else
            exit(0D);
    end;

    procedure CaducityExist(): Boolean
    var
        LFADepreciationBook: Record "FA Depreciation Book";
        LDepreciationBook: Record "Depreciation Book";
    begin
        LFADepreciationBook.RESET();
        LFADepreciationBook.SETFILTER("FA No.", "No.");
        if LFADepreciationBook.FINDSET() then
            repeat
                if not LDepreciationBook.GET(LFADepreciationBook."Depreciation Book Code") then
                    LDepreciationBook.INIT();
                if LDepreciationBook.Type = LDepreciationBook.Type::Caducity then
                    exit(true);
            until LFADepreciationBook.NEXT() = 0;
        exit(false);
    end;

    procedure FADepreciationBookInit()
    var
        LFADepreciationBook: Record "FA Depreciation Book";
    begin

        if "In Conncession By" = "In Conncession By"::Autre then
            ERROR(Text5001)
        else begin

            TESTFIELD("FA Location Code");
            LFADepreciationBook.RESET();
            LFADepreciationBook.SETFILTER("FA No.", "No.");
            if LFADepreciationBook.FINDSET() then
                ERROR(Text5003, LFADepreciationBook.COUNT)
            else begin

                LFADepreciationBook.RESET();
                FASetup.GET();
                if "Attachment Asset" = '' then begin
                    LFADepreciationBook.INIT();
                    LFADepreciationBook.VALIDATE("FA No.", "No.");
                    LFADepreciationBook.VALIDATE("Depreciation Book Code", FASetup."1st Asset Deprec. Book Code");
                    LFADepreciationBook.VALIDATE("Depreciation Method", FASetup."Deprec.Method 1st Asset");
                    LFADepreciationBook.VALIDATE("Depreciation Starting Date", "Acquisition Date");
                    if not LFADepreciationBook.INSERT() then
                        ERROR(Text5002, FASetup."1st Asset Deprec. Book Code");
                end;

                case Renewable of
                    Renewable::Oui:
                        begin
                            LFADepreciationBook.INIT();
                            LFADepreciationBook.VALIDATE("FA No.", "No.");
                            LFADepreciationBook.VALIDATE("Depreciation Book Code", FASetup."Renewable Deprec. Book Code");
                            LFADepreciationBook.VALIDATE("Depreciation Method", FASetup."Deprec.Method Renewable");
                            LFADepreciationBook.VALIDATE("Depreciation Starting Date", "Acquisition Date");
                            if not LFADepreciationBook.INSERT() then
                                ERROR(Text5002, FASetup."Renewable Deprec. Book Code");
                        end;
                    Renewable::Non:
                        begin
                            LFADepreciationBook.INIT();
                            LFADepreciationBook.VALIDATE("FA No.", "No.");
                            LFADepreciationBook.VALIDATE("Depreciation Book Code", FASetup."Non Renew.Deprec. Book Code");
                            LFADepreciationBook.VALIDATE("Depreciation Method", FASetup."Deprec.Method Renewable");
                            LFADepreciationBook.VALIDATE("Depreciation Starting Date", "Acquisition Date");
                            if not LFADepreciationBook.INSERT() then
                                ERROR(Text5002, FASetup."Non Renew.Deprec. Book Code");
                        end;
                end;

                if ("Attachment Asset" = '') and (Renewable = Renewable::Oui) then begin
                    LFADepreciationBook.INIT();
                    LFADepreciationBook.VALIDATE("FA No.", "No.");
                    LFADepreciationBook.VALIDATE("Depreciation Book Code", FASetup."Renw.Prov.Deprec. Book Code");
                    LFADepreciationBook.VALIDATE("Depreciation Method", FASetup."Deprec.Method Renw.Prov.");
                    LFADepreciationBook.VALIDATE("Depreciation Starting Date", "Acquisition Date");
                    if not LFADepreciationBook.INSERT() then
                        ERROR(Text5002, FASetup."Renw.Prov.Deprec. Book Code");
                end;
            end;
        end;
    end;

    procedure AcquisitionGeneration(Provision: Boolean)
    var
        LFADepreciationBook: Record "FA Depreciation Book";
        FAJnlLine: Record "FA Journal Line";
        ACJnlLine: Record "Gen. Journal Line";
        ACJnlTemplate: Record "Gen. Journal Template";
        AcJnlBatch: Record "Gen. Journal Batch";
        FAJnlTemplate: Record "FA Journal Template";
        FaJnlBatch: Record "FA Journal Batch";
        DepreciationBook: Record "Depreciation Book";
        FALedgerEntry: Record "FA Ledger Entry";
        FAJournalSetup: Record "FA Journal Setup";
        FAInsertGLAcc: Codeunit "FA Insert G/L Account";
        FALineNo: Integer;
        ACLineNo: Integer;
        Valid: Boolean;
        FALineNb: Integer;
        ACLineNb: Integer;
        LAmount: Decimal;
        LDate: Date;
    begin
        Valid := false;

        FASetup.GET();
        FASetup.TESTFIELD("Acquisition Doc No");
        FASetup.TESTFIELD("Renw.Prov.Deprec. Book Code");

        LFADepreciationBook.RESET();
        LFADepreciationBook.SETFILTER("FA No.", "No.");
        if Provision then
            LFADepreciationBook.SETFILTER("Depreciation Book Code", FASetup."Renw.Prov.Deprec. Book Code")
        else
            LFADepreciationBook.SETFILTER("Depreciation Book Code", '<>%1', FASetup."Renw.Prov.Deprec. Book Code");

        if not LFADepreciationBook.FINDSET() then
            ERROR(Text5004, "No.");

        LFADepreciationBook.SETFILTER("FA Posting Group", '= %1', '');
        if LFADepreciationBook.FINDSET() then
            ERROR(Text5005, LFADepreciationBook.COUNT, "No.");

        LFADepreciationBook.SETFILTER("FA Posting Group", '<> %1', '');
        LFADepreciationBook.SETFILTER("Acquisition Cost", '<> %1', 0);
        if LFADepreciationBook.FINDSET() then
            ERROR(Text5006, LFADepreciationBook.COUNT, "No.");

        LFADepreciationBook.SETFILTER("Acquisition Cost", '= %1', 0);

        if LFADepreciationBook.FINDSET() then begin
            FALedgerEntry.RESET();
            FALedgerEntry.SETFILTER("FA No.", "No.");
            FALedgerEntry.SETFILTER("Depreciation Book Code", LFADepreciationBook."Depreciation Book Code");
            if FALedgerEntry.FINDSET() then
                ERROR(Text5009, "No.", LFADepreciationBook."Depreciation Book Code");

            repeat

                FAJournalSetup.SETFILTER("Depreciation Book Code", LFADepreciationBook."Depreciation Book Code");
                FAJournalSetup.SETFILTER("User ID", USERID);

                if not FAJournalSetup.FINDFIRST() then
                    FAJournalSetup.SETFILTER("User ID", '');
                if not FAJournalSetup.FINDFIRST() then
                    ERROR(Text5011, LFADepreciationBook."Depreciation Book Code");

                if Valid then begin
                    FAJnlLine.RESET();
                    FAJnlLine.SETRANGE("Journal Template Name", FAJournalSetup."FA Jnl. Template Name");
                    FAJnlLine.SETRANGE("Journal Batch Name", FAJournalSetup."FA Jnl. Batch Name");
                    if FAJnlLine.FIND('-') then
                        ERROR(Text5007, FAJournalSetup."FA Jnl. Batch Name");

                    ACJnlLine.RESET();
                    ACJnlLine.SETRANGE("Journal Template Name", FAJournalSetup."Gen. Jnl. Template Name");
                    ACJnlLine.SETRANGE("Journal Batch Name", FAJournalSetup."Gen. Jnl. Batch Name");
                    if ACJnlLine.FIND('-') then
                        ERROR(Text5008, FAJournalSetup."Gen. Jnl. Batch Name");
                end;

                FAJnlLine.RESET();
                FAJnlLine.SETRANGE("Journal Template Name", FAJournalSetup."FA Jnl. Template Name");
                FAJnlLine.SETRANGE("Journal Batch Name", FAJournalSetup."FA Jnl. Batch Name");
                FAJnlLine.SETFILTER("FA No.", "No.");
                FAJnlLine.SETFILTER("Depreciation Book Code", LFADepreciationBook."Depreciation Book Code");
                if FAJnlLine.FIND('-') then
                    ERROR(Text5012, "No.", FAJournalSetup."FA Jnl. Batch Name");

                ACJnlLine.RESET();
                ACJnlLine.SETRANGE("Journal Template Name", FAJournalSetup."Gen. Jnl. Template Name");
                ACJnlLine.SETRANGE("Journal Batch Name", FAJournalSetup."Gen. Jnl. Batch Name");
                ACJnlLine.SETFILTER("Account No.", "No.");
                ACJnlLine.SETFILTER("Depreciation Book Code", LFADepreciationBook."Depreciation Book Code");
                if ACJnlLine.FIND('-') then
                    ERROR(Text5013, "No.", FAJournalSetup."Gen. Jnl. Batch Name");

                ACJnlTemplate.GET(FAJournalSetup."Gen. Jnl. Template Name");
                AcJnlBatch.GET(FAJournalSetup."Gen. Jnl. Template Name", FAJournalSetup."Gen. Jnl. Batch Name");
                ACJnlLine.RESET();
                ACJnlLine.LOCKTABLE();
                ACJnlLine.SETRANGE("Journal Template Name", FAJournalSetup."Gen. Jnl. Template Name");
                ACJnlLine.SETRANGE("Journal Batch Name", FAJournalSetup."Gen. Jnl. Batch Name");
                if ACJnlLine.FINDLAST() then
                    ACLineNo := ACJnlLine."Line No."
                else
                    ACLineNo := 0;

                FAJnlTemplate.GET(FAJournalSetup."FA Jnl. Template Name");
                FaJnlBatch.GET(FAJournalSetup."FA Jnl. Template Name", FAJournalSetup."FA Jnl. Batch Name");
                FaJnlBatch.TESTFIELD("No. Series", '');
                FAJnlLine.RESET();
                FAJnlLine.LOCKTABLE();
                FAJnlLine.SETRANGE("Journal Template Name", FAJournalSetup."FA Jnl. Template Name");
                FAJnlLine.SETRANGE("Journal Batch Name", FAJournalSetup."FA Jnl. Batch Name");
                if FAJnlLine.FINDLAST() then
                    FALineNo := FAJnlLine."Line No."
                else
                    FALineNo := 0;

                DepreciationBook.GET(LFADepreciationBook."Depreciation Book Code");

                if Provision then begin
                    LAmount := "Replacement Value" - "Purchase Amount";
                    LDate := "Replacement Value Appl. Date";
                end else begin
                    LAmount := "Purchase Amount";
                    LDate := "Acquisition Date";
                end;

                if DepreciationBook."G/L Integration - Acq. Cost" then begin
                    ACJnlLine.INIT();
                    ACJnlLine.VALIDATE("Journal Template Name", FAJournalSetup."Gen. Jnl. Template Name");
                    ACJnlLine.VALIDATE("Journal Batch Name", FAJournalSetup."Gen. Jnl. Batch Name");
                    ACLineNo := ACLineNo + 10000;
                    ACJnlLine.VALIDATE("Line No.", ACLineNo);
                    ACJnlLine."Document Type" := ACJnlLine."Document Type"::Payment;
                    ACJnlLine."Source Code" := ACJnlTemplate."Source Code";
                    ACJnlLine."Reason Code" := AcJnlBatch."Reason Code";
                    ACJnlLine."Posting No. Series" := AcJnlBatch."Posting No. Series";
                    ACJnlLine."Bal. Account Type" := AcJnlBatch."Bal. Account Type";
                    ACJnlLine.VALIDATE("Bal. Account No.", AcJnlBatch."Bal. Account No.");
                    ACJnlLine.VALIDATE("Account Type", ACJnlLine."Account Type"::"Fixed Asset");
                    ACJnlLine.VALIDATE("Account No.", "No.");
                    ACJnlLine.VALIDATE("Document No.", FASetup."Acquisition Doc No");
                    ACJnlLine.VALIDATE("FA Posting Date", LDate);
                    ACJnlLine.VALIDATE(Description, COPYSTR(('Achat ' + Description), 1, MAXSTRLEN(ACJnlLine.Description)));
                    ACJnlLine.VALIDATE("FA Posting Type", ACJnlLine."FA Posting Type"::"Acquisition Cost");
                    ACJnlLine.VALIDATE("Posting Date", LDate);
                    ACJnlLine.VALIDATE(Amount, LAmount);
                    ACJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                    ACJnlLine.VALIDATE("Depreciation Book Code", LFADepreciationBook."Depreciation Book Code");
                    ACJnlLine.INSERT(true);
                    FAInsertGLAcc.GetBalAcc(ACJnlLine, ACLineNo);
                    ACLineNb += 1;
                end else begin
                    FAJnlLine.INIT();
                    FAJnlLine.VALIDATE("Journal Template Name", FAJournalSetup."FA Jnl. Template Name");
                    FAJnlLine.VALIDATE("Journal Batch Name", FAJournalSetup."FA Jnl. Batch Name");
                    FAJnlLine.VALIDATE("Document No.", FASetup."Acquisition Doc No");
                    FALineNo := FALineNo + 10000;
                    FAJnlLine.VALIDATE("Line No.", FALineNo);
                    FAJnlLine."Source Code" := FAJnlTemplate."Source Code";
                    FAJnlLine."Reason Code" := FaJnlBatch."Reason Code";
                    FAJnlLine."Posting No. Series" := FaJnlBatch."Posting No. Series";
                    FAJnlLine.VALIDATE("FA No.", "No.");
                    FAJnlLine.VALIDATE("FA Posting Date", LDate);
                    FAJnlLine.VALIDATE(Description, COPYSTR(('Achat ' + Description), 1, MAXSTRLEN(FAJnlLine.Description)));
                    FAJnlLine.VALIDATE("FA Posting Type", FAJnlLine."FA Posting Type"::"Acquisition Cost");
                    FAJnlLine.VALIDATE(Amount, LAmount);
                    FAJnlLine.VALIDATE("Shortcut Dimension 1 Code", "Global Dimension 1 Code");
                    FAJnlLine.VALIDATE("Depreciation Book Code", LFADepreciationBook."Depreciation Book Code");
                    FAJnlLine.INSERT(true);
                    FALineNb += 1;
                end;

                if Valid then begin
                    ACJnlLine.RESET();
                    ACJnlLine.SETFILTER("Journal Template Name", FAJournalSetup."Gen. Jnl. Template Name");
                    ACJnlLine.SETFILTER("Journal Batch Name", FAJournalSetup."Gen. Jnl. Batch Name");
                    if ACJnlLine.FINDSET() then
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", ACJnlLine);
                    ACJnlLine.DELETEALL();

                    FAJnlLine.RESET();
                    FAJnlLine.SETFILTER("Journal Template Name", FAJournalSetup."FA Jnl. Template Name");
                    FAJnlLine.SETFILTER("Journal Batch Name", FAJournalSetup."FA Jnl. Batch Name");
                    if FAJnlLine.FINDSET() then
                        CODEUNIT.RUN(CODEUNIT::"FA Jnl.-Post Batch", FAJnlLine);
                    FAJnlLine.DELETEALL();
                end;
            until LFADepreciationBook.NEXT() = 0;
            MESSAGE(Text5010, FALineNb, FAJournalSetup."Gen. Jnl. Batch Name", ACLineNb, FAJournalSetup."FA Jnl. Batch Name");
        end;
    end;

    procedure CheckMakeProvision(): Boolean
    var
        FASetup: Record "FA Setup";
        LFADepreciationBook: Record "FA Depreciation Book";
        AccountingPeriod: Record "Accounting Period";
        FiscalYearStart: Date;
        FiscalYearEnd: Date;
    begin

        if ("Replacement Value" <> 0) and ("Replacement Value" > "Purchase Amount") then begin
            FASetup.GET();
            FASetup.TESTFIELD("Renw.Prov.Deprec. Book Code");
            if LFADepreciationBook.GET("No.", FASetup."Renw.Prov.Deprec. Book Code") then begin
                AccountingPeriod.RESET();
                AccountingPeriod.SETRANGE(Closed, false);
                AccountingPeriod.SETRANGE("New Fiscal Year", true);
                AccountingPeriod.SETFILTER("Starting Date", '<=%1', WORKDATE());
                if AccountingPeriod.FINDLAST() then begin
                    FiscalYearStart := AccountingPeriod."Starting Date";
                    AccountingPeriod.SETFILTER("Starting Date", '>%1', FiscalYearStart);
                    if AccountingPeriod.FINDFIRST() then
                        FiscalYearEnd := CALCDATE('<-1J>', AccountingPeriod."Starting Date")
                    else begin
                        AccountingPeriod.SETRANGE("New Fiscal Year", false);
                        AccountingPeriod.SETFILTER("Starting Date", '>=%1', FiscalYearStart);
                        if AccountingPeriod.FINDLAST() then
                            FiscalYearEnd := CALCDATE('<+1M-1J>', AccountingPeriod."Starting Date");
                    end;
                end;
                if (FiscalYearStart <> 0D) and (FiscalYearEnd <> 0D) and ("Replacement Value Appl. Date" <> 0D) and
                  ("Replacement Value Appl. Date" >= FiscalYearStart) and
                  ("Replacement Value Appl. Date" <= FiscalYearEnd) then
                    exit(true);
            end;
        end;
        exit(false);
    end;

    procedure MakeProvision()
    var
        FASetup: Record "FA Setup";
        LFixedAsset: Record "Fixed Asset";
        LFADepreciationBook: Record "FA Depreciation Book";
        IndexFixedAssets: Report "CPA Index Fixed Assets";
        Rate: Decimal;
    begin
        if CheckMakeProvision() then begin
            FASetup.GET();
            FASetup.TESTFIELD("Renw.Prov.Deprec. Book Code");
            if LFADepreciationBook.GET("No.", FASetup."Renw.Prov.Deprec. Book Code") then begin
                LFADepreciationBook.CALCFIELDS("Acquisition Cost");
                if (LFADepreciationBook."Acquisition Cost" = 0) and
                   (LFADepreciationBook."Last Depreciation Date" = 0D) then begin
                    LFADepreciationBook.VALIDATE("Depreciation Starting Date", "Replacement Value Appl. Date");
                    LFADepreciationBook.MODIFY();
                    AcquisitionGeneration(true);
                end else begin
                    if LFADepreciationBook."Acquisition Cost" <> 0 then
                        Rate := ("Replacement Value" - LFADepreciationBook."Acquisition Cost") / LFADepreciationBook."Acquisition Cost";
                    LFixedAsset.SETFILTER("No.", "No.");
                    IndexFixedAssets.InitBatch("No.", FASetup."Renw.Prov.Deprec. Book Code", Rate);
                    IndexFixedAssets.USEREQUESTPAGE(false);
                    IndexFixedAssets.SETTABLEVIEW(LFixedAsset);
                    IndexFixedAssets.RUN();
                end;
            end;
        end;
    end;

    procedure GetEcoDeprecYear(): Decimal
    var
        LFADepreciationBook: Record "FA Depreciation Book";
    begin
        FASetup.GET();
        LFADepreciationBook.RESET();
        LFADepreciationBook.SETFILTER("FA No.", "No.");

        case Renewable of
            Renewable::Oui:
                LFADepreciationBook.SETFILTER("Depreciation Book Code", '%1', FASetup."Renewable Deprec. Book Code");
            Renewable::Non:
                LFADepreciationBook.SETFILTER("Depreciation Book Code", '%1', FASetup."Non Renew.Deprec. Book Code");
        end;

        if LFADepreciationBook.FINDLAST() then
            exit(LFADepreciationBook."No. of Depreciation Years")
        else
            exit(0);
    end;

    procedure EconomicExist(): Boolean
    var
        LFADepreciationBook: Record "FA Depreciation Book";
        LDepreciationBook: Record "Depreciation Book";
    begin
        LFADepreciationBook.RESET();
        LFADepreciationBook.SETFILTER("FA No.", "No.");
        if LFADepreciationBook.FINDSET() then
            repeat
                if not LDepreciationBook.GET(LFADepreciationBook."Depreciation Book Code") then
                    LDepreciationBook.INIT();
                if LDepreciationBook.Type = LDepreciationBook.Type::Economic then
                    exit(true);
            until LFADepreciationBook.NEXT() = 0;
        exit(false);
    end;

    procedure EndFALocationGeneration(pSite: Code[20])
    var
        LCopyRec: Record "Fixed Asset";
        LFADepreciationBook: Record "FA Depreciation Book";
        LFALocation: Record "FA Location";
        FAJnlLine: Record "FA Journal Line";
        ACJnlLine: Record "Gen. Journal Line";
        ACJnlTemplate: Record "Gen. Journal Template";
        AcJnlBatch: Record "Gen. Journal Batch";
        FAJnlTemplate: Record "FA Journal Template";
        FaJnlBatch: Record "FA Journal Batch";
        DepreciationBook: Record "Depreciation Book";
        FAJournalSetup: Record "FA Journal Setup";
        FAInsertGLAcc: Codeunit "FA Insert G/L Account";
        FALineNo: Integer;
        ACLineNo: Integer;
        Valid: Boolean;
        FALineNb: Integer;
        ACLineNb: Integer;
        LAmount: Decimal;
        LDate: Date;
        LFlag: Boolean;
    begin

        LCopyRec.SETRANGE(LCopyRec."FA Location Code", pSite);
        FASetup.GET();
        LFALocation.GET(pSite);

        if not CONFIRM('Fin de concession %1 - %2,\Désirez-vous continuer?', false, LFALocation.Code, LFALocation.Name) then
            ERROR('Annulé par l''utilisateur.');

        repeat
            LFADepreciationBook.RESET();
            LFADepreciationBook.SETFILTER("FA No.", LCopyRec."No.");
            if LFADepreciationBook.FINDFIRST() then begin
                LFlag := false;
                repeat
                    if LFADepreciationBook."Disposal Date" > 0D then
                        LFlag := true;
                until LFlag or (LFADepreciationBook.NEXT() = 0);
                if not LFlag then begin
                    LFADepreciationBook.FINDFIRST();
                    repeat

                        FAJournalSetup.SETFILTER("Depreciation Book Code", LFADepreciationBook."Depreciation Book Code");
                        FAJournalSetup.SETFILTER("User ID", USERID);

                        if not FAJournalSetup.FINDFIRST() then
                            FAJournalSetup.SETFILTER("User ID", '');
                        if not FAJournalSetup.FINDFIRST() then
                            ERROR(Text5011, LFADepreciationBook."Depreciation Book Code");

                        if Valid then begin
                            FAJnlLine.RESET();
                            FAJnlLine.SETRANGE("Journal Template Name", FAJournalSetup."FA Jnl. Template Name");
                            FAJnlLine.SETRANGE("Journal Batch Name", FAJournalSetup."FA Jnl. Batch Name");
                            if FAJnlLine.FIND('-') then
                                ERROR(Text5007, FAJournalSetup."FA Jnl. Batch Name");

                            ACJnlLine.RESET();
                            ACJnlLine.SETRANGE("Journal Template Name", FAJournalSetup."Gen. Jnl. Template Name");
                            ACJnlLine.SETRANGE("Journal Batch Name", FAJournalSetup."Gen. Jnl. Batch Name");
                            if ACJnlLine.FIND('-') then
                                ERROR(Text5008, FAJournalSetup."Gen. Jnl. Batch Name");
                        end;
                        FAJnlLine.RESET();
                        FAJnlLine.SETRANGE("Journal Template Name", FAJournalSetup."FA Jnl. Template Name");
                        FAJnlLine.SETRANGE("Journal Batch Name", FAJournalSetup."FA Jnl. Batch Name");
                        FAJnlLine.SETFILTER("FA No.", LCopyRec."No.");
                        FAJnlLine.SETFILTER("Depreciation Book Code", LFADepreciationBook."Depreciation Book Code");
                        if FAJnlLine.FIND('-') then
                            ERROR(Text5012, LCopyRec."No.", FAJournalSetup."FA Jnl. Batch Name");

                        ACJnlLine.RESET();
                        ACJnlLine.SETRANGE("Journal Template Name", FAJournalSetup."Gen. Jnl. Template Name");
                        ACJnlLine.SETRANGE("Journal Batch Name", FAJournalSetup."Gen. Jnl. Batch Name");
                        ACJnlLine.SETFILTER("Account No.", LCopyRec."No.");
                        ACJnlLine.SETFILTER("Depreciation Book Code", LFADepreciationBook."Depreciation Book Code");
                        if ACJnlLine.FIND('-') then
                            ERROR(Text5013, LCopyRec."No.", FAJournalSetup."Gen. Jnl. Batch Name");
                        ACJnlTemplate.GET(FAJournalSetup."Gen. Jnl. Template Name");
                        AcJnlBatch.GET(FAJournalSetup."Gen. Jnl. Template Name", FAJournalSetup."Gen. Jnl. Batch Name");
                        ACJnlLine.RESET();
                        ACJnlLine.LOCKTABLE();
                        ACJnlLine.SETRANGE("Journal Template Name", FAJournalSetup."Gen. Jnl. Template Name");
                        ACJnlLine.SETRANGE("Journal Batch Name", FAJournalSetup."Gen. Jnl. Batch Name");
                        if ACJnlLine.FINDLAST() then
                            ACLineNo := ACJnlLine."Line No."
                        else
                            ACLineNo := 0;

                        FAJnlTemplate.GET(FAJournalSetup."FA Jnl. Template Name");
                        FaJnlBatch.GET(FAJournalSetup."FA Jnl. Template Name", FAJournalSetup."FA Jnl. Batch Name");
                        FaJnlBatch.TESTFIELD("No. Series", '');
                        FAJnlLine.RESET();
                        FAJnlLine.LOCKTABLE();
                        FAJnlLine.SETRANGE("Journal Template Name", FAJournalSetup."FA Jnl. Template Name");
                        FAJnlLine.SETRANGE("Journal Batch Name", FAJournalSetup."FA Jnl. Batch Name");
                        if FAJnlLine.FINDLAST() then
                            FALineNo := FAJnlLine."Line No."
                        else
                            FALineNo := 0;

                        DepreciationBook.GET(LFADepreciationBook."Depreciation Book Code");

                        LAmount := 0;
                        LDate := LFALocation."Concession End Date";

                        if DepreciationBook."G/L Integration - Disposal" then begin
                            ACJnlLine.INIT();
                            ACJnlLine.VALIDATE("Journal Template Name", FAJournalSetup."Gen. Jnl. Template Name");
                            ACJnlLine.VALIDATE("Journal Batch Name", FAJournalSetup."Gen. Jnl. Batch Name");
                            ACLineNo := ACLineNo + 10000;
                            ACJnlLine.VALIDATE("Line No.", ACLineNo);
                            ACJnlLine."Document Type" := ACJnlLine."Document Type"::" ";
                            ACJnlLine."Source Code" := ACJnlTemplate."Source Code";
                            ACJnlLine."Reason Code" := AcJnlBatch."Reason Code";
                            ACJnlLine."Posting No. Series" := AcJnlBatch."Posting No. Series";
                            ACJnlLine."Bal. Account Type" := AcJnlBatch."Bal. Account Type";
                            ACJnlLine.VALIDATE("Bal. Account No.", AcJnlBatch."Bal. Account No.");
                            ACJnlLine.VALIDATE("Account Type", ACJnlLine."Account Type"::"Fixed Asset");
                            ACJnlLine.VALIDATE("Account No.", LCopyRec."No.");
                            ACJnlLine.VALIDATE("Document No.", FASetup."Acquisition Doc No");
                            ACJnlLine.VALIDATE("FA Posting Date", LDate);
                            ACJnlLine.VALIDATE(Description, COPYSTR(('Cession ' + LCopyRec.Description), 1, MAXSTRLEN(ACJnlLine.Description)));
                            ACJnlLine.VALIDATE("FA Posting Type", ACJnlLine."FA Posting Type"::Disposal);
                            ACJnlLine.VALIDATE("Posting Date", LDate);
                            ACJnlLine.VALIDATE(Amount, LAmount);
                            ACJnlLine.VALIDATE("Shortcut Dimension 1 Code", LCopyRec."Global Dimension 1 Code");
                            ACJnlLine.VALIDATE("Depreciation Book Code", LFADepreciationBook."Depreciation Book Code");
                            ACJnlLine.INSERT(true);
                            FAInsertGLAcc.GetBalAcc(ACJnlLine, ACLineNo);
                            ACLineNb += 1;
                        end else begin
                            FAJnlLine.INIT();
                            FAJnlLine.VALIDATE("Journal Template Name", FAJournalSetup."FA Jnl. Template Name");
                            FAJnlLine.VALIDATE("Journal Batch Name", FAJournalSetup."FA Jnl. Batch Name");
                            FAJnlLine.VALIDATE("Document No.", FASetup."Acquisition Doc No");
                            FALineNo := FALineNo + 10000;
                            FAJnlLine.VALIDATE("Line No.", FALineNo);
                            FAJnlLine."Source Code" := FAJnlTemplate."Source Code";
                            FAJnlLine."Reason Code" := FaJnlBatch."Reason Code";
                            FAJnlLine."Posting No. Series" := FaJnlBatch."Posting No. Series";
                            FAJnlLine.VALIDATE("FA No.", LCopyRec."No.");
                            FAJnlLine.VALIDATE("FA Posting Date", LDate);
                            FAJnlLine.VALIDATE(Description, COPYSTR(('Cession ' + LCopyRec.Description), 1, MAXSTRLEN(FAJnlLine.Description)));
                            FAJnlLine.VALIDATE("FA Posting Type", FAJnlLine."FA Posting Type"::Disposal);
                            FAJnlLine.VALIDATE(Amount, LAmount);
                            FAJnlLine.VALIDATE("Shortcut Dimension 1 Code", LCopyRec."Global Dimension 1 Code");
                            FAJnlLine.VALIDATE("Depreciation Book Code", LFADepreciationBook."Depreciation Book Code");
                            FAJnlLine.INSERT(true);
                            FALineNb += 1;
                        end;

                        if Valid then begin
                            ACJnlLine.RESET();
                            ACJnlLine.SETFILTER("Journal Template Name", FAJournalSetup."Gen. Jnl. Template Name");
                            ACJnlLine.SETFILTER("Journal Batch Name", FAJournalSetup."Gen. Jnl. Batch Name");
                            if ACJnlLine.FINDSET() then
                                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", ACJnlLine);
                            ACJnlLine.DELETEALL();

                            FAJnlLine.RESET();
                            FAJnlLine.SETFILTER("Journal Template Name", FAJournalSetup."FA Jnl. Template Name");
                            FAJnlLine.SETFILTER("Journal Batch Name", FAJournalSetup."FA Jnl. Batch Name");
                            if FAJnlLine.FINDSET() then
                                CODEUNIT.RUN(CODEUNIT::"FA Jnl.-Post Batch", FAJnlLine);
                            FAJnlLine.DELETEALL();
                        end;
                    until LFADepreciationBook.NEXT() = 0;
                end;
            end;
        until LCopyRec.NEXT() = 0;
        MESSAGE(Text5010, FALineNb, FAJournalSetup."Gen. Jnl. Batch Name", ACLineNb, FAJournalSetup."FA Jnl. Batch Name");
    end;

    procedure RenewFALocationGeneration(pSite: Code[20])
    var
        lCopyRec: Record "Fixed Asset";
        lFALocation: Record "FA Location";
        lDefaultDim: Record "Default Dimension";
        lDefaultDim2: Record "Default Dimension";
        lFA2: Record "Fixed Asset";
        lFADepreciationBook: Record "FA Depreciation Book";
        SelectionSite: Page "Selection Site";
        lFANo: Code[20];
        lNumberofCopies: Integer;
        lNumDeb: Integer;
        MemDate: Date;
        DateOK: Boolean;
        MemDateSession: Date;
    begin

        lCopyRec.SETRANGE(lCopyRec."FA Location Code", pSite);
        if not lCopyRec.FINDFIRST() then
            ERROR(Text5100, pSite);
        FASetup.GET();
        lFALocation.GET(pSite);
        lFALocation.TESTFIELD("Concession End Date");
        MemDateSession := lFALocation."Concession End Date";
        if SelectionSite.RUNMODAL() = ACTION::OK then
            SelectionSite.GetParam(pSite, lNumDeb)
        else
            ERROR('Annulé par l''utilisateur');

        lFALocation.GET(pSite);

        if lFALocation."Concession Start Date" <> 0D then
            MemDate := lFALocation."Concession Start Date";

        if MemDate = 0D then
            lFALocation.TESTFIELD("Concession Start Date");

        lDefaultDim.LOCKTABLE();
        lCopyRec.LOCKTABLE();

        if lNumDeb >= 0 then
            lFANo := pSite + ExtractInt(FORMAT(lNumDeb), 4, 20 - STRLEN(pSite));

        repeat
            DateOK := false;
            lFADepreciationBook.RESET();
            lFADepreciationBook.SETFILTER("FA No.", lCopyRec."No.");
            if lFADepreciationBook.FINDFIRST() then
                repeat
                    if (lFADepreciationBook."Disposal Date" = MemDateSession) then
                        DateOK := true;
                until (DateOK = true) or (lFADepreciationBook.NEXT() = 0);
            if DateOK then begin
                if lNumDeb < 0 then
                    lFANo := pSite + ExtractInt(lCopyRec."No.", 4, 20 - STRLEN(pSite));
                if lFANo = '' then
                    ERROR(Text5101, lCopyRec."No.", pSite);

                lDefaultDim."Table ID" := DATABASE::"Fixed Asset";
                lDefaultDim."No." := lCopyRec."No.";
                lDefaultDim.SETRANGE("Table ID", DATABASE::"Fixed Asset");
                lDefaultDim.SETRANGE("No.", lCopyRec."No.");
                lDefaultDim2 := lDefaultDim;

                lFA2 := lCopyRec;
                lFA2."No." := '';
                lFA2."Last Date Modified" := 0D;
                lFA2."Main Asset/Component" := lFA2."Main Asset/Component"::" ";
                lFA2."Component of Main Asset" := '';
                lFA2."No." := lFANo;
                lFA2.INSERT(true);
                lFA2.VALIDATE("Acquisition Date", MemDate);
                lFA2.VALIDATE("Purchase Amount", 0);
                lFA2.VALIDATE("In Conncession By", lFA2."In Conncession By"::Concédant);
                lFA2."Attachment Asset" := '';
                lFA2.MODIFY();

                lNumberofCopies += 1;

                if lDefaultDim.FIND('-') then
                    repeat
                        lDefaultDim2 := lDefaultDim;
                        lDefaultDim2."No." := lFA2."No.";
                        lDefaultDim2.INSERT(true);
                    until lDefaultDim.NEXT() = 0;
                if lFA2.FIND() then begin
                    lFA2.VALIDATE("FA Location Code", pSite);
                    if lFA2.FIND() then begin
                        lFA2."Last Date Modified" := 0D;
                        lFA2.MODIFY();
                    end;
                end;
                if lNumDeb >= 0 then
                    lFANo := INCSTR(lFANo);
            end;
        until (lCopyRec.NEXT() = 0);
        MESSAGE(Text5102, lNumberofCopies, pSite);
    end;

    local procedure ExtractInt(pText: Text[20]; pLenMin: Integer; pLenMAx: Integer) result: Text
    var
        lLen: Integer;
    begin
        repeat
            lLen := STRLEN(pText);
            if lLen > 0 then begin
                if COPYSTR(pText, lLen) in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'] then
                    result := COPYSTR(pText, lLen) + result;
                if STRLEN(result) >= pLenMAx then
                    lLen := 0;
                lLen -= 1;
                if lLen > 0 then
                    pText := CopyStr(COPYSTR(pText, 1, lLen), 1, MaxStrLen(pText))
                else
                    lLen := 0;
            end;
        until lLen <= 0;

        while STRLEN(result) < pLenMin do
            result := '0' + result;

        exit(result);
    end;

    var
        Indice: Record Indice;
        Text5000: Label 'Une immo. ne peut etre attachée à elle même', Comment = 'FRA="Une immo. ne peut etre attachée à elle même"';
        Text5001: Label 'Le type de mise en concession ne doit pas etre Autre ', Comment = 'FRA"Le type de mise en concession ne doit pas etre Autre "';
        Text5002: Label 'La ligne loi amortissement %1 existe déja', Comment = 'FRA="La ligne loi amortissement %1 existe déja"';
        Text5003: Label '%1 ligne(s)  loi amortissement existent déjà ', Comment = 'FRA="%1 ligne(s)  loi amortissement existent déjà "';
        Text5004: Label 'pas de ligne loi amortissement à traiter pour Immobilisation %1', Comment = 'FRA="pas de ligne loi amortissement à traiter pour Immobilisation %1"';
        Text5005: Label '%1 ligne(s) loi amortissement sans groupe compta renseigné, Immobilisation %2', Comment = 'FRA="%1 ligne(s) loi amortissement sans groupe compta renseigné, Immobilisation %2"';
        Text5006: Label '%1 ligne(s) loi amortissement avec valeur d aquisition renseignée, Immobilisation %2', Comment = 'FRA="%1 ligne(s) loi amortissement avec valeur d aquisition renseignée, Immobilisation %2"';
        Text5007: Label 'Delete the existing lines in the journal,Cancel Import', Comment = 'FRA="Des lignes existent dans la feuille immobilisation %1"';
        Text5008: Label 'Des lignes existent dans la feuille comptabilisation %1', Comment = 'FRA="Des lignes existent dans la feuille comptabilisation %1"';
        Text5009: Label 'Des écritures comptables existent pour l immobilisation %1 , loi amortissement %2', Comment = 'FRA="Des écritures comptables existent pour l immobilisation %1 , loi amortissement %2"';
        Text5010: Label 'Génération des lignes d''acquisition terminée\ - %1 dans la feuille compta immobilisation %2\ - %3 dans la feuille comptabilisation %4', Comment = 'FRA="Génération des lignes d''acquisition terminée\ - %1 dans la feuille compta immobilisation %2\ - %3 dans la feuille comptabilisation %4"';
        Text5011: Label 'Paramètrage feuilles Immo absent pout la loi %1', Comment = 'FRA="Paramètrage feuilles Immo absent pout la loi %1"';
        Text5012: Label 'Delete the existing lines in the journal,Cancel Import', Comment = 'FRA="Des lignes existent, pour immobilisation %1, dans la feuille immobilisation %2"';
        Text5013: Label 'Des lignes existent, pour iimmobilisation %1, dans la feuille comptabilisation %2', Comment = 'FRA="Des lignes existent, pour iimmobilisation %1, dans la feuille comptabilisation %2"';
        Text5100: Label 'Aucune Immobilisation à copier pour %1', Comment = 'FRA="Aucune Immobilisation à copier pour %1"';
        Text5101: Label 'Erreur Numéritation de %1 pour %2', Comment = 'FRA="Erreur Numéritation de %1 pour %2"';
        Text5102: Label '%1 Immobilisations créées pour la concession %2', Comment = 'FRA="%1 Immobilisations créées pour la concession %2"';
}
