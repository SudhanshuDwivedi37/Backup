public with sharing class CertificationUserAdministrationForm { 
  
  static final Integer PAGE_SIZE = 10;
     
  string previousSortField = 'User__r.LastName';
  
  public ApexPages.StandardSetController setCon {get;set;} 
  public string SelectedUserId {get;set;}
  public string keyword {get;set;}
  public integer CurrentPage {get;set;}
  
  public CertificationUserAdministrationForm() {  
    this.sortField = 'User__r.LastName';
    this.isAscending = true; 
    CurrentPage = 0;  
    doProcess();
  }
  
  public void doProcess() {
    string q = 'SELECT Id,Username,ProfileId,Name,LastName,IsActive,FirstName,Email FROM User';
    
    string strKeyword = '';
    if(keyword != null && keyword != '' && sortField != 'Active__c'){
        strKeyword = keyword + '%';
        q = q + ' WHERE ' + sortField + ' LIKE: strKeyword ';
    }
    
    if(isAscending){
        q = q + ' ORDER BY ' + sortField + ' ASC' ;
    }
    else {
        q = q + ' ORDER BY ' + sortField + ' DESC' ;
    }
     
    setCon = new ApexPages.StandardSetController(Database.getQueryLocator(q));
    setCon.setPageSize(PAGE_SIZE);
    setCon.setPageNumber(CurrentPage);
  }
   
   public List<User> getCertificationUsers() {
        if(setCon == null){
             return new List<User>();
        }
        return (List<User>) setCon.getRecords();
    }
  
  public PageReference DoActiveInactive(){ 
    try{
       if(SelectedUserId != null){
        
          for(User u : [Select Id, isActive From User Where Id = : SelectedUserId limit 1]){
             if(u.isActive == true ){
                u.isActive = false;
             }
             else{
                u.isActive = true;
             }
             update u;
          }
          
          CurrentPage = setCon.getPageNumber();
          doProcess();
       }
   } 
    catch(Exception ex){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage())); 
    }
    return null;
  }
  
  public PageReference DoAddUsers(){ 
    PageReference pr = new PageReference('/apex/AddCertificationUsers');
    return pr;
  }
  
  
    public PageReference FirstAP() {
        if(setCon == null){
            return null;
        }
        setCon.first(); 
        return null;
    }

    public PageReference PreviousAP() {
         if(setCon.getHasPrevious()){
             setCon.previous(); 
         }
         return null;
    }

    public PageReference NextAP() {
         if(setCon.getHasNext()){
             setCon.next(); 
         }
         return null;
    }

    public PageReference LastAP() {
        if(setCon == null){
            return null;
        }
        setCon.last(); 
        return null;
    }
    
    public Integer getPageNumber(){
        if(setCon == null){
            return 0;
        }
        return setCon.getPageNumber();
    }
     
  //--------------------------------------------------------//
  // Check if previously sortedField = current Field
  // Toggle sort Status otherwise assume ascending.
  //--------------------------------------------------------//  
  private void setAscendingStatus() {
    if(previousSortField == sortField) {
      isAscending = !isAscending;
      return;
    }
    this.isAscending = true;  
  }
  
  //--------------------------------------------------------//
  // Normal Getter and Setter
  //--------------------------------------------------------//  
  public Boolean isAscending {
    get;
    set;
  }
  
  public string sortField {
    get;
    set {
      this.previousSortField = sortField;
      this.sortField = value;
      setAscendingStatus();
    }
  }
  
}