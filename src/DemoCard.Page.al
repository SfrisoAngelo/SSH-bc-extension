page 73034 "Demo Card"
{
    PageType = CardPart;
    //SourceTable = "Employee"; // seems not necessary after all

    layout
    {
        area(content)
        {
            usercontrol(Demo; "Demo Control")
            {
                ApplicationArea = all;
                trigger Ready()
                begin
                    Message('We are ready!!!');
                end;
            }
        }
    }
}