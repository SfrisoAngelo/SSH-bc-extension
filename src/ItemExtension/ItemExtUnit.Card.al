page 73016 "Item Unit Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = Item;

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
                field(FloorId; FloorId)
                {
                    ApplicationArea = All;
                    Lookup = true;
                    LookupPageId = "Floor List";
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