namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.Purchases.Document;
using System.Automation;
codeunit 50003 "CPA Function Mgt"
{
    procedure FAName(): Text[200]
    var
        FA: Record "Fixed Asset";
        DepreciationCalc: Codeunit "Depreciation Calculation";
        DeprBookCode: Code[20];
    begin
        exit(DepreciationCalc.FAName(FA, DeprBookCode));
    end;

    procedure CheckPurchaseHeaderPendingApproval(var PurchHeader: Record "Purchase Header")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Text002: Label 'This document can only be released when the approval process is complete.';
    begin

        if ApprovalsMgmt.IsPurchaseHeaderPendingApproval(PurchHeader) then
            Error(Text002);
    end;
}