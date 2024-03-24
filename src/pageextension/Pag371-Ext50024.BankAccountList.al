namespace Bcsys.CPA.Basics;

using Microsoft.Bank.BankAccount;
pageextension 50024 "Bank Account List" extends "Bank Account List" //371
{
    actions
    {
        modify("Bank Account Statements")
        {
            Visible = false;
        }
        addafter("Bank Account Statements")
        {
            action("Bank Account Statements.")
            {
                ApplicationArea = Suite;
                Caption = 'Bank Account Statements', Comment = 'FRA="Relevés bancaires"';
                Image = "Report";
                RunObject = Report "CPA Bank Account Statement";
            }
        }
    }
}