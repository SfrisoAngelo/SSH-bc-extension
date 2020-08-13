page 73007 "Floor Card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = Floor;

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
                field(ComplexId; ComplexId)
                {
                    ApplicationArea = All;
                    Lookup = true;
                    LookupPageId = "Complex List";
                }
            }
            group("Customers Group")
            {
                part("Customers"; "Customer List Part")
                {
                    ApplicationArea = All;
                    SubPageLink = "FloorId" = field("No.");
                }

            }
        }
    }


}