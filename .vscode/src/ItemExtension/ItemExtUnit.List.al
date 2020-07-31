page 73014 "Item Unit List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Item;
    CardPageId = "Item Unit Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field(Kind; Kind)
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {
                    ApplicationArea = All;

                }

                field(Status; Status)
                {
                    ApplicationArea = All;

                }
                field("Floor Name"; "Floor Name")
                {
                    ApplicationArea = All;
                }

                field("Complex Name"; "Complex Name")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
            // part(ItemSattusRentedCuePage; ItemSattusRentedCuePage)
            // {
            //     ApplicationArea = All;
            // }
            // systempart(Links; Links)
            // {
            //     ApplicationArea = All;
            // }
            // systempart(Notes; Notes)
            // {
            //     ApplicationArea = All;
            // }
        }
    }

    actions
    {
        area(Processing)
        {
        }
    }
}