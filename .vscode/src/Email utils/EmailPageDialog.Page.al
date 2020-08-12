page 50133 EmailPageDialog
{
    PageType = StandardDialog;
    Editable = true;

    layout
    {
        area(content)
        {
            group(Detail)
            {
                field(Subject; Subject) { ApplicationArea = All; Editable = true; }

                field(Body; Body) { ApplicationArea = All; Editable = true; }
            }
        }
    }
    var
        Subject: Text;
        Body: Text;
}