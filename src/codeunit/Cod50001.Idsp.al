codeunit 50001 Idsp
{
    var
        BookType: enum "Book Code Type";
        FAPostingType: Enum FAPostingType;
        Last: Enum Last;
        FAPostingCategory: Enum FAPostingCategory;
        DateSelect: Enum DateSelect;
        mtt_eco: Decimal;
        mtt_prov: Decimal;

    procedure Vdeeco(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Economic;
        FAPostingType := FAPostingType::"Acquisition Cost";
        DateSelect := DateSelect::Before;
        Last := Last::All;
        FAPostingCategory := FAPostingCategory::All;
        mtt_eco := Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory);
        BookType := BookType::Provision;
        mtt_prov := Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory);
        exit(mtt_eco + mtt_prov);
    end;

    procedure Veeeco(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Economic;
        FAPostingType := FAPostingType::"Acquisition Cost";
        DateSelect := DateSelect::During;
        Last := Last::All;
        FAPostingCategory := FAPostingCategory::" ";
        mtt_eco := Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory);
        BookType := BookType::Provision;
        mtt_prov := Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory);
        exit(mtt_eco + mtt_prov);
    end;

    procedure Veseco(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Economic;
        FAPostingType := FAPostingType::"Acquisition Cost";
        DateSelect := DateSelect::During;
        Last := Last::All;
        FAPostingCategory := FAPostingCategory::Disposal;
        mtt_eco := Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory);
        BookType := BookType::Provision;
        mtt_prov := Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory);
        exit(mtt_eco + mtt_prov);
    end;

    procedure Ddeecot(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Economic;
        FAPostingType := FAPostingType::Depreciation;
        DateSelect := DateSelect::Before;
        Last := Last::All;
        FAPostingCategory := FAPostingCategory::All;
        exit(Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory));
    end;

    procedure Dexecot(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Economic;
        FAPostingType := FAPostingType::Depreciation;
        DateSelect := DateSelect::During;
        Last := Last::All;
        FAPostingCategory := FAPostingCategory::" ";
        exit(Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory));
    end;

    procedure Dreecot(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Economic;
        FAPostingType := FAPostingType::Depreciation;
        DateSelect := DateSelect::During;
        Last := Last::All;
        FAPostingCategory := FAPostingCategory::Disposal;
        exit(Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory));
    end;

    procedure Ddeecop(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Economic;
        FAPostingType := FAPostingType::Depreciation;
        DateSelect := DateSelect::Before;
        Last := Last::No;
        FAPostingCategory := FAPostingCategory::All;

        exit(Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory));
    end;

    procedure Dexecop(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Economic;
        FAPostingType := FAPostingType::Depreciation;
        DateSelect := DateSelect::During;
        Last := Last::No;
        FAPostingCategory := FAPostingCategory::" ";

        exit(Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory));
    end;

    procedure Dreecop(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Economic;
        FAPostingType := FAPostingType::Depreciation;
        DateSelect := DateSelect::During;
        Last := Last::No;
        FAPostingCategory := FAPostingCategory::Disposal;

        exit(Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory));
    end;

    procedure Ddeecod(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Economic;
        FAPostingType := FAPostingType::Depreciation;
        DateSelect := DateSelect::Before;
        Last := Last::Yes;
        FAPostingCategory := FAPostingCategory::All;

        exit(Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory));
    end;

    procedure Dexecod(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Economic;
        FAPostingType := FAPostingType::Depreciation;
        DateSelect := DateSelect::During;
        Last := Last::Yes;
        FAPostingCategory := FAPostingCategory::" ";

        exit(Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory));
    end;

    procedure Dreecod(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Economic;
        FAPostingType := FAPostingType::Depreciation;
        DateSelect := DateSelect::During;
        Last := Last::Yes;
        FAPostingCategory := FAPostingCategory::Disposal;

        exit(Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory));
    end;

    procedure Ddeprv(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Provision;
        FAPostingType := FAPostingType::Depreciation;
        DateSelect := DateSelect::Before;
        Last := Last::All;
        FAPostingCategory := FAPostingCategory::All;

        exit(Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory));
    end;

    procedure Dexprv(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Provision;
        FAPostingType := FAPostingType::Depreciation;
        DateSelect := DateSelect::During;
        Last := Last::All;
        FAPostingCategory := FAPostingCategory::" ";

        exit(Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory));
    end;

    procedure Dreprv(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Provision;
        FAPostingType := FAPostingType::Depreciation;
        DateSelect := DateSelect::During;
        Last := Last::All;
        FAPostingCategory := FAPostingCategory::Disposal;

        exit(Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory));
    end;

    procedure Dfeprv(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Provision;
        FAPostingType := FAPostingType::Depreciation;
        DateSelect := DateSelect::"Until";
        Last := Last::All;
        FAPostingCategory := FAPostingCategory::" ";

        exit(Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory));
    end;

    procedure Ddecad(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Caducity;
        FAPostingType := FAPostingType::Depreciation;
        DateSelect := DateSelect::Before;
        Last := Last::All;
        FAPostingCategory := FAPostingCategory::All;

        exit(Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory));
    end;

    procedure Dexcad(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Caducity;
        FAPostingType := FAPostingType::Depreciation;
        DateSelect := DateSelect::During;
        Last := Last::All;
        FAPostingCategory := FAPostingCategory::" ";

        exit(Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory));
    end;

    procedure Drecad(var FANo: Code[20]; var FromDate: Date; var ToDate: Date): Decimal
    begin
        BookType := BookType::Caducity;
        FAPostingType := FAPostingType::Depreciation;
        DateSelect := DateSelect::During;
        Last := Last::All;
        FAPostingCategory := FAPostingCategory::Disposal;

        exit(Calculate(FANo, BookType, FAPostingType, DateSelect, FromDate, ToDate, Last, FAPostingCategory));
    end;

    procedure Calculate(var LFANo: Code[20]; var LBookType: enum "Book Code Type"; var LFAPostingType: Enum FAPostingType; var LDateSelect: Enum DateSelect; var LFromDate: Date; var LToDate: Date; var Llast: Enum Last; var LFAPostingCategory: Enum FAPostingCategory) LAmount: Decimal
    var
        FALedgerEntry: Record 5601;
        DepreciationBook: Record 5611;
        FixedAsset: Record 5600;
        FASetup: Record 5603;
    begin
        FASetup.GET();
        LAmount := 0;
        FALedgerEntry.RESET();
        FALedgerEntry.SETCURRENTKEY("FA No.", "Depreciation Book Code", "FA Posting Date");
        FALedgerEntry.SETFILTER("FA No.", LFANo);
        FALedgerEntry.SETRANGE("FA Posting Type", LFAPostingType);

        case LDateSelect of
            LDateSelect::Before:
                FALedgerEntry.SETFILTER("FA Posting Date", '<%1', LFromDate);
            LDateSelect::During:
                FALedgerEntry.SETFILTER("FA Posting Date", '%1..%2', LFromDate, LToDate);
            LDateSelect::"Until":
                FALedgerEntry.SETFILTER("FA Posting Date", '<=%1', LToDate);
        end;

        case LFAPostingCategory of
            LFAPostingCategory::All:
                FALedgerEntry.SETRANGE("FA Posting Category");
            LFAPostingCategory::" ":
                FALedgerEntry.SETRANGE("FA Posting Category", FALedgerEntry."FA Posting Category"::" ");
            LFAPostingCategory::Disposal:
                FALedgerEntry.SETRANGE("FA Posting Category", FALedgerEntry."FA Posting Category"::Disposal);
        end;

        if FALedgerEntry.FINDSET() then
            repeat

                if FALedgerEntry."Depreciation Book Code" <> DepreciationBook.Code then
                    DepreciationBook.GET(FALedgerEntry."Depreciation Book Code");

                FixedAsset.GET(FALedgerEntry."FA No.");

                if DepreciationBook.Type = LBookType then
                    if (FixedAsset.Renewable = FixedAsset.Renewable::Autre) or
                 ((FixedAsset.Renewable = FixedAsset.Renewable::Oui) and
                  (FALedgerEntry."Depreciation Book Code" <> FASetup."Non Renew.Deprec. Book Code")) or
                 ((FixedAsset.Renewable = FixedAsset.Renewable::Non) and
                  (FALedgerEntry."Depreciation Book Code" <> FASetup."Renewable Deprec. Book Code")) then
                        if (Llast = Llast::All) or
                          ((FixedAsset."Last Asset In Concession" = FixedAsset."Last Asset In Concession"::Oui) and (Llast = Llast::Yes)) or
                          ((FixedAsset."Last Asset In Concession" = FixedAsset."Last Asset In Concession"::Non) and (Llast = Llast::No)) then
                            LAmount += FALedgerEntry.Amount;
            until FALedgerEntry.NEXT() = 0;

        if LFAPostingCategory = LFAPostingCategory::Disposal then
            LAmount := -1 * LAmount;
    end;
}
