pageextension 73001 CustomerSendEmail extends "Customer List"// 5052

{

    actions
    {

        // Add changes to page actions here

        addlast(Processing)
        {
            action("Send Mail")
            {
                ApplicationArea = All;
                ToolTip = '...';

                trigger OnAction();
                var
                    Customer: Record Customer;
                    AddressList: Text;

                begin
                    AddressList := '';
                    CurrPage.SETSELECTIONFILTER(Customer);
                    IF Customer.FIND('-') THEN
                        REPEAT
                            IF Customer.MARK() THEN begin
                                AddressList := AddressList + Customer."E-Mail" + ';';
                            end
                        UNTIL Customer.NEXT() = 0;
                    System.Hyperlink('mailto:?bcc=' + AddressList);
                end;
            }
        }

    }

}