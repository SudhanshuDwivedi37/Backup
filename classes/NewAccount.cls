public with sharing class NewAccount {
     
    public List<Account> acc1{get;set;}
    
    public String var2{get;set;}
    public String getQueryParameter {get;set;}
    public String abc{get;set;}
    public Account acc{get;set;}
      
    public NewAccount(){
       
        acc1 = new List<Account>();
     	acc = new Account();
        getQueryParameter = ApexPages.currentPage().getParameters().get('ide');  
      
       if(getQueryParameter !=null && getQueryParameter !='') {
       acc1 = [Select Id, Name, Type, ParentId, Ownership From Account Where Id =: getQueryParameter ];
       acc = acc1[0];
       }
       else{ acc1 = new List<Account>();
       }
        
    }
  //--------------------------------------------- save new account ---------------------------------------------------------
    
    public Pagereference testSave(){
      
      upsert acc;
      Pagereference pr = new Pagereference('/' + acc.Id);
      return pr;
    }
  
   //--------------------------------------------- Cancel Method ---------------------------------------------------------
    
    public Pagereference testCancel(){
    
        Pagereference pr = new Pagereference('/home/home.jsp');
        return pr;
    }
    
}