namespace Bcsys.CPA.Basics;

using Microsoft.Bank.BankAccount;
using System.Security.AccessControl;
tableextension 50012 "Bank Account" extends "Bank Account" //270
{
    trigger OnBeforeDelete()
    begin
        if not droitEcrBk() then
            ERROR(Text500);
    end;

    trigger OnBeforeInsert()
    begin
        if not droitEcrBk() then
            ERROR(Text500);
    end;

    trigger OnBeforeModify()
    begin
        if not droitEcrBk() then
            ERROR(Text500);
    end;

    local procedure droitEcrBk(): Boolean
    var
        locAccControle: Record "Access Control";
    begin

        CLEAR(locAccControle);
        locAccControle.SETRANGE("User Name", USERID);
        locAccControle.SETRANGE("Role ID", '#CPA_ECRBANK');
        if locAccControle.FINDSET() then
            exit(true)
        else
            exit(false);
    end;

    var
        Text500: Label 'Vous n''avez pas les autorisations d''écriture sur les comptes bancaires', Comment = 'FRA="Vous n''avez pas les autorisations d''écriture sur les comptes bancaires"';
}
