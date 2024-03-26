namespace Bcsys.CPA.Basics;

using System.IO;
using Microsoft.Sales.Customer;
using Microsoft.Inventory.Item;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.Dimension;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;
using Microsoft.CRM.Team;
using Microsoft.Utilities;
page 50004 "Integration Factures Ventes CA"
{
    Caption = 'Integration Factures Ventes CA', Comment = 'FRA="Intégration Factures Ventes Caisse Automatique"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Intégration facture vente";
    SourceTableTemporary = true;
    UsageCategory = Tasks;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group("Choisir Fichier")
            {
                Caption = 'Chose File', Comment = 'FRA="Fichier à importer"';
                Editable = false;
                field(txtFileName; txtFileName)
                {
                    AssistEdit = true;
                    Caption = 'File name', Comment = 'FRA="Nom du Fichier"';
                    ExtendedDatatype = None;

                    trigger OnAssistEdit()
                    var
                        Text006: Label 'Importer depuis excel', Comment = 'FRA="Importer depuis excel"';
                        FilterText: Label 'Excel Files (*.xlsx)|*.xlsx|All Files (*.*)|*.*', Comment = 'FRA="Fichiers Excel (*.xlsx)|*.xlsx|Tous les fichiers (*.*)|*.*"';
                    begin

                        if txtFileName <> '' then
                            UploadIntoStream(Text006, '', '', txtFileName, Instream)
                        else
                            UploadIntoStream(Text006, '', FilterText, txtFileName, InStream);

                        ServerFileName := CopyStr(txtFileName, 1, MaxStrLen(ServerFileName));
                    end;
                }
            }
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                }
                field(Parc; Rec.Parc)
                {
                }
                field("Fin Période"; Rec."Fin Période")
                {
                }
                field("Type Borne"; Rec."Type Borne")
                {
                }
                field("Total Fin"; Rec."Total Fin")
                {
                }
                field(invoiceNo; Rec.invoiceNo)
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Client; Rec.Client)
                {
                }
                field("Type Equipement"; Rec."Type Equipement")
                {
                }
                field("Date Facture"; Rec."Date Facture")
                {
                }
                field(Article; Rec.Article)
                {
                }
                field(Designation; Rec.Designation)
                {
                }
                field("Montant TTC"; Rec."Montant TTC")
                {
                }
                field("Axe Analytique"; Rec."Axe Analytique")
                {
                }
                field(Erreur; Rec.Erreur)
                {
                    Style = Attention;
                    StyleExpr = true;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Excel)
            {
                Caption = 'Excel', Comment = 'FRA="Excel"';
                action("Import Prestations")
                {
                    Caption = 'Importer', Comment = 'FRA="Importer"';
                    Image = Import;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if ServerFileName = '' then
                            exit;

                        checkFindInvoice();

                        CLEAR(tabNomFeuille);
                        nbFeuille := LoopSheetsName(ServerFileName);
                        if nbFeuille = 0 then
                            exit;

                        i := 1;
                        numRec := 0;
                        while i <= nbFeuille do begin
                            NomFeuille := tabNomFeuille[i];
                            ImportSheetNameNew();
                            i := i + 1;
                        end;

                        nbErr := 0;
                        checkData();
                        if nbErr > 0 then begin
                            CurrPage.UPDATE(false);
                            MESSAGE(Text005);
                        end else begin
                            COMMIT();
                            createInvoice();
                            MESSAGE(TextFacture);
                        end;
                    end;
                }
            }
        }
    }

    var
        salesInvoiceLine: Record "Sales Invoice Line";
        salesInvoiceHdr: Record "Sales Invoice Header";
        salesLine: Record "Sales Line";
        salesHdr: Record "Sales Header";
        dimValue: Record "Default Dimension";
        ledgerSetup: Record "General Ledger Setup";
        item: Record Item;
        customer: Record Customer;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        txtFileName: Text;
        NomFeuille: Text;
        ServerFileName: Text[250];
        Text001: Label 'Le nom du fichier est vide !', Comment = 'FRA="Le nom du fichier est vide !"';
        InStream: InStream;
        tabNomFeuille: array[45] of Text;
        nbFeuille: Integer;
        Text002: Label 'Aucune Feuille à traiter sur ce fichier !', Comment = 'FRA="Aucune Feuille à traiter sur ce fichier !"';
        i: Integer;
        varCell: Text[150];
        savRow: Integer;
        savCol: Integer;
        ColESP: Integer;
        ColCHQ: Integer;
        ColCB: Integer;
        ColCD: Integer;
        montantTTC: Decimal;
        numRec: Integer;
        codeClient: Code[20];
        dDay: Integer;
        dMonth: Integer;
        dYear: Integer;
        codeArticle: Code[20];
        nbErr: Integer;
        Text003: Label 'Des factures de vente de ce fichier ont déjà été intégrées, import impossible !', Comment = 'FRA="Des factures de vente de ce fichier ont déjà été intégrées, import impossible !"';
        Text004: Label 'Factures de ce fichier ont déjà été intégrées et validées, import impossible !', Comment = 'FRA="Factures de ce fichier ont déjà été intégrées et validées, import impossible !"';
        Text005: Label 'Fichier non importé, des erreurs ont été relevées !', Comment = 'FRA="Fichier non importé, des erreurs ont été relevées !"';
        xType: Enum "Type Equipement";
        numLig: Integer;
        nbFac: Integer;
        numInvoice: array[20] of Code[20];
        TextFacture: Text;
        DiaProgress: Dialog;
        intProgressI: Integer;
        intProgress: Integer;
        intProgressTotal: Integer;
        timProgress: Time;

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

    local procedure clearVar()
    begin

        CLEAR(ColESP);
        CLEAR(ColCB);
        CLEAR(ColCHQ);
        CLEAR(ColCD);
        CLEAR(savRow);
        CLEAR(savCol);
    end;

    local procedure checkData()
    begin

        ledgerSetup.GET();

        CLEAR(Rec);
        if Rec.FINDSET() then
            repeat

                CLEAR(codeClient);
                CLEAR(codeArticle);
                CLEAR(dDay);
                CLEAR(dMonth);
                CLEAR(dYear);

                codeClient := Rec.Client;
                if customer.GET(codeClient) then begin
                    Rec.Client := customer."No.";
                    if dimValue.GET(18, customer."No.", ledgerSetup."Global Dimension 1 Code") then
                        Rec."Axe Analytique" := dimValue."Dimension Value Code"
                    else begin
                        Rec.Erreur := 'Axe Analytique  non trouvé !';
                        nbErr += 1;
                    end;
                end else begin
                    Rec.Erreur += ' Code Client ' + codeClient + ' non trouvé !';
                    nbErr += 1;
                end;
                codeArticle := Rec.Article;
                if item.GET(codeArticle) then
                    Rec.Article := item."No."
                else begin
                    Rec.Erreur += ' Code Article ' + codeArticle + ' non trouvé !';
                    nbErr += 1;
                end;

                EVALUATE(dDay, COPYSTR(Rec."Fin Période", 20, 2));
                EVALUATE(dMonth, COPYSTR(Rec."Fin Période", 23, 2));
                EVALUATE(dYear, COPYSTR(Rec."Fin Période", 26, 4));
                Rec."Date Facture" := DMY2DATE(dDay, dMonth, dYear);
                if Rec."Date Facture" = 0D then begin
                    Rec.Erreur += ' Date facture non trouvé ! ';
                    nbErr += 1;
                end;

                Rec.MODIFY(true);
            until Rec.NEXT() = 0;
    end;

    local procedure checkFindInvoice()
    begin

        CLEAR(salesHdr);
        salesHdr.SETRANGE("Document Type", salesHdr."Document Type"::Invoice);
        salesHdr.SETRANGE("Name Interface File", txtFileName);
        if salesHdr.COUNT > 0 then
            ERROR(Text003);

        CLEAR(salesLine);
        salesLine.SETRANGE("Document Type", salesLine."Document Type"::Invoice);
        salesLine.SETRANGE("Name Interface File", txtFileName);
        if salesLine.COUNT > 0 then
            ERROR(Text003);

        CLEAR(salesInvoiceHdr);
        salesInvoiceHdr.SETRANGE("Name Interface File", txtFileName);
        if salesInvoiceHdr.COUNT > 0 then
            ERROR(Text004);

        CLEAR(salesInvoiceLine);
        salesInvoiceLine.SETRANGE("Name Interface File", txtFileName);
        if salesInvoiceLine.COUNT > 0 then
            ERROR(Text004);
    end;

    local procedure createInvoice()
    begin

        CLEAR(Rec);
        Rec.FINDSET();
        intProgressTotal := Rec.COUNT;
        intProgressI := 0;
        DiaProgress.OPEN('@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\', intProgress);
        timProgress := TIME;

        CLEAR(salesHdr);
        CLEAR(salesLine);
        CLEAR(Rec);
        Rec.SETCURRENTKEY(Client, "Type Equipement", "Date Facture");
        if Rec.FINDSET() then
            repeat

                if (Rec.Client <> salesHdr."Sell-to Customer No.") or (Rec."Date Facture" <> salesHdr."Posting Date") or (Rec."Type Equipement" <> xType) then begin
                    xType := Rec."Type Equipement";
                    CLEAR(numLig);
                    CLEAR(salesHdr);
                    salesHdr.INIT();
                    salesHdr.VALIDATE("Document Type", salesHdr."Document Type"::Invoice);
                    salesHdr.VALIDATE("Sell-to Customer No.", Rec.Client);
                    salesHdr.VALIDATE("Posting Date", Rec."Date Facture");
                    salesHdr.VALIDATE("Prices Including VAT", true);
                    salesHdr."Name Interface File" := CopyStr(txtFileName, 1, MaxStrLen(salesHdr."Name Interface File"));
                    salesHdr.INSERT(true);
                    salesHdr.VALIDATE(salesHdr."Bill-to Customer No.");
                    salesHdr.VALIDATE("Prices Including VAT", true);
                    salesHdr.MODIFY();
                    nbFac += 1;
                    numInvoice[nbFac] := salesHdr."No.";
                end;
                CLEAR(salesLine);
                salesLine.INIT();
                salesLine.VALIDATE("Document Type", salesHdr."Document Type");
                salesLine.VALIDATE("Document No.", salesHdr."No.");
                numLig += 10000;
                salesLine.VALIDATE("Line No.", numLig);
                salesLine.VALIDATE("Sell-to Customer No.", salesHdr."Sell-to Customer No.");
                salesLine.VALIDATE(Type, salesLine.Type::Item);
                salesLine.VALIDATE("No.", Rec.Article);
                salesLine.VALIDATE(Description, Rec.Designation);
                salesLine.VALIDATE("Shortcut Dimension 1 Code", Rec."Axe Analytique");
                salesLine.VALIDATE(Quantity, 1);
                salesLine.VALIDATE("Unit Price", Rec."Montant TTC");
                salesLine."Name Interface File" := CopyStr(txtFileName, 1, MaxStrLen(salesLine."Name Interface File"));
                salesLine.INSERT(true);

                Rec.invoiceNo := salesHdr."No.";
                Rec.MODIFY();

                intProgressI := intProgressI + 1;
                if timProgress < TIME - 1000 then begin
                    timProgress := TIME;
                    intProgress := ROUND(intProgressI / intProgressTotal * 10000, 1);
                    DiaProgress.UPDATE();
                end;
            until Rec.NEXT() = 0;

        DiaProgress.CLOSE();

        if nbFac > 0 then begin
            TextFacture := FORMAT(nbFac) + ' Factures crées';
            i := 1;
            while i <= nbFac do begin
                TextFacture := TextFacture + ' ' + numInvoice[nbFac];
                i += 1;
            end;
        end else
            TextFacture := 'Aucune facture crée !';
    end;

    local procedure ImportSheetNameNew()
    var
        TbTeam_L: Record Team;
        Eqpt_L: Text[4];
    begin

        clearVar();
        CLEAR(Rec);
        Rec.INIT();

        TempExcelBuffer.OpenBookStream(InStream, NomFeuille);
        TempExcelBuffer.ReadSheet();
        if TempExcelBuffer.FINDFIRST() then
            repeat

                varCell := CopyStr(TempExcelBuffer."Cell Value as Text", 1, MaxStrLen(varCell));
                if COPYSTR(varCell, 1, 4) = 'Parc' then
                    Rec.Parc := CopyStr(TempExcelBuffer."Cell Value as Text", 1, MaxStrLen(Rec.Parc));
                if COPYSTR(varCell, 1, 3) = 'Fin' then
                    Rec."Fin Période" := CopyStr(TempExcelBuffer."Cell Value as Text", 1, MaxStrLen(Rec."Fin Période"));
                if COPYSTR(varCell, 1, 4) = 'Eqpt' then begin
                    Eqpt_L := COPYSTR(TempExcelBuffer."Cell Value as Text", 8, 4);
                    if TbTeam_L.GET(Eqpt_L) then begin
                        Rec.Client := TbTeam_L."Customer No.";
                        Rec.Article := TbTeam_L."Item No.";
                        Rec."Type Equipement" := TbTeam_L."Type Equipement";
                    end;
                end;
                if (COPYSTR(varCell, 1, 8) = 'ESPECES') and (ColESP = 0) then
                    ColESP := TempExcelBuffer."Column No." + 3;
                if (COPYSTR(varCell, 1, 27) = 'CHEQUES BANCAIRES') and (ColCHQ = 0) then
                    ColCHQ := TempExcelBuffer."Column No." + 2;
                if (COPYSTR(varCell, 1, 17) = 'CARTES DE CREDIT') and (ColCB = 0) then begin
                    ColCB := TempExcelBuffer."Column No." + 3;
                    if Rec."Type Equipement" = Rec."Type Equipement"::CA then
                        ColCB := TempExcelBuffer."Column No." + 5;
                end;
                if (COPYSTR(varCell, 1, 17) = 'CARTES A DECOMPTE') and (ColCD = 0) then
                    ColCD := TempExcelBuffer."Column No.";
                if (COPYSTR(varCell, 1, 5) = 'Total') and (savRow = 0) then begin
                    savRow := TempExcelBuffer."Row No.";
                    savCol := TempExcelBuffer."Column No.";
                end;
            until TempExcelBuffer.NEXT() = 0;

        if (Rec."Type Equipement" = Rec."Type Equipement"::CA) or (Rec."Type Equipement" = Rec."Type Equipement"::BS) then begin
            if (TempExcelBuffer.GET(savRow, ColESP)) and (EVALUATE(montantTTC, TempExcelBuffer."Cell Value as Text")) and (montantTTC > 0) then begin
                Rec."Total Fin" := CopyStr(TempExcelBuffer."Cell Value as Text", 1, MaxStrLen(Rec."Total Fin"));
                Rec.Designation := 'ESP';
                Rec."Montant TTC" := montantTTC;
                numRec += 1;
                Rec."Entry No." := numRec;
                Rec.INSERT(true);
            end;
            if (TempExcelBuffer.GET(savRow, ColCHQ)) and (EVALUATE(montantTTC, TempExcelBuffer."Cell Value as Text")) and (montantTTC > 0) then begin
                Rec."Total Fin" := CopyStr(TempExcelBuffer."Cell Value as Text", 1, MaxStrLen(Rec."Total Fin"));
                Rec.Designation := 'CHQ';
                Rec."Montant TTC" := montantTTC;
                numRec += 1;
                Rec."Entry No." := numRec;
                Rec.INSERT(true);
            end;
            if (TempExcelBuffer.GET(savRow, ColCB)) and (EVALUATE(montantTTC, TempExcelBuffer."Cell Value as Text")) and (montantTTC > 0) then begin
                Rec."Total Fin" := CopyStr(TempExcelBuffer."Cell Value as Text", 1, MaxStrLen(Rec."Total Fin"));
                Rec.Designation := 'CB';
                Rec."Montant TTC" := montantTTC;
                numRec += 1;
                Rec."Entry No." := numRec;
                Rec.INSERT(true);
            end;
            if (TempExcelBuffer.GET(savRow, ColCD)) and (EVALUATE(montantTTC, TempExcelBuffer."Cell Value as Text")) and (montantTTC > 0) then begin
                Rec."Total Fin" := CopyStr(TempExcelBuffer."Cell Value as Text", 1, MaxStrLen(Rec."Total Fin"));
                Rec.Designation := 'CD';
                Rec."Montant TTC" := montantTTC;
                numRec += 1;
                Rec."Entry No." := numRec;
                Rec.INSERT(true);
            end;
        end;

        TempExcelBuffer.CloseBook();
    end;
}
