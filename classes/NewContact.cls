public with sharing class NewContact {  
	public List<Contact>con1{get;set;}
    public Contact con{get;set;}
	public String getNewContact {get;set;} 
	//public String abc{get;set;}	
 
public	NewContact()
	{

		
	  con1 = new List<Contact>();
	 getNewContact = ApexPages.currentPage().getParameters().get('ID');  
	  if(  getNewContact !=null &&   getNewContact!='') {
	    	
	
	  con = new Contact();
      con.AccountId = ApexPages.currentPage().getParameters().get('ID');
      //con1=[select AccountId from Contact where AccountId= : '00190000013jqaAAAQ'];
      //con= con1[0];
       }
       else{ con1 = new List<Contact>();
       
       }
     }
		 //---------------------------------------------Save Contact ---------------------------------------------------------
	public Pagereference testSave(){
     
      upsert con;
      Pagereference pr = new Pagereference('/' + con.Id);
      return pr;
  
    }
     //--------------------------------------------- Cancel Contact ---------------------------------------------------------
    public Pagereference testCancel(){
    
        Pagereference pr = new Pagereference('/home/home.jsp');
        return pr;
    }
    
		
	}