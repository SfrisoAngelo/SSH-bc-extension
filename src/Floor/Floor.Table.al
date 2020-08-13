table 73004 Floor
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Floor List";
    LookupPageId = "Floor List";

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
        field(3; "ComplexId"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Complex;
        }
        field(4; "Complex Name"; Text[50])
        {
            Caption = 'Complex Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (Complex.Name where("No." = field(ComplexId)));
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