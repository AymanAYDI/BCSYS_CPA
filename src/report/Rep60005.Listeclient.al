namespace Bcsys.CPA.Basics;

using Microsoft.Sales.Customer;
report 60005 "Liste client"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Listeclient.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No; Customer."No.")
            {
            }
            column(Nom; Customer.Name)
            {
            }
            column(Adresse; Customer.Address)
            {
            }
            column(Phone; Customer."Phone No.")
            {
            }
        }
    }
}

