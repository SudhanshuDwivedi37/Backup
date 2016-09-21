public with sharing class WrapperClsOnContactMass {
    public List<WrapperClassEx> WrapperList{get;set;}
    public String selectedTemplateId { get; set; }
    public WrapperClsOnContactMass(ApexPages.StandardController controller) {
    }
    public WrapperClsOnContactMass() {
    }
    public List<SelectOption> getMyPersonalTemplateOptions() {
        List<SelectOption> options = new List<SelectOption>();
        for (EmailTemplate t : [
            select Id,Name 
            from EmailTemplate
            // Each User has a 'My Personal Templates' folder
            // of EmailTemplates, whose Id is the User's Id
            //where FolderId = :UserInfo.getUserId()
        ]) {
            options.add(new SelectOption(t.Id,t.Name));
        }
        return options;
    }
    public List<WrapperClassEx> getwrapperObj(){
        List<Teacher__c> conList =[select id, name, Email__c, Contact__r.Email from Teacher__c limit 5];   
        WrapperList = new List<WrapperClassEx>();
        for(Teacher__c con: conList){
            WrapperList.add(New WrapperClassEx(con,false));  
        }
        return WrapperList;  
    }
    public class WrapperClassEx{
       public WrapperClassEx(){
        }
       public Teacher__c conObj{get;set;}
       public Boolean checkBox{get;set;}
       public WrapperClassEx(Teacher__c conRec, boolean SelectedBox){               
          conObj= conRec;
          checkBox = SelectedBox;
       }
    }
       public void sendEmail(){
         List<Messaging.SingleEmailMessage> lstEmailId=new List<Messaging.SingleEmailMessage>();
         EmailTemplate et = [Select Id from EmailTemplate where id =:selectedTemplateId ];
         for(WrapperClassEx w: WrapperList){
            if(w.checkBox == true){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] {w.conObj.Email__c});
                 mail.setTemplateId(et.Id);
                 mail.setWhatId(w.conObj.id);
                 mail.setTargetObjectId(w.conObj.contact__r.Id);
                 mail.setTreatTargetObjectAsRecipient(false);
                 mail.setReplyTo('sudhanshu.dwivedi@rsystems.com');
                //mail.setplainTextBody('Hello');
                mail.setSenderDisplayName('Your Company Name');
                  
                lstEmailId.add(mail);    
            }
          }
            if(lstEmailId.size()>0){
                try{
                    Messaging.sendEmail(lstEmailId);
                   
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'Sent!'));
                }Catch(Exception ee){
                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Error,ee.getMessage()));
                }
            }
       }     
}