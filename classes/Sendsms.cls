public class Sendsms

{

   public String phNumber{get;set;}

   public String smsBody{get;set;}

   String accountSid;

   string token;

   String fromPhNumber;

   errorResponseWrapper erw;

   public sendsms(){

      phNumber ='+'+Apexpages.currentpage().getparameters().get('phNumber');

       accountSid = 'AC9aeb9519f8b62d9a997a0f918ea567d4';

       token = 'faa021b6daa00a27129bdb3c54c550ee';

       fromPhNumber = '(469) 615-2245';

   }

 public void processSms(){

       HttpRequest req = new HttpRequest();

       req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/'+accountSid+'/SMS/Messages.json');

       req.setMethod('POST');

       String VERSION  = '3.2.0';

       req.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);

       req.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);

       req.setHeader('Accept', 'application/json');

       req.setHeader('Accept-Charset', 'utf-8');

       req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(accountSid+':' +token)));

       req.setBody('To='+EncodingUtil.urlEncode(phNumber,'UTF-8')+'&From='+EncodingUtil.urlEncode(fromPhNumber,'UTF-8')+'&Body='+smsBody);

       Http http = new Http();

       HTTPResponse res = http.send(req);

       System.debug(res.getBody());

       if(res.getStatusCode()==201)

           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'SMS Sent Successfully'));

       else{

           erw =(errorResponseWrapper)json.deserialize(res.getBody(),errorResponseWrapper.class);

           ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,erw.message));

       }

   }

   public class errorResponseWrapper{

       String code;

       String message;

       String moreInfo;

       String status;    

   }

}