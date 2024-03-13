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
}