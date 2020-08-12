page 73026 "Customer List Part"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = Customer;
    CardPageId = "Customer Unit Card";
    InsertAllowed = false;
    ShowFilter = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.") { ApplicationArea = All; }
                field(Name; Name) { ApplicationArea = All; }
                field("Unit Name"; ItemUnitDescription) { ApplicationArea = All; }
                field("Floor Name"; "Floor Name") { ApplicationArea = All; }
                field("Complex Name"; "Complex Name") { ApplicationArea = All; }
                field("E-Mail"; "E-Mail") { ApplicationArea = All; }
            }
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
                            IF Customer.MARK() THEN //begin
                                AddressList := AddressList + Customer."E-Mail" + ';';
                        //end
                        UNTIL Customer.NEXT() = 0;
                    System.Hyperlink('mailto:?bcc=' + AddressList);
                end;
            }

            action("Web service call")
            {
                ApplicationArea = All;
                ToolTip = '...';

                trigger OnAction();
                var
                    Client: HttpClient;
                    Headers: HttpHeaders;
                    RequestMessage: HttpRequestMessage;
                    ResponseMessage: HttpResponseMessage;
                    Content: HttpContent;
                    ResponseContent: Text;
                    JSONContent: JsonObject;
                //AuthHeaderValue: HttpHeaders;
                //AuthText: text;
                //TempBlob: Record TempBlob temporary;

                begin
                    RequestMessage.Method := 'GET'; //Format(Parameters.RestMethod);
                    RequestMessage.SetRequestUri('https://postman-echo.com/get?foo1=bar1&foo2=bar2'); //Parameters.URL

                    RequestMessage.GetHeaders(Headers);

                    //if Parameters.Accept <> '' then
                    //    Headers.Add('Accept', Parameters.Accept);
                    //substituted with:
                    //Headers.Add('Accept', 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9');

                    /*if Parameters.UserName <> '' then begin
                        AuthText := StrSubstNo('%1:%2', Parameters.UserName, Parameters.Password);
                        TempBlob.WriteAsText(AuthText, TextEncoding::Windows);
                        Headers.Add('Authorization', StrSubstNo('Basic %1', TempBlob.ToBase64String()));
                    end;*/

                    //if Parameters.ETag <> '' then
                    //    Headers.Add('If-Match', Parameters.ETag);

                    /*if Parameters.HasRequestContent then begin
                        Parameters.GetRequestContent(Content);
                        RequestMessage.Content := Content;
                    end;*/

                    Client.Send(RequestMessage, ResponseMessage);

                    Headers := ResponseMessage.Headers;
                    //Parameters.SetResponseHeaders(Headers);

                    Content := ResponseMessage.Content;
                    Content.ReadAs(ResponseContent);
                    JSONContent.ReadFrom(ResponseContent);
                    //Parameters.SetResponseContent(Content);

                    if ResponseMessage.IsSuccessStatusCode then
                        Message(ResponseContent)
                    else
                        Message('error');
                end;
            }
        }
    }
}