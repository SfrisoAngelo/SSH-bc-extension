table 73002 Complex
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Complex List";
    LookupPageId = "Complex List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}