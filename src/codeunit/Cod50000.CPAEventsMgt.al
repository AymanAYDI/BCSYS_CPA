codeunit 50000 "CPA Events Mgt."
{
    // Table 36
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterValidateEvent, 'Bill-to Customer No.', false, false)]
    local procedure OnAfterValidateSalesHeaderBilltoCustomerNo(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
        if Rec."Document Type" in [Rec."Document Type"::Order, Rec."Document Type"::Invoice] then
            Rec."Posting Description" := 'FA ' + COPYSTR(Rec."Bill-to Name", 1, 97);

        if Rec."Document Type" in [Rec."Document Type"::"Return Order", Rec."Document Type"::"Credit Memo"] then
            Rec."Posting Description" := 'AV ' + COPYSTR(Rec."Bill-to Name", 1, 97);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeInitPostingDescription, '', false, false)]
    local procedure OnBeforeInitPostingDescriptionSalesHeader(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    //Table 38
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterValidateEvent, 'Pay-to Vendor No.', false, false)]
    local procedure OnAfterValidateEventPurchaseHeaderPaytoVendorNo(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    begin
        if Rec."Document Type" in [Rec."Document Type"::Order, Rec."Document Type"::Invoice] then
            Rec."Posting Description" := 'FA ' + COPYSTR(Rec."Pay-to Name", 1, 97);

        if Rec."Document Type" in [Rec."Document Type"::"Return Order", Rec."Document Type"::"Credit Memo"] then
            Rec."Posting Description" := 'AV ' + COPYSTR(Rec."Pay-to Name", 1, 97);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnBeforeInitPostingDescription, '', false, false)]
    local procedure OnBeforeInitPostingDescriptionPurchaseHeader(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", OnAfterInitRecord, '', false, false)]
    local procedure OnAfterInitRecordPurchaseHeader(var PurchHeader: Record "Purchase Header")
    begin
        if PurchHeader."Document Type" = PurchHeader."Document Type"::Order then
            PurchHeader."Assigned User ID" := CopyStr(USERID, 1, MaxStrLen(PurchHeader."Assigned User ID"));
    end;

    /* TODO:le code spécifique n'a pas été migré avoir la nouvelle fonction RenumberDocNoOnLines
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnBeforeRenumberDocNoOnLines', '', false, false)]
     local procedure OnBeforeRenumberDocNoOnLinesGenJournalLine(var DocNo: Code[20]; var GenJnlLine2: Record "Gen. Journal Line"; var IsHandled: Boolean)
     var
         LastGenJnlLine: Record "Gen. Journal Line";
         GenJnlLine3: Record "Gen. Journal Line";
         NoSeriesMgt: Codeunit NoSeriesManagement;
         GenJnlBatch: Record "Gen. Journal Batch";
         PrevDocNo: Code[20];
         FirstDocNo: Code[20];
         TempFirstDocNo: Code[20];
         First: Boolean;
         PrevPostingDate: Date;
     begin
         FirstDocNo := DocNo;
         GenJnlLine2.SetCurrentKey(GenJnlLine2."Journal Template Name", GenJnlLine2."Journal Batch Name", GenJnlLine2."Document No.", GenJnlLine2."Bal. Account No.");
         GenJnlLine2.SetRange(GenJnlLine2."Journal Template Name", GenJnlLine2."Journal Template Name");
         GenJnlLine2.SetRange(GenJnlLine2."Journal Batch Name", GenJnlLine2."Journal Batch Name");
         GenJnlLine2.SetRange(GenJnlLine2."Check Printed", false);
         LastGenJnlLine.Init();
         First := true;
         if GenJnlLine2.FindSet() then
             repeat
                 if ((FirstDocNo <> GetTempRenumberDocumentNo()) and (GenJnlLine2.GetFilter("Document No.") = '')) then
                     Commit();
                 Clear(NoSeriesMgt);
                 TempFirstDocNo := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series", GenJnlLine2."Posting Date");
                 if (FirstDocNo <> TempFirstDocNo) and (FirstDocNo <> IncStr(TempFirstDocNo)) then begin
                     DocNo := TempFirstDocNo;
                     FirstDocNo := DocNo;
                     First := true;
                 end;
                 if GenJnlLine2."Document No." = FirstDocNo then
                     exit;
                 if not First and
                     ((GenJnlLine2."Document No." <> PrevDocNo) or
                       (GenJnlLine2."Posting Date" <> PrevPostingDate) or
                     ((GenJnlLine2."Bal. Account No." <> '') and (GenJnlLine2."Document No." = ''))) and
                     not LastGenJnlLine.EmptyLine()
                 then
                     DocNo := IncStr(DocNo);
                 PrevDocNo := GenJnlLine2."Document No.";
                 PrevPostingDate := GenJnlLine2."Posting Date";
                 if GenJnlLine2."Document No." <> '' then
                     if GenJnlLine2."Applies-to ID" = GenJnlLine2."Document No." then
                         GenJnlLine2.RenumberAppliesToID(GenJnlLine2, GenJnlLine2."Document No.", DocNo);
                 GenJnlLine2.RenumberAppliesToDocNo(GenJnlLine2, GenJnlLine2."Document No.", DocNo);
                 GenJnlLine3.Get(GenJnlLine2."Journal Template Name", GenJnlLine2."Journal Batch Name", GenJnlLine2."Line No.");
                 CheckJobQueueStatus(GenJnlLine3);
                 GenJnlLine3.Validate("Document No.", DocNo);
                 GenJnlLine3.Modify();
                 First := false;
                 LastGenJnlLine := GenJnlLine2
             until GenJnlLine2.Next() = 0
     end;

     procedure GetTempRenumberDocumentNo(): Code[20]
     begin
         exit('RENUMBERED-000000001');
     end;

     procedure CheckJobQueueStatus(GenJnlLine: Record "Gen. Journal Line")
     var
         WrongJobQueueStatus: Label 'Journal line cannot be modified because it has been scheduled for posting.';
     begin
         if not (GenJnlLine."Job Queue Status" in [GenJnlLine."Job Queue Status"::" ", GenJnlLine."Job Queue Status"::Error]) then
             Error(WrongJobQueueStatus);
     end;
     */

    // Codeunit 90
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterSetPostingFlags, '', false, false)]
    local procedure OnAfterSetPostingFlagsPurchPost(var PurchHeader: Record "Purchase Header")
    begin
        if PurchHeader."Document Type" = PurchHeader."Document Type"::Order then
            PurchHeader.TESTFIELD(Status, PurchHeader.Status::Released);
    end;

    // Codeunit 415
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", OnBeforePerformManualCheckAndRelease, '', false, false)]
    local procedure OnBeforePerformManualCheckAndReleaseReleasePurchaseDocument(var PurchHeader: Record "Purchase Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    var
        recUser_L: Record "User Setup";
        CduLCPAFunctionMgt: Codeunit "CPA Function Mgt";
        AppManagement_l: Codeunit "Approvals Mgmt.";
        PrepaymentMgt: Codeunit "Prepayment Mgt.";
        AppAmount_l: Decimal;
        AppAmountLCY_l: Decimal;
        Text005: Label 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.';
        Text001_l: Label 'Montant HT supérieur au seuil !';
    begin
        IsHandled := true;
        if PurchHeader."Document Type" = PurchHeader."Document Type"::Order then begin
            AppManagement_l.CalcPurchaseDocAmount(PurchHeader, AppAmount_l, AppAmountLCY_l);
            if (recUser_L.GET(USERID)) and (recUser_L."Limit Purchase" >= AppAmount_l) then
                CODEUNIT.RUN(CODEUNIT::"Release Purchase Document", PurchHeader)
            else
                MESSAGE(Text001_l);
            exit;
        end;
        if (PurchHeader."Document Type" = PurchHeader."Document Type"::Order) and PrepaymentMgt.TestPurchasePayment(PurchHeader) then begin
            if PurchHeader.TestStatusIsNotPendingPrepayment() then begin
                PurchHeader.Status := PurchHeader.Status::"Pending Prepayment";
                PurchHeader.Modify();
                Commit();
            end;
            Error(Text005, PurchHeader."Document Type", PurchHeader."No.");
        end;

        CduLCPAFunctionMgt.CheckPurchaseHeaderPendingApproval(PurchHeader);

        CODEUNIT.Run(CODEUNIT::"Release Purchase Document", PurchHeader);
    end;

    // Codeunit 5606
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"FA Check Consistency", OnBeforeCreateAcquisitionCostError, '', false, false)]
    local procedure OnBeforeCreateAcquisitionCostErrorFACheckConsistency(FAJournalLine: Record "FA Journal Line"; var FALedgerEntry2: Record "FA Ledger Entry"; var IsHandled: Boolean)
    var
        CduLCPAFunctionMgt: Codeunit "CPA Function Mgt";
        Text000: label 'The first entry must be an %2 for %1.', Comment = 'FRA="La première écriture doit être %2 pour %1."';
        Text5000: label 'The first entry must be an %2 for %1.', Comment = 'FRA="La première écriture devrait  être %2 pour %1., validez vous "';
    begin
        IsHandled := true;
        FAJournalLine."FA Posting Type" := FAJournalLine."FA Posting Type"::"Acquisition Cost";
        if not CONFIRM(Text5000, false, CduLCPAFunctionMgt.FAName(), CduLCPAFunctionMgt.FAName(), FAJournalLine."FA Posting Type")
          then
            ERROR(Text000, CduLCPAFunctionMgt.FAName(), FAJournalLine."FA Posting Type");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"FA Check Consistency", OnBeforeCreatePostingTypeError, '', false, false)]
    local procedure OnBeforeCreatePostingTypeErrorFACheckConsistency(FAJnlLine: Record "FA Journal Line"; FALedgEntry2: Record "FA Ledger Entry"; DeprBook: Record "Depreciation Book"; var IsHandled: Boolean; NewAmount: Decimal)
    var
        CduLCPAFunctionMgt: Codeunit "CPA Function Mgt";
        AccumText: Text[30];
        Text003: Label 'Accumulated';
        Text5004: Label '%2%3 must not be positive on %4 for %1.', Comment = 'FRA="%2%3 devrait être positif sur %4 pour %1., validez vous"';
        Text004: label '%2%3 must not be positive on %4 for %1.', Comment = 'FRA="%2%3 doit être positif sur %4 pour %1."';
        Text5005: label '%2%3 must not be negative on %4 for %1.', Comment = 'FRA="%2%3 devrait  être négatif sur %4 pour %1., validez vous"';
        Text005: label '%2%3 must not be negative on %4 for %1.', Comment = 'FRA="%2%3 doit être négatif sur %4 pour %1."';

    begin
        IsHandled := true;
        FAJnlLine."FA Posting Type" := "FA Journal Line FA Posting Type".FromInteger(FALedgEntry2.ConvertPostingType());
        if FAJnlLine."FA Posting Type" = FAJnlLine."FA Posting Type"::Depreciation then
            AccumText := STRSUBSTNO('%1 %2', Text003, '');
        if NewAmount > 0 then
            if not CONFIRM(Text5004, false, CduLCPAFunctionMgt.FAName(), AccumText, FAJnlLine."FA Posting Type", FALedgEntry2."FA Posting Date")
            then
                ERROR(Text004, CduLCPAFunctionMgt.FAName(), AccumText, FAJnlLine."FA Posting Type", FALedgEntry2."FA Posting Date");

        if NewAmount < 0 then
            if not CONFIRM(Text5005, false, CduLCPAFunctionMgt.FAName(), AccumText, FAJnlLine."FA Posting Type", FALedgEntry2."FA Posting Date")
            then
                ERROR(Text005, CduLCPAFunctionMgt.FAName(), AccumText, FAJnlLine."FA Posting Type", FALedgEntry2."FA Posting Date");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"FA Check Consistency", OnBeforeCreateBookValueError, '', false, false)]
    local procedure OnBeforeCreateBookValueErrorFACheckConsistency(FALedgerEntry2: Record "FA Ledger Entry"; BookValue: Decimal; SalvageValue: Decimal; var IsHandled: Boolean)
    var
        FAJnlLine: Record "FA Journal Line";
        FADeprBook: Record "FA Depreciation Book";
        CduLCPAFunctionMgt: Codeunit "CPA Function Mgt";
        Text5006: label '%2 must not be negative or less than %3 on %4 for %1.', Comment = 'FRA="%2 ne devrait pas être négatif ou inférieur à %3 sur %4 dans %1. , validez vous "';
        Text006: Label '%2 must not be negative or less than %3 on %4 for %1.', Comment = 'FRA="%2 ne devrait pas être négatif ou inférieur à %3 sur %4 dans %1. , validez vous "';
    begin
        IsHandled := true;

        if not CONFIRM(Text5006, false, CduLCPAFunctionMgt.FAName(), FADeprBook.FIELDCAPTION("Book Value"), FAJnlLine."FA Posting Type", FALedgerEntry2."FA Posting Date")
        then
            ERROR(Text006, CduLCPAFunctionMgt.FAName(), FADeprBook.FIELDCAPTION("Book Value"), FAJnlLine."FA Posting Type", FALedgerEntry2."FA Posting Date");
    end;
}