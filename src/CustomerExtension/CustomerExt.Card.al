page 73023 "Customer Unit Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field(Name; Name)
                {
                    ApplicationArea = All;

                }
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = All;

                }
                field(ItemUnitId; ItemUnitId)
                {
                    ApplicationArea = All;
                    Lookup = true;
                    LookupPageId = "Item Unit List";
                }
            }
            // group("Extras 1")
            // {
            //     part("Courses"; "Course List Part")
            //     {
            //         ApplicationArea = All;
            //         SubPageLink = FloorId = field("No.");
            //     }
            // }
            // group("Extras 2")
            // {
            //     part("Teachers"; "Teacher List Part")
            //     {
            //         ApplicationArea = All;
            //         SubPageLink = "FloorId" = field("No.");
            //     }
            // }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action("Add course")
    //         {
    //             ApplicationArea = All;

    //             RunObject = page "New Course In Floor Card";
    //             RunPageMode = Create;
    //             Promoted = true;
    //             PromotedCategory = New;
    //             trigger OnAction();
    //             begin
    //                 Message('Uhm...');
    //             end;
    //         }
    //     }
    // }
}