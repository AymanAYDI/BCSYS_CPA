namespace Bcsys.CPA.Basics;

using Microsoft.Bank.Ledger;
codeunit 50002 "Reopen BankAccountLdgerEntries"
{
    Permissions = TableData "Bank Account Ledger Entry" = rim;

    trigger OnRun()
    begin
        exit;
        BankAccountLedgerEntry.SETFILTER("Entry No.", '22382|24653|22384|22437|22444|24655|22386|22439|22446|24657');
        BankAccountLedgerEntry.SETRANGE("Bank Account No.", 'CCO');

        MESSAGE('%1', BankAccountLedgerEntry.COUNT);

        if BankAccountLedgerEntry.FINDFIRST() then
            repeat
                BankAccountLedgerEntry."Statement No." := '';
                BankAccountLedgerEntry."Statement Line No." := 0;
                BankAccountLedgerEntry."Statement Status" := BankAccountLedgerEntry."Statement Status"::Open;
            until BankAccountLedgerEntry.NEXT() = 0;
    end;

    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
}
