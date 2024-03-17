namespace Bcsys.CPA.Basics;

using Microsoft.Inventory.Item;
report 50000 test
{
    DefaultLayout = RDLC;
    RDLCLayout = './test.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(Item; Item)
        {
            column(No_Item; "No.")
            {
            }
        }
    }
}

