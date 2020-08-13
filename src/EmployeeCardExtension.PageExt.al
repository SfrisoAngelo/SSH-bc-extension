pageextension 73035 "Employee Card Extension" extends "Employee Card"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part(Demo; "Demo Card")
            {
                //SubPageLink = "No." = field("No."); // seems not necessary after all
                Caption = 'WebPage';
                ApplicationArea = All; // Important. Without this, it is not visible
            }
        }
    }
}