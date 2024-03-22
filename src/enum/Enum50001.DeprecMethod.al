enum 50001 "Deprec Method"
{
    Extensible = false;

    value(0; "Straight-Line")
    {
        Caption = 'Straight-Line', Comment = 'FRA="Linéaire"';
    }
    value(1; "Declining-Balance 1")
    {
        Caption = 'Declining-Balance 1', Comment = 'FRA="Dégressif 1"';
    }
    value(2; "Declining-Balance 2")
    {
        Caption = 'Declining-Balance 2', Comment = 'FRA="Dégressif 2"';
    }
    value(3; "DB1/SL")
    {
        Caption = 'DB1/SL', Comment = 'FRA="Dégr. 1/Lin."';
    }
    value(4; "DB2/SL")
    {
        Caption = 'DB2/SL', Comment = 'FRA="Dégr. 2/Lin."';
    }
    value(5; "User-Defined")
    {
        Caption = 'User-Defined', Comment = 'FRA="Paramétrable"';
    }
    value(6; Manual)
    {
        Caption = 'Manual', Comment = 'FRA="Manuelle"';
    }
}