enum 50003 "Funding Method"
{
    Extensible = false;

    value(0; Autre)
    {
        Caption = 'Other', Comment = 'FRA="Autre"';
    }
    value(1; Classique)
    {
        Caption = 'Classical', Comment = 'FRA="Classique"';
    }
    value(2; "Crédit bail")
    {
        Caption = 'Credit Lease', Comment = 'FRA="Crédit bail"';
    }
}