page 73024 "Customer Unit List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Customer;
    CardPageId = "Customer Unit Card";

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
                field(Name; Name)
                {
                    ApplicationArea = All;

                }
                field("ItemUnitDescription"; ItemUnitDescription)
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
                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = All;

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
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