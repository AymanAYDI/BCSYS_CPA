namespace Bcsys.CPA.Basics;

using Microsoft.Purchases.Vendor;
using Microsoft.Finance.Currency;
using Microsoft.Purchases.Payables;
using System.Utilities;
report 51305 "Vendor - Summary Aging ACTIV"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/VendorSummaryAgingACTIV.rdl';
    Caption = 'Vendor - Summary Aging', Comment = 'FRA="Vendor - Summary Aging ACTIV"';
    UsageCategory = None;
    ApplicationArea = All;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Search Name", "Vendor Posting Group", "Currency Filter";
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PrintAmountsInLCY; PrintAmountsInLCY)
            {
            }
            column(Vendor_TABLECAPTION__________VendFilter; TABLECAPTION + ': ' + VendFilter)
            {
            }
            column(VendFilter; VendFilter)
            {
            }
            column(PeriodStartDate_2_; FORMAT(PeriodStartDate[2]))
            {
            }
            column(PeriodStartDate_3_; FORMAT(PeriodStartDate[3]))
            {
            }
            column(PeriodStartDate_4_; FORMAT(PeriodStartDate[4]))
            {
            }
            column(PeriodStartDate_3____1; FORMAT(PeriodStartDate[3] - 1))
            {
            }
            column(PeriodStartDate_4____1; FORMAT(PeriodStartDate[4] - 1))
            {
            }
            column(PeriodStartDate_5____1; FORMAT(PeriodStartDate[5] - 1))
            {
            }
            column(PrintLine; PrintLine)
            {
            }
            column(VendBalanceDueLCY_1_; VendBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(VendBalanceDueLCY_2_; VendBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(VendBalanceDueLCY_3_; VendBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(VendBalanceDueLCY_4_; VendBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(VendBalanceDueLCY_5_; VendBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(TotalVendAmtDueLCY; TotalVendAmtDueLCY)
            {
                AutoFormatType = 1;
            }
            column(LineTotalVendAmountDue; LineTotalVendAmountDue)
            {
                AutoFormatType = 1;
            }
            column(VendBalanceDue_5_; VendBalanceDue[5])
            {
                AutoFormatType = 1;
            }
            column(VendBalanceDue_4_; VendBalanceDue[4])
            {
                AutoFormatType = 1;
            }
            column(VendBalanceDue_3_; VendBalanceDue[3])
            {
                AutoFormatType = 1;
            }
            column(VendBalanceDue_2_; VendBalanceDue[2])
            {
                AutoFormatType = 1;
            }
            column(VendBalanceDue_1_; VendBalanceDue[1])
            {
                AutoFormatType = 1;
            }
            column(Vendor_Name; Name)
            {
            }
            column(Vendor__No__; "No.")
            {
            }
            column(InVendBalanceDueLCY_1; InVendBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(InVendBalanceDueLCY_2; InVendBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(InVendBalanceDueLCY_3; InVendBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(InVendBalanceDueLCY_4; InVendBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(InVendBalanceDueLCY_5; InVendBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(Vendor___Summary_AgingCaption; Vendor___Summary_AgingCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(All_amounts_are_in_LCYCaption; All_amounts_are_in_LCYCaptionLbl)
            {
            }
            column(Balance_DueCaption; Balance_DueCaptionLbl)
            {
            }
            column(Vendor__No___Control29Caption; FIELDCAPTION("No."))
            {
            }
            column(Vendor_Name_Control30Caption; FIELDCAPTION(Name))
            {
            }
            column(VendBalanceDue_1__Control31Caption; VendBalanceDue_1__Control31CaptionLbl)
            {
            }
            column(VendBalanceDue_5__Control35Caption; VendBalanceDue_5__Control35CaptionLbl)
            {
            }
            column(LineTotalVendAmountDue_Control36Caption; LineTotalVendAmountDue_Control36CaptionLbl)
            {
            }
            column(Total__LCY_Caption; Total__LCY_CaptionLbl)
            {
            }
            column(EnAttenteFilterCptn; EnAttentebl)
            {
            }
            column(EnAttente; EnAttente)
            {
            }
            dataitem(Integer; Integer)
            {
                DataItemTableView = sorting(Number)
                                    where(Number = filter(1 ..));
                column(Currency2_Code; TempCurrency2.Code)
                {
                }
                column(LineTotalVendAmountDue_Control36; LineTotalVendAmountDue)
                {
                    AutoFormatExpression = TempCurrency2.Code;
                    AutoFormatType = 1;
                }
                column(VendBalanceDue_5__Control35; VendBalanceDue[5])
                {
                    AutoFormatExpression = TempCurrency2.Code;
                    AutoFormatType = 1;
                }
                column(VendBalanceDue_4__Control34; VendBalanceDue[4])
                {
                    AutoFormatExpression = TempCurrency2.Code;
                    AutoFormatType = 1;
                }
                column(VendBalanceDue_3__Control33; VendBalanceDue[3])
                {
                    AutoFormatExpression = TempCurrency2.Code;
                    AutoFormatType = 1;
                }
                column(VendBalanceDue_2__Control32; VendBalanceDue[2])
                {
                    AutoFormatExpression = TempCurrency2.Code;
                    AutoFormatType = 1;
                }
                column(VendBalanceDue_1__Control31; VendBalanceDue[1])
                {
                    AutoFormatExpression = TempCurrency2.Code;
                    AutoFormatType = 1;
                }
                column(Vendor_Name_Control30; Vendor.Name)
                {
                }
                column(Vendor__No___Control29; Vendor."No.")
                {
                }

                trigger OnAfterGetRecord()
                var
                    DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                    lVendorLedgerEntry: Record "Vendor Ledger Entry";
                begin
                    if Number = 1 then
                        TempCurrency2.FIND('-')
                    else
                        if TempCurrency2.NEXT() = 0 then
                            CurrReport.BREAK();
                    TempCurrency2.CALCFIELDS("Vendor Ledg. Entries in Filter");
                    if not TempCurrency2."Vendor Ledg. Entries in Filter" then
                        CurrReport.SKIP();

                    PrintLine := false;
                    LineTotalVendAmountDue := 0;
                    for i := 1 to 5 do begin
                        DtldVendLedgEntry.SETCURRENTKEY("Vendor No.", "Initial Entry Due Date");
                        DtldVendLedgEntry.SETRANGE("Vendor No.", Vendor."No.");
                        DtldVendLedgEntry.SETRANGE("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                        DtldVendLedgEntry.SETRANGE("Currency Code", TempCurrency2.Code);
                        DtldVendLedgEntry.CALCSUMS(Amount);
                        if (EnAttente = false) then begin
                            lVendorLedgerEntry.SETCURRENTKEY("Vendor No.", Open, Positive, "Due Date", "Currency Code");
                            lVendorLedgerEntry.SETRANGE("Vendor No.", Vendor."No.");
                            lVendorLedgerEntry.SETRANGE(Open, true);
                            lVendorLedgerEntry.SETRANGE("Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                            lVendorLedgerEntry.SETRANGE("Currency Code", TempCurrency2.Code);
                            if lVendorLedgerEntry.FINDFIRST() then
                                repeat
                                    if (lVendorLedgerEntry."On Hold" <> '') then begin
                                        lVendorLedgerEntry.CALCFIELDS(Amount);
                                        DtldVendLedgEntry.Amount := DtldVendLedgEntry.Amount - lVendorLedgerEntry.Amount;
                                    end;
                                until lVendorLedgerEntry.NEXT() = 0;
                        end;

                        VendBalanceDue[i] := DtldVendLedgEntry.Amount;
                        InVendBalanceDueLCY[i] := InVendBalanceDueLCY2[i];
                        if VendBalanceDue[i] <> 0 then
                            PrintLine := true;
                        LineTotalVendAmountDue := LineTotalVendAmountDue + VendBalanceDue[i];
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    if PrintAmountsInLCY or not PrintLine then
                        CurrReport.BREAK();
                    TempCurrency2.RESET();
                    TempCurrency2.SETRANGE("Vendor Filter", Vendor."No.");
                    Vendor.COPYFILTER("Currency Filter", TempCurrency2.Code);
                    if (Vendor.GETFILTER("Global Dimension 1 Filter") <> '') or
                       (Vendor.GETFILTER("Global Dimension 2 Filter") <> '')
                    then begin
                        Vendor.COPYFILTER("Global Dimension 1 Filter", TempCurrency2."Global Dimension 1 Filter");
                        Vendor.COPYFILTER("Global Dimension 2 Filter", TempCurrency2."Global Dimension 2 Filter");
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            var
                DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
                lVendorLedgerEntry: Record "Vendor Ledger Entry";
            begin
                PrintLine := false;
                LineTotalVendAmountDue := 0;
                COPYFILTER("Currency Filter", DtldVendLedgEntry."Currency Code");
                for i := 1 to 5 do begin
                    DtldVendLedgEntry.SETCURRENTKEY("Vendor No.", "Initial Entry Due Date");
                    DtldVendLedgEntry.SETRANGE("Vendor No.", "No.");
                    DtldVendLedgEntry.SETRANGE("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                    DtldVendLedgEntry.CALCSUMS("Amount (LCY)");
                    if (EnAttente = false) then begin
                        lVendorLedgerEntry.SETCURRENTKEY("Vendor No.", Open, Positive, "Due Date", "Currency Code");
                        lVendorLedgerEntry.SETRANGE("Vendor No.", "No.");
                        lVendorLedgerEntry.SETRANGE(Open, true);
                        lVendorLedgerEntry.SETRANGE("Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                        if lVendorLedgerEntry.FINDFIRST() then
                            repeat
                                if (lVendorLedgerEntry."On Hold" <> '') then begin
                                    lVendorLedgerEntry.CALCFIELDS("Amount (LCY)");
                                    DtldVendLedgEntry."Amount (LCY)" := DtldVendLedgEntry."Amount (LCY)" - lVendorLedgerEntry."Amount (LCY)";
                                end;
                            until lVendorLedgerEntry.NEXT() = 0;
                    end;
                    VendBalanceDue[i] := DtldVendLedgEntry."Amount (LCY)";
                    VendBalanceDueLCY[i] := DtldVendLedgEntry."Amount (LCY)";
                    if PrintAmountsInLCY then
                        InVendBalanceDueLCY[i] += DtldVendLedgEntry."Amount (LCY)"
                    else
                        InVendBalanceDueLCY2[i] += DtldVendLedgEntry."Amount (LCY)";
                    if VendBalanceDue[i] <> 0 then
                        PrintLine := true;
                    LineTotalVendAmountDue := LineTotalVendAmountDue + VendBalanceDueLCY[i];
                    TotalVendAmtDueLCY := TotalVendAmtDueLCY + VendBalanceDueLCY[i];
                end;
            end;

            trigger OnPreDataItem()
            begin
                TempCurrency2.Code := '';
                TempCurrency2.INSERT();
                if Currency.FIND('-') then
                    repeat
                        TempCurrency2 := Currency;
                        TempCurrency2.INSERT();
                    until Currency.NEXT() = 0;
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
                    field(PeriodStartDate2; PeriodStartDate[2])
                    {
                        Caption = 'Starting Date', Comment = 'FRA="Date début"';
                        NotBlank = true;
                        ApplicationArea = All;
                    }
                    field(PeriodLengthF; PeriodLength)
                    {
                        Caption = 'Period Length', Comment = 'FRA="Base période"';
                        ApplicationArea = All;
                    }
                    field(PrintAmountsInLCYF; PrintAmountsInLCY)
                    {
                        Caption = 'Show Amounts in LCY', Comment = 'FRA="Afficher montants DS"';
                        ApplicationArea = All;
                    }
                    field(EnAttenteF; EnAttente)
                    {
                        Caption = 'Not good to pay', Comment = 'FRA="En attente"';
                        ApplicationArea = All;
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            if PeriodStartDate[2] = 0D then
                PeriodStartDate[2] := WORKDATE();
            if FORMAT(PeriodLength) = '' then
                EVALUATE(PeriodLength, '<1M>');
        end;
    }
    trigger OnPreReport()
    begin
        VendFilter := Vendor.GETFILTERS;
        for i := 3 to 5 do
            PeriodStartDate[i] := CALCDATE(PeriodLength, PeriodStartDate[i - 1]);
        PeriodStartDate[6] := 99991231D;
    end;

    var
        Currency: Record Currency;
        TempCurrency2: Record Currency temporary;
        PeriodLength: DateFormula;

        PrintAmountsInLCY: Boolean;
        VendFilter: Text;
        PeriodStartDate: array[6] of Date;
        LineTotalVendAmountDue: Decimal;
        TotalVendAmtDueLCY: Decimal;
        VendBalanceDue: array[5] of Decimal;
        VendBalanceDueLCY: array[5] of Decimal;
        PrintLine: Boolean;
        i: Integer;
        InVendBalanceDueLCY: array[5] of Decimal;
        InVendBalanceDueLCY2: array[5] of Decimal;
        Vendor___Summary_AgingCaptionLbl: Label 'Vendor - Summary Aging (Good to pay)', Comment = 'FRA="Fourn. : Échéancier (Bon à payer)"';
        CurrReport_PAGENOCaptionLbl: Label 'Page', Comment = 'FRA="Page"';
        All_amounts_are_in_LCYCaptionLbl: Label 'All amounts are in LCY.', Comment = 'FRA="Tous les montants sont en DS."';
        Balance_DueCaptionLbl: Label 'Balance Due', Comment = 'FRA="Solde dû"';
        VendBalanceDue_1__Control31CaptionLbl: Label '...Before', Comment = 'FRA="...Avant"';
        VendBalanceDue_5__Control35CaptionLbl: Label 'After...', Comment = 'FRA="Après..."';
        LineTotalVendAmountDue_Control36CaptionLbl: Label 'Balance', Comment = 'FRA="Solde"';
        Total__LCY_CaptionLbl: Label 'Total (LCY)', Comment = 'FRA="Total DS"';
        EnAttente: Boolean;
        EnAttentebl: Label 'With on hold lines', Comment = 'FRA="Avec écritures en attente."';

    procedure InitializeRequest(NewPeriodStartDate: Date; NewPeriodLength: Text[10]; NewPrintAmountsInLCY: Boolean)
    begin
        PeriodStartDate[2] := NewPeriodStartDate;
        EVALUATE(PeriodLength, NewPeriodLength);
        PrintAmountsInLCY := NewPrintAmountsInLCY;
    end;
}