namespace Bcsys.CPA.Basics;

using Microsoft.Sales.Document;
using System.Globalization;
using Microsoft.Foundation.Address;
using Microsoft.CRM.Segment;
using Microsoft.Utilities;
using Microsoft.CRM.Contact;
using Microsoft.Sales.Customer;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Shipping;
using Microsoft.CRM.Team;
using Microsoft.Finance.VAT.Calculation;
using Microsoft.Sales.Posting;
using Microsoft.CRM.Task;
using System.IO;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Sales.Setup;
using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Location;
using Microsoft.Finance.Currency;
using System.Utilities;

report 60000 "Sales - Quote SCH TEST"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/SalesQuoteSCHTEST.rdl';
    Caption = 'Sales - Quote', Comment = 'FRA="Ventes : Devis"';
    PreviewMode = PrintLayout;
    UsageCategory = None;
    ApplicationArea = All;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.")
                                where("Document Type" = const(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Quote';
            column(DocType_SalesHeader; "Document Type")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            column(SalesLineVATIdentifierCaption; SalesLineVATIdentifierCaptionLbl)
            {
            }
            column(PaymentTermsDescriptionCaption; PaymentTermsDescriptionCaptionLbl)
            {
            }
            column(ShipmentMethodDescriptionCaption; ShipmentMethodDescriptionCaptionLbl)
            {
            }
            column(CompanyInfoHomePageCaption; CompanyInfoHomePageCaptionLbl)
            {
            }
            column(CompanyInfoEmailCaption; CompanyInfoEmailCaptionLbl)
            {
            }
            column(DocumentDateCaption; DocumentDateCaptionLbl)
            {
            }
            column(SalesLineAllowInvoiceDiscCaption; SalesLineAllowInvoiceDiscCaptionLbl)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = sorting(Number)
                                        where(Number = const(1));
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(PaymentTermsDescription; PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(SalesCopyText; STRSUBSTNO(Text004, CopyText))
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
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
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
                    column(BilltoCustNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(DocDate_SalesHeader; FORMAT("Sales Header"."Document Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesHeader; "Sales Header"."VAT Registration No.")
                    {
                    }
                    column(ShipmentDate_SalesHeader; FORMAT("Sales Header"."Shipment Date"))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_SalesHeader; "Sales Header"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourReference_SalesHeader; "Sales Header"."Your Reference")
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
                    column(PricesIncludingVAT_SalesHdr; "Sales Header"."Prices Including VAT")
                    {
                    }
                    column(PageCaption; STRSUBSTNO(Text005, ''))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVATYesNo_SalesHdr; FORMAT("Sales Header"."Prices Including VAT"))
                    {
                    }
                    column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegNoCaption; CompanyInfoVATRegNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankNameCaption; CompanyInfoBankNameCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankAccountNoCaption; CompanyInfoBankAccountNoCaptionLbl)
                    {
                    }
                    column(SalesHeaderShipmentDateCaption; SalesHeaderShipmentDateCaptionLbl)
                    {
                    }
                    column(SalesHeaderNoCaption; SalesHeaderNoCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricesIncludingVAT_SalesHdrCaption; "Sales Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = sorting(Number)
                                            where(Number = filter(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
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
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = field("Document Type"),
                                       "Document No." = field("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = sorting(Number);
                        column(LineAmt_SalesLine; TempSalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(No_SalesLine; "Sales Line"."No.")
                        {
                        }
                        column(Desc_SalesLine; "Sales Line".Description)
                        {
                        }
                        column(Quantity_SalesLine; "Sales Line".Quantity)
                        {
                        }
                        column(UnitofMeasure_SalesLine; "Sales Line"."Unit of Measure")
                        {
                        }
                        column(LineAmt1_SalesLine; "Sales Line"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDiscount_SalesLine; "Sales Line"."Line Discount %")
                        {
                        }
                        column(AllowInvoiceDisc_SalesLine; "Sales Line"."Allow Invoice Disc.")
                        {
                            IncludeCaption = false;
                        }
                        column(VATIdentifier_SalesLine; "Sales Line"."VAT Identifier")
                        {
                        }
                        column(Type_SalesLine; FORMAT("Sales Line".Type))
                        {
                        }
                        column(No1_SalesLine; "Sales Line"."Line No.")
                        {
                        }
                        column(AllowInvoiceDisYesNo; FORMAT("Sales Line"."Allow Invoice Disc."))
                        {
                        }
                        column(InvDiscountAmount_SalesLine; -TempSalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(DiscountAmt_SalesLine; TempSalesLine."Line Amount" - TempSalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtTxt; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(SalesLineLineDiscCaption; SalesLineLineDiscCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(SalesLineInvDiscAmtCaption; SalesLineInvDiscAmtCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        column(No_SalesLineCaption; "Sales Line".FIELDCAPTION("No."))
                        {
                        }
                        column(Desc_SalesLineCaption; "Sales Line".FIELDCAPTION(Description))
                        {
                        }
                        column(Quantity_SalesLineCaption; "Sales Line".FIELDCAPTION(Quantity))
                        {
                        }
                        column(UnitofMeasure_SalesLineCaption; "Sales Line".FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = sorting(Number)
                                                where(Number = filter(1 ..));
                            column(DimText_DimnLoop2; DimText)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
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

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then
                                TempSalesLine.FIND('-')
                            else
                                TempSalesLine.NEXT();
                            "Sales Line" := TempSalesLine;

                            if not "Sales Header"."Prices Including VAT" and
                               (TempSalesLine."VAT Calculation Type" = TempSalesLine."VAT Calculation Type"::"Full VAT")
                            then
                                TempSalesLine."Line Amount" := 0;

                            if (TempSalesLine.Type = TempSalesLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Sales Line"."No." := '';
                        end;

                        trigger OnPostDataItem()
                        begin
                            TempSalesLine.DELETEALL();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := TempSalesLine.FIND('+');
                            while MoreLines and (TempSalesLine.Description = '') and (TempSalesLine."Description 2" = '') and
                                  (TempSalesLine."No." = '') and (TempSalesLine.Quantity = 0) and
                                  (TempSalesLine.Amount = 0)
                            do
                                MoreLines := TempSalesLine.NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK();
                            TempSalesLine.SETRANGE("Line No.", 0, TempSalesLine."Line No.");
                            SETRANGE(Number, 1, TempSalesLine.COUNT);
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = sorting(Number);
                        column(VATBase_VATAmtLine; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmt_VATAmtLine; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(LineAmount_VATAmtLine; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(InvDiscBaseAmt_VATAmtLine; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(InvoiceDiscAmt_VATAmtLine; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VAT_VATAmtLine; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATIdentifier_VATAmtLine; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLineVATCaption; VATAmountLineVATCaptionLbl)
                        {
                        }
                        column(VATBaseCaption; VATBaseCaptionLbl)
                        {
                        }
                        column(VATAmtCaption; VATAmtCaptionLbl)
                        {
                        }
                        column(VATAmountSpecificationCaption; VATAmountSpecificationCaptionLbl)
                        {
                        }
                        column(LineAmtCaption; LineAmtCaptionLbl)
                        {
                        }
                        column(InvoiceDiscBaseAmtCaption; InvoiceDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(InvoiceDiscAmtCaption; InvoiceDiscAmtCaptionLbl)
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
                            if VATAmount = 0 then
                                CurrReport.BREAK();
                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                        end;
                    }
                    dataitem(VATCounterLCY; Integer)
                    {
                        DataItemTableView = sorting(Number);
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATCtrl_VATAmtLine; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATIdentifierCtrl_VATAmtLine; TempVATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              TempVATAmountLine.GetBaseLCY(
                                "Sales Header"."Posting Date", "Sales Header"."Currency Code", "Sales Header"."Currency Factor");
                            VALVATAmountLCY :=
                              TempVATAmountLine.GetAmountLCY(
                                "Sales Header"."Posting Date", "Sales Header"."Currency Code", "Sales Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Sales Header"."Currency Code" = '') or
                               (TempVATAmountLine.GetTotalVATAmount() = 0)
                            then
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text008 + Text009
                            else
                                VALSpecLCYHeader := Text008 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Header"."Order Date", "Sales Header"."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text010, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
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
                        column(SelltoCustNo_SalesHeader; "Sales Header"."Sell-to Customer No.")
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
                        column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Sell-to Customer No."))
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
                var
                    SalesPost: Codeunit "Sales-Post";
                begin
                    CLEAR(TempSalesLine);
                    CLEAR(SalesPost);
                    TempSalesLine.DELETEALL();
                    TempVATAmountLine.DELETEALL();
                    SalesPost.GetSalesLines("Sales Header", TempSalesLine, 0);
                    TempSalesLine.CalcVATAmountLines(0, "Sales Header", TempSalesLine, TempVATAmountLine);
                    TempSalesLine.UpdateVATOnLines(0, "Sales Header", TempSalesLine, TempVATAmountLine);
                    VATAmount := TempVATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT();

                    if Number > 1 then begin
                        CopyText := Text003;
                        OutputNo += 1;
                    end;
                end;

                trigger OnPostDataItem()
                begin
                    if Print then
                        SalesCountPrinted.RUN("Sales Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                "Sell-to Country": Text[50];
            begin
                CurrReport.Language := CduLanguage.GetLanguageIdOrDefault("Language Code");

                if RespCenter.GET("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

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
                FormatAddr.SalesHeaderBillTo(CustAddr, "Sales Header");

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

                if Country.GET("Sell-to Country/Region Code") then
                    "Sell-to Country" := Country.Name;
                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                for i := 1 to ARRAYLEN(ShipToAddr) do
                    if (ShipToAddr[i] <> CustAddr[i]) and (ShipToAddr[i] <> '') and (ShipToAddr[i] <> "Sell-to Country") then
                        ShowShippingAddr := true;

                if Print then begin
                    if ArchiveDocument then
                        ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);

                    if LogInteraction then begin
                        CALCFIELDS("No. of Archived Versions");
                        if "Bill-to Contact No." <> '' then
                            SegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        else
                            SegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                    end;
                end;
                MARK(true);
            end;

            trigger OnPostDataItem()
            var
                ToDo: Record "To-do";
            begin
                MARKEDONLY := true;
                COMMIT();
                CurrReport.LANGUAGE := GLOBALLANGUAGE;
                if FIND('-') and ToDo.WRITEPERMISSION then
                    if Print and (NoOfRecords = 1) then
                        if CONFIRM(Text007) then
                            CreateTask();
            end;

            trigger OnPreDataItem()
            begin
                NoOfRecords := COUNT;
                Print := Print or not CurrReport.PREVIEW;
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
                    field(ShowInternalInfoF; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information', Comment = 'FRA="Afficher info. internes"';
                        ApplicationArea = All;
                    }
                    field(ArchiveDocumentF; ArchiveDocument)
                    {
                        Caption = 'Archive Document', Comment = 'FRA="Archiver document"';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field(LogInteractionF; LogInteraction)
                    {
                        Caption = 'Log Interaction', Comment = 'FRA="Journal interaction"';
                        Enabled = LogInteractionEnable;
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            if LogInteraction then
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                }
            }
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            ArchiveDocument := SalesSetup."Archive Quotes" <> SalesSetup."Archive Quotes"::Never;
            LogInteraction := SegManagement.FindInteractTmplCode(1) <> '';

            LogInteractionEnable := LogInteraction;
        end;
    }

    trigger OnInitReport()
    begin
        GLSetup.GET();
        CompanyInfo.GET();
        SalesSetup.GET();

        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo3.GET();
                    CompanyInfo3.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo1.GET();
                    CompanyInfo1.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo2.GET();
                    CompanyInfo2.CALCFIELDS(Picture);
                end;
        end;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        TempSalesLine: Record "Sales Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        Country: Record "Country/Region";
        CurrExchRate: Record "Currency Exchange Rate";
        CduLanguage: Codeunit Language;
        SalesCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        Text000: Label 'Salesperson', Comment = 'FRA="Vendeur"';
        Text001: Label 'Total %1', Comment = 'FRA="Total %1"';
        Text002: Label 'Total %1 Incl. VAT', Comment = 'FRA="Total %1 TTC"';
        Text003: Label 'COPY', Comment = 'FRA="COPIE"';
        Text004: Label 'Sales - Quote %1', Comment = 'FRA="Ventes : Devis %1"';
        Text005: Label 'Page %1', Comment = 'FRA="Page %1"';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'FRA="Total %1 HT"';
        Text007: Label 'Do you want to create a follow-up to-do?', Comment = 'FRA="Voulez-vous créer une action de suivi ?"';
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[135];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        NoOfRecords: Integer;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text008: Label 'VAT Amount Specification in ', Comment = 'FRA="Détail TVA dans "';
        Text009: Label 'Local Currency', Comment = 'FRA="Devise société"';
        Text010: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change : %1/%2"';
        OutputNo: Integer;
        Print: Boolean;
        ArchiveDocumentEnable: Boolean;
        LogInteractionEnable: Boolean;
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.', Comment = 'FRA="N° téléphone"';
        CompanyInfoVATRegNoCaptionLbl: Label 'VAT Registration No.', Comment = 'FRA="N° identif. intracomm."';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.', Comment = 'FRA="N° CCP"';
        CompanyInfoBankNameCaptionLbl: Label 'Bank', Comment = 'FRA="Banque"';
        CompanyInfoBankAccountNoCaptionLbl: Label 'Account No.', Comment = 'FRA="N° compte"';
        SalesHeaderShipmentDateCaptionLbl: Label 'Shipment Date', Comment = 'FRA="Date d''expédition"';
        SalesHeaderNoCaptionLbl: Label 'Quote No.', Comment = 'FRA="N° devis"';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions', Comment = 'FRA="Analytique en-tête"';
        UnitPriceCaptionLbl: Label 'Unit Price', Comment = 'FRA="Prix unitaire"';
        SalesLineLineDiscCaptionLbl: Label 'Discount %', Comment = 'FRA="% remise"';
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        SalesLineInvDiscAmtCaptionLbl: Label 'Invoice Discount Amount', Comment = 'FRA="Montant remise facture"';
        SubtotalCaptionLbl: Label 'Subtotal', Comment = 'FRA="Sous-total"';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT', Comment = 'FRA="Escompte sur TVA"';
        LineDimensionsCaptionLbl: Label 'Line Dimensions', Comment = 'FRA="Analytique ligne"';
        VATAmountLineVATCaptionLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        VATBaseCaptionLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        VATAmtCaptionLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VATAmountSpecificationCaptionLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail montant TVA"';
        LineAmtCaptionLbl: Label 'Line Amount', Comment = 'FRA="Montant ligne"';
        InvoiceDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount', Comment = 'FRA="Montant base remise facture"';
        InvoiceDiscAmtCaptionLbl: Label 'Invoice Discount Amount', Comment = 'FRA="Montant remise facture"';
        TotalCaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address', Comment = 'FRA="Adresse destinataire"';
        SalesLineVATIdentifierCaptionLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        PaymentTermsDescriptionCaptionLbl: Label 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
        ShipmentMethodDescriptionCaptionLbl: Label 'Shipment Method', Comment = 'FRA="Conditions de livraison"';
        CompanyInfoHomePageCaptionLbl: Label 'Home Page', Comment = 'FRA="Page d''accueil"';
        CompanyInfoEMailCaptionLbl: Label 'E-Mail', Comment = 'FRA="E-mail"';
        DocumentDateCaptionLbl: Label 'Document Date', Comment = 'FRA="Date document"';
        SalesLineAllowInvoiceDiscCaptionLbl: Label 'Allow Invoice Discount', Comment = 'FRA="Autoriser remise facture"';

    procedure InitializeRequest(NoOfCopiesFrom: Integer; ShowInternalInfoFrom: Boolean; ArchiveDocumentFrom: Boolean; LogInteractionFrom: Boolean; PrintFrom: Boolean)
    begin
        NoOfCopies := NoOfCopiesFrom;
        ShowInternalInfo := ShowInternalInfoFrom;
        ArchiveDocument := ArchiveDocumentFrom;
        LogInteraction := LogInteractionFrom;
        Print := PrintFrom;
    end;
}
