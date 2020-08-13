table 73031 EnvironmentVariable
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "EnvironmentVariable List";
    LookupPageId = "EnvironmentVariable List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Value"; Text[250])
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