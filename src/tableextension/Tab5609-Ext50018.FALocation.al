namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.Setup;
using Microsoft.Finance.Dimension;
tableextension 50018 "FA Location" extends "FA Location" //5609
{
    fields
    {
        field(50000; "Concession Start Date"; Date)
        {
            Caption = 'Concession start Date', Comment = 'FRA="Debut de concession"';

            trigger OnValidate()
            begin
                Chkdates();
            end;
        }
        field(50001; "Concession End Date"; Date)
        {
            Caption = 'Concession End  Date', Comment = 'FRA="Fin de concession"';

            trigger OnValidate()
            begin
                Chkdates();
            end;
        }
        field(50002; "Year Number"; Integer)
        {
            Caption = 'Year Number', Comment = 'FRA="Nombre d''années"';
            MinValue = 0;
        }
    }

    trigger OnBeforeDelete()
    begin
        GType := GType::Delete;
        UpdateDimension();
    end;

    trigger OnBeforeInsert()
    begin
        GType := GType::Insert;
        UpdateDimension();
    end;

    trigger OnBeforeModify()
    begin
        GType := GType::Modify;
        UpdateDimension();
    end;

    trigger OnBeforeRename()
    begin
        GType := GType::Rename;
        UpdateDimension();
    end;

    procedure Chkdates()
    begin
        if ("Concession Start Date" <> 0D) and ("Concession End Date" <> 0D) then begin
            if "Concession Start Date" > "Concession End Date" then
                ERROR(Text50000);

            "Year Number" := ROUND(("Concession End Date" - "Concession Start Date") / 365, 1)
        end;
    end;

    procedure UpdateDimension()
    var
        LFASetup: Record "FA Setup";
        LDimensionValue: Record "Dimension Value";
    begin
        LFASetup.GET();
        LFASetup.TESTFIELD("Global Dimension Site Code");

        if GType = GType::Delete then begin
            if LDimensionValue.GET(LFASetup."Global Dimension Site Code", Code) then
                LDimensionValue.DELETE(true);
            exit;
        end;

        if GType = GType::Rename then
            if LDimensionValue.GET(LFASetup."Global Dimension Site Code", xRec.Code) then
                LDimensionValue.DELETE(true);

        if GType = GType::Modify then begin
            if LDimensionValue.GET(LFASetup."Global Dimension Site Code", xRec.Code) then
                LDimensionValue.VALIDATE(Name, COPYSTR(Name, 1, 50));
            LDimensionValue.MODIFY(true);
        end;

        LDimensionValue.INIT();
        LDimensionValue.VALIDATE("Dimension Code", LFASetup."Global Dimension Site Code");
        LDimensionValue.VALIDATE(Code, Code);
        LDimensionValue.VALIDATE(Name, COPYSTR(Name, 1, 50));
        LDimensionValue.VALIDATE("Dimension Value Type", LDimensionValue."Dimension Value Type"::Standard);
    end;

    var
        Text50000: Label 'Wrong Start/End Dates', Comment = 'FRA="Erreur dans les dates debut et fin"';
        GType: Enum GType;
}
