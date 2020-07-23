page 73001 "Complex Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = Complex;

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
                field(Address; Address)
                {
                    ApplicationArea = All;

                }
            }
            group("Floors Group")
            {
                part("Floors"; "Floor List Part")
                {
                    ApplicationArea = All;
                    SubPageLink = ComplexId = field("No.");
                }
            }
            group("Customers Group")
            {
                part("Customers"; "Customer List Part")
                {
                    ApplicationArea = All;
                    SubPageLink = "ComplexId" = field("No.");
                }

            }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action("Add course")
    //         {
    //             ApplicationArea = All;

    //             RunObject = page "New Course In Complex Card";
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