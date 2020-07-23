tableextension 73017 CustomerExt extends "Customer"
{
    fields
    {
        field(73018; "ItemUnitId"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(73019; "FloorId"; Text[50])
        {
            Caption = 'Floor Id';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (Item.FloorId where("No." = field(ItemUnitId)));
        }
        field(73020; "Floor Name"; Text[50])
        {
            Caption = 'Floor Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (Floor.Name where("No." = field(FloorId)));
        }
        field(73021; "ComplexId"; Text[50])
        {
            Caption = 'Complex Id';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (Floor.ComplexId where("No." = field(FloorId)));
        }
        field(73022; "Complex Name"; Text[50])
        {
            Caption = 'Complex Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (Complex.Name where("No." = field(ComplexId)));
        }
    }

    var
        myInt: Integer;
}