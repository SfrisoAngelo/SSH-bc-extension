tableextension 73008 ItemExt extends "Item"
{
    fields
    {
        field(73009; "Kind"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Room","House";
            OptionCaption = 'Room,House';
        }
        field(73027; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Published","Under Reservation","Salary Check","Rented","Available";
            OptionCaption = 'Published,Under Reservation,Salary Check, Rented, Available';
        }
        field(73010; "FloorId"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Floor;
        }
        field(73011; "Floor Name"; Text[50])
        {
            Caption = 'Floor Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (Floor.Name where("No." = field(FloorId)));
        }
        field(73012; "ComplexId"; Text[50])
        {
            Caption = 'Complex Id';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (Floor.ComplexId where("No." = field(FloorId)));
        }
        field(73013; "Complex Name"; Text[50])
        {
            Caption = 'Complex Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (Complex.Name where("No." = field(ComplexId)));
        }
        // field(73014; "CustomerId"; Text[50])
        // {
        //     Caption = 'Customer Id';
        //     TableRelation = Customer;
        // }
        // field(73015; "Customer Name"; Text[50])
        // {
        //     Caption = 'Customer Name';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup (Customer.Name where("No." = field(CustomerId)));
        // }

    }

    var
        myInt: Integer;
}