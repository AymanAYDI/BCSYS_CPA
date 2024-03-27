namespace Bcsys.CPA.Basics;

using Microsoft.Purchases.Vendor;
using Microsoft.Purchases.Payables;
using Microsoft.Finance.Currency;
using System.Utilities;
report 51321 "Vendor - Balance to Date ACTIV"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/VendorBalancetoDateACTIV.rdl';
    Caption = 'Vendor - Good to pay', Comment = 'FRA="Fourn. : Bon à payer"';
    UsageCategory = None;
    ApplicationArea = All;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", Blocked, "Date Filter";
            column(StrNoVenGetMaxDtFilter; STRSUBSTNO(Text000, FORMAT(GETRANGEMAX("Date Filter"))))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(VendFilter; VendFilter)
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(PrintOnePrPage; PrintOnePrPage)
            {
            }
            column(VendorCaption; TABLECAPTION + ': ' + VendFilter)
            {
            }
            column(No_Vendor; "No.")
            {
            }
            column(Name_Vendor; Name)
            {
            }
            column(PhoneNo_Vendor; "Phone No.")
            {
                IncludeCaption = true;
            }
            column(VendorBalancetoDateCptn; VendorBalancetoDateCptnLbl)
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(AllamountsareinLCYCaption; AllamountsareinLCYCaptionLbl)
            {
            }
            column(PostingDateCption; PostingDateCptionLbl)
            {
            }
            column(OriginalAmtCaption; OriginalAmtCaptionLbl)
            {
            }
            column(EnAttenteFilterCptn; EnAttentebl)
            {
            }
            column(EnAttente; EnAttente)
            {
            }
            dataitem(VendLedgEntry3; "Vendor Ledger Entry")
            {
                DataItemTableView = sorting("Entry No.");
                column(PostDt_VendLedgEntry3; FORMAT("Posting Date"))
                {
                }
                column(DocType_VendLedgEntry3; "Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocNo_VendLedgEntry3; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(Desc_VendLedgEntry3; Description)
                {
                    IncludeCaption = true;
                }
                column(OriginalAmt; OriginalAmt)
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(EntryNo_VendLedgEntry3; "Entry No.")
                {
                    IncludeCaption = true;
                }
                column(CurrencyCode; CurrencyCode)
                {
                }
                column(OnHold_VendLedgEntry3; "On Hold")
                {
                    IncludeCaption = true;
                }
                dataitem(DataItem2149; 380)
                {
                    DataItemLink = "Vendor Ledger Entry No." = field("Entry No."),
                                   "Posting Date" = field("Date Filter");
                    DataItemTableView = sorting("Vendor Ledger Entry No.", "Posting Date")
                                        where("Entry Type" = filter(<> "Initial Entry"));
                    column(EntryTp_DtldVendLedgEntry; "Entry Type")
                    {
                    }
                    column(PostDate_DtldVendLedEnt; FORMAT("Posting Date"))
                    {
                    }
                    column(DocType_DtldVendLedEnt; "Document Type")
                    {
                    }
                    column(DocNo_DtldVendLedgEntry; "Document No.")
                    {
                    }
                    column(Amt; Amt)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(CurrencyCode1; CurrencyCode)
                    {
                    }
                    column(DtldVendtLedgEntryNum; DtldVendtLedgEntryNum)
                    {
                    }
                    column(RemainingAmt; RemainingAmt)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if not PrintUnappliedEntries then
                            if Unapplied then
                                CurrReport.SKIP();
                        if PrintAmountInLCY then begin
                            Amt := "Amount (LCY)";
                            CurrencyCode := '';
                        end else begin
                            Amt := Amount;
                            CurrencyCode := "Currency Code";
                        end;
                        if Amt = 0 then
                            CurrReport.SKIP();

                        DtldVendtLedgEntryNum := DtldVendtLedgEntryNum + 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        DtldVendtLedgEntryNum := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    if PrintAmountInLCY then begin
                        CALCFIELDS("Original Amt. (LCY)", "Remaining Amt. (LCY)");
                        OriginalAmt := "Original Amt. (LCY)";
                        RemainingAmt := "Remaining Amt. (LCY)";
                        CurrencyCode := '';
                    end else begin
                        CALCFIELDS("Original Amount", "Remaining Amount");
                        OriginalAmt := "Original Amount";
                        RemainingAmt := "Remaining Amount";
                        CurrencyCode := "Currency Code";
                    end;

                    TempCurrencyTotalBuffer.UpdateTotal(
                      CurrencyCode,
                      RemainingAmt,
                      0,
                      Counter1);
                end;

                trigger OnPreDataItem()
                begin
                    RESET();
                    DtldVendLedgEntry.SETCURRENTKEY("Vendor No.", "Posting Date", "Entry Type");
                    DtldVendLedgEntry.SETRANGE("Vendor No.", Vendor."No.");
                    DtldVendLedgEntry.SETRANGE("Posting Date", CALCDATE('<+1D>', MaxDate), 99991231D);
                    DtldVendLedgEntry.SETRANGE("Entry Type", DtldVendLedgEntry."Entry Type"::Application);
                    if not PrintUnappliedEntries then
                        DtldVendLedgEntry.SETRANGE(Unapplied, false);

                    if DtldVendLedgEntry.FIND('-') then
                        repeat
                            "Entry No." := DtldVendLedgEntry."Vendor Ledger Entry No.";
                            MARK(true);
                        until DtldVendLedgEntry.NEXT() = 0;

                    SETCURRENTKEY("Vendor No.", Open);
                    SETRANGE("Vendor No.", Vendor."No.");
                    SETRANGE(Open, true);
                    SETRANGE("Posting Date", 0D, MaxDate);

                    if FIND('-') then
                        repeat
                            if (EnAttente = true) or ("On Hold" = '') then
                                MARK(true);
                        until NEXT() = 0;

                    SETCURRENTKEY("Entry No.");
                    SETRANGE(Open);
                    MARKEDONLY(true);
                    SETRANGE("Date Filter", 0D, MaxDate);
                end;
            }
            dataitem(Integer2; Integer)
            {
                DataItemTableView = sorting(Number)
                                    where(Number = filter(1 ..));
                column(Name1_Vendor; Vendor.Name)
                {
                }
                column(CurrTotalBufferTotalAmt; TempCurrencyTotalBuffer."Total Amount")
                {
                    AutoFormatExpression = TempCurrencyTotalBuffer."Currency Code";
                    AutoFormatType = 1;
                }
                column(CurrTotalBufferCurrCode; TempCurrencyTotalBuffer."Currency Code")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    if Number = 1 then
                        OK := TempCurrencyTotalBuffer.FIND('-')
                    else
                        OK := TempCurrencyTotalBuffer.NEXT() <> 0;
                    if not OK then
                        CurrReport.BREAK();

                    TempCurrencyTotalBuffer2.UpdateTotal(
                      TempCurrencyTotalBuffer."Currency Code",
                      TempCurrencyTotalBuffer."Total Amount",
                      0,
                      Counter1);
                end;

                trigger OnPostDataItem()
                begin
                    TempCurrencyTotalBuffer.DELETEALL();
                end;

                trigger OnPreDataItem()
                begin
                    TempCurrencyTotalBuffer.SETFILTER("Total Amount", '<>0');
                end;
            }

            trigger OnAfterGetRecord()
            begin
                MaxDate := GETRANGEMAX("Date Filter");
                SETRANGE("Date Filter", 0D, MaxDate);
                CALCFIELDS("Net Change (LCY)", "Net Change");

                if ((PrintAmountInLCY and ("Net Change (LCY)" = 0)) or
                    ((not PrintAmountInLCY) and ("Net Change" = 0)))
                then
                    CurrReport.SKIP();
            end;
        }
        dataitem(Integer3; Integer)
        {
            DataItemTableView = sorting(Number)
                                where(Number = filter(1 ..));
            column(CurrTotalBuffer2CurrCode; TempCurrencyTotalBuffer2."Currency Code")
            {
            }
            column(CurrTotalBuffer2TotalAmt; TempCurrencyTotalBuffer2."Total Amount")
            {
                AutoFormatExpression = TempCurrencyTotalBuffer2."Currency Code";
                AutoFormatType = 1;
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Number = 1 then
                    OK := TempCurrencyTotalBuffer2.FIND('-')
                else
                    OK := TempCurrencyTotalBuffer2.NEXT() <> 0;
                if not OK then
                    CurrReport.BREAK();
            end;

            trigger OnPostDataItem()
            begin
                TempCurrencyTotalBuffer2.DELETEALL();
            end;

            trigger OnPreDataItem()
            begin
                TempCurrencyTotalBuffer2.SETFILTER("Total Amount", '<>0');
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
                    field(ShowAmountsInLCY; PrintAmountInLCY)
                    {
                        Caption = 'Show Amounts in LCY', Comment = 'FRA="Afficher montants DS"';
                        ApplicationArea = All;
                    }
                    field(PrintOnePrPageF; PrintOnePrPage)
                    {
                        Caption = 'New Page per Vendor', Comment = 'FRA="Nouvelle page par fournisseur"';
                        ApplicationArea = All;
                    }
                    field(PrintUnappliedEntriesF; PrintUnappliedEntries)
                    {
                        Caption = 'Include Unapplied Entries', Comment = 'FRA="Inclure écritures non lettrées"';
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
    }

    trigger OnPreReport()
    begin
        VendFilter := Vendor.GETFILTERS;
        VendDateFilter := CopyStr(Vendor.GETFILTER("Date Filter"), 1, MaxStrLen(VendDateFilter));
    end;

    var
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        TempCurrencyTotalBuffer: Record "Currency Total Buffer" temporary;
        TempCurrencyTotalBuffer2: Record "Currency Total Buffer" temporary;
        PrintAmountInLCY: Boolean;
        PrintOnePrPage: Boolean;
        VendFilter: Text;
        VendDateFilter: Text[30];
        MaxDate: Date;
        OriginalAmt: Decimal;
        Amt: Decimal;
        RemainingAmt: Decimal;
        Counter1: Integer;
        DtldVendtLedgEntryNum: Integer;
        OK: Boolean;
        CurrencyCode: Code[10];
        PrintUnappliedEntries: Boolean;
        Text000: Label 'Balance on %1', Comment = 'FRA="Solde au %1"';
        VendorBalancetoDateCptnLbl: Label 'Vendor - Good to pay', Comment = 'FRA="Fourn. : Bon à payer"';
        PageNoCaptionLbl: Label 'Page', Comment = 'FRA="Page"';
        AllamountsareinLCYCaptionLbl: Label 'All amounts are in LCY.', Comment = 'FRA="Tous les montants sont en DS."';
        PostingDateCptionLbl: Label 'Posting Date', Comment = 'FRA="Date comptabilisation"';
        OriginalAmtCaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        TotalCaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        EnAttente: Boolean;
        EnAttentebl: Label 'with on hold lines', Comment = 'FRA="Avec écritures en attente"';

    procedure InitializeRequest(NewPrintAmountInLCY: Boolean; NewPrintOnePrPage: Boolean; NewPrintUnappliedEntries: Boolean)
    begin
        PrintAmountInLCY := NewPrintAmountInLCY;
        PrintOnePrPage := NewPrintOnePrPage;
        PrintUnappliedEntries := NewPrintUnappliedEntries;
    end;
}
