namespace Bcsys.CPA.Basics;

using Microsoft.FixedAssets.FixedAsset;
report 60004 "test immo"
{
    DefaultLayout = RDLC;
    RDLCLayout = './testimmo.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            RequestFilterFields = "No.";
            column(Idsp_Vdeeco; Idsp.Vdeeco("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Veeeco; Idsp.Veeeco("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Veseco; Idsp.Veseco("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Ddeecot; Idsp.Ddeecot("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Dexecot; Idsp.Dexecot("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Dreecot; Idsp.Dreecot("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Ddeecop; Idsp.Ddeecop("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Dexecop; Idsp.Dexecop("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Dreecop; Idsp.Dreecop("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Ddeecod; Idsp.Ddeecod("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Dexecod; Idsp.Dexecod("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Dreecod; Idsp.Dreecod("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Ddeprv; Idsp.Ddeprv("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Dexprv; Idsp.Dexprv("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Dreprv; Idsp.Dreprv("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Dfeprv; Idsp.Dfeprv("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Ddecad; Idsp.Ddecad("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Dexcad; Idsp.Dexcad("Fixed Asset"."No.", Deb, Fin))
            {
            }
            column(Idsp_Drecad; Idsp.Drecad("Fixed Asset"."No.", Deb, Fin))
            {
            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("")
                {
                    field(Deb; Deb)
                    {
                        Caption = 'Deb', Comment = 'FRA="Deb"';
                        ApplicationArea = All;
                    }
                    field(Fin; Fin)
                    {
                        Caption = 'Fin', Comment = 'FRA="Fin"';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    var
        Deb: Date;
        Fin: Date;
        Idsp: Codeunit Idsp;
}
