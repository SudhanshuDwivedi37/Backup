public with sharing class ContactTriggerHandler {
        public static void beforeInsert(List<Contact> newList){
        checkDuplicate(newList);
    }
    
    public static void beforeUpdate(List<Contact> newList, Map<Id, Contact> oldMap){
        List<Contact>contactToUpdate = new List<Contact>();
        for(Contact c : newList){
            if(c.FirstName != oldMap.get(c.id).FirstName  
                || c.LastName != oldMap.get(c.id).LastName 
                || c.Email != oldMAp.get(c.id).Email || c.Phone != oldMap.get(c.id).Phone){
                contactToUpdate.add(c);
            }
            checkDuplicate(contactToUpdate);
        }
    }
    
    // All Private methods  
    private static void checkDuplicate(List<Contact> leadsToCheck){
        if(leadsToCheck != null && leadsToCheck.size() > 0){
            //for(String err : UtilityClass.checkDupicateLeadContact(leadsToCheck)){
              //  leadsToCheck.get(0).addError(err);
            //}
        }
    }
}