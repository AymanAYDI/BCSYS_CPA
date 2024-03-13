namespace Bcsys.CPA.Basics;

using Microsoft.Finance.GeneralLedger.Budget;
using Microsoft.Finance.Analysis;
tableextension 50006 "G_L Budget Entry" extends "G/L Budget Entry" //96
{
    trigger OnAfterDelete()
    begin
        DeleteAnalysisViewBudgetEntries();
    end;

    local procedure DeleteAnalysisViewBudgetEntries();
    var
        AnalysisViewBudgetEntry: Record "Analysis View Budget Entry";
    begin
        AnalysisViewBudgetEntry.SETRANGE("Budget Name", "Budget Name");
        AnalysisViewBudgetEntry.SETRANGE("Entry No.", "Entry No.");
        AnalysisViewBudgetEntry.DELETEALL();
    end;
}
