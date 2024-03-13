namespace Bcsys.CPA.Basics;

using Microsoft.CRM.Team;
using Microsoft.Sales.Customer;
using Microsoft.Inventory.Item;
tableextension 50013 Team extends Team //5083
{
    fields
    {
        field(50000; "Customer No."; Code[20])
        {
            Caption = 'Client', comment = 'FRA="Client"';
            TableRelation = Customer;
        }
        field(50001; "Item No."; Code[20])
        {
            Caption = 'Article', comment = 'FRA="Article"';
            TableRelation = Item;
        }
        field(50002; "Type Equipement"; Enum "Type Equipement")
        {
            Caption = 'Type Equipement', comment = 'FRA="Type Equipement"';
        }
    }
}
