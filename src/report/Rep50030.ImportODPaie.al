namespace Bcsys.CPA.Basics;

using System.IO;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.Dimension;
using Microsoft.Finance.GeneralLedger.Journal;
using Microsoft.Foundation.NoSeries;
using Microsoft.Finance.GeneralLedger.Account;
using System.Utilities;
using Microsoft.Utilities;
report 50030 "Import OD Paie"
{
    ProcessingOnly = true;
    UsageCategory = None;
    ApplicationArea = All;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number)
                                order(ascending)
                                where(Number = const(1));

            trigger OnAfterGetRecord()
            begin
                GLSetup.GET();
                DimensionValue.SETRANGE("Dimension Code", GLSetup."Shortcut Dimension 1 Code");
                GenJournalBatch.GET(JTN, JBN);
                T81.SETRANGE("Journal Template Name", JTN);
                T81.SETRANGE("Journal Batch Name", JBN);
                if T81.FINDLAST() then begin
                    NumLine := T81."Line No.";
                    TypeDoc := T81."Document Type".AsInteger();
                    NoDoc := T81."Document No."
                end else
                    NumLine := 0;
                if ServerFileName = '' then
                    exit;

                CLEAR(tabNomFeuille);
                nbFeuille := LoopSheetsName(ServerFileName);
                if nbFeuille = 0 then
                    exit;

                i := 1;
                while i <= nbFeuille do begin
                    NomFeuille := tabNomFeuille[i];
                    ImportSheetName();
                    i := i + 1;
                end;
            end;

            trigger OnPostDataItem()
            begin
                if (ErrSection = '') and (ErrCompte = '') then
                    MESSAGE(Text007, NbLines)
                else
                    ERROR(Text008 + ' ' + ErrCompte + '\' + Text009 + ' ' + ErrSection);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                field(txtFileNameF; txtFileName)
                {
                    AssistEdit = true;
                    Caption = 'File name', Comment = 'FRA="Nom du Fichier"';
                    ExtendedDatatype = None;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    var
                        Text006: Label 'Importer depuis excel', Comment = 'FRA="Importer depuis excel"';
                        FilterText: Label 'Excel Files (*.xlsx)|*.xlsx|All Files (*.*)|*.*', Comment = 'FRA="Fichiers Excel (*.xlsx)|*.xlsx|Tous les fichiers (*.*)|*.*"';
                        InStream: InStream;
                    begin
                        if txtFileName <> '' then
                            UploadIntoStream(Text006, '', '', txtFileName, InStream)
                        else
                            UploadIntoStream(Text006, '', FilterText, txtFileName, InStream);

                        ServerFileName := CopyStr(txtFileName, 1, MaxStrLen(ServerFileName));
                    end;
                }
                field(JTNF; JTN)
                {
                    Caption = 'Nom modèle feuille comptabilité', Comment = 'FRA="Nom modèle feuille comptabilité"';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GenJournalTemplate.GET(JTN);
                    end;
                }
                field(JBNF; JBN)
                {
                    Caption = 'Nom feuille comptabilité', Comment = 'FRA="Nom feuille comptabilité"';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        GenJournalBatch.GET(JTN, JBN);
                    end;
                }
            }
        }
    }
    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        GLSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        T81: Record "Gen. Journal Line";
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GLAccount: Record "G/L Account";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        InStream: InStream;
        txtFileName: Text;
        NomFeuille: Text;
        ServerFileName: Text[250];
        tabNomFeuille: array[30] of Text;
        nbFeuille: Integer;
        i: Integer;
        varCell: Text[150];
        Text001: Label 'Le nom du fichier est vide !', Comment = 'FRA="Le nom du fichier est vide !"';
        Text002: Label 'Aucune Feuille à traiter sur ce fichier !', Comment = 'FRA="Aucune Feuille à traiter sur ce fichier !"';
        MemRow: Integer;
        JTN: Code[20];
        JBN: Code[20];
        NumLine: Integer;
        FirstLine: Integer;
        LastCol: Integer;
        Mt: Decimal;
        Section: Code[20];
        SectionImp: Code[20];
        NbLines: Integer;
        Text007: Label '%1 lignes importées.', Comment = 'FRA="%1 lignes importées."';
        TypeDoc: Integer;
        NoDoc: Code[20];
        ErrSection: Text;
        ErrCompte: Text;
        Text008: Label 'Comptes inexstants :', Comment = 'FRA="Comptes inexstants :"';
        Text009: Label 'Sections inexistantes :', Comment = 'FRA="Sections inexistantes :"';

    procedure LoopSheetsName(FileName: Text): Integer
    var
        TempNameValueBufferOut: Record "Name/Value Buffer" temporary;
        SheetName: Text[250];
        SheetsList: Text[250];
        j: Integer;
    begin

        if FileName = '' then
            ERROR(Text001);
        TempNameValueBufferOut.DeleteAll();
        TempExcelBuffer.GetSheetsNameListFromStream(InStream, TempNameValueBufferOut);

        Clear(j);
        Clear(i);
        if not TempNameValueBufferOut.IsEmpty then
            repeat
                SheetName := TempNameValueBufferOut.Value;
                if (TempNameValueBufferOut.Value <> '') and (STRLEN(SheetsList) + STRLEN(SheetName) < 250) then begin
                    j += 1;
                    tabNomFeuille[j] := SheetName;
                end;
                i := i + 1;
            until TempNameValueBufferOut.Next() = 0;

        if j = 0 then
            MESSAGE(Text002);

        exit(j);
    end;

    local procedure ImportSheetName()
    begin
        MemRow := 0;
        FirstLine := 999999999;
        CLEAR(T81);
        T81.INIT();

        TempExcelBuffer.OpenBookStream(Instream, NomFeuille);
        TempExcelBuffer.ReadSheet();
        if TempExcelBuffer.FINDFIRST() then
            repeat
                varCell := CopyStr(TempExcelBuffer."Cell Value as Text", 1, MaxStrLen(varCell));
                if TempExcelBuffer."Row No." >= FirstLine then begin
                    if varCell <> '' then begin
                        if MemRow <> TempExcelBuffer."Row No." then begin
                            MemRow := TempExcelBuffer."Row No.";
                            InitRow();
                        end;
                        case TempExcelBuffer."Column No." of
                            1:

                                T81."Source Code" := CopyStr(varCell, 1, MaxStrLen(T81."Source Code"));
                            2:
                                begin
                                    EVALUATE(T81."Posting Date", varCell);
                                    T81.VALIDATE("Posting Date");
                                end;
                            3:

                                if GLAccount.GET(varCell) then
                                    T81.VALIDATE("Account No.", varCell)
                                else
                                    if STRPOS(ErrCompte, varCell + ';') = 0 then
                                        ErrCompte := ErrCompte + varCell + ';';
                            4:
                                begin
                                    if not DimensionValue.GET(GLSetup."Shortcut Dimension 1 Code", varCell) then
                                        SectionImp := CopyStr(DELCHR(UPPERCASE(varCell)), 1, MaxStrLen(SectionImp));
                                    if DimensionValue.FINDFIRST() then begin
                                        repeat
                                            if DELCHR(UPPERCASE(DimensionValue.Name)) = SectionImp then
                                                Section := DimensionValue.Code;
                                        until (Section <> '') or (DimensionValue.NEXT() = 0);
                                        if Section <> '' then
                                            T81.VALIDATE("Shortcut Dimension 1 Code", Section)
                                        else
                                            if STRPOS(ErrSection, varCell + ';') = 0 then
                                                ErrSection := ErrSection + varCell + ';';
                                    end else
                                        T81.VALIDATE("Shortcut Dimension 1 Code", varCell);
                                end;
                            5:

                                T81.Description := 'Paie ' + FORMAT(T81."Posting Date", 0, '<Month,2>/<Year4>');
                            6:
                                begin
                                    EVALUATE(Mt, varCell);
                                    if Mt <> 0 then
                                        T81.VALIDATE("Debit Amount", Mt);
                                end;
                            7:
                                begin
                                    EVALUATE(Mt, varCell);
                                    if Mt <> 0 then
                                        T81.VALIDATE("Credit Amount", Mt);
                                end;
                        end;
                    end;
                    if TempExcelBuffer."Column No." = LastCol then
                        ValidRow();
                end else begin
                    if UPPERCASE(DELCHR(varCell)) = UPPERCASE('CODEJOURNAL') then
                        FirstLine := TempExcelBuffer."Row No." + 1;
                    if TempExcelBuffer."Column No." > LastCol then
                        LastCol := TempExcelBuffer."Column No.";
                end;
            until TempExcelBuffer.NEXT() = 0;
        TempExcelBuffer.CloseBook();
    end;

    local procedure InitRow()
    begin
        T81.INIT();
        T81."Journal Template Name" := CopyStr(JTN, 1, MaxStrLen(T81."Journal Template Name"));
        T81."Journal Batch Name" := CopyStr(JBN, 1, MaxStrLen(T81."Journal Batch Name"));
        NumLine += 10000;
        T81."Line No." := NumLine;
        T81."Document Type" := TypeDoc;
        T81."Account Type" := T81."Account Type"::"G/L Account";
        T81.INSERT(true);
    end;

    local procedure ValidRow()
    begin
        if (ErrSection = '') and (ErrCompte = '') then begin
            if (T81."Account No." <> '') or (T81.Amount <> 0) then
                if (NoDoc = '') and (GenJournalBatch."No. Series" <> '') then begin
                    CLEAR(NoSeriesMgt);
                    if T81."Posting Date" <> 0D then
                        NoDoc := NoSeriesMgt.GetNextNo(GenJournalBatch."No. Series", T81."Posting Date", false)
                    else
                        NoDoc := NoSeriesMgt.GetNextNo(GenJournalBatch."No. Series", WORKDATE(), false);
                end;
            if NoDoc <> '' then
                T81.VALIDATE("Document No.", NoDoc);
            T81.MODIFY();
            NbLines += 1;
        end;
    end;

    procedure SetParam(Modele_P: Code[20]; Feuille_P: Code[20])
    begin
        JTN := Modele_P;
        JBN := Feuille_P;
    end;
}
