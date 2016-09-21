trigger isertContact on Account (before update) {
    
    public List<Contact>conList = new List<Contact>();
    for(Account acc : trigger.new){
        if(acc.cloudera__NumOfContacts__c == 2){
            Contact c  = new Contact();
            c.LastName = 'New Contact';
            conList.add(c); 
        }
    
    }     
    insert conList;
}