query 73028 "Q_ItemUnit"
{
    QueryType = Normal;
    Caption = 'Q_ItemUnit';

    elements
    {
        dataitem(Item; "Item")
        {
            column(Kind; "Kind")
            {
            }
            column(Description; "Description") { }
            column(Status; Status) { }
            dataitem(Floor; "Floor")
            {
                DataItemLink = "No." = Item.FloorId;
                column(Name; "Name")
                {
                }
                column(ComplexName; "Complex Name")
                {
                }
            }
        }
    }
}