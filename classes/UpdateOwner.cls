public with sharing class UpdateOwner {
    
    
    public static void Updatecase(List<Case> cList, Map<Id, Case> oldMap) {
      try{
        List<Case> csList= new List<Case>();
        List<String> emailIds = new List<String>();
        Profile p = [SELECT Id FROM Profile WHERE Name= 'Standard Platform User']; 
        User u = [select id from user where ProfileId =: p.Id];
        for(Case c : cList){
            if(c.Status!= oldMap.get(c.id).Status && c.Status == 'Escalated'){
                c.OwnerId = u.Id;
                csList.add(c);
                emailIds.add(c.Owner.Email);
            }
        }
        if(emailIds.size() > 0){
           
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setSubject('Change Case Owner');
            email.setToAddresses(emailIds);
            email.setPlainTextBody('Case Owner has been changed.');  
            Messaging.Sendemailresult[] r = Messaging.sendEmail(new Messaging.Singleemailmessage[] {email});
        }
       
       }catch(Exception ex){}
    }
}