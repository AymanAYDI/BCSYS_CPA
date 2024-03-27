namespace Bcsys.CPA.Basics;

using Microsoft.Sales.History;
using Microsoft.Foundation.Company;
using Microsoft.CRM.Team;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Shipping;
using Microsoft.Finance.VAT.Calculation;
using Microsoft.Assembly.History;
using Microsoft.Finance.VAT.Clause;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Sales.Setup;
using Microsoft.Sales.Customer;
using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Location;
using System.Globalization;
using Microsoft.Finance.Currency;
using Microsoft.Foundation.Address;
using Microsoft.CRM.Segment;
using Microsoft.Sales.Document;
using Microsoft.Inventory.Ledger;
using Microsoft.Foundation.UOM;
using Microsoft.CRM.Contact;
using System.Utilities;
report 50014 "Sales - Invoice CPA Group"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/SalesInvoiceCPAGroup.rdl';
    Caption = 'Sales - Invoice', Comment = 'FRA="Ventes : Facture"';
    Permissions = TableData "Sales Shipment Buffer" = rimd;
    PreviewMode = PrintLayout;
    UsageCategory = None;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(No_SalesInvHdr; "No.")
            {
            }
            column(PmtTermsDescCaption; PmtTermsDescCaptionLbl)
            {
            }
            column(ShpMethodDescCaption; ShpMethodDescCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionCap)
            {
            }
            column(EMailCaption; EMailCaptionLbl)
            {
            }
            column(DocDateCaption; DocDateCaptionLbl)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = sorting(Number)
                                        where(Number = const(1));
                    column(CompanyCity; CompanyInfo.City)
                    {
                    }
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(DocCaptCopyText; STRSUBSTNO(DocumentCaption(), CopyText))
                    {
                    }
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CustAddr5; CustAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(CompanyInfoVATRegistrationNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEMail; CompanyInfo."E-Mail")
                    {
                    }
                    column(BilltoCustNo_SalesInvHdr; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(PostingDate_SalesInvHdr; FORMAT("Sales Invoice Header"."Posting Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesInvHdr; "Sales Invoice Header"."VAT Registration No.")
                    {
                    }
                    column(DueDate_SalesInvHdr; FORMAT("Sales Invoice Header"."Due Date", 0, 4))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_SalesInvHdr; "Sales Invoice Header"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_SalesInvHdr; "Sales Invoice Header"."Your Reference")
                    {
                    }
                    column(OrderNoText; OrderNoText)
                    {
                    }
                    column(OrderNo_SalesInvHdr; "Sales Invoice Header"."Order No.")
                    {
                    }
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(DocDate_SalesInvHdr; FORMAT("Sales Invoice Header"."Document Date", 0, 4))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdr; "Sales Invoice Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVAT1_SalesInvHdr; FORMAT("Sales Invoice Header"."Prices Including VAT"))
                    {
                    }
                    column(PageCaption; PageCaptionCap)
                    {
                    }
                    column(PaymentTermsDescription; PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption; BankNameCaptionLbl)
                    {
                    }
                    column(BankAccNoCaption; BankAccNoCaptionLbl)
                    {
                    }
                    column(DueDateCaption; DueDateCaptionLbl)
                    {
                    }
                    column(InvoiceNoCaption; InvoiceNoCaptionLbl)
                    {
                    }
                    column(PostingDateCaption; PostingDateCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesInvHdrCaption; "Sales Invoice Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdrCaption; "Sales Invoice Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting(Number)
                                            where(Number = filter(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(Number_DimensionLoop1; DimensionLoop1.Number)
                        {
                        }
                        column(HdrDimsCaption; HdrDimsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.FINDSET() then
                                    CurrReport.BREAK();
                            end else
                                if not Continue then
                                    CurrReport.BREAK();

                            CLEAR(DimText);
                            Continue := false;
                            repeat
                                OldDimText := CopyStr(DimText, 1, MaxStrLen(OldDimText));
                                if DimText = '' then
                                    DimText := STRSUBSTNO('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText := CopyStr(STRSUBSTNO('%1, %2 %3', DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code"), 1, MaxStrLen(DimText));
                                if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    exit;
                                end;
                            until DimSetEntry1.NEXT() = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = field("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting("Document No.", "Line No.");
                        column(LineAmt_SalesInvLine; "Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesInvLine; Description)
                        {
                        }
                        column(No_SalesInvLine; "No.")
                        {
                        }
                        column(Quantity_SalesInvLine; Quantity)
                        {
                        }
                        column(UnitofMeasure_SalesInvLine; "Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesInvLine; "Unit Price")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 2;
                        }
                        column(LineDisc_SalesInvLine; discToPrint)
                        {
                        }
                        column(VATIdentifier_SalesInvLine; "VAT Identifier")
                        {
                        }
                        column(PostedShipmentDate; FORMAT(PostedShipmentDate))
                        {
                        }
                        column(Type_SalesInvLine; FORMAT("Sales Invoice Line".Type))
                        {
                        }
                        column(GetTotalLineAmt; GetTotalLineAmount)
                        {
                        }
                        column(GetTotalAmtIncVAT; GetTotalAmountIncVAT)
                        {
                        }
                        column(InvDiscAmt; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscAmt; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(Amt_SalesInvLine; Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotalAmt; TotalAmount)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AmtIncludingVATAmt_SalesInvLine; "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(AmtInclVAT_SalesInvLine; "Amount Including VAT")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(VATAmtText_SalesInvLine; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalAmtInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmtVAT; TotalAmountVAT)
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseDisc_SalesInvHdr; "Sales Invoice Header"."VAT Base Discount %")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscOnVAT; TotalPaymentDiscountOnVAT)
                        {
                            AutoFormatType = 1;
                        }
                        column(LineNo_SalesInvLine; "Line No.")
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(DiscPercentCaption; DiscPercentCaptionLbl)
                        {
                        }
                        column(AmtCaption; AmtCaptionLbl)
                        {
                        }
                        column(PostedShpDateCaption; PostedShpDateCaptionLbl)
                        {
                        }
                        column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(PmtDiscVATCaption; PmtDiscVATCaptionLbl)
                        {
                        }
                        column(Desc_SalesInvLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(No_SalesInvLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(Quantity_SalesInvLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UnitofMeasure_SalesInvLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_SalesInvLineCaption; FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        dataitem("Sales Shipment Buffer"; Integer)
                        {
                            DataItemTableView = sorting(Number);
                            column(SalesShipmentBufferPostingDate; FORMAT(TempSalesShipmentBuffer."Posting Date"))
                            {
                            }
                            column(SalesShipmentBufferQty; TempSalesShipmentBuffer.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShpCaption; ShpCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then
                                    TempSalesShipmentBuffer.FIND('-')
                                else
                                    TempSalesShipmentBuffer.NEXT();
                            end;

                            trigger OnPreDataItem()
                            begin
                                TempSalesShipmentBuffer.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
                                TempSalesShipmentBuffer.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");

                                SETRANGE(Number, 1, TempSalesShipmentBuffer.COUNT);
                            end;
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = sorting(Number)
                                                where(Number = filter(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(LineDimsCaption; LineDimsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.FINDSET() then
                                        CurrReport.BREAK();
                                end else
                                    if not Continue then
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := CopyStr(DimText, 1, MaxStrLen(OldDimText));
                                    if DimText = '' then
                                        DimText := STRSUBSTNO('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText := CopyStr(STRSUBSTNO('%1, %2 %3', DimText, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code"), 1, MaxStrLen(DimText));
                                    if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until DimSetEntry2.NEXT() = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.BREAK();

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Invoice Line"."Dimension Set ID");
                            end;
                        }
                        dataitem(AsmLoop; Integer)
                        {
                            DataItemTableView = sorting(Number);
                            column(TempPostedAsmLineUOMCode; GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
                            {
                            }
                            column(TempPostedAsmLineQty; TempPostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(TempPostedAsmLineVariantCode; BlanksForIndent() + TempPostedAsmLine."Variant Code")
                            {
                            }
                            column(TempPostedAsmLineDesc; BlanksForIndent() + TempPostedAsmLine.Description)
                            {
                            }
                            column(TempPostedAsmLineNo; BlanksForIndent() + TempPostedAsmLine."No.")
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                ItemTranslation: Record 30;
                            begin
                                if Number = 1 then
                                    TempPostedAsmLine.FINDSET()
                                else
                                    TempPostedAsmLine.NEXT();

                                if ItemTranslation.GET(TempPostedAsmLine."No.",
                                     TempPostedAsmLine."Variant Code",
                                     "Sales Invoice Header"."Language Code")
                                then
                                    TempPostedAsmLine.Description := ItemTranslation.Description;
                            end;

                            trigger OnPreDataItem()
                            begin
                                CLEAR(TempPostedAsmLine);
                                if not DisplayAssemblyInformation then
                                    CurrReport.BREAK();
                                CollectAsmInformation();
                                CLEAR(TempPostedAsmLine);
                                SETRANGE(Number, 1, TempPostedAsmLine.COUNT);
                            end;
                        }
                        dataitem(ShipmentDatas; Integer)
                        {
                            DataItemTableView = sorting(Number);
                            column(NoShipmentText; NoShipmentText)
                            {
                            }
                            column(NoShipmentDatas1; NoShipmentDatas[1])
                            {
                            }
                            column(NoShipmentDatas2; NoShipmentDatas[2])
                            {
                            }
                            column(NoShipmentDatas3; NoShipmentDatas[3])
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                CLEAR(NoShipmentDatas);
                                NoShipmentNumLoop := 0;
                                if Number = 1 then begin
                                    ShipmentInvoiced.FIND('-');
                                    NoShipmentText := Text10800;
                                    repeat
                                        NoShipmentNumLoop := NoShipmentNumLoop + 1;
                                        NoShipmentDatas[NoShipmentNumLoop] := ShipmentInvoiced."Shipment No.";
                                    until (ShipmentInvoiced.NEXT() = 0) or (NoShipmentNumLoop = 3);
                                end else begin
                                    NoShipmentText := '';
                                    repeat
                                        NoShipmentNumLoop := NoShipmentNumLoop + 1;
                                        NoShipmentDatas[NoShipmentNumLoop] := ShipmentInvoiced."Shipment No.";
                                    until (ShipmentInvoiced.NEXT() = 0) or (NoShipmentNumLoop = 3);
                                end;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not GIncludeShptNo then
                                    CurrReport.BREAK();

                                if ShipmentInvoiced.COUNT < 1 then
                                    CurrReport.BREAK();
                                ShipmentDatas.SETRANGE(Number, 1, ROUND(ShipmentInvoiced.COUNT / 3, 1, '>'));
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PostedShipmentDate := 0D;
                            if Quantity <> 0 then
                                PostedShipmentDate := FindPostedShipmentDate();

                            if (Type = Type::"G/L Account") and (not ShowInternalInfo) then
                                "No." := '';

                            TempVATAmountLine.INIT();
                            TempVATAmountLine."VAT Identifier" := "VAT Identifier";
                            TempVATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            TempVATAmountLine."Tax Group Code" := "Tax Group Code";
                            TempVATAmountLine."VAT %" := "VAT %";
                            TempVATAmountLine."VAT Base" := Amount;
                            TempVATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            TempVATAmountLine."Line Amount" := "Line Amount";
                            if "Allow Invoice Disc." then
                                TempVATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            TempVATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            TempVATAmountLine."VAT Clause Code" := "VAT Clause Code";
                            TempVATAmountLine.InsertLine();

                            TotalSubTotal += "Line Amount";
                            TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                            TotalAmount += Amount;
                            TotalAmountVAT += "Amount Including VAT" - Amount;
                            TotalAmountInclVAT += "Amount Including VAT";
                            TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                            if GIncludeShptNo then begin
                                ShipmentInvoiced.RESET();
                                ShipmentInvoiced.SETRANGE("Invoice No.", "Sales Invoice Line"."Document No.");
                                ShipmentInvoiced.SETRANGE("Invoice Line No.", "Sales Invoice Line"."Line No.");
                            end;

                            discToPrint := ROUND("Line Discount %", 0.01);
                        end;

                        trigger OnPreDataItem()
                        begin
                            TempVATAmountLine.DELETEALL();
                            TempSalesShipmentBuffer.RESET();
                            TempSalesShipmentBuffer.DELETEALL();
                            FirstValueEntryNo := 0;
                            MoreLines := FIND('+');
                            while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                                MoreLines := NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");

                            GetTotalLineAmount := 0;
                            GetTotalAmountIncVAT := 0;
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = sorting(Number);
                        column(VATAmtLineVATBase; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvoiceDiscAmt; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATPercentCaption; VATPercentCaptionLbl)
                        {
                        }
                        column(VATBaseCaption; VATBaseCaptionLbl)
                        {
                        }
                        column(VATAmtCaption; VATAmtCaptionLbl)
                        {
                        }
                        column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
                        {
                        }
                        column(VATIdentCaption; VATIdentCaptionLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmtCaption; LineAmtCaptionLbl)
                        {
                        }
                        column(InvDiscAmtCaption1; InvDiscAmtCaption1Lbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                        end;
                    }
                    dataitem(VATClauseEntryCounter; Integer)
                    {
                        DataItemTableView = sorting(Number);
                        column(VATClauseVATIdentifier; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATClauseCode; TempVATAmountLine."VAT Clause Code")
                        {
                        }
                        column(VATClauseDescription; VATClause.Description)
                        {
                        }
                        column(VATClauseDescription2; VATClause."Description 2")
                        {
                        }
                        column(VATClauseAmount; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATClausesCaption; VATClausesCap)
                        {
                        }
                        column(VATClauseVATIdentifierCaption; VATIdentCaptionLbl)
                        {
                        }
                        column(VATClauseVATAmtCaption; VATAmtCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                            if not VATClause.GET(TempVATAmountLine."VAT Clause Code") then
                                CurrReport.SKIP();
                            VATClause.TranslateDescription("Sales Invoice Header"."Language Code");
                        end;

                        trigger OnPreDataItem()
                        begin
                            CLEAR(VATClause);
                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                        end;
                    }
                    dataitem(VatCounterLCY; Integer)
                    {
                        DataItemTableView = sorting(Number);
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmtLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT1; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier1; TempVATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              TempVATAmountLine.GetBaseLCY(
                                "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                                "Sales Invoice Header"."Currency Factor");
                            VALVATAmountLCY :=
                              TempVATAmountLine.GetAmountLCY(
                                "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
                                "Sales Invoice Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Sales Invoice Header"."Currency Code" = '')
                            then
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text007 + Text008
                            else
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / "Sales Invoice Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := STRSUBSTNO(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = sorting(Number)
                                            where(Number = const(1));
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = sorting(Number)
                                            where(Number = const(1));
                        column(SelltoCustNo_SalesInvHdr; "Sales Invoice Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(ShiptoAddrCaption; ShiptoAddrCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesInvHdrCaption; "Sales Invoice Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if not ShowShippingAddr then
                                CurrReport.BREAK();
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                        CopyText := Text003;
                        OutputNo += 1;
                    end;

                    TotalSubTotal := 0;
                    TotalInvoiceDiscountAmount := 0;
                    TotalAmount := 0;
                    TotalAmountVAT := 0;
                    TotalAmountInclVAT := 0;
                    TotalPaymentDiscountOnVAT := 0;
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.PREVIEW then
                        SalesInvCountPrinted.RUN("Sales Invoice Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + Cust."Invoice Copies" + 1;
                    if NoOfLoops <= 0 then
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := CduLanguage.GetLanguageIdOrDefault("Language Code");

                if RespCenter.GET("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                if "Order No." = '' then
                    OrderNoText := ''
                else
                    OrderNoText := CopyStr(FIELDCAPTION("Order No."), 1, MaxStrLen(OrderNoText));
                if "Salesperson Code" = '' then begin
                    SalesPurchPerson.INIT();
                    SalesPersonText := '';
                end else begin
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;
                end;
                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    ReferenceText := CopyStr(FIELDCAPTION("Your Reference"), 1, MaxStrLen(ReferenceText));
                if "VAT Registration No." = '' then
                    VATNoText := ''
                else
                    VATNoText := CopyStr(FIELDCAPTION("VAT Registration No."), 1, MaxStrLen(VATNoText));
                if "Currency Code" = '' then begin
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                end else begin
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                end;
                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");
                if not Cust.GET("Bill-to Customer No.") then
                    CLEAR(Cust);

                if "Payment Terms Code" = '' then
                    PaymentTerms.INIT()
                else begin
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                end;
                if "Shipment Method Code" = '' then
                    ShipmentMethod.INIT()
                else begin
                    ShipmentMethod.GET("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                end;
                FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, "Sales Invoice Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                for i := 1 to ARRAYLEN(ShipToAddr) do
                    if ShipToAddr[i] <> CustAddr[i] then
                        ShowShippingAddr := true;

                if LogInteraction then
                    if not CurrReport.PREVIEW then
                        if "Bill-to Contact No." <> '' then
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '')
                        else
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '');
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
                    field(NoOfCopiesF; NoOfCopies)
                    {
                        Caption = 'No. of Copies', Comment = 'FRA="Nombre de copies"';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            InitLogInteraction();
        end;
    }

    labels
    {
        LblTitre = 'FACTURE N°', Comment = 'FRA="FACTURE N°"';
    }

    trigger OnInitReport()
    begin
        GLSetup.GET();
        CompanyInfo.GET();
        SalesSetup.GET();
        CompanyInfo.VerifyAndSetPaymentInfo();
        CompanyInfo3.CALCFIELDS(Picture);
        CompanyInfo1.GET();
        CompanyInfo1.CALCFIELDS(Picture);
        CompanyInfo2.GET();
        CompanyInfo2.CALCFIELDS(Picture);
    end;

    trigger OnPreReport()
    begin

        if not CurrReport.USEREQUESTPAGE then
            InitLogInteraction();
    end;

    var
        GLSetup: Record "General Ledger Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        TempSalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        Cust: Record Customer;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        TempPostedAsmLine: Record "Posted Assembly Line" temporary;
        VATClause: Record "VAT Clause";
        ShipmentInvoiced: Record "Shipment Invoiced";
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        CduLanguage: Codeunit Language;
        PostedShipmentDate: Date;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        OrderNoText: Text[80];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        Text000: Label 'Salesperson', Comment = 'FRA="Vendeur"';
        Text001: Label 'Total %1', Comment = 'FRA="Total %1"';
        Text002: Label 'Total %1 Incl. VAT', Comment = 'FRA="Total %1 TTC"';
        Text003: Label 'COPY', Comment = 'FRA="COPIE"';
        Text004: Label 'Sales - Invoice %1', Comment = 'FRA="Ventes : Facture %1"';
        PageCaptionCap: Label 'Page %1 of %2', Comment = 'FRA="Page %1 de %2"';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'FRA="Total %1 HT"';
        Text007: Label 'VAT Amount Specification in ', Comment = 'FRA="Détail TVA dans"';
        Text008: Label 'Local Currency', Comment = 'FRA="Devise société"';
        VALExchRate: Text[50];
        Text009: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change : %1/%2"';
        CalculatedExchRate: Decimal;
        Text010: Label 'Sales - Prepayment Invoice %1', Comment = 'FRA="Ventes - Facture acompte %1"';
        OutputNo: Integer;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalPaymentDiscountOnVAT: Decimal;
        Text10800: Label 'ShipmentNo', Comment = 'FRA="NoExpédition"';
        NoShipmentNumLoop: Integer;
        NoShipmentDatas: array[3] of Text[20];
        NoShipmentText: Text[30];
        GIncludeShptNo: Boolean;
        GetTotalLineAmount: Decimal;
        GetTotalAmountIncVAT: Decimal;
        DisplayAssemblyInformation: Boolean;
        PhoneNoCaptionLbl: Label 'Phone No.', Comment = 'FRA="N° téléphone"';
        VATRegNoCaptionLbl: Label 'VAT Registration No.', Comment = 'FRA="N° identif. intracomm."';
        GiroNoCaptionLbl: Label 'Giro No.', Comment = 'FRA="N° CCP"';
        BankNameCaptionLbl: Label 'Bank', Comment = 'FRA="Banque"';
        BankAccNoCaptionLbl: Label 'Account No.', Comment = 'FRA="N° compte"';
        DueDateCaptionLbl: Label 'Due Date', Comment = 'FRA="Date d''échéance"';
        InvoiceNoCaptionLbl: Label 'Invoice No.', Comment = 'FRA="N° facture"';
        PostingDateCaptionLbl: Label 'Posting Date', Comment = 'FRA="Date comptabilisation"';
        HdrDimsCaptionLbl: Label 'Header Dimensions', Comment = 'FRA="Analytique en-tête"';
        UnitPriceCaptionLbl: Label 'Unit Price', Comment = 'FRA="Prix unitaire"';
        DiscPercentCaptionLbl: Label 'Discount %', Comment = 'FRA="% remise"';
        AmtCaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        VATClausesCap: Label 'VAT Clause', Comment = 'FRA="Clause TVA"';
        PostedShpDateCaptionLbl: Label 'Posted Shipment Date', Comment = 'FRA="Date expédition validée"';
        InvDiscAmtCaptionLbl: Label 'Inv. Discount Amount', Comment = 'FRA="Montant remise facture"';
        SubtotalCaptionLbl: Label 'Subtotal', Comment = 'FRA="Sous-total"';
        PmtDiscVATCaptionLbl: Label 'Payment Discount on VAT', Comment = 'FRA="Escompte sur TVA"';
        ShpCaptionLbl: Label 'Shipment', Comment = 'FRA="Expédition"';
        LineDimsCaptionLbl: Label 'Line Dimensions', Comment = 'FRA="Analytique ligne"';
        VATPercentCaptionLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        VATBaseCaptionLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VATAmtCaptionLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail montant TVA"';
        VATIdentCaptionLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount', Comment = 'FRA="Montant base remise facture"';
        LineAmtCaptionLbl: Label 'Line Amount', Comment = 'FRA="Montant ligne"';
        InvDiscAmtCaption1Lbl: Label 'Invoice Discount Amount', Comment = 'FRA="Montant remise facture"';
        TotalCaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address', Comment = 'FRA="Adresse destinataire"';
        PmtTermsDescCaptionLbl: Label 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
        ShpMethodDescCaptionLbl: Label 'Shipment Method', Comment = 'FRA="Conditions de livraison"';
        HomePageCaptionCap: Label 'Home Page', Comment = 'FRA="Page d''accueil"';
        EMailCaptionLbl: Label 'E-Mail', Comment = 'FRA="E-mail"';
        DocDateCaptionLbl: Label 'Document Date', Comment = 'FRA="Date document"';
        discToPrint: Decimal;

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    procedure FindPostedShipmentDate(): Date
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        TempSalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
    begin
        NextEntryNo := 1;
        if "Sales Invoice Line"."Shipment No." <> '' then
            if SalesShipmentHeader.GET("Sales Invoice Line"."Shipment No.") then
                exit(SalesShipmentHeader."Posting Date");

        if "Sales Invoice Header"."Order No." = '' then
            exit("Sales Invoice Header"."Posting Date");

        case "Sales Invoice Line".Type of
            "Sales Invoice Line".Type::Item:
                GenerateBufferFromValueEntry("Sales Invoice Line");
            "Sales Invoice Line".Type::"G/L Account", "Sales Invoice Line".Type::Resource,
          "Sales Invoice Line".Type::"Charge (Item)", "Sales Invoice Line".Type::"Fixed Asset":
                GenerateBufferFromShipment("Sales Invoice Line");
            "Sales Invoice Line".Type::" ":
                exit(0D);
        end;

        TempSalesShipmentBuffer.RESET();
        TempSalesShipmentBuffer.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
        TempSalesShipmentBuffer.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");
        if TempSalesShipmentBuffer.FIND('-') then begin
            TempSalesShipmentBuffer2 := TempSalesShipmentBuffer;
            if TempSalesShipmentBuffer.NEXT() = 0 then begin
                TempSalesShipmentBuffer.GET(
                  TempSalesShipmentBuffer2."Document No.", TempSalesShipmentBuffer2."Line No.", TempSalesShipmentBuffer2."Entry No.");
                TempSalesShipmentBuffer.DELETE();
                exit(TempSalesShipmentBuffer2."Posting Date");
            end;
            TempSalesShipmentBuffer.CALCSUMS(Quantity);
            if TempSalesShipmentBuffer.Quantity <> "Sales Invoice Line".Quantity then begin
                TempSalesShipmentBuffer.DELETEALL();
                exit("Sales Invoice Header"."Posting Date");
            end;
        end else
            exit("Sales Invoice Header"."Posting Date");
    end;

    procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record "Sales Invoice Line")
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", SalesInvoiceLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date", "Sales Invoice Header"."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.", '');
        ValueEntry.SETFILTER("Entry No.", '%1..', FirstValueEntryNo);
        if ValueEntry.FIND('-') then
            repeat
                if ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") then begin
                    if SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 then
                        Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
                    else
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(
                      SalesInvoiceLine2,
                      -Quantity,
                      ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
                end;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            until (ValueEntry.NEXT() = 0) or (TotalQuantity = 0);
    end;

    procedure GenerateBufferFromShipment(SalesInvoiceLine: Record "Sales Invoice Line")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine2: Record "Sales Invoice Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := 0;
        SalesInvoiceHeader.SETCURRENTKEY("Order No.");
        SalesInvoiceHeader.SETFILTER("No.", '..%1', "Sales Invoice Header"."No.");
        SalesInvoiceHeader.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
        if SalesInvoiceHeader.FIND('-') then
            repeat
                SalesInvoiceLine2.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine2.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
                SalesInvoiceLine2.SETRANGE(Type, SalesInvoiceLine.Type);
                SalesInvoiceLine2.SETRANGE("No.", SalesInvoiceLine."No.");
                SalesInvoiceLine2.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
                if SalesInvoiceLine2.FIND('-') then
                    repeat
                        TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
                    until SalesInvoiceLine2.NEXT() = 0;
            until SalesInvoiceHeader.NEXT() = 0;

        SalesShipmentLine.SETCURRENTKEY("Order No.", "Order Line No.");
        SalesShipmentLine.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
        SalesShipmentLine.SETRANGE("Order Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE(Type, SalesInvoiceLine.Type);
        SalesShipmentLine.SETRANGE("No.", SalesInvoiceLine."No.");
        SalesShipmentLine.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
        SalesShipmentLine.SETFILTER(Quantity, '<>%1', 0);

        if SalesShipmentLine.FIND('-') then
            repeat
                if "Sales Invoice Header"."Get Shipment Used" then
                    CorrectShipment(SalesShipmentLine);
                if ABS(SalesShipmentLine.Quantity) <= ABS(TotalQuantity - SalesInvoiceLine.Quantity) then
                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
                else begin
                    if ABS(SalesShipmentLine.Quantity) > ABS(TotalQuantity) then
                        SalesShipmentLine.Quantity := TotalQuantity;
                    Quantity :=
                      SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);

                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
                    SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;

                    if SalesShipmentHeader.GET(SalesShipmentLine."Document No.") then
                        AddBufferEntry(
                          SalesInvoiceLine,
                          Quantity,
                          SalesShipmentHeader."Posting Date");
                end;
            until (SalesShipmentLine.NEXT() = 0) or (TotalQuantity = 0);
    end;

    procedure CorrectShipment(var SalesShipmentLine: Record "Sales Shipment Line")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SETCURRENTKEY("Shipment No.", "Shipment Line No.");
        SalesInvoiceLine.SETRANGE("Shipment No.", SalesShipmentLine."Document No.");
        SalesInvoiceLine.SETRANGE("Shipment Line No.", SalesShipmentLine."Line No.");
        if SalesInvoiceLine.FIND('-') then
            repeat
                SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
            until SalesInvoiceLine.NEXT() = 0;
    end;

    procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Invoice Line"; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        TempSalesShipmentBuffer.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
        TempSalesShipmentBuffer.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        TempSalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
        if TempSalesShipmentBuffer.FIND('-') then begin
            TempSalesShipmentBuffer.Quantity := TempSalesShipmentBuffer.Quantity + QtyOnShipment;
            TempSalesShipmentBuffer.MODIFY();
            exit;
        end;

        TempSalesShipmentBuffer."Document No." := SalesInvoiceLine."Document No.";
        TempSalesShipmentBuffer."Line No." := SalesInvoiceLine."Line No.";
        TempSalesShipmentBuffer."Entry No." := NextEntryNo;
        TempSalesShipmentBuffer.Type := SalesInvoiceLine.Type;
        TempSalesShipmentBuffer."No." := SalesInvoiceLine."No.";
        TempSalesShipmentBuffer.Quantity := QtyOnShipment;
        TempSalesShipmentBuffer."Posting Date" := PostingDate;
        TempSalesShipmentBuffer.INSERT();
        NextEntryNo := NextEntryNo + 1
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        if "Sales Invoice Header"."Prepayment Invoice" then
            exit(Text010);
        exit(Text004);
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; IncludeShptNo: Boolean; DisplAsmInfo: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        IncludeShptNo := IncludeShptNo;
        DisplayAssemblyInformation := DisplAsmInfo;
    end;

    procedure CollectAsmInformation()
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        TempPostedAsmLine.DELETEALL();
        if "Sales Invoice Line".Type <> "Sales Invoice Line".Type::Item then
            exit;
        ValueEntry.SETCURRENTKEY(ValueEntry."Document No.");
        ValueEntry.SETRANGE(ValueEntry."Document No.", "Sales Invoice Line"."Document No.");
        ValueEntry.SETRANGE(ValueEntry."Document Type", ValueEntry."Document Type"::"Sales Invoice");
        ValueEntry.SETRANGE(ValueEntry."Document Line No.", "Sales Invoice Line"."Line No.");
        ValueEntry.SETRANGE(ValueEntry.Adjustment, false);
        if not ValueEntry.FINDSET() then
            exit;
        repeat
            if ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") then begin
                if ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" then
                    SalesShipmentLine.GET(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                if SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) then begin
                    PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                    if PostedAsmLine.FINDSET() then
                        repeat
                            TreatAsmLineBuffer(PostedAsmLine);
                        until PostedAsmLine.NEXT() = 0;
                end;
            end;
        until ValueEntry.NEXT() = 0;
    end;

    procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line")
    begin
        CLEAR(TempPostedAsmLine);
        TempPostedAsmLine.SETRANGE(Type, PostedAsmLine.Type);
        TempPostedAsmLine.SETRANGE("No.", PostedAsmLine."No.");
        TempPostedAsmLine.SETRANGE("Variant Code", PostedAsmLine."Variant Code");
        TempPostedAsmLine.SETRANGE(Description, PostedAsmLine.Description);
        TempPostedAsmLine.SETRANGE("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        if TempPostedAsmLine.FINDFIRST() then begin
            TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
            TempPostedAsmLine.MODIFY();
        end else begin
            CLEAR(TempPostedAsmLine);
            TempPostedAsmLine := PostedAsmLine;
            TempPostedAsmLine.INSERT();
        end;
    end;

    procedure GetUOMText(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.GET(UOMCode) then
            exit(UOMCode);
        exit(CopyStr(UnitOfMeasure.Description, 1, 10));
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        exit(PADSTR('', 2, ' '));
    end;
}
