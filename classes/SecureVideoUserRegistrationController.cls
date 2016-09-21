public class SecureVideoUserRegistrationController{
    
    public string fullName {get;set;}
    public string emailAddress {get;set;}
    public string smsNumber {get;set;}
    public string defaultResolution {get;set;}
    public string timeZoneWindowsId {get;set;}
    public string helpNumber {get;set;}
    public string systemRoles {get;set;}
    public String jsonResults;
    public string returnUrl;
    public string selectedIso{get;set;}
    public List<selectOption> timeZone {
        get {
          List<selectOption> options = new List<selectOption>();
            options.add(new SelectOption('Option','Please Select Option'));
          for (cloudera__TimeZone__c iso : cloudera__TimeZone__c.getAll().values())
            options.add(new SelectOption(iso.Name,iso.Name));
          return options;
        }
        set;
     }
    
    public SecureVideoUserRegistrationController(){
    }
    
    public void newUserRegistration(){
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod('POST');
        String url = 'https://api.securevideo.com/user/';
        req.setHeader('Authorization', 'Basic NGRkNDkyOTZjYWNjNDRlZDlmMmNjZDlhODQ3ODc4ZjA1Nzc5YWY1MzJkZmI0MWNhOTFkYjA0MDA4MGU1ZDA4YjowYTY4ZDU0MjgwYzY0NjBlYWJkYTJlYThkNDI4NTEyYWM3NDhmMzZjMTYzZDQ5YWZiMDk2MTBjMzFjMWFkYmZk');     
        req.setHeader('Content-Type','application/json; charset=utf-8');
        req.setEndPoint(url); 
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('FullName', fullName);
        gen.writeStringField('EmailAddress', emailAddress); 
        gen.writeStringField('SmsNumber', smsNumber);
        gen.writeStringField('DefaultResolution', defaultResolution);
        gen.writeStringField('TimeZoneWindowsId', selectedIso);
        gen.writeStringField('HelpNumber', helpNumber);
        gen.writeStringField('SystemRoles', systemRoles);
        gen.writeEndObject();
        String jsonOrders = gen.getAsString();
        system.debug('jsonOrders'+jsonOrders  );
        
        req.setBody(jsonOrders);
        HTTPResponse resp = http.send(req);
        system.debug('jsonResults'+resp.getBody());
        
        
    }
    
    
    public void updateExistingUser(){
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod('PUT');
        String url = 'https://api.securevideo.com/user/34441';
        req.setHeader('Authorization', 'Basic NGRkNDkyOTZjYWNjNDRlZDlmMmNjZDlhODQ3ODc4ZjA1Nzc5YWY1MzJkZmI0MWNhOTFkYjA0MDA4MGU1ZDA4YjowYTY4ZDU0MjgwYzY0NjBlYWJkYTJlYThkNDI4NTEyYWM3NDhmMzZjMTYzZDQ5YWZiMDk2MTBjMzFjMWFkYmZk');     
        req.setHeader('Content-Type','application/json; charset=utf-8');
        req.setEndPoint(url); 
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('FullName', fullName);
        gen.writeStringField('EmailAddress', emailAddress); 
        gen.writeStringField('SmsNumber', smsNumber);
        gen.writeStringField('DefaultResolution', defaultResolution);
        gen.writeStringField('TimeZoneWindowsId', timeZoneWindowsId);
        gen.writeStringField('HelpNumber', helpNumber);
        gen.writeStringField('SystemRoles', systemRoles);
        gen.writeEndObject();
        String jsonOrders = gen.getAsString();
        system.debug('jsonOrders'+jsonOrders  );
        
        req.setBody(jsonOrders);
        HTTPResponse resp = http.send(req);
        system.debug('jsonResults'+resp.getBody());
        if(jsonResults == '200'){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'User Successfully Created'));
        }
    }
    
    public void scheduleSession(){
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod('POST');
        String url = 'https://api.securevideo.com/session/35130';
        req.setHeader('Authorization', 'Basic NGRkNDkyOTZjYWNjNDRlZDlmMmNjZDlhODQ3ODc4ZjA1Nzc5YWY1MzJkZmI0MWNhOTFkYjA0MDA4MGU1ZDA4YjowYTY4ZDU0MjgwYzY0NjBlYWJkYTJlYThkNDI4NTEyYWM3NDhmMzZjMTYzZDQ5YWZiMDk2MTBjMzFjMWFkYmZk');     
        req.setHeader('Content-Type','application/json; charset=utf-8');
        req.setEndPoint(url);
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('ScheduleTs',''); 
        gen.writeBooleanField('IsRecorded', True);
        gen.writeFieldName('Participants');
            gen.writeStartArray();
                gen.writeStartObject();
                    gen.writeStringField('ParticipantFullName', 'Jitendra');
                    gen.writeStringField('ParticipantEmailAddress', 'Jitendra.Jain@rsystems.com');
                    gen.writeStringField('ParticipantSmsNumber', '222-333-4444');
                    gen.writeStringField('ParticipantDefaultResolution', 'default');
                    gen.writeStringField('ParticipantTimeZoneWindowsId', 'Eastern Standard Time');
                    gen.writeStringField('ShouldAutoDeliverCode', 'E');
                gen.writeEndObject();
                gen.writeStartObject();
                    gen.writeStringField('ParticipantFullName', 'Sudhanshu');
                    gen.writeStringField('ParticipantEmailAddress', 'sudhanshu.dwivedi@rsystems.com');
                    gen.writeStringField('ParticipantSmsNumber', '222-333-4444');
                    gen.writeStringField('ParticipantDefaultResolution', 'default');
                    gen.writeStringField('ParticipantTimeZoneWindowsId', 'Eastern Standard Time');
                    gen.writeStringField('ShouldAutoDeliverCode', 'E');
                gen.writeEndObject();
            gen.writeEndArray();
        gen.writeEndObject();
        String jsonOrders = gen.getAsString();
        system.debug('jsonOrders'+jsonOrders  );
        req.setBody(jsonOrders);
        HTTPResponse resp = http.send(req);
        system.debug('jsonResults'+resp.getBody());
        
    }
    
    public pagereference login(){
        returnUrl = 'https://www.rsystems.com';
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod('POST');
        String url = 'https://api.securevideo.com/login/35297';
        req.setHeader('Authorization', 'Basic NGRkNDkyOTZjYWNjNDRlZDlmMmNjZDlhODQ3ODc4ZjA1Nzc5YWY1MzJkZmI0MWNhOTFkYjA0MDA4MGU1ZDA4YjowYTY4ZDU0MjgwYzY0NjBlYWJkYTJlYThkNDI4NTEyYWM3NDhmMzZjMTYzZDQ5YWZiMDk2MTBjMzFjMWFkYmZk');     
        req.setHeader('Content-Type','application/json; charset=utf-8');
        req.setEndPoint(url);
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeStringField('RedirectToUriOnExpiry', 'https://www.securevideo.com/');
        gen.writeEndObject();
        String jsonOrders = gen.getAsString();
        req.setBody(jsonOrders);
        system.debug('request'+req.getBody());
        HTTPResponse resp = http.send(req);
        system.debug('response'+resp.getBody());
        jsonResults = resp.getBody();
        JSONParser parser = JSON.createParser(jsonResults);
        String loginUri;
        while (parser.nextToken() != null) {
            if ((parser.getText() == 'LoginUri')) {
                parser.nextToken();
                loginUri = parser.getText();
            }
        }
       system.debug('loginUri::'+loginUri );  
       Pagereference prAcc = new Pagereference(loginUri);
       return prAcc;
    }

    public String parseDuration(String value) {
        value = value.replace('text : ', '');
        system.debug('value====='+value);
        return value;
    }
}