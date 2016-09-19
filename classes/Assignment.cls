public with sharing class Assignment
 {
   static final Integer PAGE_SIZE = 10;
    public String message {get;set;}
    public String searchText {get;set;}
    public boolean checkBox1 {get;set;}
    public boolean checkBox2 {get;set;}
    public boolean checkBox3 {get;set;}
    public Boolean showTable1 {get;set;}
    public Boolean showTable2 {get;set;}
    public Boolean showAdvanceSearchAccount  {get;set;}
    public Boolean showAdvanceSearchcontact  {get;set;}
    public List<Account> account{get;set;}
    public List<Contact> contact{get;set;}
    public String deleteId {get;set;}
    public Boolean deleteCheck {get;set;}
    public String var1{get;set;}     
    public String var2{get;set;}     
    public String abc{get;set;}
    public String NewContact{get;set;}
    public Account acc{get;set;}
    public Contact con{get;set;}
    public String getType{get;set;}
    public String GetImageId{get;set;}
    public Date getDate{get;set;}
    public Boolean isAscending{get;set;}
    public string SelectedUserId {get;set;}
    public string keyword {get;set;}
    public string q{get;set;}
    public string p{get;set;}
    public string r{get;set;}
    public string previousSortField = 'Name';
   public ApexPages.StandardSetController setCon{get;set;} 
    public Assignment() 
   
      {   
      showTable1=false; 
      showTable2=false;
      account = new List<Account>();
      contact = new List<Contact>();
      acc = new Account();
      con = new Contact();
      this.isAscending = true; 
      this.sortField = 'Name';
      doProcess();
      }
//--------------------------------------------- Search ---------------------------------------------------------     
public void click1()
   {
     if((searchText!= '' && searchText!= null)&&(checkBox1==false && checkBox2==false))
      {
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Select CheckBox!!'));
       showTable1=false;
       showTable2=false;
      }
       
        if(searchText.length()>=2)
         {      
          if(checkBox1==true && checkBox2==false)
       	   {
       		  showTable1=true;
              showTable2=false;
              showAdvanceSearchAccount=false; 
              showAdvanceSearchContact=false; 
              p = 'select Name,Type from Account where name LIKE '+ '\'%'+searchText+'%\' ';
            }
              if(acc.Type!= '' && acc.Type!=null) 
 	              {
 	                p = p+' and Type LIKE '+ '\'%'+acc.Type+'%\'';    
 	              }
 	             if( acc.SLAExpirationDate__c!= null)   
 	                {
 	                 date SLAExpirationDate= acc.SLAExpirationDate__c;
 	                 p= P+'and SLAExpirationDate__c = :SLAExpirationDate';
 	                }
                    if(acc.ParentId!=null)
                     {
                       string ParentId=acc.ParentId;
                       p = p + ' and ParentId = '+'\''+acc.ParentId+'\'';
                     }
                     
        else if(checkBox2==true && checkBox1==false)
          {
             showTable2=true;
             showTable1=false;
             showAdvanceSearchAccount=false; 
             showAdvanceSearchContact=false;
             r = 'select Name,Title from Contact where name LIKE '+ '\'%'+searchText+'%\' '; 
             
             if(con.Title!= '' && con.Title!=null) 
 	              {
 	                r = r+' and  Title LIKE '+ '\'%'+con.Title+'%\'';    
                  }
          }
         else if(checkBox1==true && checkBox2==true)
           {
              showTable1=true;
              showTable2=true;
                p = 'select Name,Type from Account where name LIKE '+ '\'%'+searchText+'%\' ';
                r = 'select Name,Title from Contact where name LIKE '+ '\'%'+searchText+'%\' '; 
                
              account= [select Name,Type from Account where name LIKE:  '%'+searchText+'%'  ];
             if(acc.Type!= '' && acc.Type!=null) 
 	              {
 	                p = p+' and Type LIKE '+ '\'%'+acc.Type+'%\'';    
 	              }
 	             if( acc.SLAExpirationDate__c!= null)   
 	                {
 	                 date SLAExpirationDate= acc.SLAExpirationDate__c;
 	                 p= P+'and SLAExpirationDate__c = :SLAExpirationDate';
 	                }
                    if(acc.ParentId!=null)
                     {
                       string ParentId=acc.ParentId;
                       p = p + ' and ParentId = '+'\''+acc.ParentId+'\'';
                     }
                       if(con.Title!= '' && con.Title!=null) 
 	              {
 	                r = r+' and  Title LIKE '+ '\'%'+con.Title+'%\'';    
                  }
  
            }
         }
           if(p!=null && p!='')
         account= Database.query(p);
          if(r!=null && r!='')
         contact= Database.query(r);         
            if(account.size()==0)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Record not found!!'));
                 showTable1=false;
                 showTable2=false;
                 showAdvanceSearchAccount=false; 
                 showAdvanceSearchContact=false; 
            }
   
  }
 
  //--------------------------------------------- Clear ---------------------------------------------------------     
