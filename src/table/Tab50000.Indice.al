namespace Bcsys.CPA.Basics;
table 50000 Indice
{
    fields
    {
        field(1; Date; Date)
        {
        }
        field(2; Indice; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; Date)
        {
            Clustered = true;
        }
    }
}

