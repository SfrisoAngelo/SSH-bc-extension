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
            action("Send Mail via Outlook")
            {
                ApplicationArea = All;
                ToolTip = '...';
                //Visible = false;

                trigger OnAction();
                var
                    Customer: Record Customer;
                    AddressList: Text;

                begin
                    AddressList := '';
                    CurrPage.SETSELECTIONFILTER(Customer);
                    IF Customer.FIND('-') THEN
                        REPEAT
                            //IF Customer.MARK() THEN //begin --> with this, the "select all" doesn't work (If all records are selected, marks will not be used.)
                            AddressList := AddressList + Customer."E-Mail" + ';';
                        //end
                        UNTIL Customer.NEXT() = 0;
                    Message(AddressList);
                    //System.Hyperlink('mailto:?bcc=' + AddressList); //--> works but open outlook desktop
                    //System.Hyperlink('https://col125.mail.live.com/?page=Compose&bcc=' + AddressList); //--> doesn't work
                    System.Hyperlink('https://outlook.office.com/mail/deeplink/compose?to=' + AddressList); // opens outlook web but problem is, cc&bcc do not work, and the "+" in the email confuses it
                end;
            }

            action("Web service test")
            {
                ApplicationArea = All;
                ToolTip = '...';
                Visible = false;

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
            action("Send email")
            {
                ApplicationArea = All;
                ToolTip = '...';

                trigger OnAction();
                var
                    Customer: Record Customer;
                    AddressList: Text;

                    Client: HttpClient;
                    Headers: HttpHeaders;
                    ContentHeaders: HttpHeaders;
                    RequestMessage: HttpRequestMessage;
                    ResponseMessage: HttpResponseMessage;
                    Content: HttpContent;
                    ReqContent: HttpContent;
                    ResponseContent: Text;
                    JSONContent: JsonObject;

                begin
                    AddressList := '';
                    CurrPage.SETSELECTIONFILTER(Customer);
                    IF Customer.FIND('-') THEN
                        REPEAT
                            IF Customer.MARK() THEN
                                IF AddressList = '' THEN
                                    AddressList := AddressList + '{"email": "' + Customer."E-Mail" + '"}'
                                else
                                    AddressList := AddressList + ', {"email": "' + Customer."E-Mail" + '"}';
                        UNTIL Customer.NEXT() = 0;

                    RequestMessage.Method := 'POST';
                    RequestMessage.SetRequestUri('https://api.sendgrid.com/v3/mail/send');

                    RequestMessage.GetHeaders(Headers);
                    Headers.Add('Authorization', 'Bearer INSERTKEYHERE');

                    Content.WriteFrom('{"personalizations": [{ "to": [' + AddressList + '],"subject": "Test email"}],"from": {"email": "giulia@hoppinger.com","name":"Giulia Costantini"},"content":[{"type": "text/plain", "value": "This is a test email."}]}');
                    Content.GetHeaders(contentHeaders);
                    contentHeaders.Clear();
                    contentHeaders.Add('Content-Type', 'application/json');
                    RequestMessage.Content := Content;

                    client.Send(RequestMessage, ResponseMessage);

                    // Read the response content as json.
                    ResponseMessage.Content().ReadAs(ResponseContent);

                    if ResponseMessage.IsSuccessStatusCode then
                        Message('Email sent!')
                    else
                        Message('error');
                end;
            }

            action("EmailDialog")
            {
                ApplicationArea = All;
                ToolTip = '...';

                trigger OnAction();
                var
                    lPage: Page EmailPageDialog;
                    lAction: Action;
                begin
                    lAction := lPage.RunModal();
                    //lPage.
                    case lAction of
                        action::OK, action::LookupOK:
                            ExecuteOKCode();
                        action::Cancel, action::LookupCancel:
                            ExecuteCancelCode();
                    end;
                end;

            }
        }
    }

    procedure ExecuteOKCode();
    begin
        Message('Ok');
    end;

    procedure ExecuteCancelCode();
    begin
        Message('Cancel');
    end;
}