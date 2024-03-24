namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.FixedAsset;
using Microsoft.FixedAssets.Depreciation;
using Microsoft.Purchases.Document;
using System.Automation;
using Microsoft.Foundation.Period;
using System.Utilities;
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

    procedure VerifiyDateFilter("Filter": Text[30])
    var
        Text10800: Label 'The selected date is not a starting period.', Comment = 'FRA="La date choisie n''est pas un début de période."';
    begin
        if Filter = ',,,' then
            Error(Text10800);
    end;

    procedure CheckFiscalYearStatus(PeriodRange: Text[30]): Text[30]
    var
        AccountingPeriod: Record "Accounting Period";
        Date: Record Date;
        Text009: Label 'Fiscally Closed';
        Text010: Label 'Fiscally Open';
    begin
        Date.SetRange("Period Type", Date."Period Type"::Date);
        Date.SetFilter("Period Start", PeriodRange);
        Date.FindLast();
        AccountingPeriod.SetFilter("Starting Date", '<=%1', Date."Period Start");
        AccountingPeriod.SetRange("New Fiscal Year", true);
        AccountingPeriod.FindLast();
        if AccountingPeriod."Fiscally Closed" then
            exit(Text009);

        exit(Text010);
    end;
}