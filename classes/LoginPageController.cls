global with sharing class LoginPageController {
    global String username{get;set;}
    global String password{get;set;}
    public String usernameForgotPw{get;set;}
    public Boolean doCheck {get;set;}
   
    global LoginPageController () {
    doCheck = true;
    
    }
    
    global PageReference login() {
        return Site.login(username, password, null);
    }
   
    public void hideLoginPanel(){
        doCheck = false;
    
    }
    
    public PageReference notMember(){
      Pagereference pr = new Pagereference('https://jaipurdeveloper-developer-edition.ap2.force.com/CommunitiesCustomRegistrationPage');
      pr.setRedirect(true);
      return pr;
    }
    public PageReference forgotPassword() {
      boolean success = Site.forgotPassword(usernameForgotPw);
      System.debug('success000'+success);
     
      return null;
    }
}