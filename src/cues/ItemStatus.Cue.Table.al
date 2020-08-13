table 73030 ItemStatusCueTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; PrimaryKey; Code[250])
        {

            DataClassification = ToBeClassified;
        }
        field(2; ItemStatusRentedCount; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Item" where(Status = FILTER("Rented")));

        }
        field(3; ItemStatusPublishedCount; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Item" where(Status = FILTER("Published")));
        }
        field(4; ItemStatusUReservationCount; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Item" where(Status = FILTER("Under Reservation")));
        }
        field(5; ItemStatusSalaryCheckCount; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Item" where(Status = FILTER("Salary Check")));

        }
        field(6; ItemStatusAvailableCount; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Item" where(Status = FILTER("Available")));

        }
    }

    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }
}