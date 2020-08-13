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
            action("Send Email via Outlook Desktop")
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
                    System.Hyperlink('mailto:?bcc=' + AddressList); //--> works but open outlook desktop
                    //System.Hyperlink('https://col125.mail.live.com/?page=Compose&bcc=' + AddressList); //--> doesn't work
                    //System.Hyperlink('https://outlook.office.com/mail/deeplink/compose?to=' + AddressList); // opens outlook web but problem is, cc&bcc do not work, and the "+" in the email confuses it
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

            action("Send Email via Sendgrid")
            {
                ApplicationArea = All;
                ToolTip = '...';

                trigger OnAction();
                var
                    Customer: Record Customer;
                    EnvVar: Record EnvironmentVariable;
                    AddressList: Text;
                    BearerKey: Text;

                    Client: HttpClient;
                    Headers: HttpHeaders;
                    ContentHeaders: HttpHeaders;
                    RequestMessage: HttpRequestMessage;
                    ResponseMessage: HttpResponseMessage;
                    Content: HttpContent;
                    RequestContentText: Text;
                    ResponseContentText: Text;

                    JSONResponseArr: JsonArray;

                    JSONFromObj: JsonObject;
                    JSONContentArr: JsonArray;
                    JSONContentObj: JsonObject;
                    JSONPersArr: JsonArray;
                    JSONToArr: JsonArray;
                    JSONToObj: JsonObject;
                    JSONBccArr: JsonArray;
                    JSONPersObj: JsonObject;
                    JSONSingleAddressObj: JsonObject;
                    JSONRequestObj: JsonObject;

                begin
                    AddressList := '';
                    CurrPage.SETSELECTIONFILTER(Customer);
                    IF Customer.FIND('-') THEN
                        REPEAT
                            IF AddressList <> '' THEN
                                AddressList := AddressList + ', ';
                            AddressList := AddressList + '{"email": "' + Customer."E-Mail" + '"}';
                            //JSONSingleAddressObj := JSONSingleAddressObj.Clone().AsObject();
                            //JSONSingleAddressObj.Remove('email');
                            //JSONSingleAddressObj.Add('email', Customer."E-Mail");
                            JSONSingleAddressObj := CreateJSONObject('email', Customer."E-Mail");
                            JSONBccArr.Add(JSONSingleAddressObj);
                        UNTIL Customer.NEXT() = 0;

                    RequestMessage.Method := 'POST';
                    RequestMessage.SetRequestUri('https://api.sendgrid.com/v3/mail/send');

                    RequestMessage.GetHeaders(Headers);
                    EnvVar.Get('sendgrid');
                    BearerKey := 'Bearer ' + EnvVar.Value;
                    Headers.Add('Authorization', BearerKey);

                    // FROM 
                    JSONFromObj.Add('email', 'giulia@hoppinger.com');
                    JSONFromObj.Add('name', 'Giulia Costantini');
                    JSONRequestObj.Add('from', JSONFromObj);

                    // CONTENT
                    JSONContentObj.Add('type', 'text/plain');
                    JSONContentObj.Add('value', 'Body of test email');
                    JSONContentArr.Add(JSONContentObj);
                    JSONRequestObj.Add('content', JSONContentArr);

                    // PERSONALIZATIONS (To, Bcc, Subject, etc)
                    // JSONBccArr has been filled in above while looping through the selected customers
                    JSONToObj.Add('email', 'giulia@hoppinger.com');
                    JSONToArr.Add(JSONToObj);
                    JSONPersObj.Add('to', JSONToArr);
                    JSONPersObj.Add('bcc', JSONBccArr);
                    JSONPersObj.Add('subject', 'Subject of test email');
                    JSONPersArr.Add(JSONPersObj);
                    JSONRequestObj.Add('personalizations', JSONPersArr);

                    JSONRequestObj.WriteTo(RequestContentText);
                    Content.WriteFrom(RequestContentText);
                    //Content.WriteFrom('{"personalizations": [{ "to": [' + AddressList + '],"subject": "Test email"}],"from": {"email": "giulia@hoppinger.com","name":"Giulia Costantini"},"content":[{"type": "text/plain", "value": "This is a test email."}]}');
                    Content.GetHeaders(contentHeaders);
                    contentHeaders.Clear();
                    contentHeaders.Add('Content-Type', 'application/json');
                    RequestMessage.Content := Content;

                    client.Send(RequestMessage, ResponseMessage);

                    // Read the response content as json.
                    ResponseMessage.Content().ReadAs(ResponseContentText);

                    if ResponseMessage.IsSuccessStatusCode then
                        Message('Email sent to: ' + AddressList)
                    else begin
                        Message('Error');
                        if not JSONResponseArr.ReadFrom(ResponseContentText) then
                            Error('invalid response, expected JSON object');
                    end;
                end;
            }

            action("Send Email via Dialog Page and OWA")
            {
                ApplicationArea = All;
                ToolTip = '...';

                trigger OnAction();
                var
                    Customer: Record Customer;
                    lPage: Page EmailPageDialog;
                    AddressList: Text;
                    lAction: Action;
                begin
                    AddressList := '';
                    CurrPage.SETSELECTIONFILTER(Customer);
                    IF Customer.FIND('-') THEN
                        REPEAT
                            if AddressList <> '' then
                                AddressList := AddressList + ';';
                            AddressList := AddressList + Customer."E-Mail";
                        UNTIL Customer.NEXT() = 0;

                    lAction := lPage.RunModal();

                    case lAction of
                        action::OK, action::LookupOK:
                            lPage.PrintInput(AddressList); //ExecuteOKCode();
                        action::Cancel, action::LookupCancel:
                            ExecuteCancelCode();
                    end;
                end;

            }
        }
    }

    /*procedure ExecuteOKCode();
    begin
        Message('Ok');
    end;*/

    procedure ExecuteCancelCode();
    begin
        Message('You pressed Cancel. Nothing happened.');
    end;

    procedure CreateJSONObject(keyString: Text; valueString: Text) JSONObj: JsonObject;
    begin
        JSONObj.Add(keyString, valueString);
    end;
}