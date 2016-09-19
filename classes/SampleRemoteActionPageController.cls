global class SampleRemoteActionPageController {

 @RemoteAction  
    global Static  List <Contact> myContacts() {     
      try{
           return [select id, name, email from Contact Order By LastModifiedDate DESC LIMIT 200];
        }
       catch(Exception e){
           ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR, e.getMessage()));
            
       }   
       return null;
    }
 }