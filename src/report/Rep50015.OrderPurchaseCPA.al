namespace Bcsys.CPA.Basics;

using Microsoft.Purchases.Document;
using System.Utilities;
using Microsoft.Foundation.Company;
using System.Security.AccessControl;
using System.Security.User;
using Microsoft.CRM.Team;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Shipping;
using Microsoft.Finance.VAT.Calculation;
using Microsoft.Finance.ReceivablesPayables;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Location;
using System.Globalization;
using Microsoft.Finance.Currency;
using Microsoft.Purchases.Setup;
using Microsoft.Foundation.Address;
using Microsoft.Purchases.Posting;
using Microsoft.Utilities;
using Microsoft.CRM.Segment;
using Microsoft.Foundation.ExtendedText;
using Microsoft.Purchases.Vendor;

report 50015 "Order Purchase CPA"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/OrderPurchaseCPA.rdl';
    Caption = 'Order', Comment = 'FRA="Commande"';
    PreviewMode = PrintLayout;
    UsageCategory = Tasks;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.")
                                where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(DocType_PurchHeader; "Document Type")
            {
            }
            column(No_PurchHeader; "No.")
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(PurchLineInvDiscAmtCaption; PurchLineInvDiscAmtCaptionLbl)
            {
            }
            column(SubtotalCaption; SubtotalCaptionLbl)
            {
            }
            column(VATAmtLineVATCaption; VATAmtLineVATCaptionLbl)
            {
            }
            column(VATAmtLineVATAmtCaption; VATAmtLineVATAmtCaptionLbl)
            {
            }
            column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
            {
            }
            column(VATIdentifierCaption; VATIdentifierCaptionLbl)
            {
            }
            column(VATAmtLineInvDiscBaseAmtCaption; VATAmtLineInvDiscBaseAmtCaptionLbl)
            {
            }
            column(VATAmtLineLineAmtCaption; VATAmtLineLineAmtCaptionLbl)
            {
            }
            column(VALVATBaseLCYCaption; VALVATBaseLCYCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(PaymentTermsDescCaption; PaymentTermsDescCaptionLbl)
            {
            }
            column(ShipmentMethodDescCaption; ShipmentMethodDescCaptionLbl)
            {
            }
            column(PrepymtTermsDescCaption; PrepymtTermsDescCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EmailIDCaption; EmailIDCaptionLbl)
            {
            }
            column(AllowInvoiceDiscCaption; AllowInvoiceDiscCaptionLbl)
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
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = sorting(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = sorting(Number)
                                        where(Number = const(1));
                    column(Prevention; prevention_g)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo.Picture)
                    {
                    }
                    column(SIG_Name; user_g."Full Name")
                    {
                    }
                    column(SIG_Picture; userSetup_g."Electronic Signature")
                    {
                    }
                    column(COM_Penalty; penalty_g)
                    {
                    }
                    column(COM_Condition; condition_g)
                    {
                    }
                    column(COM_Particulier; waranty_g)
                    {
                    }
                    column(COM_Texte; texte_g)
                    {
                    }
                    column(PH_DeliveryTime; "Purchase Header"."Delivey Time")
                    {
                    }
                    column(PH_DevisNo; "Purchase Header"."Quote No")
                    {
                    }
                    column(PH_DevisDate; FORMAT("Purchase Header"."Quote Date", 0, '<Closing><Day> <Month Text> <Year4>'))
                    {
                    }
                    column(CompanyCity; CompanyInfo.City)
                    {
                    }
                    column(ReportTitleCopyText; STRSUBSTNO(Text004, "Purchase Header"."No."))
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
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
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(DocDate_PurchHeader; FORMAT("Purchase Header"."Document Date", 0, '<Closing><Day> <Month Text> <Year4>'))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_PurchHeader; "Purchase Header"."VAT Registration No.")
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_PurchHeader; "Purchase Header"."Your Reference")
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(BuyFrmVendNo_PurchHeader; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(BuyFromAddr1; BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr2; BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr3; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr4; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr5; BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr6; BuyFromAddr[6])
                    {
                    }
                    column(BuyFromAddr7; BuyFromAddr[7])
                    {
                    }
                    column(BuyFromAddr8; BuyFromAddr[8])
                    {
                    }
                    column(PricesInclVAT_PurchHeader; "Purchase Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(VATBaseDisc_PurchHeader; "Purchase Header"."VAT Base Discount %")
                    {
                    }
                    column(PricesInclVATtxt; PricesInclVATtxt)
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(PrepmtPaymentTermsDesc; PrepmtPaymentTerms.Description)
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
                    {
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(DimText; DimText)
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
                    column(CompanyInfoBankAccNoCaption; CompanyInfoBankAccNoCaptionLbl)
                    {
                    }
                    column(OrderNoCaption; OrderNoCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(BuyFrmVendNo_PurchHeaderCaption; "Purchase Header".FIELDCAPTION("Buy-from Vendor No."))
                    {
                    }
                    column(PricesInclVAT_PurchHeaderCaption; "Purchase Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting(Number)
                                            where(Number = filter(1 ..));
                        column(HdrDimCaption; HdrDimCaptionLbl)
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
                                    DimText :=
                                      CopyStr(STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code"), 1, MaxStrLen(DimText));
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
                    dataitem("Purchase Line"; 39)
                    {
                        DataItemLink = "Document Type" = field("Document Type"),
                                       "Document No." = field("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = sorting(Number);
                        column(PHL_Desc2; TempPurchLine."Description 2")
                        {
                        }
                        column(LineAmt_PurchLine; TempPurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(LineNo_PurchLine; "Purchase Line"."Line No.")
                        {
                        }
                        column(AllowInvDisctxt; AllowInvDisctxt)
                        {
                        }
                        column(Type_PurchLine; FORMAT("Purchase Line".Type, 0, 2))
                        {
                        }
                        column(No_PurchLine; "Purchase Line"."No.")
                        {
                        }
                        column(Desc_PurchLine; "Purchase Line".Description)
                        {
                        }
                        column(Qty_PurchLine; "Purchase Line".Quantity)
                        {
                        }
                        column(UOM_PurchLine; "Purchase Line"."Unit of Measure")
                        {
                        }
                        column(DirUnitCost_PurchLine; "Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDisc_PurchLine; "Purchase Line"."Line Discount %")
                        {
                        }
                        column(LineAmt2_PurchLine; "Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvDisc_PurchLine; "Purchase Line"."Allow Invoice Disc.")
                        {
                        }
                        column(HomePage; CompanyInfo."Home Page")
                        {
                        }
                        column(EMail; CompanyInfo."E-Mail")
                        {
                        }
                        column(VATIdentifier_PurchLine; "Purchase Line"."VAT Identifier")
                        {
                        }
                        column(InvDiscAmt_PurchLine; -TempPurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVAT; TempPurchLine."Line Amount" - TempPurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VATAmountText; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DirectUniCostCaption; DirectUniCostCaptionLbl)
                        {
                        }
                        column(PurchLineLineDiscCaption; PurchLineLineDiscCaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        column(No_PurchLineCaption; "Purchase Line".FIELDCAPTION("No."))
                        {
                        }
                        column(Desc_PurchLineCaption; "Purchase Line".FIELDCAPTION(Description))
                        {
                        }
                        column(Qty_PurchLineCaption; "Purchase Line".FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_PurchLineCaption; "Purchase Line".FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_PurchLineCaption; "Purchase Line".FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = sorting(Number)
                                                where(Number = filter(1 ..));
                            column(LineDimCaption; LineDimCaptionLbl)
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
                                        DimText :=
                                          CopyStr(STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code"), 1, MaxStrLen(DimText));
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

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Purchase Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then
                                TempPurchLine.FIND('-')
                            else
                                TempPurchLine.NEXT();
                            "Purchase Line" := TempPurchLine;

                            if not "Purchase Header"."Prices Including VAT" and
                               (TempPurchLine."VAT Calculation Type" = TempPurchLine."VAT Calculation Type"::"Full VAT")
                            then
                                TempPurchLine."Line Amount" := 0;

                            if (TempPurchLine.Type = TempPurchLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Purchase Line"."No." := '';
                            AllowInvDisctxt := FORMAT("Purchase Line"."Allow Invoice Disc.");
                            TotalSubTotal += "Purchase Line"."Line Amount";
                            TotalInvoiceDiscountAmount -= "Purchase Line"."Inv. Discount Amount";
                            TotalAmount += "Purchase Line".Amount;
                        end;

                        trigger OnPostDataItem()
                        begin
                            TempPurchLine.DELETEALL();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := TempPurchLine.FIND('+');
                            while MoreLines and (TempPurchLine.Description = '') and (TempPurchLine."Description 2" = '') and
                                  (TempPurchLine."No." = '') and (TempPurchLine.Quantity = 0) and
                                  (TempPurchLine.Amount = 0)
                            do
                                MoreLines := TempPurchLine.NEXT(-1) <> 0;
                            if not MoreLines then
                                CurrReport.BREAK();
                            TempPurchLine.SETRANGE("Line No.", 0, TempPurchLine."Line No.");
                            SETRANGE(Number, 1, TempPurchLine.COUNT);
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = sorting(Number);
                        column(VATAmtLineVATBase; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; TempVATAmountLine."VAT Identifier")
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
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              TempVATAmountLine.GetBaseLCY(
                                "Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                            VALVATAmountLCY :=
                              TempVATAmountLine.GetAmountLCY(
                                "Purchase Header"."Posting Date", "Purchase Header"."Currency Code", "Purchase Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Purchase Header"."Currency Code" = '') or
                               (TempVATAmountLine.GetTotalVATAmount() = 0)
                            then
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text007 + Text008
                            else
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = sorting(Number)
                                            where(Number = const(1));
                        column(PayToVendNo_PurchHeader; "Purchase Header"."Pay-to Vendor No.")
                        {
                        }
                        column(VendAddr8; VendAddr[8])
                        {
                        }
                        column(VendAddr7; VendAddr[7])
                        {
                        }
                        column(VendAddr6; VendAddr[6])
                        {
                        }
                        column(VendAddr5; VendAddr[5])
                        {
                        }
                        column(VendAddr4; VendAddr[4])
                        {
                        }
                        column(VendAddr3; VendAddr[3])
                        {
                        }
                        column(VendAddr2; VendAddr[2])
                        {
                        }
                        column(VendAddr1; VendAddr[1])
                        {
                        }
                        column(PaymentDetailsCaption; PaymentDetailsCaptionLbl)
                        {
                        }
                        column(VendNoCaption; VendNoCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(Total3; Integer)
                    {
                        DataItemTableView = sorting(Number)
                                            where(Number = const(1));
                        column(SellToCustNo_PurchHeader; "Purchase Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
                        {
                        }
                        column(SellToCustNo_PurchHeaderCaption; "Purchase Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if ("Purchase Header"."Sell-to Customer No." = '') and (ShipToAddr[1] = '') then
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(PrepmtLoop; Integer)
                    {
                        DataItemTableView = sorting(Number)
                                            where(Number = filter(1 ..));
                        column(PrepmtLineAmount; PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBufGLAccNo; TempPrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(PrepmtInvBufDesc; TempPrepmtInvBuf.Description)
                        {
                        }
                        column(TotalInclVATText2; TotalInclVATText)
                        {
                        }
                        column(TotalExclVATText2; TotalExclVATText)
                        {
                        }
                        column(PrepmtInvBufAmt; TempPrepmtInvBuf.Amount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountText; TempPrepmtVATAmountLine.VATAmountText())
                        {
                        }
                        column(PrepmtVATAmount; PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtTotalAmountInclVAT; PrepmtTotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATBaseAmount; PrepmtVATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBuDescCaption; PrepmtInvBuDescCaptionLbl)
                        {
                        }
                        column(PrepmtInvBufGLAccNoCaption; PrepmtInvBufGLAccNoCaptionLbl)
                        {
                        }
                        column(PrepaymentSpecCaption; PrepaymentSpecCaptionLbl)
                        {
                        }
                        dataitem(PrepmtDimLoop; Integer)
                        {
                            DataItemTableView = sorting(Number)
                                                where(Number = filter(1 ..));

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not PrepmtDimSetEntry.FINDSET() then
                                        CurrReport.BREAK();
                                end else
                                    if not Continue then
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := CopyStr(DimText, 1, MaxStrLen(OldDimText));
                                    if DimText = '' then
                                        DimText := STRSUBSTNO('%1 %2', PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code")
                                    else
                                        DimText :=
                                          CopyStr(STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code"), 1, MaxStrLen(DimText));
                                    if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        exit;
                                    end;
                                until PrepmtDimSetEntry.NEXT() = 0;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not TempPrepmtInvBuf.FIND('-') then
                                    CurrReport.BREAK();
                            end else
                                if TempPrepmtInvBuf.NEXT() = 0 then
                                    CurrReport.BREAK();

                            if ShowInternalInfo then
                                PrepmtDimSetEntry.SETRANGE("Dimension Set ID", TempPrepmtInvBuf."Dimension Set ID");

                            if "Purchase Header"."Prices Including VAT" then
                                PrepmtLineAmount := TempPrepmtInvBuf."Amount Incl. VAT"
                            else
                                PrepmtLineAmount := TempPrepmtInvBuf.Amount;
                        end;
                    }
                    dataitem(PrepmtVATCounter; Integer)
                    {
                        DataItemTableView = sorting(Number);
                        column(PrepmtVATAmtLineVATAmt; TempPrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATBase; TempPrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineLineAmt; TempPrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVAT; TempPrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmtLineVATId; TempPrepmtVATAmountLine."VAT Identifier")
                        {
                        }
                        column(PrepymtVATAmtSpecCaption; PrepymtVATAmtSpecCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempPrepmtVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, TempPrepmtVATAmountLine.COUNT);
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    TempPrepmtPurchLine: Record "Purchase Line" temporary;
                    TempPurchLine: Record "Purchase Line" temporary;
                begin
                    CLEAR(TempPurchLine);
                    CLEAR(PurchPost);
                    TempPurchLine.DELETEALL();
                    TempVATAmountLine.DELETEALL();
                    PurchPost.GetPurchLines("Purchase Header", TempPurchLine, 0);
                    TempPurchLine.CalcVATAmountLines(0, "Purchase Header", TempPurchLine, TempVATAmountLine);
                    TempPurchLine.UpdateVATOnLines(0, "Purchase Header", TempPurchLine, TempVATAmountLine);
                    VATAmount := TempVATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT();

                    TempPrepmtInvBuf.DELETEALL();
                    PurchPostPrepmt.GetPurchLines("Purchase Header", 0, TempPrepmtPurchLine);
                    if not TempPrepmtPurchLine.ISEMPTY then begin
                        PurchPostPrepmt.GetPurchLinesToDeduct("Purchase Header", TempPurchLine);
                        if not TempPurchLine.ISEMPTY then
                            PurchPostPrepmt.CalcVATAmountLines("Purchase Header", TempPurchLine, TempPrepmtVATAmountLineDeduct, 1);
                    end;
                    PurchPostPrepmt.CalcVATAmountLines("Purchase Header", TempPrepmtPurchLine, TempPrepmtVATAmountLine, 0);
                    if TempPrepmtVATAmountLine.FINDSET() then
                        repeat
                            TempPrepmtVATAmountLineDeduct := TempPrepmtVATAmountLine;
                            if TempPrepmtVATAmountLineDeduct.FIND() then begin
                                TempPrepmtVATAmountLine."VAT Base" := TempPrepmtVATAmountLine."VAT Base" - TempPrepmtVATAmountLineDeduct."VAT Base";
                                TempPrepmtVATAmountLine."VAT Amount" := TempPrepmtVATAmountLine."VAT Amount" - TempPrepmtVATAmountLineDeduct."VAT Amount";
                                TempPrepmtVATAmountLine."Amount Including VAT" := TempPrepmtVATAmountLine."Amount Including VAT" -
                                  TempPrepmtVATAmountLineDeduct."Amount Including VAT";
                                TempPrepmtVATAmountLine."Line Amount" := TempPrepmtVATAmountLine."Line Amount" - TempPrepmtVATAmountLineDeduct."Line Amount";
                                TempPrepmtVATAmountLine."Inv. Disc. Base Amount" := TempPrepmtVATAmountLine."Inv. Disc. Base Amount" -
                                  TempPrepmtVATAmountLineDeduct."Inv. Disc. Base Amount";
                                TempPrepmtVATAmountLine."Invoice Discount Amount" := TempPrepmtVATAmountLine."Invoice Discount Amount" -
                                  TempPrepmtVATAmountLineDeduct."Invoice Discount Amount";
                                TempPrepmtVATAmountLine."Calculated VAT Amount" := TempPrepmtVATAmountLine."Calculated VAT Amount" -
                                  TempPrepmtVATAmountLineDeduct."Calculated VAT Amount";
                                TempPrepmtVATAmountLine.MODIFY();
                            end;
                        until TempPrepmtVATAmountLine.NEXT() = 0;
                    PurchPostPrepmt.UpdateVATOnLines("Purchase Header", TempPrepmtPurchLine, TempPrepmtVATAmountLine, 0);
                    PurchPostPrepmt.BuildInvLineBuffer("Purchase Header", TempPrepmtPurchLine, 0, TempPrepmtInvBuf);
                    PrepmtVATAmount := TempPrepmtVATAmountLine.GetTotalVATAmount();
                    PrepmtVATBaseAmount := TempPrepmtVATAmountLine.GetTotalVATBase();
                    PrepmtTotalAmountInclVAT := TempPrepmtVATAmountLine.GetTotalAmountInclVAT();

                    if Number > 1 then
                        CopyText := Text003;
                    OutputNo := OutputNo + 1;

                    TotalSubTotal := 0;
                    TotalAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.PREVIEW then
                        PurchCountPrinted.RUN("Purchase Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                printSign_g := false;
                if "Purchase Header".Status = "Purchase Header".Status::Released then
                    printSign_g := true;

                CurrReport.Language := CduLanguage.GetLanguageIdOrDefault("Language Code");

                CompanyInfo.GET();
                CompanyInfo."Phone No." := RespCenter."Phone No.";
                CompanyInfo."Fax No." := RespCenter."Fax No.";
                FormatAddr.Company(CompanyAddr, CompanyInfo);

                penalty_g := CopyStr(initTexte(CompanyInfo."Late penalty", 50), 1, MaxStrLen(penalty_g));
                condition_g := CopyStr(initTexte(CompanyInfo."General Condition Purchase", 250), 1, MaxStrLen(condition_g));
                texte_g := CopyStr(initTexte(CompanyInfo."Comment Order Purchase", 250), 1, MaxStrLen(texte_g));
                waranty_g := CopyStr(initTexte(CompanyInfo."Special warranty", 250), 1, MaxStrLen(waranty_g));

                CLEAR(user_g);
                CLEAR(userSetup_g);
                if userSetup_g.GET("Purchase Header".Signatory) then begin
                    userSetup_g.CALCFIELDS(userSetup_g."Electronic Signature");
                    if not printSign_g then
                        CLEAR(userSetup_g."Electronic Signature");
                    CLEAR(user_g);
                    user_g.SETRANGE("User Name", "Purchase Header".Signatory);
                    if not user_g.FINDFIRST() then
                        CLEAR(userSetup_g);
                end;
                CompanyInfo.CALCFIELDS(Picture);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                if "Purchaser Code" = '' then begin
                    SalesPurchPerson.INIT();
                    PurchaserText := '';
                end else begin
                    SalesPurchPerson.GET("Purchaser Code");
                    PurchaserText := Text000
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

                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
                if "Buy-from Vendor No." <> "Pay-to Vendor No." then
                    FormatAddr.PurchHeaderPayTo(VendAddr, "Purchase Header");
                if "Payment Terms Code" = '' then
                    PaymentTerms.INIT()
                else begin
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                end;
                if "Prepmt. Payment Terms Code" = '' then
                    PrepmtPaymentTerms.INIT()
                else begin
                    PrepmtPaymentTerms.GET("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Language Code");
                end;
                if "Shipment Method Code" = '' then
                    ShipmentMethod.INIT()
                else begin
                    ShipmentMethod.GET("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                end;

                FormatAddr.PurchHeaderShipTo(ShipToAddr, "Purchase Header");

                if not CurrReport.PREVIEW then begin
                    if ArchiveDocument then
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

                    if LogInteraction then begin
                        CALCFIELDS("No. of Archived Versions");
                        SegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.",
                          "Purchaser Code", '', "Posting Description", '');
                    end;
                end;
                PricesInclVATtxt := FORMAT("Prices Including VAT");
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
                    field(NoofCopiesF; NoOfCopies)
                    {
                        Caption = 'No. of Copies', Comment = 'FRA="Nombre de copies"';
                        ApplicationArea = All;
                    }
                    field(prevention_gF; prevention_g)
                    {
                        Caption = 'Plan de prévention', Comment = 'FRA="Plan de prévention"';
                        ApplicationArea = All;
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            ArchiveDocument := PurchSetup."Archive Orders";
            LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';

            prevention_g := false;
        end;
    }

    trigger OnInitReport()
    begin
        GLSetup.GET();
        PurchSetup.GET();
    end;

    var
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        TempPrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        TempPrepmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        PurchSetup: Record "Purchases & Payables Setup";
        CurrExchRate: Record "Currency Exchange Rate";
        TempPurchLine: Record "Purchase Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        PrepmtDimSetEntry: Record "Dimension Set Entry";
        TempPrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        userSetup_g: Record "User Setup";
        user_g: Record User;
        CduLanguage: Codeunit Language;
        PurchCountPrinted: codeunit "Purch.Header-Printed";
        FormatAddr: codeunit "Format Address";
        PurchPost: codeunit "Purch.-Post";
        ArchiveManagement: codeunit ArchiveManagement;
        SegManagement: codeunit SegManagement;
        PurchPostPrepmt: codeunit "Purchase-Post Prepayments";
        Text000: Label 'Purchaser', Comment = 'FRA="Acheteur"';
        Text001: Label 'Total %1', Comment = 'FRA="Total %1"';
        Text002: Label 'Total %1 Incl. VAT', Comment = 'FRA="Total %1 TTC"';
        Text003: Label ' COPY', Comment = 'FRA="COPIE"';
        Text004: Label 'Order%1', Comment = 'FRA="LETTRE DE COMMANDE n° %1"';
        Text006: Label 'Total %1 Excl. VAT', Comment = 'FRA="Total %1 HT"';
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        BuyFromAddr: array[8] of Text[50];
        PurchaserText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
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
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text007: Label 'VAT Amount Specification in ', Comment = 'FRA="Détail TVA dans "';
        Text008: Label 'Local Currency', Comment = 'FRA="Devise société"';
        Text009: Label 'Exchange rate: %1/%2', Comment = 'FRA="Taux de change : %1/%2"';
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        PricesInclVATtxt: Text[30];
        AllowInvDisctxt: Text[30];
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.', Comment = 'FRA="N° téléphone"';
        CompanyInfoVATRegNoCaptionLbl: Label 'VAT Registration No.', Comment = 'FRA="N° identif. intracomm."';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.', Comment = 'FRA="N° CCP"';
        CompanyInfoBankNameCaptionLbl: Label 'Bank', Comment = 'FRA="Banque"';
        CompanyInfoBankAccNoCaptionLbl: Label 'Account No.', Comment = 'FRA="N° compte"';
        OrderNoCaptionLbl: Label 'Order No.', Comment = 'FRA="N° commande"';
        PageCaptionLbl: Label 'Page', Comment = 'FRA="Page"';
        DocumentDateCaptionLbl: Label 'Document Date', Comment = 'FRA="Date document"';
        HdrDimCaptionLbl: Label 'Header Dimensions', Comment = 'FRA="Analytique en-tête"';
        DirectUniCostCaptionLbl: Label 'Direct Unit Cost', Comment = 'FRA="Coût unitaire direct"';
        PurchLineLineDiscCaptionLbl: Label 'Discount %', Comment = 'FRA="% remise"';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT', Comment = 'FRA="Escompte sur TVA"';
        LineDimCaptionLbl: Label 'Line Dimensions', Comment = 'FRA="Analytique ligne"';
        PaymentDetailsCaptionLbl: Label 'Payment Details', Comment = 'FRA="Détail paiement"';
        VendNoCaptionLbl: Label 'Vendor No.', Comment = 'FRA="N° fournisseur"';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address', Comment = 'FRA="Adresse destinataire"';
        PrepmtInvBuDescCaptionLbl: Label 'Description', Comment = 'FRA="Désignation"';
        PrepmtInvBufGLAccNoCaptionLbl: Label 'G/L Account No.', Comment = 'FRA="N° compte général"';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification', Comment = 'FRA="Spécification acompte"';
        PrepymtVATAmtSpecCaptionLbl: Label 'Prepayment VAT Amount Specification', Comment = 'FRA="Spécification montant TVA acompte"';
        AmountCaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        PurchLineInvDiscAmtCaptionLbl: Label 'Invoice Discount Amount', Comment = 'FRA="Montant remise facture"';
        SubtotalCaptionLbl: Label 'Subtotal', Comment = 'FRA="Sous-total"';
        VATAmtLineVATCaptionLbl: Label 'VAT %', Comment = 'FRA="% TVA"';
        VATAmtLineVATAmtCaptionLbl: Label 'VAT Amount', Comment = 'FRA="Montant TVA"';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification', Comment = 'FRA="Détail montant TVA"';
        VATIdentifierCaptionLbl: Label 'VAT Identifier', Comment = 'FRA="Identifiant TVA"';
        VATAmtLineInvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount', Comment = 'FRA="Montant base remise facture"';
        VATAmtLineLineAmtCaptionLbl: Label 'Line Amount', Comment = 'FRA="Montant ligne"';
        VALVATBaseLCYCaptionLbl: Label 'VAT Base', Comment = 'FRA="Base TVA"';
        TotalCaptionLbl: Label 'Total', Comment = 'FRA="Total"';
        PaymentTermsDescCaptionLbl: Label 'Payment Terms', Comment = 'FRA="Conditions de paiement"';
        ShipmentMethodDescCaptionLbl: Label 'Shipment Method', Comment = 'FRA="Conditions de livraison"';
        PrepymtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms', Comment = 'FRA="Conditions paiement acompte"';
        HomePageCaptionLbl: Label 'Home Page', Comment = 'FRA="Page d''accueil"';
        EmailIDCaptionLbl: Label 'E-Mail', Comment = 'FRA="E-mail"';
        AllowInvoiceDiscCaptionLbl: Label 'Allow Invoice Discount', Comment = 'FRA="Autoriser remise facture"';
        penalty_g: Text[50];
        condition_g: Text[250];
        texte_g: Text[250];
        printSign_g: Boolean;
        waranty_g: Text[250];
        prevention_g: Boolean;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewArchiveDocument: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;

    local procedure initTexte(CodeText_P: Code[20]; MaxLg_P: Integer): Text
    var
        ExtTextLine_L: Record "Extended Text Line";
        TextToReturn_L: Text[1000];
    begin

        CLEAR(TextToReturn_L);
        CLEAR(ExtTextLine_L);
        ExtTextLine_L.SETRANGE("Table Name", ExtTextLine_L."Table Name"::"Standard Text");
        ExtTextLine_L.SETRANGE("No.", CodeText_P);
        if ExtTextLine_L.FindSet() then
            repeat
                if STRLEN(TextToReturn_L) + STRLEN(ExtTextLine_L.Text) < MaxLg_P then
                    TextToReturn_L := CopyStr(TextToReturn_L + ExtTextLine_L.Text, 1, MaxStrLen(TextToReturn_L));
            until ExtTextLine_L.NEXT() = 0;

        exit(TextToReturn_L);
    end;
}
