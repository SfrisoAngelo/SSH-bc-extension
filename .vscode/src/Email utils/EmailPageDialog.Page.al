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

    procedure PrintInput(AddressList: Text);
    begin
        //Message('You inserted the following data. Subject: ' + Subject + ', Body: ' + Body);
        System.Hyperlink('https://outlook.office.com/mail/deeplink/compose?subject=' + Subject + '&body=' + Body + '&to=' + AddressList);
    end;
}