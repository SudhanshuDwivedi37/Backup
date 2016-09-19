public class EmailComposePageController {

public String emailVal{get;set;}
public String cc{get;set;}
public String emailSubject{get;set;}
public String body{get;set;}
public Attachment att{get;set;}
public List<Attachment> attList{get;set;}
private List<String> emailIds;
private List<String> ccEmailIds;

    // simple Constructor for creting object of Attachment list and Attachment.
    public EmailComposePageController(){
        attList = new List<Attachment>();
        att = new Attachment();
    }
    
    // method to attach attachment to attachment list.
    public void upload(){
        system.debug('attttt'+att);
        if(att.name == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please Select File Path First.'));
        }
        else{
            att.OwnerId = UserInfo.getUserId();
            attList.add(att);
            att = new Attachment();
        }        
    }
    
    // this action method is calls from send button.
    public void sendMail() {
       if( emailVal !='' && emailVal.length() > 0 )
           emailIds = emailVal.split(';');
       if( cc !='' && cc.length() > 0 )
           ccEmailIds = cc.split(';');
       
       Messaging.SingleEmailMessage mail = sendEmail(emailIds ,ccEmailIds ,null, emailSubject, body);
       if(mail != null){
           Messaging.SendEmailResult [] r =Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
           ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO,'Email Has Been Sent');
           ApexPages.addMessage(myMsg);
       }
       
    }
    
    // from this method the actual mail is sends.
    private Messaging.SingleEmailMessage sendEmail( List<String> toMail, List<String> ccEmailIdList,List<String> bccEmailIdList, String strSubject, String strMsgBody ){
        List<Messaging.EmailFileAttachment> mailAttList = new List<Messaging.EmailFileAttachment>();
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(toMail);
        if(ccEmailIdList != null && ccEmailIdList.size()>0){
            email.setCcAddresses(ccEmailIdList);
        }
        if(bccEmailIdList != null && bccEmailIdList.size()>0){
            email.setBccAddresses(bccEmailIdList);
            email.setBccSender(true);
        }
        email.setSubject(strSubject);    
        email.setPlainTextBody(strMsgBody);
        email.setSaveAsActivity(false);
        
        for(Attachment att1 : attList){
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setBody(att1.body);
            efa.setFileName(att1.name);
            mailAttList.add(efa);
        }
        system.debug('mailAttList'+mailAttList);
        email.setFileAttachments(mailAttList);
        Messaging.SendEmailResult[] sendResult;
        return  email ;
    }
}