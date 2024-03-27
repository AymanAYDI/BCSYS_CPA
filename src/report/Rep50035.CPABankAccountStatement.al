namespace Bcsys.CPA.Basics;

using Microsoft.Bank.Statement;
using Microsoft.Bank.Ledger;
using System.Utilities;
using Microsoft.Bank.BankAccount;
report 50035 "CPA Bank Account Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/rdl/BankAccountStatement.rdl';
    Caption = 'Bank Account Statement', Comment = 'FRA="Relevé bancaire"';
    UsageCategory = None;
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Account Statement "; "Bank Account Statement")
        {
            DataItemTableView = sorting("Bank Account No.", "Statement No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Bank Account No.", "Statement No.";
            column(ComanyName; COMPANYNAME)
            {
            }
            column(BankAccStmtTableCaptFltr; TABLECAPTION + ': ' + BankAccStmtFilter)
            {
            }
            column(BankAccStmtFilter; BankAccStmtFilter)
            {
            }
            column(StmtNo_BankAccStmt; "Statement No.")
            {
                IncludeCaption = true;
            }
            column(Amt_BankAccStmtLineStmt; "Bank Account Statement Line"."Statement Amount")
            {
            }
            column(AppliedAmt_BankAccStmtLine; "Bank Account Statement Line"."Applied Amount")
            {
            }
            column(BankAccNo_BankAccStmt; "Bank Account No.")
            {
                IncludeCaption = true;
            }
            column(StatementEndingBalance_BankAccStmt; "Statement Ending Balance")
            {
                IncludeCaption = true;
            }
            column(BalanceLastStatement_BankAccStmt; "Balance Last Statement")
            {
                IncludeCaption = true;
            }
            column(BankAccStmtCapt; BankAccStmtCaptLbl)
            {
            }
            column(CurrReportPAGENOCapt; CurrReportPAGENOCaptLbl)
            {
            }
            column(BnkAccStmtLinTrstnDteCapt; BnkAccStmtLinTrstnDteCaptLbl)
            {
            }
            column(BnkAcStmtLinValDteCapt; BnkAcStmtLinValDteCaptLbl)
            {
            }
            column(StatementDte__BankAccStmt; FORMAT("Statement Date"))
            {
            }
            column(ImpLigRelx; ImpLigRelx)
            {
            }
            column(TypeLigne; TypeLigne)
            {
            }
            column(Phase; Phase)
            {
            }
            column(NetChange; NetChange)
            {
            }
            dataitem("Bank Account Statement Line"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No."),
                               "Statement No." = field("Statement No.");
                DataItemTableView = sorting("Bank Account No.", "Statement No.", "Statement Line No.");
                column(TrnsctnDte_BnkAcStmtLin; FORMAT("Transaction Date"))
                {
                }
                column(Type_BankAccStmtLine; Type)
                {
                    IncludeCaption = true;
                }
                column(LineDocNo_BankAccStmt; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(AppliedEntr_BankAccStmtLine; "Applied Entries")
                {
                    IncludeCaption = true;
                }
                column(Amt1_BankAccStmtLineStmt; "Statement Amount")
                {
                    IncludeCaption = true;
                }
                column(AppliedAmt1_BankAccStmtLine; "Applied Amount")
                {
                    IncludeCaption = true;
                }
                column(Desc_BankAccStmtLine; Description)
                {
                    IncludeCaption = true;
                }
                column(ValueDate_BankAccStmtLine; FORMAT("Value Date"))
                {
                }
                column(LineNo_BankAccStmtLine; "Statement Line No.")
                {
                }
                dataitem(OutstandingBankTransaction; "Bank Account Ledger Entry")
                {
                    DataItemLink = "Bank Account No." = field("Bank Account No."),
                                   "Statement No." = field("Statement No."),
                                   "Statement Line No." = field("Statement Line No.");
                    DataItemTableView = sorting("Bank Account No.", "Posting Date")
                                        order(ascending);
                    column(PostingDate_BnkAccLedgEntr; FORMAT("Posting Date"))
                    {
                    }
                    column(Documenttype_BnkAccLedgEntr; "Document Type")
                    {
                    }
                    column(DocumentNo_BnkAccLedgEntr; "Document No.")
                    {
                    }
                    column(Description_BnkAccLedgEntr; Description)
                    {
                    }
                    column(Amount_BnkAccLedgEntr; Amount)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if ImpLigRel then
                            Phase += 1
                        else
                            CurrReport.SKIP();
                    end;
                }

                trigger OnAfterGetRecord()
                begin

                    TypeLigne := 'ST';
                    Phase := 0;

                    TotAppliedAmount += "Applied Amount";
                    TotStatementAmount += "Statement Amount";
                end;
            }
            dataitem(EcrituresAvant; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No.");
                DataItemTableView = sorting("Bank Account No.", "Posting Date");
                column(PostingDate_EcrituresAvant; FORMAT("Posting Date"))
                {
                }
                column(Documenttype_EcrituresAvant; "Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocumentNo_EcrituresAvant; "Document No.")
                {
                    IncludeCaption = true;
                }
                column(ExternalDocumentNo_EcrituresAvant; "External Document No.")
                {
                    IncludeCaption = true;
                }
                column(Description_EcrituresAvant; Description)
                {
                    IncludeCaption = true;
                }
                column(DebitAmount_EcrituresAvant; "Debit Amount")
                {
                    IncludeCaption = true;
                }
                column(CreditAmount_EcrituresAvant; "Credit Amount")
                {
                    IncludeCaption = true;
                }
                column(ImpLigAvant; ImpLigAvant)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Imp := Open;

                    if not Open then
                        if "Statement No." <> "Bank Account Statement "."Statement No." then
                            if BankAccountStat2.GET("Bank Account No.", "Statement No.") then
                                if BankAccountStat2."Statement Date" > "Bank Account Statement "."Statement Date" then
                                    Imp := true;

                    if Imp then begin
                        StmtBalance -= ("Debit Amount" - "Credit Amount");
                        ImpLigAvant := 'Y';
                    end else begin
                        ImpLigAvant := 'N';
                        CurrReport.SKIP();
                    end;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Posting Date", 0D, "Bank Account Statement "."Statement Date");
                    TypeLigne := 'AV';
                end;
            }
            dataitem(EcrituresApres; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = field("Bank Account No.");
                DataItemTableView = sorting("Bank Account No.", "Posting Date")
                                    order(ascending);
                column(PostingDate_EcrituresApres; FORMAT("Posting Date"))
                {
                }
                column(Documenttype_EcrituresApres; "Document Type")
                {
                }
                column(DocumentNo_EcrituresApres; "Document No.")
                {
                }
                column(ExternalDocumentNo_EcrituresApres; "External Document No.")
                {
                }
                column(Description_EcrituresApres; Description)
                {
                }
                column(DebitAmount_EcrituresApres; "Debit Amount")
                {
                }
                column(CreditAmount_EcrituresApres; "Credit Amount")
                {
                }

                trigger OnPreDataItem()
                begin
                    TypeLigne := 'AP';
                    SETFILTER("Posting Date", '>%1', "Bank Account Statement "."Statement Date");
                    SETRANGE("Statement No.", "Bank Account Statement "."Statement No.");
                    StmtBalance += ("Debit Amount" - "Credit Amount")
                end;
            }
            dataitem(Total; Integer)
            {
                DataItemTableView = sorting(Number)
                                    where(Number = const(1));
                column(StmtBalance; StmtBalance)
                {
                }

                trigger OnPreDataItem()
                begin
                    TypeLigne := 'TO';
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Phase := 0;
                BankAccount.GET("Bank Account Statement "."Bank Account No.");
                BankAccount.SETRANGE("Date Filter", 0D, "Statement Date");
                BankAccount.CALCFIELDS("Net Change");
                StmtBalance := BankAccount."Net Change";
                NetChange := BankAccount."Net Change";
            end;

            trigger OnPreDataItem()
            begin
                if ImpLigRel then
                    ImpLigRelx := 'Y'
                else
                    ImpLigRelx := 'N';
            end;
        }
        dataitem(Total2; Integer)
        {
            DataItemTableView = sorting(Number)
                                order(ascending)
                                where(Number = const(1));
            column(TotAppliedAmount; TotAppliedAmount)
            {
            }
            column(TotStatementAmount; TotStatementAmount)
            {
            }
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
                    Editable = BankStatementVisible;
                    Enabled = BankStatementVisible;
                    Visible = BankStatementVisible;
                    field(ImpLigRelF; ImpLigRel)
                    {
                        Caption = 'Sorted by Document No.', Comment = 'FRA="Trié par n° document"';
                        Editable = BankStatementVisible;
                        Enabled = BankStatementVisible;
                        Visible = BankStatementVisible;
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    labels
    {
        TotalCaption = 'Total', Comment = 'FRA="Total"';
        EcrNonRapprCaption = 'Ecritures non rapprochées', Comment = 'FRA="Ecritures non rapprochées"';
        TotEcrNonRapprCaption = 'Total écritures non rapprochées', Comment = 'FRA="Total écritures non rapprochées"';
        EcrPrisesCompteCaption = 'Ecritures prises en compte après le', Comment = 'FRA="Ecritures prises en compte après le"';
        TotEcrPrisesCompteCaption = 'Total écritures prises en compte', Comment = 'FRA="Total écritures prises en compte"';
        DiffCaption = 'Différence', Comment = 'FRA="Différence"';
        MontantCalculeCaption = 'Montant relevé calculé', Comment = 'FRA="Montant relevé calculé"';
        PostingDateCaption = 'Date Compta.', Comment = 'FRA="Date Compta."';
        SoldeCaption = 'Solde', Comment = 'FRA="Solde"';
        SoldeFinalCaption = 'Solde final relevé', Comment = 'FRA="Solde final relevé"';
        StatmDate = 'Date du relevé', Comment = 'FRA="Date du relevé"';
        SoldeCompte = 'Solde compte au', Comment = 'FRA="Solde compte au"';
        DocumentTypeCaption = 'Type Doc.', Comment = 'FRA="Type Doc."';
    }

    trigger OnInitReport()
    begin
        BankStatementVisible := true;
    end;

    trigger OnPreReport()
    begin
        BankAccStmtFilter := "Bank Account Statement ".GETFILTERS;
    end;

    var
        BankAccountStat2: Record "Bank Account Statement";
        BankAccount: Record "Bank Account";
        BankAccStmtFilter: Text;
        BankAccStmtCaptLbl: Label 'Bank Account Statement', Comment = 'FRA="Relevés bancaire"';
        CurrReportPAGENOCaptLbl: Label 'Page', Comment = 'FRA="Page"';
        BnkAccStmtLinTrstnDteCaptLbl: Label 'Transaction Date', Comment = 'FRA="Date transaction"';
        BnkAcStmtLinValDteCaptLbl: Label 'Value Date', Comment = 'FRA="Date de valeur"';
        Imp: Boolean;
        Phase: Integer;
        ImpLigRel: Boolean;
        ImpLigRelx: Text[1];
        ImpLigAvant: Text[1];
        BankStatementVisible: Boolean;
        TypeLigne: Text[2];
        StmtBalance: Decimal;
        NetChange: Decimal;
        TotAppliedAmount: Decimal;
        TotStatementAmount: Decimal;
}
