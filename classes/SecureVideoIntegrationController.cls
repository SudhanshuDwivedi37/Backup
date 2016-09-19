public class SecureVideoIntegrationController{
    public string jsonResults {get;set;}
    
    public SecureVideoIntegrationController(){
        jsonResults = getUserResponse();
    }

    public string getUserResponse(){
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        
        req.setMethod('GET');
        
        String url = 'https://api.securevideo.com/user';
        req.setHeader('Authorization', 'Basic NGRkNDkyOTZjYWNjNDRlZDlmMmNjZDlhODQ3ODc4ZjA1Nzc5YWY1MzJkZmI0MWNhOTFkYjA0MDA4MGU1ZDA4YjowYTY4ZDU0MjgwYzY0NjBlYWJkYTJlYThkNDI4NTEyYWM3NDhmMzZjMTYzZDQ5YWZiMDk2MTBjMzFjMWFkYmZk');     
        req.setEndPoint(url);
        
        HTTPResponse resp = http.send(req);
        system.debug('resp'+resp  );
        String jsonResults = resp.getBody().replace('\n', '');
    
        return resp.getBody();    
    }

}