public void clear1()
 { 
 	if(account.size()>0)
 	{
 	 account.clear();
 	account = new List<Account>();
 	}
  if(contact.size()>0)
 	 {
 	 contact.clear();
 	 contact = new List<Contact>();
 	 }
 	 /*if(account.size()>0 && contact.size()>0){
 	 	account.clear();
 	 	contact.clear();
 	 	account = new List<Account>();
 	 	contact = new List<Contact>();
 	 }else if(account.size()>0){
 	 	account.clear();
 	 	account = new List<Account>();
 	 }else if(contact.size()>0){
 	 	contact.clear();
 	 	contact = new List<Contact>();
 	 }*/
 	 
 }
 
    
    
    
     
    
 
 //--------------------------------------------- Reset ---------------------------------------------------------
   public void reset()
     {
      showTable1=false;
      showTable2= false;
      acc.Type= null;
      message = null;
   
     }
//--------------------------------------------- Delete ---------------------------------------------------------   
    
public  void deleteMethod(){
    
    List<Account> delAcc = new List<Account>();
   delAcc= [select Name, id from Account where id= : var1 ];  
   delete delAcc;
   account= [select  Name,id  from Account where name LIKE:  '%'+searchText+'%' ];
     	
}

//--------------------------------------------- New Account ---------------------------------------------------------
public Pagereference NewAccount(){
    
    Pagereference pr = new Pagereference('/apex/NewAccount');
    
    return pr;
}
 
 //--------------------------------------------- Edit Account ---------------------------------------------------------
public Pagereference EditAccount(){
  
 
  if(var2!=null && var2!=''){
   Pagereference prAcc = new Pagereference('/apex/NewAccount?ide='+var2);
   return prAcc;
  }
  else return null;
 }
 
 	//--------------------------------------------- New Contact  ---------------------------------------------------------
 public Pagereference NewContact(){
  
   if(NewContact!=null && NewContact!=''){
   Pagereference prAcc = new Pagereference('/apex/NewContact?ID='+NewContact);
   return prAcc;
   }
     else return null;
 }
 
 	//--------------------------------------------- New Contact  ---------------------------------------------------------
 	
 	public void AdvancedSearch()
 	{
 		if((searchText!= '' && searchText!= null)&&(checkBox1==false && checkBox2==false))
      {
       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please Select CheckBox!!'));
       showTable1=false;
       showTable2=false;
       showAdvanceSearchAccount =false;
       showAdvanceSearchContact =false;
      }
     // if(searchText.length()>=2)
      //{
      if(checkBox1==True) 
 	 showAdvanceSearchAccount =true; 
 	  if(checkBox2==True)
 	  showAdvanceSearchContact= true; 
 	 
      //}
 	}
 	 //--------------------------------------------- sorting---------------------------------------------------------     
 public string sortField {
    get;
    set{
     this.sortField = value;
     this.previousSortField= sortField;
     setAscendingStatus();  
    }
 } 
     public void doProcess() { 

   q = 'select Name,Type from Account where name LIKE '+ '\'%'+searchText+'%\'';
   if(keyword!=null && keyword!=''){
   if(keyword=='All')
   {
    q = 'SELECT Name,Type FROM Account';
   }
   else{
   string strKeyword = keyword + '%';
    q = 'SELECT Name,Type FROM Account where name like :strKeyword';
   } 	
   }
	if(isAscending){
		q = q + ' ORDER BY ' + sortField + ' ASC' ;
	} 
	else {
		q = q + ' ORDER BY ' + sortField + ' DESC' ;
	}
	
	account= Database.query(q); 
	
       
     }
  
    private void setAscendingStatus() {
    	
    if(previousSortField == sortField) {
      isAscending = !isAscending;
      this.previousSortField = sortField;
      return;
    }
    this.isAscending = true; 
   
  }
 }
 
 
  //--------------------------------------------- ---------------------------------------------------------