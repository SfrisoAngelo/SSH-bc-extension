page 73031 ItemSattusRentedCuePage
{
    PageType = CardPart;
    SourceTable = ItemStatusCueTable;

    layout
    {
        area(content)
        {
            cuegroup(RentedCueContainer)
            {
                Caption='Rented';
                // CuegroupLayout=Wide;
                field(RentedCue; ItemStatusRentedCount)
                {
                    Caption='Rented';
                    DrillDownPageId="Item Unit List";
                }
            }
        }
    }
        
    trigger OnOpenPage();
    begin
        RESET;
        if not get then begin
            INIT;
            INSERT;
        end;
    end;
}