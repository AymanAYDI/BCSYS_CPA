/*// l'etazt 50020 n'est pas utilisé dans nav car la lecture du fichier n'est pas fonctionelle
namespace Bcsys.CPA.Basics;

using Microsoft.Finance.GeneralLedger.Posting;
using Microsoft.FixedAssets.Posting;
using Microsoft.Finance.GeneralLedger.Setup;
using System.Security.User;
using System.IO;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.FixedAssets.Journal;
using Microsoft.FixedAssets.FixedAsset;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.FixedAssets.Ledger;
using System.Utilities;
report 50020 "Acquisition Import"
{
    Caption = 'Acquisition Import', Comment = 'FRA="Acquisition Import"';
    ProcessingOnly = true;
    UsageCategory = None;
    ApplicationArea = All;

    dataset
    {
        dataitem(Integer; Integer)
        {
            trigger OnAfterGetRecord()
            begin
                Fic.TEXTMODE(true);
                if Fic.OPEN(FileName) then begin
                    repeat
                        Fic.Open(TextLine);
                        if STRLEN(TextLine) > 0 then begin
                            NbRecu += 1;
                            TextLine := PADSTR(TextLine, 200);
                            GFANo := CopyStr(Oteb(CopyStr(COPYSTR(TextLine, 1, STRPOS(TextLine, GSep) - 1), 1, 500)), 1, MaxStrLen(GFANo));
                            if GFANo <> 'XXXXX' then begin
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                EVALUATE(GDate, (FormatDate(CopyStr(COPYSTR(TextLine, 1, STRPOS(TextLine, GSep) - 1), 1, 500))));
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                GDepreciationBookCode := CopyStr(Oteb(CopyStr(COPYSTR(TextLine, 1, STRPOS(TextLine, GSep) - 1), 1, 500)), 1, MaxStrLen(GDepreciationBookCode));
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                GAcquisition := ConvDec(CopyStr(COPYSTR(TextLine, 1, STRPOS(TextLine, GSep) - 1), 1, 30));
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                GAmortissement := ConvDec(CopyStr(COPYSTR(TextLine, 1, STRPOS(TextLine, GSep) - 1), 1, 30));
                                TextLine := COPYSTR(TextLine, STRPOS(TextLine, GSep) + 1, 200);
                                if STRPOS(TextLine, GSep) <> 0 then
                                    GAchat := ConvDec(CopyStr(COPYSTR(TextLine, 1, STRPOS(TextLine, GSep) - 1), 1, 30))
                                else
                                    GAchat := ConvDec(COPYSTR(TextLine, 1, 20));

                                if not DepreciationBook.GET(GDepreciationBookCode) then
                                    ERROR(Text040, GDepreciationBookCode);

                                if not FixedAsset.GET(GFANo) then
                                    ERROR(Text001, GFANo);

                                if (GImportType = GImportType::Amortissement) and (DepreciationBook."G/L Integration - Depreciation") or
                                   (GImportType = GImportType::Acquisition) and (DepreciationBook."G/L Integration - Acq. Cost") then begin
                                    ACJnlLine.INIT();
                                    ACJnlLine.VALIDATE("Journal Template Name", GenJournalTemplate.Name);
                                    ACJnlLine.VALIDATE("Journal Batch Name", JnlACBatchName);
                                    ACLineNo := ACLineNo + 10000;
                                    ACJnlLine.VALIDATE("Line No.", ACLineNo);
                                    ACJnlLine."Document Type" := ACJnlLine."Document Type"::Payment;
                                    ACJnlLine."Source Code" := ACJnlTemplate."Source Code";
                                    ACJnlLine."Reason Code" := AcJnlBatch."Reason Code";
                                    ACJnlLine."Posting No. Series" := AcJnlBatch."Posting No. Series";
                                    ACJnlLine."Bal. Account Type" := AcJnlBatch."Bal. Account Type";
                                    ACJnlLine.VALIDATE("Bal. Account No.", AcJnlBatch."Bal. Account No.");
                                    ACJnlLine.VALIDATE("Account Type", ACJnlLine."Account Type"::"Fixed Asset");
                                    ACJnlLine.VALIDATE("Account No.", GFANo);
                                    ACJnlLine.VALIDATE("Document No.", GLDocNo);
                                    case GImportType of
                                        GImportType::Acquisition:
                                            begin
                                                ACJnlLine.VALIDATE("FA Posting Date", GDate);
                                                ACJnlLine.VALIDATE(Description, COPYSTR(('Achat ' + FixedAsset.Description), 1, MAXSTRLEN(ACJnlLine.Description)));
                                                ACJnlLine.VALIDATE("FA Posting Type", ACJnlLine."FA Posting Type"::"Acquisition Cost");
                                            end;
                                        GImportType::Amortissement:
                                            begin
                                                ACJnlLine.VALIDATE("FA Posting Date", PostingDate);
                                                ACJnlLine.VALIDATE(Description, COPYSTR(('Amort. ' + FixedAsset.Description), 1, MAXSTRLEN(ACJnlLine.Description)));
                                                ACJnlLine.VALIDATE("FA Posting Type", ACJnlLine."FA Posting Type"::Depreciation);
                                            end;
                                    end;
                                    ACJnlLine.VALIDATE("Posting Date", ACJnlLine."FA Posting Date");
                                    ACJnlLine.VALIDATE(Amount, GAchat);
                                    ACJnlLine.VALIDATE("Shortcut Dimension 1 Code", FixedAsset."Global Dimension 1 Code");
                                    ACJnlLine.VALIDATE("Depreciation Book Code", GDepreciationBookCode);
                                    ACJnlLine.INSERT(true);
                                    if BalAccount then
                                        FAInsertGLAcc.GetBalAcc(ACJnlLine, ACLineNo);
                                end else begin
                                    FAJnlLine.INIT();
                                    FAJnlLine.VALIDATE("Journal Template Name", FAJournalTemplate.Name);
                                    FAJnlLine.VALIDATE("Journal Batch Name", JnlFABatchName);
                                    FAJnlLine.VALIDATE("Document No.", GLDocNo);
                                    FALineNo := FALineNo + 10000;
                                    FAJnlLine.VALIDATE("Line No.", FALineNo);

                                    FAJnlLine."Source Code" := FAJnlTemplate."Source Code";
                                    FAJnlLine."Reason Code" := FaJnlBatch."Reason Code";
                                    FAJnlLine."Posting No. Series" := FaJnlBatch."Posting No. Series";

                                    FAJnlLine.VALIDATE(FAJnlLine."FA No.", GFANo);
                                    case GImportType of
                                        GImportType::Acquisition:
                                            begin
                                                FAJnlLine.VALIDATE("FA Posting Date", GDate);
                                                FAJnlLine.VALIDATE(Description, COPYSTR(('Achat ' + FixedAsset.Description), 1, MAXSTRLEN(FAJnlLine.Description)));
                                                FAJnlLine.VALIDATE("FA Posting Type", FAJnlLine."FA Posting Type"::"Acquisition Cost");
                                            end;
                                        GImportType::Amortissement:
                                            begin
                                                FAJnlLine.VALIDATE("FA Posting Date", PostingDate);
                                                FAJnlLine.VALIDATE(Description, COPYSTR(('Amort. ' + FixedAsset.Description), 1, MAXSTRLEN(FAJnlLine.Description)));
                                                FAJnlLine.VALIDATE("FA Posting Type", FAJnlLine."FA Posting Type"::Depreciation);
                                            end;
                                    end;
                                    FAJnlLine.VALIDATE(Amount, GAchat);
                                    FAJnlLine.VALIDATE("Shortcut Dimension 1 Code", FixedAsset."Global Dimension 1 Code");
                                    FAJnlLine.VALIDATE("Depreciation Book Code", GDepreciationBookCode);
                                    FAJnlLine.INSERT(true);
                                end;
                                NTraité += 1;
                            end;
                        end;
                    until (TextLine = '');
                    Fic.CLOSE;
                end;
            end;

            trigger OnPostDataItem()
            begin

                if Valid then begin
                    ACJnlLine.RESET();
                    ACJnlLine.SETFILTER("Journal Template Name", GenJournalTemplate.Name);
                    ACJnlLine.SETFILTER("Journal Batch Name", JnlACBatchName);
                    if ACJnlLine.FINDSET() then
                        CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", ACJnlLine);
                    ACJnlLine.DELETEALL();

                    FAJnlLine.RESET();
                    FAJnlLine.SETFILTER("Journal Template Name", FAJournalTemplate.Name);
                    FAJnlLine.SETFILTER("Journal Batch Name", JnlFABatchName);
                    if FAJnlLine.FINDSET() then
                        CODEUNIT.RUN(CODEUNIT::"FA Jnl.-Post Batch", FAJnlLine);
                    FAJnlLine.DELETEALL();
                end;
            end;

            trigger OnPreDataItem()
            var
                GLSetup: Record "General Ledger Setup";
                UserSetup: Record "User Setup";
                AllowPostingFrom: Date;
                AllowPostingTo: Date;
            begin

                GSep := ';';

                if GImportType = GImportType::Amortissement then begin
                    GLSetup.GET();
                    if UserSetup.GET(USERID) then begin
                        AllowPostingFrom := UserSetup."Allow Posting From";
                        AllowPostingTo := UserSetup."Allow Posting To";
                    end;
                    if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
                        AllowPostingFrom := GLSetup."Allow Posting From";
                        AllowPostingTo := GLSetup."Allow Posting To";
                    end;
                    if AllowPostingTo = 0D then
                        AllowPostingTo := 99991231D;

                    if (PostingDate < AllowPostingFrom) or (PostingDate > AllowPostingTo) then
                        ERROR(Text041);
                end;

                if not CONFIRM(Text023, false)
                   then
                    CurrReport.QUIT();

                ACJnlLine."Journal Template Name" := GenJournalTemplate.Name;
                ACJnlLine."Journal Batch Name" := JnlACBatchName;
                ACJnlTemplate.GET(ACJnlLine."Journal Template Name");
                AcJnlBatch.GET(ACJnlLine."Journal Template Name", ACJnlLine."Journal Batch Name");
                if ACLineNo = 0 then begin
                    ACJnlLine.LOCKTABLE();
                    ACJnlLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
                    ACJnlLine.SETRANGE("Journal Batch Name", JnlACBatchName);
                    if ACJnlLine.FIND('+') then
                        ACLineNo := ACJnlLine."Line No.";
                    ACLineNo := 0;
                end;

                FAJnlLine."Journal Template Name" := FAJournalTemplate.Name;
                FAJnlLine."Journal Batch Name" := JnlFABatchName;
                FAJnlTemplate.GET(FAJnlLine."Journal Template Name");
                FaJnlBatch.GET(FAJnlLine."Journal Template Name", FAJnlLine."Journal Batch Name");
                if FALineNo = 0 then begin
                    FAJnlLine.LOCKTABLE();
                    FAJnlLine.SETRANGE("Journal Template Name", FAJournalTemplate.Name);
                    FAJnlLine.SETRANGE("Journal Batch Name", JnlFABatchName);
                    if FAJnlLine.FIND('+') then
                        FALineNo := FAJnlLine."Line No.";
                    FALineNo := 0;
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options', Comment = 'FRA="Options"';
                    field(FileName; FileName)
                    {
                        Caption = 'File Name', Comment = 'FRA="Nom du fichier"';
                        Visible = FileNameVisible;
                        ApplicationArea = All;

                        trigger OnAssistEdit()
                        begin
                            ReadFromFile(FileName);
                        end;
                    }
                    field(GLDocNo; GLDocNo)
                    {
                        Caption = 'N°du Document', Comment = 'FRA="N°du Document"';
                        ApplicationArea = All;
                    }
                    field(GImportType; GImportType)
                    {
                        Caption = 'Iimport type', Comment = 'FRA="Type d''import"';
                        ApplicationArea = All;
                    }
                    field(JnlACBatchName; JnlACBatchName)
                    {
                        Caption = 'General Journal Batche', Comment = 'FRA="Nom feuille comptabilité"';
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            GenJournalBatch: Record "Gen. Journal Batch";
                            GeneralJournalBatches: Page "General Journal Batches";
                        begin

                            CLEAR(GeneralJournalBatches);
                            GenJournalBatch.RESET();
                            GenJournalBatch.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
                            GeneralJournalBatches.SETTABLEVIEW(GenJournalBatch);
                            GeneralJournalBatches.LOOKUPMODE := true;
                            if GeneralJournalBatches.RUNMODAL() = ACTION::LookupOK then begin
                                GeneralJournalBatches.GETRECORD(GenJournalBatch);
                                JnlACBatchName := GenJournalBatch.Name;
                            end;
                        end;
                    }
                    field(JnlFABatchName; JnlFABatchName)
                    {
                        Caption = 'FA Batch Name', Comment = 'FRA="Nom feuille immobilisation"';
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            FAJnlBatch: Record "FA Journal Batch";
                            FAJnlBatches: Page "FA Journal Batches";
                        begin

                            CLEAR(FAJnlBatches);
                            FAJnlBatch.RESET();
                            FAJnlBatch.SETRANGE("Journal Template Name", FAJournalTemplate.Name);
                            FAJnlBatches.SETTABLEVIEW(FAJnlBatch);
                            FAJnlBatches.LOOKUPMODE := true;
                            if FAJnlBatches.RUNMODAL() = ACTION::LookupOK then begin
                                FAJnlBatches.GETRECORD(FAJnlBatch);
                                JnlFABatchName := FAJnlBatch.Name;
                            end;
                        end;
                    }
                    field(PostingDate; PostingDate)
                    {
                        Caption = 'Date comptabilisation', Comment = 'FRA="Date comptabilisation"';
                        ApplicationArea = All;
                    }
                    field(BalAccount; BalAccount)
                    {
                        Caption = 'Insert Bal. Account', Comment = 'FRA="Insérer compte contrepartie"';
                        ApplicationArea = All;
                    }
                    field(CheckJnl; CheckJnl)
                    {
                        Caption = 'Check Journals', Comment = 'FRA="Vérifier feuilles de saisie"';
                        ApplicationArea = All;
                    }
                    field(Valid; Valid)
                    {
                        Caption = 'Validation automatique', Comment = 'FRA="Validation automatique"';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    var
        GenJournalTemplate: Record "Gen. Journal Template";
        ACJnlLine: Record "Gen. Journal Line";
        ACJnlTemplate: Record "Gen. Journal Template";
        AcJnlBatch: Record "Gen. Journal Batch";
        FAJournalTemplate: Record "FA Journal Template";
        FAJnlLine: Record "FA Journal Line";
        FAJnlTemplate: Record "FA Journal Template";
        FaJnlBatch: Record "FA Journal Batch";
        FixedAsset: Record "Fixed Asset";
        DepreciationBook: Record "Depreciation Book";
        FAInsertGLAcc: Codeunit "FA Insert G/L Account";
        Fic: File;
        FileName: Text[250];
        TextLine: Text[250];
        JnlACBatchName: Code[10];
        JnlFABatchName: Code[10];
        PostingDate: Date;
        GImportType: Enum GImportType;
        GLDocNo: Code[20];
        CheckJnl: Boolean;
        FileNameVisible: Boolean;
        GFANo: Code[20];
        GDate: Date;
        GAcquisition: Decimal;
        GAmortissement: Decimal;
        GAchat: Decimal;
        GDepreciationBookCode: Code[10];
        GSep: Text[1];
        FALineNo: Integer;
        ACLineNo: Integer;
        Valid: Boolean;
        NbRecu: Integer;
        "NTraité": Integer;
        BalAccount: Boolean;
        Text001: Label 'Fixe Asset  %1 not found', Comment = 'FRA="Immobilisation %1 non trouvé "';
        Text023: Label 'Do you want to update ?', Comment = 'FRA="Souhaitez vous mettre à jour  ?"';
        Text031: Label 'Import from Text File', Comment = 'FRA="Import à partir d''un fichier texte"';
        Text035: Label 'XML Files (*.xml)|*.xml|All Files (*.*)|*.*', Comment = 'FRA="Fichiers XML (*.xml)|*.xml|Tous les fichiers (*.*)|*.*"';
        Text1000000003: Label 'Delete the existing lines in the journal,Cancel Import', Comment = 'FRA="Supprimer les lignes existantes dans la feuille immobilisation,Arrêter l''import"';
        Text1000000004: Label 'Supprimer les lignes existantes dans la feuille comptabilisation,Arrêter l''import', Comment = 'FRA="Supprimer les lignes existantes dans la feuille comptabilisation,Arrêter l''import"';
        Text040: Label 'Dépraciation book  %1 missing', Comment = 'FRA="Loi d amortisement %1 inconnue"';
        Text041: Label 'Date de comptabilisation non valide', Comment = 'FRA="Date de comptabilisation non valide"';

    procedure ReadFromFile(var FileName2: Text[1024])
    var
        NewFileName: Text[1024];
    begin
        if not (UPLOAD(Text031, '', Text035, FileName2, NewFileName))
          then
            NewFileName := '';

        if NewFileName <> '' then
            FileName2 := NewFileName;
    end;

    procedure ConvDec(Texo: Text[30]) ValDec: Decimal
    var
        Po: Integer;
        P1: Integer;
    begin
        Texo := CopyStr(Oteb(Texo), 1, MaxStrLen(Texo));
        ValDec := 0;
        if Texo = ''
           then
            exit;
        Po := STRPOS(Texo, '.');
        P1 := STRPOS(Texo, ',');
        if not EVALUATE(ValDec, '0.01')
           then
            if Po > 0
            then
                Texo[Po] := ',';
        if not EVALUATE(ValDec, '0,01')
           then
            if P1 > 0
            then
                Texo[P1] := '.';

        EVALUATE(ValDec, Texo);
    end;

    procedure Oteb(Texo: Text[500]): Text[500]
    begin
        Texo := DELCHR(Texo, '<>', ' ');
        exit(Texo);
    end;

    procedure CheckACFAJnl()
    var
        Sel: Integer;
    begin

        FAJnlLine.RESET();
        FAJnlLine.SETRANGE("Journal Template Name", FAJournalTemplate.Name);
        FAJnlLine.SETRANGE("Journal Batch Name", JnlFABatchName);
        if FAJnlLine.FIND('-') then
            Sel := STRMENU(Text1000000003, 2);

        case Sel of
            2:
                CurrReport.QUIT();
            1:
                begin
                    FAJnlLine.RESET();
                    FAJnlLine.SETRANGE("Journal Template Name", FAJournalTemplate.Name);
                    FAJnlLine.SETRANGE("Journal Batch Name", JnlFABatchName);
                    FAJnlLine.DELETEALL();
                end;
        end;

        ACJnlLine.RESET();
        ACJnlLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
        ACJnlLine.SETRANGE("Journal Batch Name", JnlACBatchName);
        if ACJnlLine.FIND('-') then
            Sel := STRMENU(Text1000000004, 2);

        case Sel of
            2:
                CurrReport.QUIT();
            1:
                begin
                    ACJnlLine.RESET();
                    ACJnlLine.SETRANGE("Journal Template Name", GenJournalTemplate.Name);
                    ACJnlLine.SETRANGE("Journal Batch Name", JnlACBatchName);
                    ACJnlLine.DELETEALL();
                end;
        end;
    end;

    procedure FormatDate(Texo: Text[500]): Text[500]
    begin
        Texo := (COPYSTR(Texo, 1, 2) + COPYSTR(Texo, 4, 2) + COPYSTR(Texo, 7, 4));
        exit(Texo);
    end;

    procedure FormatDate2(Ldate: Date): Text[6]
    var
        LDatex: Text[10];
    begin
        LDatex := FORMAT(Ldate);

        exit(COPYSTR(LDatex, 7, 2) + COPYSTR(LDatex, 4, 2) + COPYSTR(LDatex, 1, 2));
    end;
}
*/