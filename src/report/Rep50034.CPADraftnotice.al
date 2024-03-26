namespace Bcsys.CPA.Basics;

using Microsoft.Bank.Payment;
using Microsoft.Purchases.Vendor;
using System.Utilities;
using Microsoft.Purchases.Payables;
using Microsoft.Foundation.Company;
using Microsoft.Finance.GeneralLedger.Setup;
using Microsoft.Foundation.Address;
report 50034 "CPA Draft notice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/Draftnotice.rdl';
    Caption = 'Draft notice', Comment = 'FRA="Avis provisoire"';
    UsageCategory = None;
    ApplicationArea = All;

    dataset
    {
        dataitem("Payment Lines1"; "Payment Line")
        {
            DataItemTableView = sorting("No.", "Line No.")
                                where(Marked = const(true));
            column(Payment_Lines1_No_; "No.")
            {
            }
            column(Payment_Lines1_Line_No_; "Line No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                PaymtHeader.GET("No.");
                PaymtHeader.CALCFIELDS("Payment Class Name");
                PostingDate := PaymtHeader."Posting Date";

                BankAccountBuffer."Customer No." := "Account No.";
                BankAccountBuffer."Bank Branch No." := "Bank Branch No.";
                BankAccountBuffer."Agency Code" := "Agency Code";
                BankAccountBuffer."Bank Account No." := "Bank Account No.";
                if not BankAccountBuffer.INSERT() then;
            end;

            trigger OnPreDataItem()
            begin
                SETRANGE("No.", TransfertNo);
            end;
        }
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(Vendor_No_; "No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = sorting(Number);
                dataitem("Bank Account Buffer"; "Bank Account Buffer")
                {
                    DataItemTableView = sorting("Customer No.", "Bank Branch No.", "Agency Code", "Bank Account No.");
                    column(Bank_Account_Buffer_Customer_No_; "Customer No.")
                    {
                    }
                    column(Bank_Account_Buffer_Bank_Branch_No_; "Bank Branch No.")
                    {
                    }
                    column(Bank_Account_Buffer_Agency_Code; "Agency Code")
                    {
                    }
                    column(Bank_Account_Buffer_Bank_Account_No_; "Bank Account No.")
                    {
                    }
                    dataitem("Payment Line"; "Payment Line")
                    {
                        DataItemLink = "Account No." = field("Customer No."),
                                       "Bank Branch No." = field("Bank Branch No."),
                                       "Agency Code" = field("Agency Code"),
                                       "Bank Account No." = field("Bank Account No.");
                        DataItemLinkReference = "Bank Account Buffer";
                        DataItemTableView = sorting("No.", "Account No.", "Bank Branch No.", "Agency Code", "Bank Account No.", "Payment Address Code")
                                            where(Marked = const(true));
                        column(FORMAT_PostingDate_0_4_; FORMAT(PostingDate, 0, 4))
                        {
                        }
                        column(Payment_Lines1___No__; "Payment Lines1"."No.")
                        {
                        }
                        column(PaymtHeader_IBAN; PaymtHeader.IBAN)
                        {
                        }
                        column(VendAddr_7_; VendAddr[7])
                        {
                        }
                        column(PaymtHeader_SWIFT_Code; PaymtHeader."SWIFT Code")
                        {
                        }
                        column(VendAddr_6_; VendAddr[6])
                        {
                        }
                        column(CompanyInformation__VAT_Registration_No__; CompanyInformation."VAT Registration No.")
                        {
                        }
                        column(VendAddr_5_; VendAddr[5])
                        {
                        }
                        column(CompanyInformation__Fax_No__; CompanyInformation."Fax No.")
                        {
                        }
                        column(VendAddr_4_; VendAddr[4])
                        {
                        }
                        column(CompanyInformation__Phone_No__; CompanyInformation."Phone No.")
                        {
                        }
                        column(VendAddr_3_; VendAddr[3])
                        {
                        }
                        column(CompanyAddr_6_; CompanyAddr[6])
                        {
                        }
                        column(VendAddr_2_; VendAddr[2])
                        {
                        }
                        column(CompanyAddr_5_; CompanyAddr[5])
                        {
                        }
                        column(VendAddr_1_; VendAddr[1])
                        {
                        }
                        column(CompanyAddr_4_; CompanyAddr[4])
                        {
                        }
                        column(CompanyAddr_3_; CompanyAddr[3])
                        {
                        }
                        column(CompanyAddr_2_; CompanyAddr[2])
                        {
                        }
                        column(CompanyAddr_1_; CompanyAddr[1])
                        {
                        }
                        column(STRSUBSTNO_Text002_CopyText_; STRSUBSTNO(Text002, CopyText))
                        {
                        }
                        column(PrintCurrencyCode; PrintCurrencyCode())
                        {
                        }
                        column(OutputNo; OutputNo)
                        {
                        }
                        column(Vendor__No__; Vendor."No.")
                        {
                        }
                        column(CopyLoop_Number; CopyLoop.Number)
                        {
                        }
                        column(Bank_Account_Buffer___Agency_Code_; "Bank Account Buffer"."Agency Code")
                        {
                        }
                        column(Bank_Account_Buffer___Customer_No__; "Bank Account Buffer"."Customer No.")
                        {
                        }
                        column(Bank_Account_Buffer___Bank_Branch_No__; "Bank Account Buffer"."Bank Branch No.")
                        {
                        }
                        column(Bank_Account_Buffer___Bank_Account_No__; "Bank Account Buffer"."Bank Account No.")
                        {
                        }
                        column(HeaderText1; HeaderText1)
                        {
                        }
                        column(PrintCurrencyCode_Control1120069; PrintCurrencyCode())
                        {
                        }
                        column(ABS_Amount_; ABS(Amount))
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Payment_Line__Due_Date_; FORMAT("Due Date"))
                        {
                        }
                        column(PostingDate; FORMAT(PostingDate))
                        {
                        }
                        column(Payment_Line__External_Document_No__; "External Document No.")
                        {
                        }
                        column(PaymtHeader__Payment_Class_Name_; PaymtHeader."Payment Class Name")
                        {
                        }
                        column(Payment_Line__Document_No__; "Document No.")
                        {
                        }
                        column(PrintCurrencyCode_Control1120064; PrintCurrencyCode())
                        {
                        }
                        column(DraftAmount; DraftAmount)
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalDraftAmount; TotalDraftAmount)
                        {
                        }
                        column(Payment_Line_No_; "No.")
                        {
                        }
                        column(Payment_Line_Line_No_; "Line No.")
                        {
                        }
                        column(Payment_Line_Payment_Address_Code; "Payment Address Code")
                        {
                        }
                        column(Payment_Line_Account_No_; "Account No.")
                        {
                        }
                        column(Payment_Line_Bank_Branch_No_; "Bank Branch No.")
                        {
                        }
                        column(Payment_Line_Agency_Code; "Agency Code")
                        {
                        }
                        column(Payment_Line_Bank_Account_No_; "Bank Account No.")
                        {
                        }
                        column(Payment_Line_Applies_to_ID; "Applies-to ID")
                        {
                        }
                        column(Payment_Lines1___No__Caption; Payment_Lines1___No__CaptionLbl)
                        {
                        }
                        column(PaymtHeader__IBAN__Caption; PaymtHeader__IBAN__CaptionLbl)
                        {
                        }
                        column(PaymtHeader__SWIFT_Code__Caption; PaymtHeader__SWIFT_Code__CaptionLbl)
                        {
                        }
                        column(CompanyInformation__VAT_Registration_No__Caption; CompanyInformation__VAT_Registration_No__CaptionLbl)
                        {
                        }
                        column(CompanyInformation__Fax_No__Caption; CompanyInformation__Fax_No__CaptionLbl)
                        {
                        }
                        column(CompanyInformation__Phone_No__Caption; CompanyInformation__Phone_No__CaptionLbl)
                        {
                        }
                        column(PrintCurrencyCodeCaption; PrintCurrencyCodeCaptionLbl)
                        {
                        }
                        column(Draft_Notice_AmountCaption; Draft_Notice_AmountCaptionLbl)
                        {
                        }
                        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
                        {
                            CalcFields = "Remaining Amount";
                            DataItemLink = "Vendor No." = field("Account No."),
                                           "Applies-to ID" = field("Applies-to ID");
                            DataItemLinkReference = "Payment Line";
                            DataItemTableView = sorting("Document No.");
                            column(HeaderText2; HeaderText2)
                            {
                            }
                            column(ABS__Remaining_Amount__; ABS("Remaining Amount"))
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(Remainig_Amount; "Remaining Amount")
                            {
                            }
                            column(PrintCurrencyCode_Control1120060; PrintCurrencyCode())
                            {
                            }
                            column(Vendor_Ledger_Entry__Currency_Code_; "Currency Code")
                            {
                            }
                            column(ABS__Remaining_Amount___Control1120059; ABS("Remaining Amount"))
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(Vendor_Ledger_Entry__Document_No__; "Document No.")
                            {
                            }
                            column(Vendor_Ledger_Entry_Description; Description)
                            {
                            }
                            column(Vendor_Ledger_Entry__External_Document_No__; "External Document No.")
                            {
                            }
                            column(Vendor_Ledger_Entry__Posting_Date_; FORMAT("Posting Date"))
                            {
                            }
                            column(Vendor_Ledger_Entry__Due_Date_; FORMAT("Due Date"))
                            {
                            }
                            column(ABS__Remaining_Amount___Control1120036; ABS("Remaining Amount"))
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(PrintCurrencyCode_Control1120063; PrintCurrencyCode())
                            {
                            }
                            column(Vendor_Ledger_Entry_Entry_No_; "Entry No.")
                            {
                            }
                            column(Vendor_Ledger_Entry_Vendor_No_; "Vendor No.")
                            {
                            }
                            column(Vendor_Ledger_Entry_Applies_to_ID; "Applies-to ID")
                            {
                            }
                            column(Vendor_Ledger_Entry__Document_No__Caption; FIELDCAPTION("Document No."))
                            {
                            }
                            column(Vendor_Ledger_Entry_DescriptionCaption; FIELDCAPTION(Description))
                            {
                            }
                            column(Vendor_Ledger_Entry__External_Document_No__Caption; FIELDCAPTION("External Document No."))
                            {
                            }
                            column(Vendor_Ledger_Entry__Posting_Date_Caption; Vendor_Ledger_Entry__Posting_Date_CaptionLbl)
                            {
                            }
                            column(Vendor_Ledger_Entry__Due_Date_Caption; Vendor_Ledger_Entry__Due_Date_CaptionLbl)
                            {
                            }
                            column(ABS__Remaining_Amount___Control1120059Caption; ABS__Remaining_Amount___Control1120059CaptionLbl)
                            {
                            }
                            column(ReportCaption; ReportCaptionLbl)
                            {
                            }
                            column(ReportCaption_Control1120015; ReportCaption_Control1120015Lbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if "Payment Line"."Applies-to ID" = '' then
                                    CurrReport.SKIP()
                                    ;
                                if "Currency Code" = '' then
                                    "Currency Code" := GLSetup."LCY Code";

                                DraftCounting := DraftCounting + 1;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        var
                            PaymtAddr: Record "Payment Address";
                        begin
                            HeaderText1 := STRSUBSTNO(Text004, "Bank Account Name", "SWIFT Code",
                                "Agency Code", IBAN, PostingDate);
                            DraftCounting := 0;

                            TotalDraftAmount := TotalDraftAmount + ABS(Amount);

                            if "Payment Address Code" = '' then
                                FormatAddress.Vendor(VendAddr, Vendor)
                            else
                                if PaymtAddr.GET("Account Type"::Vendor, "Account No.", "Payment Address Code") then
                                    FormatAddress.FormatAddr(VendAddr, PaymtAddr.Name, PaymtAddr."Name 2", PaymtAddr.Contact, PaymtAddr.Address, PaymtAddr."Address 2",
                                                             PaymtAddr.City, PaymtAddr."Post Code", PaymtAddr.County, PaymtAddr."Country/Region Code");

                            DraftAmount := ABS(Amount);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE("No.", TransfertNo);
                            SETRANGE("Account No.", Vendor."No.");

                            TotalDraftAmount := 0;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                        CopyText := Text001;
                        OutputNo := OutputNo + 1;
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    OutputNo := 1;
                    LoopsNumber := ABS(CopiesNumber) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, LoopsNumber);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                PaymtLine.RESET();
                PaymtLine.SETRANGE("No.", TransfertNo);
                PaymtLine.SETRANGE("Account No.", "No.");
                if not PaymtLine.FINDFIRST() then
                    CurrReport.SKIP();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options', Comment = 'FRA="Options"';
                    field(NumberOfCopies; CopiesNumber)
                    {
                        Caption = 'Number of copies', Comment = 'FRA"Nombre de copies"';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnPostReport()
    begin
        BankAccountBuffer.DELETEALL();
    end;

    trigger OnPreReport()
    begin
        TransfertNo := COPYSTR("Payment Lines1".GETFILTER("No."), 1, MAXSTRLEN(TransfertNo));
        if TransfertNo = '' then
            ERROR(Text000);

        CompanyInformation.GET();
        FormatAddress.Company(CompanyAddr, CompanyInformation);
        GLSetup.GET();
    end;

    var
        CompanyInformation: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        PaymtHeader: Record "Payment Header";
        PaymtLine: Record "Payment Line";
        BankAccountBuffer: Record "Bank Account Buffer";
        FormatAddress: Codeunit "Format Address";
        VendAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        LoopsNumber: Integer;
        CopiesNumber: Integer;
        CopyText: Text;
        DraftAmount: Decimal;
        TotalDraftAmount: Decimal;
        DraftCounting: Decimal;
        TransfertNo: Code[20];
        HeaderText1: Text;
        PostingDate: Date;
        Text000: Label 'You must specify a transfer number.', Comment = 'FRA="Vous devez spécifier un numéro de virement."';
        Text001: Label 'COPY', Comment = 'FRA="COPIE"';
        Text002: Label 'Draft notice %1', Comment = 'FRA="Avis provisoire %1"';
        Text004: Label 'A transfer to your bank account %1 (RIB : %2 %3 %4) has been done on %5.', Comment = 'FRA="Un virement sur votre compte bancaire %1 (RIB : %2 %3 %4) a été effectué le %5."';
        HeaderText2: Label 'This transfer is related to these invoices :', Comment = 'FRA="Ce virement est lié aux factures suivantes :"';
        OutputNo: Integer;
        Payment_Lines1___No__CaptionLbl: Label 'Draft No.', Comment = 'FRA="N° brouillon"';
        PaymtHeader__IBAN__CaptionLbl: Label 'IBAN', Comment = '"IBAN"';
        PaymtHeader__SWIFT_Code__CaptionLbl: Label 'SWIFT Code', Comment = 'FRA="Code SWIFT"';
        CompanyInformation__VAT_Registration_No__CaptionLbl: Label 'VAT Registration No.', Comment = 'FRA="N° identif. intracomm."';
        CompanyInformation__Fax_No__CaptionLbl: Label 'FAX No.', Comment = 'FRA="N° télécopie"';
        CompanyInformation__Phone_No__CaptionLbl: Label 'Phone No.', Comment = 'FRA="N° téléphone"';
        PrintCurrencyCodeCaptionLbl: Label 'Currency Code', Comment = 'FRA="Code devise"';
        Draft_Notice_AmountCaptionLbl: Label 'Draft Notice Amount', Comment = 'FRA="Montant avis provisoire"';
        Vendor_Ledger_Entry__Posting_Date_CaptionLbl: Label 'Posting Date', Comment = 'FRA=""';
        Vendor_Ledger_Entry__Due_Date_CaptionLbl: Label 'Due Date', Comment = 'FRA="Date d''échéance"';
        ABS__Remaining_Amount___Control1120059CaptionLbl: Label 'Amount', Comment = 'FRA="Montant"';
        ReportCaptionLbl: Label 'Report', Comment = 'FRA="État"';
        ReportCaption_Control1120015Lbl: Label 'Report', Comment = 'FRA="État"';

    procedure PrintCurrencyCode(): Code[10]
    begin
        if "Payment Lines1"."Currency Code" = '' then
            exit(GLSetup."LCY Code");

        exit("Payment Lines1"."Currency Code");
    end;
}
