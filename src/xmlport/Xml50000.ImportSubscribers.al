namespace Bcsys.CPA.Basics;

using Microsoft.Finance.GeneralLedger.Journal;
xmlport 50000 "Import Subscribers"
{
    Caption = 'Import Subscribers', Comment = 'FRA="Import abonnées"';
    Direction = Import;
    Format = Xml;
    FormatEvaluate = Xml;
    UseRequestPage = false;

    schema
    {
        textelement(exportcompta)
        {
            XmlName = 'ExportCompta';
            textelement(debut)
            {
            }
            textelement(fin)
            {
                trigger OnAfterAssignVariable()
                begin
                    if STRLEN(fin) > 10 then begin
                        EVALUATE(G_Datetime, fin);
                        G_PostingDate := DT2DATE(G_Datetime);
                    end else
                        EVALUATE(G_PostingDate, fin);
                end;
            }
            textelement(Details)
            {
                tableelement("Gen. Journal Line"; "Gen. Journal Line")
                {
                    XmlName = 'PROC_ExportCompta';
                    textelement(Parc)
                    {
                        trigger OnAfterAssignVariable()
                        begin
                            EVALUATE(G_AccountNo, Parc);
                        end;
                    }
                    textelement(Produit)
                    {
                        trigger OnAfterAssignVariable()
                        begin
                            EVALUATE(G_BalAccountNo, Produit);
                        end;
                    }
                    textelement(Quantite)
                    {
                    }
                    textelement(Total_TTC)
                    {
                        trigger OnAfterAssignVariable()
                        begin
                            Replace(Total_TTC, '.', ',');
                            EVALUATE(G_DebitAmount, Total_TTC);
                        end;
                    }
                    textelement(Total_HT)
                    {
                    }
                    textelement(Montant_TVA)
                    {
                    }
                    textelement(Type)
                    {
                        trigger OnAfterAssignVariable()
                        begin
                            if (Type = 'H') or (Type = 'F') then
                                "Gen. Journal Line".VALIDATE("Document Type", "Gen. Journal Line"."Document Type"::Invoice);
                            if Type = 'A' then
                                "Gen. Journal Line".VALIDATE("Document Type", "Gen. Journal Line"."Document Type"::"Credit Memo");
                        end;
                    }

                    trigger OnAfterInitRecord()
                    begin
                        "Gen. Journal Line".VALIDATE("Journal Template Name", G_GenJnlTemplate.Name);
                        "Gen. Journal Line".VALIDATE("Journal Batch Name", G_GenJnlBatch.Name);
                        "Gen. Journal Line".VALIDATE("Source Code", G_GenJnlTemplate."Source Code");

                        G_GenJnlLine.RESET();
                        G_GenJnlLine.SETRANGE("Journal Template Name", G_GenJnlTemplate.Name);
                        G_GenJnlLine.SETRANGE("Journal Batch Name", G_GenJnlBatch.Name);
                        G_GenJnlLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
                        if G_GenJnlLine.FINDLAST() then
                            G_LineNo := G_GenJnlLine."Line No.";
                        G_LineNo += 10000;

                        "Gen. Journal Line"."Line No." := G_LineNo;
                        "Gen. Journal Line".VALIDATE("Account Type", "Gen. Journal Line"."Account Type"::Customer);
                        "Gen. Journal Line".VALIDATE("Bal. Account Type", "Gen. Journal Line"."Bal. Account Type"::"G/L Account");
                    end;

                    trigger OnBeforeInsertRecord()
                    begin
                        "Gen. Journal Line".VALIDATE("Posting Date", G_PostingDate);
                        "Gen. Journal Line".VALIDATE("Account No.", G_AccountNo);
                        "Gen. Journal Line".VALIDATE("Bal. Account No.", G_BalAccountNo);
                        "Gen. Journal Line".VALIDATE(Amount, G_DebitAmount);
                        "Gen. Journal Line".Description := CopyStr(STRSUBSTNO('%1%2%3', "Gen. Journal Line".Description, ' - ', FORMAT(G_PostingDate)), 1, MaxStrLen("Gen. Journal Line".Description));
                    end;
                }
            }
        }
    }

    trigger OnPreXmlPort()
    begin
        G_GenJnlLine.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
        G_GenJnlLine.SETRANGE("Journal Template Name", G_GenJnlTemplate.Name);
        G_GenJnlLine.SETRANGE("Journal Batch Name", G_GenJnlBatch.Name);

        if G_GenJnlLine.FINDLAST() then begin
            if CONFIRM(Text50000) then
                G_LineNo := G_GenJnlLine."Line No."
            else
                ERROR(Text50001);
        end
        else
            G_LineNo := 0;
    end;

    var
        G_GenJnlTemplate: Record "Gen. Journal Template";
        G_GenJnlBatch: Record "Gen. Journal Batch";
        G_GenJnlLine: Record "Gen. Journal Line";
        G_LineNo: Integer;
        G_PostingDate: Date;
        G_AccountNo: Code[20];
        G_BalAccountNo: Code[20];
        G_DebitAmount: Decimal;
        Text50000: Label 'Warning, The Chosen Sales Sheet is Not Empty. Would You Like to Add Subscribesr Lines to Existing Lines?', Comment = 'FRA="Attention, la feuille vente choisie n''est pas vide. Souhaitez vous ajouter des lignes d''abonées aux lignes existantes ?"';
        Text50001: Label 'Interrupted Treatment.', Comment = 'FRA="Traitement interrompu."';
        G_Datetime: DateTime;

    procedure InitJournalTemplate(P_TemplateJnl: Code[10]; P_BatchName: Code[10])
    begin
        G_GenJnlTemplate.GET(P_TemplateJnl);
        G_GenJnlBatch.GET(P_TemplateJnl, P_BatchName);
    end;

    local procedure Replace(var String: Text; FindWhat: Text; ReplaceWith: Text)
    begin
        while STRPOS(String, FindWhat) > 0 do
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
    end;
}
