namespace Bcsys.CPA.Basics;

report 50033 "Import Subscribers"
{
    Caption = 'Import Subscribers', Comment = 'FRA="Import abonnées"';
    ProcessingOnly = true;
    UseRequestPage = false;
    UsageCategory = None;
    ApplicationArea = All;

    trigger OnPreReport()
    var
        TempFile: Text;
        FileInStream: InStream;
    begin
        Clear(FileInStream);
        if UploadIntoStream(Text001, '', Text002, TempFile, FileInStream) then
            ImportSubscribers(FileInStream);
        CurrReport.QUIT();
    end;

    var
        G_ImportSubscribers: XMLport "Import Subscribers";
        Text001: Label 'Import from XML File', Comment = 'FRA="Import à partir d''un fichier XML"';
        Text002: Label 'XML Files (*.xml)|*.xml|All Files (*.*)|*.*', Comment = 'FRA="Fichiers XML (*.xml)|*.xml|Tous les fichiers (*.*)|*.*"';
        G_Temp: Code[10];
        G_Batch: Code[10];

    procedure ImportSubscribers(FileInStream: InStream)
    begin
        G_ImportSubscribers.InitJournalTemplate(G_Temp, G_Batch);
        G_ImportSubscribers.SETSOURCE(FileInStream);
        G_ImportSubscribers.IMPORT();
    end;

    procedure InitJournalTemplate(P_TemplateJnl: Code[10]; P_BatchName: Code[10])
    begin
        G_Temp := P_TemplateJnl;
        G_Batch := P_BatchName;
    end;
}