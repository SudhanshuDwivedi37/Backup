public with sharing class Email{
public List<Contact> con{get;set;}
private final List<Id> contactids;
public Email(ApexPages.StandardController controller){
con = new List<Contact>();
contactids = new List<Id>(); 
}
public void loadAction(){
con = [select Id from Contact limit 3  ];
     for(Integer i=0;i<3;i++)
     {
         contactids.add(con[i].Id);
      }  
system.debug('contact::'+ contactids);
 Messaging.MassEmailMessage mail = new Messaging.MassEmailMessage();
    EmailTemplate et = [SELECT id from emailtemplate where name= :'demo']; 
    
    mail.setTemplateId(et.Id); 
    mail.setSaveAsActivity(true); 
    mail.setTargetObjectIds(contactids);
    
Messaging.sendEmail(new Messaging.MassEmailMessage[] { mail });
}

}