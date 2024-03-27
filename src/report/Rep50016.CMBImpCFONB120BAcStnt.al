namespace Bcsys.CPA.Basics;

using Microsoft.Bank.Reconciliation;
using Microsoft.Bank.BankAccount;
report 50016 "CMB- Imp. CFONB120 B. Ac. Stnt"
{
    Caption = 'Import CFONB Bank Acc. Stnt', Comment = 'FRA="Import relevé bancaire CFONB120"';
    ProcessingOnly = true;
    UseRequestPage = true;
    UsageCategory = Tasks;
    ApplicationArea = All;

    requestpage
    {
        layout
        {
            area(content)
            {
                field(ZoneCode_GF; ZoneCode_G)
                {
                    Caption = 'Bank statement date', Comment = 'FRA="Code info. complémentaire"';
                    ApplicationArea = All;
                }
            }
        }

        trigger OnOpenPage()
        begin
            StatementDate_G := WORKDATE();
        end;
    }
    trigger OnPostReport()
    begin
        CLEAR(InStream_G);
    end;

    trigger OnPreReport()
    var
        FileLineTxt_G: Text[120];
    begin
        CreatedHeaderNo_G := 0;
        if not UPLOADINTOSTREAM(Text8060982, '', '', FileName_G, InStream_G) then
            ERROR('');

        if StatementDate_G = 0D then
            ERROR(Text8060986);

        Window_G.OPEN('Import    #1###############');
        NextLineNo_G := 10000;

        while not (InStream_G.EOS) do begin

            InStream_G.READTEXT(FileLineTxt_G, 120);
            Window_G.UPDATE(1, NextLineNo_G / 10000);

            if NextLineNo_G = 10000 then
                if COPYSTR(FileLineTxt_G, 1, 2) <> '01' then
                    ERROR(Text8060985);

            if COPYSTR(FileLineTxt_G, 1, 2) = '01' then
                InsertBankRecHeader(FileLineTxt_G);

            if COPYSTR(FileLineTxt_G, 1, 2) = '04' then
                InsertBankRecLine(FileLineTxt_G);

            if COPYSTR(FileLineTxt_G, 1, 2) = '05' then
                UpdateBankRecLine(FileLineTxt_G);

            if COPYSTR(FileLineTxt_G, 1, 2) = '07' then
                UpdateBankRecHeader(FileLineTxt_G);

            NextLineNo_G += 10000;
        end;

        Window_G.CLOSE();
        MESSAGE(Text8060983, CreatedHeaderNo_G);
    end;

    var
        BankAccRecon_G: Record "Bank Acc. Reconciliation";
        BankAccReconLine_G: Record "Bank Acc. Reconciliation Line";
        TempBankAccRec_G: Record "Bank Acc. Reconciliation" temporary;
        InStream_G: InStream;
        Text8060982: Label 'Import Bank acc. Rec. SG CFONB120', Comment = 'FRA="Import relevé bancaire CFONB120"';
        Text8060983: Label 'Import completed.', Comment = 'FRA="Import terminé. %1 relevé(s) créé(s)."';
        FileName_G: Text[1024];
        NextLineNo_G: Integer;
        Text8060985: Label 'File Format does not match.', Comment = 'FRA="Format de fichier non conforme."';
        StatementDate_G: Date;
        Text8060986: Label 'Statement date should be set.', Comment = 'FRA="Pour le compte bancaire %1, le solde du dernier relevé (%2) ne correspond à celui du premier relevé importé (%3)."';
        IsMaptableRead_G: Boolean;
        Window_G: Dialog;
        MapTableCodeDebit_G: array[20] of Code[1];
        MapTableCodeCredit_G: array[10] of Code[1];
        DoProcessLines_G: Boolean;
        CreatedHeaderNo_G: Integer;
        ZoneCode_G: Enum ZoneCode;

    procedure GetCFONB120Amount(CFONB120Amt_14: Text[14]; _decimalPlace: Text[1]) result: Decimal
    var
        l_x: Integer;
        l_Decimalplace: Integer;
    begin
        if not IsMaptableRead_G then begin
            MapTableCodeCredit_G[1] := 'A';
            MapTableCodeCredit_G[2] := 'B';
            MapTableCodeCredit_G[3] := 'C';
            MapTableCodeCredit_G[4] := 'D';
            MapTableCodeCredit_G[5] := 'E';
            MapTableCodeCredit_G[6] := 'F';
            MapTableCodeCredit_G[7] := 'G';
            MapTableCodeCredit_G[8] := 'H';
            MapTableCodeCredit_G[9] := 'I';
            MapTableCodeCredit_G[10] := '{';

            MapTableCodeDebit_G[1] := 'J';
            MapTableCodeDebit_G[2] := 'K';
            MapTableCodeDebit_G[3] := 'L';
            MapTableCodeDebit_G[4] := 'M';
            MapTableCodeDebit_G[5] := 'N';
            MapTableCodeDebit_G[6] := 'O';
            MapTableCodeDebit_G[7] := 'P';
            MapTableCodeDebit_G[8] := 'Q';
            MapTableCodeDebit_G[9] := 'R';
            MapTableCodeDebit_G[10] := '}';

            IsMaptableRead_G := true;
        end;

        for l_x := 1 to 10 do begin

            if COPYSTR(CFONB120Amt_14, 14, 1) = MapTableCodeDebit_G[l_x] then
                if l_x < 10 then begin
                    CFONB120Amt_14 := CONVERTSTR(CFONB120Amt_14, MapTableCodeDebit_G[l_x], FORMAT(l_x));
                    EVALUATE(result, CFONB120Amt_14);
                    result := -result;
                end else begin
                    CFONB120Amt_14 := CONVERTSTR(CFONB120Amt_14, MapTableCodeDebit_G[l_x], '0');
                    EVALUATE(result, CFONB120Amt_14);
                    result := -result;
                end;

            if COPYSTR(CFONB120Amt_14, 14, 1) = MapTableCodeCredit_G[l_x] then
                if l_x < 10 then begin
                    CFONB120Amt_14 := CONVERTSTR(CFONB120Amt_14, MapTableCodeCredit_G[l_x], FORMAT(l_x));
                    EVALUATE(result, CFONB120Amt_14);
                end else begin
                    CFONB120Amt_14 := CONVERTSTR(CFONB120Amt_14, MapTableCodeCredit_G[l_x], '0');
                    EVALUATE(result, CFONB120Amt_14);
                end;
        end;

        EVALUATE(l_Decimalplace, _decimalPlace);
        for l_x := 1 to l_Decimalplace do
            result := result / 10;

        exit(result);
    end;

    procedure convertCFONB120date(_CFONBDateTxt: Text[6]) result: Date
    begin
        EVALUATE(result, _CFONBDateTxt);
        exit(result);
    end;

    procedure InsertBankRecHeader(FileTxtLine_P: Text[120])
    var
        BankAccount_L: Record "Bank Account";
        BankAccRecon_L: Record "Bank Acc. Reconciliation";
        LastBalanceStatement_L: Decimal;
    begin
        BankAccount_L.RESET();
        BankAccount_L.SETFILTER("Bank Branch No.", COPYSTR(FileTxtLine_P, 3, 5));
        BankAccount_L.SETFILTER("Agency Code", COPYSTR(FileTxtLine_P, 12, 5));
        BankAccount_L.SETFILTER("Bank Account No.", COPYSTR(FileTxtLine_P, 22, 11));
        if BankAccount_L.FINDFIRST() then begin
            DoProcessLines_G := true;
            TempBankAccRec_G.RESET();
            TempBankAccRec_G.SETRANGE("Bank Account No.", BankAccount_L."No.");
            if TempBankAccRec_G.FINDFIRST() then
                BankAccRecon_G.GET(TempBankAccRec_G."Statement Type", TempBankAccRec_G."Bank Account No.", TempBankAccRec_G."Statement No.")

            else begin

                LastBalanceStatement_L := GetCFONB120Amount(COPYSTR(FileTxtLine_P, 91, 14), COPYSTR(FileTxtLine_P, 20, 1));

                if BankAccount_L."Balance Last Statement" <> LastBalanceStatement_L then
                    ERROR(Text8060986, BankAccount_L."No.", BankAccount_L."Balance Last Statement", LastBalanceStatement_L);

                BankAccRecon_G.INIT();
                BankAccRecon_G.VALIDATE("Bank Account No.", BankAccount_L."No.");
                if BankAccRecon_G."Statement No." = '' then begin
                    BankAccRecon_L.RESET();
                    BankAccRecon_L.SETRANGE("Statement Type", BankAccRecon_L."Statement Type"::"Bank Reconciliation");
                    BankAccRecon_L.SETRANGE("Bank Account No.", BankAccount_L."No.");
                    if BankAccRecon_L.FINDLAST() then
                        BankAccRecon_G."Statement No." := INCSTR(BankAccRecon_L."Statement No.")
                    else
                        BankAccRecon_G."Statement No." := '1';
                end;
                BankAccRecon_G."Balance Last Statement" := LastBalanceStatement_L;
                BankAccRecon_G.INSERT(true);

                TempBankAccRec_G.INIT();
                TempBankAccRec_G."Statement Type" := BankAccRecon_G."Statement Type";
                TempBankAccRec_G."Bank Account No." := BankAccRecon_G."Bank Account No.";
                TempBankAccRec_G."Statement No." := BankAccRecon_G."Statement No.";
                TempBankAccRec_G.INSERT();

                CreatedHeaderNo_G += 1;
            end;
        end else
            DoProcessLines_G := false;
    end;

    procedure InsertBankRecLine(FileLineTxt_P: Text[120])
    begin
        if DoProcessLines_G then begin
            BankAccReconLine_G.INIT();
            BankAccReconLine_G.VALIDATE(Type, BankAccReconLine_G.Type::"Bank Account Ledger Entry");
            BankAccReconLine_G."Bank Account No." := BankAccRecon_G."Bank Account No.";
            BankAccReconLine_G."Statement No." := BankAccRecon_G."Statement No.";
            BankAccReconLine_G."Statement Line No." := NextLineNo_G;
            BankAccReconLine_G."Document No." := COPYSTR(FileLineTxt_P, 82, 7);
            BankAccReconLine_G."Transaction Date" := convertCFONB120date(COPYSTR(FileLineTxt_P, 35, 6));
            BankAccReconLine_G.Description := COPYSTR(FileLineTxt_P, 49, 31);
            BankAccReconLine_G.VALIDATE("Statement Amount",
                  GetCFONB120Amount(COPYSTR(FileLineTxt_P, 91, 14), COPYSTR(FileLineTxt_P, 20, 1)));
            BankAccReconLine_G."Value Date" := convertCFONB120date(COPYSTR(FileLineTxt_P, 43, 6));
            BankAccReconLine_G.INSERT(true);
        end;
    end;

    local procedure UpdateBankRecHeader(FileLineTxt_P: Text[120])
    begin
        if DoProcessLines_G then begin
            BankAccRecon_G."Statement Ending Balance" :=
              GetCFONB120Amount(COPYSTR(FileLineTxt_P, 91, 14), COPYSTR(FileLineTxt_P, 20, 1));
            EVALUATE(BankAccRecon_G."Statement Date", COPYSTR(FileLineTxt_P, 35, 6));
            BankAccRecon_G.MODIFY();
        end;
    end;

    local procedure UpdateBankRecLine(FileLineTxt_P: Text[120])
    var
        ZoneCode_L: Code[3];
        TransactionInfo_L: Text[100];
    begin
        if DoProcessLines_G and (FORMAT(ZoneCode_G) <> '') then begin
            EVALUATE(ZoneCode_L, COPYSTR(FileLineTxt_P, 46, 3));
            if ZoneCode_L = FORMAT(ZoneCode_G) then begin
                EVALUATE(TransactionInfo_L, COPYSTR(FileLineTxt_P, 49, 70));
                TransactionInfo_L := CopyStr(DELCHR(DELSTR(STRSUBSTNO('%1 %2', BankAccReconLine_G."Additional Transaction Info", TransactionInfo_L), 100), '>', ' '), 1, MaxStrLen(TransactionInfo_L));
                BankAccReconLine_G."Additional Transaction Info" := TransactionInfo_L;
                BankAccReconLine_G.MODIFY();
            end;
        end;
    end;
}
