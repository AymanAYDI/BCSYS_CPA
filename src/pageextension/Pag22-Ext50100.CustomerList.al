namespace Bcsys.CPA.Basics;

using Microsoft.Sales.Customer;

pageextension 50100 "CustomerList" extends "Customer List" //22 
{
    trigger OnOpenPage();
    begin
        Message('App published: Hello world');
    end;
}