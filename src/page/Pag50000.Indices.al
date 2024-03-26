namespace Bcsys.CPA.Basics;
page 50000 Indices
{
    PageType = List;
    SourceTable = Indice;
    UsageCategory = None;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                }
                field(Indice; Rec.Indice)
                {
                }
            }
        }
    }
}
