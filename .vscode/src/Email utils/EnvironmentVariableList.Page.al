page 73033 "EnvironmentVariable List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "EnvironmentVariable";
    CardPageId = "EnvironmentVariable Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
                }
                field(Value; Value)
                {
                    ApplicationArea = All;
                    ToolTip = 'Value';
                }
            }
        }
    }
}