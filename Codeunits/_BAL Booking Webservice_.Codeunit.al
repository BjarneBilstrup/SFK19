codeunit 50100 "BAL Booking Webservice"
//BAL1.00 EA 05-09-2019 Booking WebService 
{
    procedure HttpRequestBooking(CallFunction: Text[20];
    DocumentNo: Code[20];
    LineNo: Integer;
    Dato: Text[10];
    StartTime: Text[8];
    EndTime: Text[8];
    Resource: Text[20];
    ResourceName: Text[50];
    Description: Text[100]): Text
    var //TempBlob: Record TempBlob temporary;
        CompanyInfo: Record "Company Information";
        Client: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        Headers: HttpHeaders;
        Content: HttpContent;
        XMLoptions: XmlReadOptions;
        XMLDoc: XmlDocument;
        XML_text: text;
        XML_BookingDelete: text;
        XML_BookingModify: text;
        XML_BookingTruncate: text;
        XML_HelloWorld: text;
        URL: Text;
        UserName: Text;
        Password: Text;
        AuthTxt: Text;
        ErrorMessage: Text;
        IfError: Integer;
    begin
        CompanyInfo.Get();
        if CompanyInfo."BAL Web Active" then begin
            CompanyInfo.TestField("BAL BookingURL");
            CompanyInfo.TestField("BAL Username");
            CompanyInfo.TestField("BAL Password");
            URL := CompanyInfo."BAL BookingURL";
            UserName := CompanyInfo."BAL Username";
            Password := CompanyInfo."BAL Password";
            Description := StrReplace(Description);
            ResourceName := StrReplace(ResourceName);
            XML_BookingDelete := '<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:sfk="SFK">' + '  <soapenv:Header/>' + '    <soapenv:Body>' + '      <sfk:BookingDelete soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' + '        <User xsi:type="xsd:string">' + UserName + '</User>' + '        <Pass xsi:type="xsd:string">' + Password + '</Pass>' + '        <DocumentNo xsi:type="xsd:string">' + DocumentNo + '</DocumentNo>' + '        <LineNo xsi:type="xsd:int">' + format(LineNo) + '</LineNo>' + '      </sfk:BookingDelete>' + '    </soapenv:Body>' + '</soapenv:Envelope>';
            XML_BookingModify := '<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:sfk="SFK">' + '  <soapenv:Header/>' + '    <soapenv:Body>' + '      <sfk:BookingModify soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">' + '        <User xsi:type="xsd:string">' + UserName + '</User>' + '        <Pass xsi:type="xsd:string">' + Password + '</Pass>' + '        <DocumentNo xsi:type="xsd:string">' + DocumentNo + '</DocumentNo>' + '        <LineNo xsi:type="xsd:int">' + format(LineNo) + '</LineNo>' + '        <Date xsi:type="xsd:string">' + Dato + '</Date>' + '        <StartTime xsi:type="xsd:string">' + StartTime + '</StartTime>' + '        <EndTime xsi:type="xsd:string">' + EndTime + '</EndTime>' + '        <Resource xsi:type="xsd:string">' + Resource + '</Resource>' + '        <ResourceName xsi:type="xsd:string">' + ResourceName + '</ResourceName>' + '        <Description xsi:type="xsd:string">' + Description + '</Description>' + '      </sfk:BookingModify>' + '    </soapenv:Body>' + '</soapenv:Envelope>';
            //message(XML_BookingModify);
            XML_HelloWorld := '<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:sfk="SFK">' + '  <soapenv:Header/>' + '    <soapenv:Body>' + '      <sfk:HelloWorld soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"/>' + '        <User xsi:type="xsd:string">' + UserName + '</User>' + '        <Pass xsi:type="xsd:string">' + Password + '</Pass>' + '    </soapenv:Body>' + '</soapenv:Envelope>';
            XML_BookingTruncate := '<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:sfk="SFK">' + '  <soapenv:Header/>' + '    <soapenv:Body>' + '      <sfk:BookingTruncate soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"/>' + '        <User xsi:type="xsd:string">' + UserName + '</User>' + '        <Pass xsi:type="xsd:string">' + Password + '</Pass>' + '    </soapenv:Body>' + '</soapenv:Envelope>';
            CASE CallFunction of
                'BookingModify':
                    XML_Text := XML_BookingModify;
                'BookingDelete':
                    XML_Text := XML_BookingDelete;
                'BookingTruncate':
                    XML_Text := XML_BookingTruncate;
                else
                    XML_text := XML_HelloWorld;
            end;
            //XML_Text := XML_BookingModify;
            RequestMessage.SetRequestUri(URL);
            RequestMessage.Method('POST');
            Content.WriteFrom(XML_text);
            Content.GetHeaders(Headers);
            Headers.Remove('Content-Type');
            Headers.Add('Content-Type', 'text/xml;charset=UTF-8');
            RequestMessage.Content := Content;
            RequestMessage.GetHeaders(Headers);
            /*
                        if UserName <> '' then begin
                        AuthTxt := strsubstno('%1:%2', UserName, Password);

                        TempBlob.WriteAsText(AuthTxt, TextEncoding::Windows);
                        Headers.Add('Authorization', StrSubstNo('Basic %1', TempBlob.ToBase64String()));
                    end;
            */
            Headers.Add('SoapAction', 'HelloWorld');
            Client.send(RequestMessage, ResponseMessage);
            if not ResponseMessage.IsSuccessStatusCode() then
                error(format(ResponseMessage.HttpStatusCode()) + ' , ' + ResponseMessage.ReasonPhrase())
            else begin
                clear(XML_text);
                ResponseMessage.Content().ReadAs(XML_text);
                XMLoptions.PreserveWhitespace := true;
                XmlDocument.ReadFrom(XML_text, XMLoptions, XMLDoc);
                ErrorMessage := FindTagValue(XML_text, 'return');
                //error(ErrorMessage);
                IfError := STRPOS(ErrorMessage, 'ERROR:');
                if IfError <> 0 then Message(ErrorMessage);
            end;
        end;
    end;

    local procedure FindTagValue(inXMLBody: Text; inTagName: Text): Text
    var
        endTagName: Text;
        TempText: Text;
        FoundPosStart: Integer;
        FoundPosEnd: Integer;
        ValueLen: Integer;
    begin
        FoundPosStart := STRPOS(inXMLBody, '<' + inTagName);
        TempText := CopyStr(inXMLBody, FoundPosStart);
        FoundPosStart := STRPOS(TempText, '>') + 1;
        TempText := CopyStr(TempText, FoundPosStart);
        FoundPosEnd := STRPOS(TempText, '</' + inTagName + '>');
        if FoundPosEnd > 1 then TempText := CopyStr(TempText, 1, FoundPosEnd - 1);
        exit(TempText);
    end;

    procedure WebTotalUpdate()
    var
        SalesLine: record "sales line";
        Salesheader: Record "Sales Header";
        resource: Record Resource;
    begin
        HttpRequestBooking('BookingTruncate', '', 0, '', '', '', '', '', '');

        SalesLine.setrange(SalesLine."Document Type", SalesLine."Document Type"::Order);
        SalesLine.setrange(SalesLine.type, SalesLine.type::Resource);
        SalesLine.setfilter(SalesLine."No.", '<>%1', '');
        if SalesLine.findset then
            repeat
                if (SalesLine."Document Type" = SalesLine."Document Type"::Order) and (SalesLine.type = SalesLine.Type::Resource) and (SalesLine."no." <> '') then begin
                    Resource.get(SalesLine."No.");
                    SalesHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
                    if SalesHeader."Sell-to Customer Name" = 'Gamle bookinger' then SalesHeader."Sell-to Customer Name" := '';
                    HttpRequestBooking('BookingModify', SalesLine."Document No.", SalesLine."Line No.", format(SalesLine."Shipment Date", 0, '<year4><month,2><day,2>'), format(SalesLine."BAL Start time"), format(SalesLine."BAL ending time"), SalesLine."no.", Resource.Name, SalesHeader."Sell-to Customer Name" + ' ' + SalesLine."Description 2");
                end;
            until SalesLine.next = 0;
    end;

    local procedure StrReplace(ReplaceInString: Text): Text
    begin
        ReplaceInString := ReplaceInString.Replace('&', '&amp;');
        ReplaceInString := ReplaceInString.Replace('"', '&quot;');
        ReplaceInString := ReplaceInString.Replace('<', '&lt;');
        ReplaceInString := ReplaceInString.Replace('>', '&gt;');
        ReplaceInString := ReplaceInString.Replace('''', '&apos;');
        exit(ReplaceInString);
    end;
}
